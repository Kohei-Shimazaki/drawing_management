require 'rails_helper'

RSpec.describe 'ユーザー情報編集機能', type: :system do
  describe 'ユーザー編集画面' do
    before do
      @user = create(:user)
      @company = create(:company)
      @user.update(company_id: @company.id)
      @company.update(admin_id: @user.id)
      @user2 = create(:user2, company: @company)
      visit new_user_session_path
      fill_in 'Eメールアドレス', with: 'sample2@example.com'
      fill_in 'パスワード', with: 'password'
      find("#login_btn").click
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
        find("#user_delete_btn").click
        page.accept_confirm
        expect(page).to have_content 'アカウントを削除しました'
      end
    end
  end
end
