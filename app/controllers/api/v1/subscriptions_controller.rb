class Api::V1::SubscriptionsController < Api::V1::ApiController
  def index
    @subscriptions = Subscription.all.includes [:plan, :customer]
  end

  def show
    @subscription = Subscription.find_by_oid params[:id]

    head :not_found unless @subscription
  end

  def create
    plan = Plan.find_by_oid params[:plan_id]
    customer = Customer.find_by_oid params[:customer_id]

    subscription_body = subscription_params
    subscription_body[:plan_id] = plan.id
    subscription_body[:customer_id] = customer.id

    @subscription = Subscription.new subscription_body

    render status: :unprocessable_entity, json: { error: @subscription.errors } unless @subscription.save
  end

  def update
    @subscription = Subscription.find_by_oid params[:id]
    return head :not_found unless @subscription

    subscription_body = subscription_params

    if params[:plan_id]
      plan = Plan.find_by_oid params[:plan_id]
      subscription_body[:plan_id] = plan.id
    end

    if params[:customer_id]
      customer = Customer.find_by_oid params[:customer_id]
      subscription_body[:customer_id] = customer.id
    end

    unless @subscription.update subscription_body
      render status: :unprocessable_entity, json: { error: @subscription.errors }
    end
  end

  private

    def subscription_params
      params.permit(:oid, :cancelled_at, :quantity, :started_at)
    end
end
