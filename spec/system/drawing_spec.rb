# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '図面管理機能', type: :system do
  before do
    @user = create(:user)
    @company = create(:company)
    @user.update(company_id: @company.id)
    @company.update(admin_id: @user.id)
    @customer = create(:customer, company: @company)
    @customer2 = create(:customer, name: 'customer2', company: @company)
    @project = create(:project, customer: @customer)
    @project2 = create(:project, name: 'project2', customer: @customer)
    @team = create(:team, owner: @user, company: @company)
    @team2 = create(:team, name: 'team2', owner: @user, company: @company)
    @team_assign = create(:team_assign, user: @user, team: @team)
    @drawing = create(:drawing, team: @team, project: @project)
    @drawing2 = create(:drawing, team: @team2, project: @project)
    @drawing3 = create(:drawing, title: 'target', team: @team, project: @project2)
    visit new_user_session_path
    fill_in 'Eメールアドレス', with: 'sample@example.com'
    fill_in 'パスワード', with: 'password'
    find('#login_btn').click
  end
  describe '図面登録機能' do
    before do
      visit team_path(@team.id)
      click_on '図面新規'
    end
    context '正しい情報を入力する' do
      it '図面を登録できる' do
        fill_in '図名', with: 'new_drawing'
        fill_in '図番', with: 100_001
        fill_in '説明', with: 'new_drawing_explanation'
        select @project.name, from: 'drawing[project_id]'
        find('#drawing_submit_btn').click
        expect(Drawing.last.title).to eq 'new_drawing'
      end
    end
    context '正しい情報を入力していない' do
      it '図名なしでは図面を登録できない' do
        fill_in '図番', with: 100_001
        fill_in '説明', with: 'new_drawing_explanation'
        select @project.name, from: 'drawing[project_id]'
        find('#drawing_submit_btn').click
        expect(page).to have_content '図名を入力してください'
      end
      it '図番なしでは図面を登録できない' do
        fill_in '図名', with: 'new_drawing'
        fill_in '説明', with: 'new_drawing_explanation'
        select @project.name, from: 'drawing[project_id]'
        find('#drawing_submit_btn').click
        expect(page).to have_content '図番を入力してください'
      end
    end
  end
  describe '図面一覧画面' do
    before do
      visit drawings_path
    end
    context '客先名で検索する' do
      it '客先名が一致したデータを取得' do
        select @customer.name, from: 'q[customer_id_eq]'
        find('#search_btn').click
        expect(all('table tr').count).to eq 4
      end
    end
    context 'プロジェクト名で検索する' do
      it 'プロジェクト名が一致したデータを取得' do
        select @project.name, from: 'q[project_id_eq]'
        find('#search_btn').click
        expect(all('table tr').count).to eq 3
      end
    end
    context 'チーム名で検索する' do
      it 'チーム名が一致したデータを取得' do
        select @team2.name, from: 'q[team_id_in]'
        find('#search_btn').click
        expect(all('table tr').count).to eq 2
      end
    end
    context '図名で検索する' do
      it '図名が部分一致したデータを取得' do
        fill_in 'q_title_cont', with: 'target'
        find('#search_btn').click
        expect(all('table tr').count).to eq 2
      end
    end
  end
end
