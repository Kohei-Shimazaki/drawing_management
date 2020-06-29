class RevisionsController < ApplicationController
  def new
    @revision = Revision.new
  end

  def create
    @revision = Revision.new(revision_params)
    if @revision.save
      flash[:notice] = "#{I18n.t("activerecord.models.revision")}#{I18n.t("flash.create")}"
      redirect_to new_revision_path
    else
      render :new
    end
  end

  private
    def revision_params
      params.require(:revision).permit(
        :revision_number,
        :content,
        :comment,
      )
    end
end
