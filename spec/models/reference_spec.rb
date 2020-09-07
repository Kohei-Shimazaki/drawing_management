# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reference, type: :model do
  describe '参考モデルテスト' do
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
    context '参考エビデンスコメントバリデーション' do
      it 'commentが空ならバリデーションが通らない' do
        reference = Reference.new(task: @task)
        expect(reference).not_to be_valid
      end
    end
    context 'バリデーションクリア' do
      it 'commentのバリデーションが通る' do
        reference = Reference.new(comment: 'sample', task: @task)
        expect(reference).to be_valid
      end
    end
  end
end
