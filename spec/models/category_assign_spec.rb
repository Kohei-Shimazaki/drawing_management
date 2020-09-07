# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoryAssign, type: :model do
  describe 'カテゴリー付けモデルテスト' do
    before do
      @company = create(:company)
      @customer = create(:customer, company: @company)
      @project = create(:project, customer: @customer)
      @category = create(:category, company: @company)
      @user = create(:user)
      @team = create(:team, company: @company, owner: @user)
      @drawing = create(:drawing, team: @team, project: @project)
    end
    it '図面とカテゴリーの関連付けができる' do
      categoryassign = CategoryAssign.new(category: @category, drawing: @drawing)
      expect(categoryassign).to be_valid
    end
  end
end
