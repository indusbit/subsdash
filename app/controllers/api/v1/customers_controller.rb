class Api::V1::CustomersController < Api::V1::ApiController
    def index
      @customers = Customer.all
    end

    def show
      @customer = Customer.find_by_oid params[:id]

      head :not_found unless @customer
    end

    def create
      @customer = Customer.new customer_params

      render status: :unprocessable_entity, json: { error: @customer.errors } unless @customer.save 
    end

    def update
      @customer = Customer.find_by_oid params[:id]
      return head :not_found unless @customer
      
      unless @customer.update customer_params
        render status: :unprocessable_entity, json: { error: @customer.errors }
      end
    end

    # Not implemented because functionality has not been decided
    # def destroy
    #   @customer = Customer.find_by_oid params[:id]
    #   return head :not_found unless @customer

    #   if @customer.destroy
    #     head :ok
    #   else
    #     render status: :unprocessable_entity, json: { error: @customer.errors }
    #   end
    # end

  private

    def customer_params
      params.permit(:oid, :name, :email, :notes)
    end

end
