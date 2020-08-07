require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'コメントモデルテスト' do
    before do
      @company = create(:company)
      @customer = create(:customer, company: @company)
      @project = create(:project, customer: @customer)
      @category = create(:category, company: @company)
      @user = create(:user)
      @user2 = create(:user2)
      @team = create(:team, company: @company, owner: @user)
      @drawing = create(:drawing, team: @team, project: @project)
      @task = create(:task, drawing: @drawing, staff: @user, approver: @user2)
      @question = create(:question, task: @task)
    end
    context '質問タイトルバリデーション' do
      it 'contentが空ならバリデーションが通らない' do
        comment = Comment.new(question: @question, user: @user)
        expect(comment).not_to be_valid
      end
    end
    context 'バリデーションクリア' do
      it 'contentのバリデーションが通る' do
        comment = Comment.new(content: "sample", question: @question, user: @user)
        expect(comment).to be_valid
      end
    end
  end
end
