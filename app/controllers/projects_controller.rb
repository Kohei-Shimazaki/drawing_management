class ProjectsController < ApplicationController
  before_action :set_project, only: %i(show edit update destroy)

  def create
    @project = Project.new(project_params)
    respond_to do |format|
      if @project.save
        format.js { render :index }
      else
        format.js { render :new }
      end
    end
  end

  def show
  end

  def edit
    @project = current_user.company.projects.find(params[:id])
    respond_to do |format|
      format.js { render :edit }
    end
  end

  def update
    @project = current_user.company.projects.find(params[:id])
    respond_to do |format|
      if @project.update(project_params)
        format.js { render :index }
      else
        format.js { render :edit }
      end
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      flash[:notice] = "#{I18n.t("activerecord.models.project")}#{I18n.t("flash.destroy")}"
      format.js { render :index }
    end
  end

  private
    def project_params
      params.require(:project).permit(
        :name,
        :location,
        :explanation,
        :customer_id,
      )
    end

    def set_project
      @project = Project.find(params[:id])
    end
end
