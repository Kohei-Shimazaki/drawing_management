class CommentsController < ApplicationController
  before_action :set_comment, only: %i(edit update destroy)
  PER = 10

  def create
    @question = Question.find(params[:question_id])
    @comment = @question.comments.build(comment_params)
    respond_to do |format|
      if @comment.save
        format.js { render :index }
      else
        format.html { redirect_to question_path(@question), notice: "#{I18n.t("activerecord.models.comment")}#{I18n.t("flash.create_failure")}"}
      end
    end
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
        :content,
        :attachment,
        :question_id,
        :user_id,
      )
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end
end
