class SubscriptionsController < ApplicationController
  def index
    @subscriptions = Subscription.all.order(id: :desc)
  end

  def create
    @subscription = Subscription.new subscription_params
    if @subscription.save
      ActionCable.server.broadcast('subscriptions_channel', subscription: @subscription.as_json(include: [:customer, :plan]), action: 'create')
      render json: @subscription
    else
      render status: :bad_request, json: { error: "can't save" }
    end
  end

  def update
    @subscription = Subscription.find params[:id]
    if @subscription.update(subscription_params)
      ActionCable.server.broadcast('subscriptions_channel', subscription: @subscription.as_json(include: [:customer, :plan]), action: 'update')
      render json: @subscription
    else
      render status: :bad_request, json: { error: "can't save" }
    end
  end

  private

    def subscription_params
      params.require(:subscription).permit(:oid, :plan_id, :customer_id, :cancelled_at, :quantity, :started_at)
    end
end
