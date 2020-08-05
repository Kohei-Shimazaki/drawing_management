require 'rails_helper'

RSpec.describe 'チーム作成機能', type: :system do
  describe 'チーム登録画面' do
    before do
      @user = create(:user)
      @company = create(:company)
      @user.update(company_id: @company.id)
      @company.update(admin_id: @user.id)
      @user2 = create(:user2, company: @company)
      visit new_user_session_path
      fill_in 'Eメールアドレス', with: 'sample@example.com'
      fill_in 'パスワード', with: 'password'
      find("#login_btn").click
      find("#new_team_btn").click
      sleep(3)
    end
    context 'チーム登録に必要な情報を入力した場合' do
      it '新しいチームが作成できる' do
        fill_in '名前', with: 'new_team'
        fill_in 'チームプロフィール', with: 'new_team_profile'
        find("#create_team_btn").click
        sleep(3)
        expect(Team.all.count).to eq 1
      end
    end
    context 'チーム登録に必要な情報がない場合' do
      it '新しいチームを作成できない' do
        fill_in 'チームプロフィール', with: 'new_team_profile'
        find("#create_team_btn").click
        expect(page).to have_content 'チームを登録できませんでした...'
      end
    end
  end
end
