class RevisionsController < ApplicationController
  before_action :set_revision, only: %i(edit update show destroy)

  def index
    @revisions = Revision.all
  end

  def new
    @revision = Revision.new
    @revision.drawing_id = params[:drawing_id]
    @revision.revision_number = params[:revision_number]
  end

  def create
    @revision = Revision.new(revision_params)
    binding.pry
    if @revision.save
      flash[:notice] = "#{I18n.t("activerecord.models.revision")}#{I18n.t("flash.create")}"
      redirect_to new_revision_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @revision.update(revision_params)
      flash[:notice] = "#{I18n.t("activerecord.models.revision")}#{I18n.t("flash.update")}"
      redirect_to revisions_path
    else
      render :edit
    end
  end

  def destroy
    @revision.content.purge
    @revision.destroy
    flash[:notice] = "#{I18n.t("activerecord.models.revision")}#{I18n.t("flash.destroy")}"
    redirect_to revisions_path
  end

  private
    def revision_params
      params.require(:revision).permit(
        :revision_number,
        :content,
        :comment,
        :drawing_id,
      )
    end

    def set_revision
      @revision = Revision.find(params[:id])
    end

end
