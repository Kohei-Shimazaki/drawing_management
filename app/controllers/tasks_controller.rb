class TasksController < ApplicationController
  before_action :set_task, only: %i(edit update show destroy revision_assign_delete)

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
    @task.drawing_id = params[:drawing_id]
    @drawing = Drawing.find(params[:drawing_id])
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = "#{I18n.t("activerecord.models.task")}#{I18n.t("flash.create")}"
      redirect_to drawing_path(@task.drawing.id)
    else
      render :new
    end
  end

  def show
    @references = @task.references
    @reference = @task.references.build
    @evidences = @task.evidences
    @evidence = @task.evidences.build
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

  def revision_assign
    @task = Task.find(params[:task][:task_id])
    @task.revision_id = params[:task][:revision_id]
    if @task.save
      redirect_to drawing_path(@task.drawing)
    end
  end

  def revision_assign_delete
    @task.revision_id = nil
    @task.save
    redirect_to drawing_path(@task.drawing)
  end

  private
    def task_params
      params.require(:task).permit(
        :title,
        :content,
        :status,
        :deadline,
        :drawing_id,
        :staff_id,
        :approver_id,
      )
    end

    def set_task
      @task = Task.find(params[:id])
    end
end
