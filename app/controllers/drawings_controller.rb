class DrawingsController < ApplicationController
  before_action :set_drawing, only: %i(show edit update destroy)

  def index
    @q = current_user.company.drawings.ransack(params[:q])
    @categories = current_user.company.categories
    @projects = current_user.company.projects
    @teams = current_user.company.teams
    @drawings = @q.result.includes(:categories, :project, :team)
  end

  def new
    @drawing = Drawing.new
    @drawing.team_id = params[:team_id]
  end

  def create
    @drawing = Drawing.new(drawing_params)
    if @drawing.save
      flash[:notice] = "#{I18n.t("activerecord.models.drawing")}#{I18n.t("flash.create")}"
      redirect_to drawings_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @drawing.update(drawing_params)
      flash[:notice] = "#{I18n.t("activerecord.models.drawing")}#{I18n.t("flash.update")}"
      redirect_to drawings_path
    else
      render :edit
    end
  end

  def destroy
    @drawing.destroy
    flash[:notice] = "#{I18n.t("activerecord.models.drawing")}#{I18n.t("flash.destroy")}"
    redirect_to drawings_path
  end

  private
    def drawing_params
      params.require(:drawing).permit(
        :title,
        :drawing_number,
        :explanation,
        :team_id,
        :project_id,
        category_ids: []
      )
    end

    def set_drawing
      @drawing = Drawing.find(params[:id])
    end

end
