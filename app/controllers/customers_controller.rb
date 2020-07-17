class CustomersController < ApplicationController
  before_action :set_customer, only: %i(show edit update destroy)

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

  def show
  end

  def edit
    @customer = current_user.company.customers.find(params[:id])
    respond_to do |format|
      flash.now[:notice] = 'コメントの編集中'
      format.js { render :edit }
    end
  end

  def update
    @customer = current_user.company.customers.find(params[:id])
    respond_to do |format|
      if @customer.update(customer_params)
        flash.now[:notice] = 'コメントが編集されました'
        format.js { render :index }
      else
        flash.now[:notice] = 'コメントの編集に失敗しました'
        format.js { render :edit_error }
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
