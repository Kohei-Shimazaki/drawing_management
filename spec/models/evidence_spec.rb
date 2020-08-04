require 'rails_helper'

RSpec.describe Evidence, type: :model do
  describe 'エビデンスモデルテスト' do
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
    end
    context 'エビデンスコメントバリデーション' do
      it 'commentが空ならバリデーションが通らない' do
        evidence = Evidence.new(task: @task)
        expect(evidence).not_to be_valid
      end
    end
    context 'バリデーションクリア' do
      it 'commentのバリデーションが通る' do
        evidence = Evidence.new(comment: "sample", task: @task)
        expect(evidence).to be_valid
      end
    end
  end
end
