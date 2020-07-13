class TeamsController < ApplicationController
  def create
    @team = Team.new(team_params)
    respond_to do |format|
      if @team.save
        format.html { redirect_to user_path(current_user), notice: 'チーム作成完了！' }
        format.js { render :create }
      else
        format.html { redirect_to user_path(current_user), notice: "#{I18n.t("activerecord.models.team")}#{I18n.t("flash.create_failure")}"}
      end
    end
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
end
