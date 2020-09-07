# frozen_string_literal: true

class TeamAssignsController < ApplicationController
  def create
    @team = Team.find(params[:team_assign][:team_id])
    @team_assign = @team.team_assigns.build(team_assign_params)
    respond_to do |format|
      if @team_assign.save
        format.js { render :index }
      else
        format.html { redirect_to team_path(@team), notice: "#{I18n.t('activerecord.models.team_assign')}#{I18n.t('flash.create_failure')}" }
      end
    end
  end

  def destroy
    @team_assign = TeamAssign.find(params[:id])
    @team = @team_assign.team
    @team_assign.delete
    respond_to do |format|
      format.js { render :index }
    end
  end

  private

  def team_assign_params
    params.require(:team_assign).permit(
      :user_id,
      :team_id
    )
  end
end
