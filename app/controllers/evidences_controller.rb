class EvidencesController < ApplicationController
  before_action :set_evidence, only: %i(destroy)

  def create
    @task = Task.find(params[:task_id])
    @evidence = @task.evidences.build(evidence_params)
    respond_to do |format|
      if @evidence.save
        format.js { render :index }
      else
        format.js { render :new }
      end
    end
  end

  def destroy
    @evidence.destroy
    respond_to do |format|
      flash[:notice] = "#{I18n.t("activerecord.models.evidence")}#{I18n.t("flash.destroy")}"
      format.js { render :index }
    end
  end

  private
    def evidence_params
      params.require(:evidence).permit(
        :content,
        :comment,
        :task_id,
      )
    end

    def set_evidence
      @evidence = Evidence.find(params[:id])
    end
end
