class PlansController < ApplicationController
  def index
    @plans = Plan.all.order(id: :desc).includes(:subscriptions).map do |plan|
      attributes = plan.attributes
      attributes["total_monthly"] = plan.total_monthly.round(2)
      attributes
    end
  end

  def show
    @plan = Plan.find params[:id]

    @subscriptions = @plan.subscriptions.all.includes [:plan, :customer]
    
    days = (0..30).map { |e| e.days.ago }.reverse
    
    @mrr = []; @new_customers = []; @customers = []; @cancellations = []; @dates = []
    
    days.each do |day|
      active_subscriptions = @subscriptions
        .select { |e| e.cancelled_at ? e.started_at < day && e.cancelled_at > day : e.started_at < day }
      
      revenue = active_subscriptions
        .map { |e| e.monthly_revenue.round 2  }
        .sum

      cancellation = @subscriptions.select {|e| e.cancelled_at&.to_date == day.to_date }.uniq {|e| e.customer_id }.size
      new_customer = @subscriptions.select {|e| e.started_at.to_date == day.to_date }.size
      active_customers = active_subscriptions.uniq {|e| e.customer_id }.size


      @customers.push active_customers
      @new_customers.push new_customer
      @cancellations.push cancellation
      @mrr.push revenue
      @dates.push day.strftime '%b %d'
    end
  end

  def create
    @plan = Plan.new plan_params
    if @plan.save
      ActionCable.server.broadcast('plans_channel', plan: @plan, action: 'create')
      render json: @plan
    else
      render status: :bad_request, json: { error: "can't save" }
    end
  end

  def update
    @plan = Plan.find params[:id]
    if @plan.update plan_params
      ActionCable.server.broadcast('plans_channel', plan: @plan, action: 'update')
      render json: @plan
    else
      render status: :bad_request, json: { error: "can't save" }
    end
  end

  # Not implemented yet because behaviour in undecided.
  def destroy
    @plan = Plan.find params[:id]

    head :ok
  end

  private

    def plan_params
      params.require(:plan).permit(:name, :currency, :interval, :interval_count, :oid, :platform, :amount)
    end
end
