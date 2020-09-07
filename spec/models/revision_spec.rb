# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Revision, type: :model do
  describe 'レビジョンモデルテスト' do
    before do
      @company = create(:company)
      @customer = create(:customer, company: @company)
      @project = create(:project, customer: @customer)
      @category = create(:category, company: @company)
      @user = create(:user)
      @team = create(:team, company: @company, owner: @user)
      @drawing = create(:drawing, team: @team, project: @project)
    end
    context 'レビジョンファイルバリデーション' do
      it 'contentが空ならバリデーションが通らない' do
        revision = Revision.new(revision_number: 0, drawing: @drawing)
        expect(revision).not_to be_valid
      end
    end
  end
end
