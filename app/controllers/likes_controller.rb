class LikesController < ApplicationController
  PER = 10

  def index
    if params[:q]
      @user = User.find(params[:q][:user_id])
    else
      @user = User.find(params[:user_id])
    end
    @q = @user.like_questions.order(created_at: :desc).ransack(params[:q])
    @tasks = current_user.company.tasks
    @drawings = current_user.company.drawings
    @projects = current_user.company.projects
    @teams = current_user.company.teams
    @questions = @q.result.includes(:task, :drawing, :project, :team).page(params[:page]).per(PER)
  end

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
