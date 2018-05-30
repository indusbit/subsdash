module Api::V1
  class PlansController < ApiController

    # GET /v1/plans
    # @query_parameter [float] range
    # @response_class BicyclesSerializer
    def index
      @plans = Plan.all
    end

    # GET /v1/plans/:id
    # @response_class BicycleSerializer
    def show
      @plan = Plan.find params[:id]
    end

    def create
      @plan = Plan.new plan_params

      @plan.save
    end

  private

    def plan_params
      params.permit(:oid, :amount, :currency, :interval, :interval_count, :name, :platform)    
    end

  end
end