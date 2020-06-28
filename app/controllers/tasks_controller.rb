class TasksController < ApplicationController
  before_action :set_task, only: %i(edit update show destroy)

  def index
    @tasks = Task.all
  end
  
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = "タスク登録しました！" #辞書機能待ち
      redirect_to new_task_path
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
      flash[:notice] = "タスクを更新しました！" #辞書機能待ち
      redirect_to tasks_path
    else
      render :edit
    end
  end

  private
    def task_params
      params.require(:task).permit(
        :title,
        :content,
        :status,
        :deadline,
      )
    end

    def set_task
      @task = Task.find(params[:id])
    end
end
