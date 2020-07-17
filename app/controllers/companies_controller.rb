class CompaniesController < ApplicationController
  before_action :set_company, only: %i(show edit update destroy)

  def index
    @companys = Company.all
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      flash[:notice] = "#{I18n.t("activerecord.models.company")}#{I18n.t("flash.create")}"
      redirect_to new_user_registration_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @company.update(company_params)
      flash[:notice] = "#{I18n.t("activerecord.models.company")}#{I18n.t("flash.update")}"
      redirect_to company_path(@company.id)
    else
      render :edit
    end
  end

  def destroy
    @company.destroy
    flash[:notice] = "#{I18n.t("activerecord.models.company")}#{I18n.t("flash.destroy")}"
    redirect_to companies_path
  end

  private
    def company_params
      params.require(:company).permit(
        :name,
        :phone_number,
        :location,
        :icon,
        :overview,
      )
    end

    def set_company
      @company = Company.find(params[:id])
    end

end
