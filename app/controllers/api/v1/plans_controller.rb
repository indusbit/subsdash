module Api::V1
  class PlansController < ApiController

    # GET /v1/plans
    def index
      @plans = Plan.all
    end

    # GET /v1/plans/:id
    def show
      @plan = Plan.find_by_oid params[:id]

      head :not_found unless @plan
    end

    def create
      @plan = Plan.new plan_params

      render status: :unprocessable_entity, json: { error: @plan.errors } unless @plan.save 
    end

    def update
      @plan = Plan.find_by_oid params[:id]
      return head :not_found unless @plan
      
      @plan.assign_attributes plan_params
      
      return render status: :unprocessable_entity, json: { error: @plan.errors } unless @plan.save
    end

    def destroy
      @plan = Plan.find_by_oid params[:id]
      return head :not_found unless @plan

      if @plan.destroy
        render json: { message: "Successfully deleted the plan." }
      else
        render status: :unprocessable_entity, json: { error: @plan.errors }
      end
    end

  private

    def plan_params
      params.permit(:oid, :amount, :currency, :interval, :interval_count, :name, :platform)    
    end

  end
end