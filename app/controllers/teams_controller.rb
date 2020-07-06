class TeamsController < ApplicationController
  def create
    @team = Task.new(team_params)
    if @team.save
      flash[:notice] = "#{I18n.t("activerecord.models.team")}#{I18n.t("flash.create")}"
      redirect_to user_path(current_user.id)
    else
      render template: "user/show"
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
