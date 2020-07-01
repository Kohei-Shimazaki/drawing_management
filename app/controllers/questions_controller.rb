class QuestionsController < ApplicationController
  before_action :set_question, only: %i(edit update show destroy)

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
    @question.drawing_id = params[:task_id]
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:notice] = "#{I18n.t("activerecord.models.question")}#{I18n.t("flash.create")}"
      redirect_to questions_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @question.update(question_params)
      flash[:notice] = "#{I18n.t("activerecord.models.question")}#{I18n.t("flash.update")}"
      redirect_to questions_path
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    flash[:notice] = "#{I18n.t("activerecord.models.question")}#{I18n.t("flash.destroy")}"
    redirect_to questions_path
  end

  private
    def question_params
      params.require(:question).permit(
        :title,
        :content,
        attachment: [],
        :task_id,
      )
    end

    def set_question
      @question = Question.find(params[:id])
    end
end
