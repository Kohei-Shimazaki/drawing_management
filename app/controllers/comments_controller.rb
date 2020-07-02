class CommentsController < ApplicationController
  before_action :set_comment, only: %i(edit update show destroy)

  def index
    @comments = Comment.all
  end

  def new
    @comment = Comment.new
    @comment.drawing_id = params[:task_id]
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:notice] = "#{I18n.t("activerecord.models.comment")}#{I18n.t("flash.create")}"
      redirect_to comments_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      flash[:notice] = "#{I18n.t("activerecord.models.comment")}#{I18n.t("flash.update")}"
      redirect_to comments_path
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    flash[:notice] = "#{I18n.t("activerecord.models.comment")}#{I18n.t("flash.destroy")}"
    redirect_to comments_path
  end

  private
    def comment_params
      params.require(:comment).permit(
        :title,
        :content,
        attachment: [],
        :task_id,
      )
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end
end
