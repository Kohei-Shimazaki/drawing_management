# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'エビデンス・参考管理機能', type: :system do
  before do
    @user = create(:user)
    @company = create(:company)
    @user.update(company_id: @company.id)
    @company.update(admin_id: @user.id)
    @user2 = create(:user2, company: @company)
    @customer = create(:customer, company: @company)
    @project = create(:project, customer: @customer)
    @team = create(:team, owner: @user, company: @company)
    @team_assign = create(:team_assign, user: @user, team: @team)
    @team_assign2 = create(:team_assign, user: @user2, team: @team)
    @drawing = create(:drawing, team: @team, project: @project)
    @task = create(:task, staff: @user, approver: @user, drawing: @drawing)
    visit new_user_session_path
    fill_in 'Eメールアドレス', with: 'sample@example.com'
    fill_in 'パスワード', with: 'password'
    find('#login_btn').click
  end
  describe 'タスク詳細画面' do
    before do
      visit task_path(@task)
    end
    context 'エビデンスを登録する場合' do
      it '正しい情報入力でエビデンスを登録できる' do
        fill_in 'evidence_comment', with: 'new_evidence'
        find('#create_evidence_btn').click
        sleep(3)
        expect(Evidence.all.count).to eq 1
      end
      it '正しい情報を入力していないと登録できない' do
        find('#create_evidence_btn').click
        sleep(1)
        expect(page).to have_content 'エビデンスコメントを入力してください'
      end
    end
    context '参考を登録する場合' do
      it '正しい情報入力で参考を登録できる' do
        fill_in 'reference_comment', with: 'new_reference'
        find('#create_reference_btn').click
        sleep(3)
        expect(Reference.all.count).to eq 1
      end
      it '正しい情報を入力していないと登録できない' do
        find('#create_reference_btn').click
        sleep(1)
        expect(page).to have_content '参考コメントを入力してください'
      end
    end
  end
end
