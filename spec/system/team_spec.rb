# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'チーム作成機能', type: :system do
  describe 'チーム登録画面', js: true do
    before do
      @user = create(:user)
      @company = create(:company)
      @user.update(company_id: @company.id)
      @company.update(admin_id: @user.id)
      @user2 = create(:user2, company: @company)
      visit new_user_session_path
      fill_in 'Eメールアドレス', with: 'sample@example.com'
      fill_in 'パスワード', with: 'password'
      find('#login_btn').click
      find('#new_team_btn').click
      sleep(3)
    end
    context 'チーム登録に必要な情報を入力した場合', js: true do
      it '新しいチームが作成できる' do
        fill_in '名前', with: 'new_team'
        fill_in 'チームプロフィール', with: 'new_team_profile'
        find('#create_team_btn').click
        sleep(3)
        expect(Team.all.count).to eq 1
      end
    end
    context 'チーム登録に必要な情報がない場合', js: true do
      it '新しいチームを作成できない' do
        fill_in 'チームプロフィール', with: 'new_team_profile'
        find('#create_team_btn').click
        expect(page).to have_content 'チームを登録できませんでした...'
      end
    end
  end
  describe 'チーム画面' do
    before do
      @user = create(:user)
      @company = create(:company)
      @user.update(company_id: @company.id)
      @company.update(admin_id: @user.id)
      @user2 = create(:user2, company: @company)
      @user3 = create(:user, id: 3, name: 'sample3', email: 'sample3@example.com', company: @company)
      @team = create(:team, company: @company, owner: @user)
      @teamassign1 = create(:team_assign, user: @user, team: @team)
      @teamassign2 = create(:team_assign, user: @user2, team: @team)
      visit new_user_session_path
      fill_in 'Eメールアドレス', with: 'sample@example.com'
      fill_in 'パスワード', with: 'password'
      find('#login_btn').click
      visit team_path(@team.id)
    end
    context 'チームを編集する場合' do
      before do
        click_on 'チーム編集'
      end
      it '正しい情報入力でチーム情報を更新できる' do
        fill_in '名前', with: 'edit_team'
        fill_in 'チームプロフィール', with: 'edit_team_profile'
        find('#update_team_btn').click
        expect(page).to have_content 'チームを更新しました!'
      end
      it '情報が正しくないと更新できない' do
        fill_in '名前', with: ''
        fill_in 'チームプロフィール', with: 'edit_team_profile'
        find('#update_team_btn').click
        expect(page).to have_content '名前を入力してください'
      end
    end
    context 'チームにメンバーを加える場合' do
      it '同じ会社のユーザーを登録できる' do
        select 'sample3', from: 'team_assign[user_id]'
        find('#team_assign_btn').click
        sleep(3)
        expect(@team.members.count).to eq 3
      end
    end
    context 'チームのメンバーを削除する場合' do
      it '削除ボタンを押せば削除できる' do
        find("#member_delete_#{@teamassign2.id}").click
        sleep(3)
        expect(@team.members.count).to eq 1
      end
    end
    context 'チャットを送る場合' do
      before do
        click_on 'チャットルーム'
      end
      it 'メッセージを送れる', js: true do
        find('.form-control').set('sample_chat')
        find('.form-control').native.send_keys(:return)
        sleep(3)
        expect(Message.last.content).to eq 'sample_chat'
      end
    end
  end
end
