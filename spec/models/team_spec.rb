# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Team, type: :model do
  describe 'チームモデルテスト' do
    before do
      @company = create(:company)
      @user = create(:user)
    end
    context 'チーム名バリデーション' do
      it 'nameが空ならバリデーションが通らない' do
        team = Team.new(profile: 'Mytext', owner: @user, company: @company)
        expect(team).not_to be_valid
      end
      it 'nameが101文字以上ならバリデーションが通らない' do
        team = Team.new(name: 'M' * 101, owner: @user, company: @company)
        expect(team).not_to be_valid
      end
    end
    context 'バリデーションクリア' do
      it 'nameが1文字以上100字以内ならバリデーションが通る' do
        team = Team.new(name: 'Mytext', owner: @user, company: @company)
        expect(team).to be_valid
      end
    end
  end
end
