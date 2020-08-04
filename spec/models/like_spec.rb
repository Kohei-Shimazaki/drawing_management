require 'rails_helper'

RSpec.describe Like, type: :model do
  # describe 'いいねモデルテスト' do
  #   before do
  #     @company = create(:company)
  #     @customer = create(:customer, company: @company)
  #     @project = create(:project, customer: @customer)
  #     @category = create(:category, company: @company)
  #     @user = create(:user)
  #     @user2 = create(:user2)
  #     @team = create(:team, company: @company, owner: @user)
  #     @drawing = create(:drawing, team: @team, project: @project)
  #     @task = create(:task, drawing: @drawing, staff: @user, approver: @user2)
  #     @question = create(:question, drawing: @drawing)
  #   end
  #   it "いいねでユーザーと質問を関連付ける" do
  #     like = Like.new(user: @user2, question: @question)
  #     expect(like).to be_valid
  #   end
  # end
end
