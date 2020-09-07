# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ユーザー編集・検索機能', type: :system do
  before do
    @user = create(:user)
    @company = create(:company)
    @user.update(company_id: @company.id)
    @company.update(admin_id: @user.id)
    @user2 = create(:user2, company: @company)
    @team = create(:team, owner: @user, company: @company)
    @team2 = create(:team, name: 'team2', owner: @user, company: @company)
    @team_assign = create(:team_assign, user: @user, team: @team)
    @team_assign2 = create(:team_assign, user: @user, team: @team2)
    @team_assign3 = create(:team_assign, user: @user2, team: @team2)
    visit new_user_session_path
    fill_in 'Eメールアドレス', with: 'sample2@example.com'
    fill_in 'パスワード', with: 'password'
    find('#login_btn').click
  end
  describe 'ユーザー編集画面' do
    before do
      click_on 'ユーザー編集'
    end
    context '正しく情報を入力する' do
      it 'ユーザ情報を更新できる' do
        fill_in 'Eメールアドレス', with: 'user@gmail.com'
        fill_in 'パスワード', with: 'new_password'
        fill_in 'パスワード確認', with: 'new_password'
        fill_in '現在のパスワード', with: 'password'
        click_on '更新'
        expect(page).to have_content 'アカウント情報を変更しました。'
      end
    end
    context 'Eメールアドレスを入力しない' do
      it 'ユーザー情報が更新されない' do
        fill_in 'Eメールアドレス', with: ''
        fill_in '現在のパスワード', with: 'password'
        click_on '更新'
        expect(page).to have_content 'Eメールアドレスを入力してください'
      end
    end
    context '現在のパスワードを入力しない' do
      it 'ユーザー情報が更新されない' do
        fill_in 'Eメールアドレス', with: 'user@gmail.com'
        fill_in 'パスワード', with: 'new_password'
        fill_in 'パスワード確認', with: 'new_password'
        click_on '更新'
        expect(page).to have_content '現在のパスワードを入力してください'
      end
    end
    context 'アカウント削除を押す' do
      it 'アカウントを削除できる' do
        find('#user_delete_btn').click
        page.accept_confirm
        expect(page).to have_content 'アカウントを削除しました'
      end
    end
  end
  describe '会社詳細画面' do
    before do
      visit company_path(@company.id)
    end
    context 'チーム名で検索する' do
      it 'チーム名が一致したユーザーを取得' do
        check("q_teams_id_in_#{@team.id}")
        find('#search_btn').click
        expect(all('table tr').count).to eq 2
      end
    end
    context 'ユーザー名で検索する' do
      it 'ユーザー名が部分一致したユーザーを取得' do
        fill_in 'q_name_cont', with: 'sampl'
        find('#search_btn').click
        expect(all('table tr').count).to eq 3
      end
    end
    context 'emailで検索する' do
      it 'emailが部分一致したユーザーを取得' do
        fill_in 'q_email_cont', with: 'sample@'
        find('#search_btn').click
        expect(all('table tr').count).to eq 2
      end
    end
  end
end
