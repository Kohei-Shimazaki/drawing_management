# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy]

  def create
    @category = current_user.company.categories.build(category_params)
    respond_to do |format|
      if @category.save
        format.js { render :index }
      else
        format.js { render :new }
      end
    end
  end

  def show; end

  def edit
    @category = current_user.company.categories.find(params[:id])
    respond_to do |format|
      format.js { render :edit }
    end
  end

  def update
    @category = current_user.company.categories.find(params[:id])
    respond_to do |format|
      if @category.update(category_params)
        format.js { render :index }
      else
        format.js { render :edit }
      end
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      flash[:notice] = "#{I18n.t('activerecord.models.category')}#{I18n.t('flash.destroy')}"
      format.js { render :index }
    end
  end

  private

  def category_params
    params.require(:category).permit(
      :name,
      :explanation,
      :company_id
    )
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
