# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'タスクモデルテスト' do
    before do
      @company = create(:company)
      @customer = create(:customer, company: @company)
      @project = create(:project, customer: @customer)
      @category = create(:category, company: @company)
      @user = create(:user)
      @team = create(:team, company: @company, owner: @user)
      @drawing = create(:drawing, team: @team, project: @project)
    end
    context 'タスクタイトルバリデーション' do
      it 'titleが空ならバリデーションが通らない' do
        task = Task.new(content: 'sample', deadline: Time.current, drawing: @drawing)
        expect(task).not_to be_valid
      end
      it 'titleが101文字以上ならバリデーションが通らない' do
        task = Task.new(title: 't' * 101, content: 'sample', deadline: Time.current, drawing: @drawing)
        expect(task).not_to be_valid
      end
    end
    context 'タスク期限バリデーション' do
      it 'deadlineが空ならバリデーションが通らない' do
        task = Task.new(title: 'sample', content: 'sample', drawing: @drawing)
        expect(task).not_to be_valid
      end
    end
    context 'バリデーションクリア' do
      it 'title,deadlineのバリデーションが通る' do
        task = Task.new(title: 'sample', content: 'sample', deadline: Time.current, drawing: @drawing)
        expect(task).to be_valid
      end
    end
  end
end
