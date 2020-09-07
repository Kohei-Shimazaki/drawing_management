# frozen_string_literal: true

class CompaniesController < ApplicationController
  before_action :set_company, only: %i[show edit update destroy]
  PER = 10

  def show
    @q = @company.users.ransack(params[:q])
    @teams = @company.teams
    @users = @q.result.includes(:teams).page(params[:page]).per(PER)
  end

  def edit; end

  def update
    if @company.update(company_params)
      flash[:notice] = "#{I18n.t('activerecord.models.company')}#{I18n.t('flash.update')}"
      redirect_to company_path(@company.id)
    else
      render :edit
    end
  end

  def destroy
    @company.destroy
    flash[:notice] = "#{I18n.t('activerecord.models.company')}#{I18n.t('flash.destroy')}"
    redirect_to companies_path
  end

  private

  def company_params
    params.require(:company).permit(
      :name,
      :phone_number,
      :location,
      :icon,
      :overview
    )
  end

  def set_company
    @company = Company.find(params[:id])
  end
end
