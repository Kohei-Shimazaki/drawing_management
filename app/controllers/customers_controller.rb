class CustomersController < ApplicationController
  before_action :set_customer, only: %i(edit update destroy)

  def create
    @customer = current_user.company.customers.build(customer_params)
    respond_to do |format|
      if @customer.save
        format.js { render :index }
      else
        format.html { redirect_to new_user_invitation_path, notice: "#{I18n.t("activerecord.models.customer")}#{I18n.t("flash.create_failure")}"}
      end
    end
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      flash[:notice] = "#{I18n.t("activerecord.models.customer")}#{I18n.t("flash.update")}"
      redirect_to customers_path
    else
      render :edit
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
