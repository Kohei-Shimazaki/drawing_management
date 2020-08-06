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
      it 'titleが空ならバリデーションが通らない' do
        question = Question.new(content: "sample", task: @task)
        expect(question).not_to be_valid
      end
      it 'titleが101文字以上ならバリデーションが通らない' do
        question = Question.new(title: "a"*101, content: "sample", task: @task)
        expect(question).not_to be_valid
      end
    end
    context '質問内容バリデーション' do
      it 'contentが空ならバリデーションが通らない' do
        question = Question.new(title: "sample", task: @task)
        expect(question).not_to be_valid
      end
    end
    context 'バリデーションクリア' do
      it 'title,contentのバリデーションが通る' do
        question = Question.new(title: "sample", content: "sample", task: @task)
        expect(question).to be_valid
      end
    end
  end
end
