class DrawingsController < ApplicationController
  before_action :set_drawing, only: %i(show edit update destroy)

  def index
    @drawings = Drawing.all
  end

  def new
    @drawing = Drawing.new
  end

  def create
    @drawing = Drawing.new(drawing_params)
    if @drawing.save
      flash[:notice] = "" #辞書
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
      )
    end

    def set_drawing
      @drawing = Drawing.find(params[:id])
    end

end
