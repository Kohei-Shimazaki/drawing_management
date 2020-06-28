class DrawingsController < ApplicationController
  def new
    @drawing = Drawing.new
  end
end
