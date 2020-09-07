# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TeamAssign, type: :model do
  describe 'チーム付けモデル' do
    before do
      @user = create(:user)
      @company = create(:company)
      @team = create(:team, company: @company, owner: @user)
    end
    it 'ユーザーとチームの関連付けができる' do
      teamassign = TeamAssign.new(user: @user, team: @team)
      expect(teamassign).to be_valid
    end
  end
end
