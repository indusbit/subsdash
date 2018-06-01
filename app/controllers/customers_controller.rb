class CustomersController < ApplicationController
  def index
    @customers = Customer.all.order(id: :desc)
  end

  def create
    @customer = Customer.new customer_params
    if @customer.save
      ActionCable.server.broadcast('customers_channel', customer: @customer, action: 'create')
      render json: @customer
    else
      render status: :bad_request, json: { error: "can't save" }
    end
  end

  def update
    @customer = Customer.find params[:id]
    if @customer.update(customer_params)
      ActionCable.server.broadcast('customers_channel', customer: @customer, action: 'update')
      render json: @customer
    else
      render status: :bad_request, json: { error: "can't save" }
    end
  end

  private

    def customer_params
      params.require(:customer).permit(:name, :email, :notes, :oid)
    end
end
