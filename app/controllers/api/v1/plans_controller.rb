module Api::V1
  class PlansController < ApiController

    # GET /v1/plans
    def index
      @plans = Plan.all
    end

    # GET /v1/plans/:id
    def show
      return render status: :unprocessable_entity, json: { error: "Please pass plan oid" } unless params[:id]
      @plan = Plan.find_by_oid params[:id]
      
      render status: :unprocessable_entity, json: { error: "Plan not found." } unless @plan
    end

    def create
      @plan = Plan.new plan_params

      render status: :unprocessable_entity, json: { error: @plan.errors.full_messages } unless @plan.save 
    end

    def destroy
      @plan = Plan.find_by_oid params[:id]
      return render status: :unprocessable_entity, json: { error: "Plan not found." } unless @plan

      if @plan.destroy
        render json: { message: "Successfully deleted the plan." }
      else
        render status: :unprocessable_entity, json: { error: @plan.errors.full_messages }
      end
    end

  private

    def plan_params
      params.permit(:oid, :amount, :currency, :interval, :interval_count, :name, :platform)    
    end

  end
end