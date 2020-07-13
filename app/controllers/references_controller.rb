class ReferencesController < ApplicationController
  before_action :set_reference, only: %i(destroy)

  def create
    @task = Task.find(params[:task_id])
    @reference = @task.references.build(reference_params)
    respond_to do |format|
      if @reference.save
        format.js { render :index }
      else
        format.html { redirect_to task_path(@task), notice: "#{I18n.t("activerecord.models.reference")}#{I18n.t("flash.create_failure")}"}
      end
    end
  end

  def destroy
    @reference.destroy
    respond_to do |format|
      flash[:notice] = "#{I18n.t("activerecord.models.reference")}#{I18n.t("flash.destroy")}"
      format.js { render :index }
    end
  end

  private
    def reference_params
      params.require(:reference).permit(
        :content,
        :comment,
        :task_id,
      )
    end

    def set_reference
      @reference = Reference.find(params[:id])
    end
end
