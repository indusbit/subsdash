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
      render json: { error: "can't save" }
    end
  end

  private

    def plan_params
      params.require(:plan).permit(:name, :currency, :interval, :interval_count, :oid, :platform, :amount)
    end
end
