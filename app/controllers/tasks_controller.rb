class TasksController < ApplicationController
  before_action :set_task, only: %i(edit update show destroy)

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
    @task.drawing_id = params[:drawing_id]
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = "#{I18n.t("activerecord.models.task")}#{I18n.t("flash.create")}"
      redirect_to tasks_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:notice] = "#{I18n.t("activerecord.models.task")}#{I18n.t("flash.update")}"
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:notice] = "#{I18n.t("activerecord.models.task")}#{I18n.t("flash.destroy")}"
    redirect_to tasks_path
  end

  private
    def task_params
      params.require(:task).permit(
        :title,
        :content,
        :status,
        :deadline,
        :drawing_id,
      )
    end

    def set_task
      @task = Task.find(params[:id])
    end
end
