class TeamsController < ApplicationController
  before_action :set_team, only: %i(edit update show destroy chat)
  PER = 10

  def create
    @team = Team.new(team_params)
    respond_to do |format|
      if @team.save
        @team_assign = TeamAssign.create(user_id: current_user.id, team_id: @team.id)
        format.js { render :create }
      else
        format.html { redirect_to user_path(current_user), notice: "#{I18n.t("activerecord.models.team")}#{I18n.t("flash.create_failure")}"}
      end
    end
  end

  def show
    @team_assign = @team.team_assigns.build
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

  def chat
    @messages = @team.messages.order(created_at: :desc).page(params[:page]).per(PER)
  end

  private
    def team_params
      params.require(:team).permit(
        :name,
        :profile,
        :icon,
        :owner_id,
        :company_id,
      )
    end

    def set_team
      @team = Team.find(params[:id])
    end
end
