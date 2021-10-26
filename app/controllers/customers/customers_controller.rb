class Customers::CustomersController < ApplicationController
  def show
    @customer = Customer.all
  end

  def edit
    # @customer = current_customer.customers
    @customer = Customer.find(params[:id])
  end

  def update
  end

  def unsubscribe
    
  end

  def withdraw
  end

  private
end
