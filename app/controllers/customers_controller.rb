class CustomersController < ApplicationController
  before_action :set_customer, only: %i(show edit update destroy)

  def create
    @customer = current_user.company.customers.build(customer_params)
    respond_to do |format|
      if @customer.save
        format.js { render :index }
      else
        format.js { render :new }
      end
    end
  end

  def show
  end

  def edit
    @customer = current_user.company.customers.find(params[:id])
    respond_to do |format|
      format.js { render :edit }
    end
  end

  def update
    @customer = current_user.company.customers.find(params[:id])
    respond_to do |format|
      if @customer.update(customer_params)
        format.js { render :index }
      else
        format.js { render :edit }
      end
    end
  end

  def destroy
    @customer.icon.purge
    @customer.destroy
    respond_to do |format|
      flash[:notice] = "#{I18n.t("activerecord.models.customer")}#{I18n.t("flash.destroy")}"
      format.js { render :index }
    end
  end

  private
    def customer_params
      params.require(:customer).permit(
        :name,
        :phone_number,
        :location,
        :icon,
        :overview,
      )
    end

    def set_customer
      @customer = Customer.find(params[:id])
    end
end
