class TeamsController < ApplicationController
  before_action :set_team, only: %i(edit update show destroy)

  def create
    @team = Team.new(team_params)
    respond_to do |format|
      if @team.save
        format.html { redirect_to user_path(current_user), notice: "#{I18n.t("activerecord.models.team")}#{I18n.t("flash.create")}" }
        format.js { render :create }
      else
        format.html { redirect_to user_path(current_user), notice: "#{I18n.t("activerecord.models.team")}#{I18n.t("flash.create_failure")}"}
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    if @team.update(team_params)
      flash[:notice] = "#{I18n.t("activerecord.models.team")}#{I18n.t("flash.update")}"
      redirect_to team_path(@team)
    else
      render :edit
    end
  end

  def destroy
    @team.destroy
    flash[:notice] = "#{I18n.t("activerecord.models.team")}#{I18n.t("flash.destroy")}"
    redirect_to user_path(current_user)
  end

  private
    def team_params
      params.require(:team).permit(
        :name,
        :profile,
        :icon,
        :owner_id,
      )
    end

    def set_team
      @team = Team.find(params[:id])
    end
end
