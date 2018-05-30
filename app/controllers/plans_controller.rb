class PlansController < ApplicationController
  def index
    @plans = Plan.all
  end

  def show
    @plan = Plan.find params[:id]
  end

  def create
    @plan = Plan.new plan_params
    if @plan.save
      render json: @plan
    else
      render status: :bad_request, json: { error: "can't save" }
    end
  end

  def update
    @plan = Plan.find params[:id]
    if @plan.update plan_params
      render json: @plan
    else
      render status: :bad_request, json: { error: "can't save" }
    end
  end

  private

    def plan_params
      params.require(:plan).permit(:name, :currency, :interval, :interval_count, :oid, :platform, :amount)
    end
end
