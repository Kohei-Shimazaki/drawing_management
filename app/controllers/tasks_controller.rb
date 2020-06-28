class TasksController < ApplicationController
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

  private
    def task_params
      params.require(:task).permit(
                                    :title,
                                    :content,
                                    :status,
                                    :deadline,
      )
    end
end
