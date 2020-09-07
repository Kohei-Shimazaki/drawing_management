# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i[edit update show destroy revision_assign_delete approval approval_delete]

  def new
    @task = Task.new
    @task.drawing_id = params[:drawing_id]
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = "#{I18n.t('activerecord.models.task')}#{I18n.t('flash.create')}"
      redirect_to drawing_path(@task.drawing)
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

  def edit; end

  def update
    if @task.update(task_params)
      flash[:notice] = "#{I18n.t('activerecord.models.task')}#{I18n.t('flash.update')}"
      redirect_to drawing_path(@task.drawing)
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:notice] = "#{I18n.t('activerecord.models.task')}#{I18n.t('flash.destroy')}"
    redirect_to drawing_path(@task.drawing)
  end

  def revision_assign
    @task = Task.find(params[:task][:task_id])
    @task.revision_id = params[:task][:revision_id]
    @task.status = 'approval_waiting'
    redirect_to drawing_path(@task.drawing) if @task.save
  end

  def revision_assign_delete
    @task.revision_id = nil
    @task.status = 'working'
    redirect_to drawing_path(@task.drawing) if @task.save
  end

  def approval
    @task.status = 'completed'
    redirect_to drawing_path(@task.drawing) if @task.save
  end

  def approval_delete
    @task.status = 'approval_rescission'
    @task.revision_id = nil
    redirect_to drawing_path(@task.drawing) if @task.save
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
      :approver_id
    )
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
