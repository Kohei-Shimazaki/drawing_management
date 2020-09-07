# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :set_question, only: %i[edit update show destroy]
  PER = 10

  def index
    @q = current_user.company.questions.order(created_at: :desc).ransack(params[:q])
    @tasks = current_user.company.tasks
    @drawings = current_user.company.drawings
    @projects = current_user.company.projects
    @teams = current_user.company.teams
    @questions = @q.result.includes(:task, :drawing, :project, :team).page(params[:page]).per(PER)
  end

  def new
    @question = Question.new
    @question.task_id = params[:task_id]
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:notice] = "#{I18n.t('activerecord.models.question')}#{I18n.t('flash.create')}"
      redirect_to questions_path
    else
      render :new
    end
  end

  def show
    @comments = @question.comments.order(created_at: :desc).page(params[:page]).per(PER)
    @comment = @question.comments.build
  end

  def edit; end

  def update
    if @question.update(question_params)
      flash[:notice] = "#{I18n.t('activerecord.models.question')}#{I18n.t('flash.update')}"
      redirect_to questions_path
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    flash[:notice] = "#{I18n.t('activerecord.models.question')}#{I18n.t('flash.destroy')}"
    redirect_to questions_path
  end

  private

  def question_params
    params.require(:question).permit(
      :title,
      :content,
      :task_id,
      :attachment
    )
  end

  def set_question
    @question = Question.find(params[:id])
  end
end
