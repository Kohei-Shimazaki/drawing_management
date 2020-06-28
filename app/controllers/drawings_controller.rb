class DrawingsController < ApplicationController
  before_action :set_drawing, only: %i(show edit update destroy)

  def new
    @drawing = Drawing.new
  end

  def create
    @drawing = Drawing.new(drawing_params)
    if @drawing.save
      flash[:notice] = "図面を登録しました！" #辞書
      redirect_to drawings_path
    else
      render :new
    end
  end
end
