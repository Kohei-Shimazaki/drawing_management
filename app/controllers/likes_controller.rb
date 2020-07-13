class LikesController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    like = current_user.likes.create(question_id: params[:question_id])
    like.save
  end

  def destroy
    like = current_user.likes.find_by(id: params[:id]).destroy
    @question = like.question
  end

  private
    def like_params
      params.permit(
        question_id,
        comment_id,
      )
    end
end
