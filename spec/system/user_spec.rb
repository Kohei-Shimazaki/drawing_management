require 'rails_helper'

RSpec.describe 'サインアップ機能', type: :system do
  describe 'ユーザー登録画面' do
    before do
      visit new_user_registration_path
    end
    context 'ユーザがログインしていない場合' do
      it 'ユーザの新規登録ができる' do
        fill_in '社員番号', with: 100001
        fill_in '名前', with: 'user_name'
        fill_in 'Eメールアドレス', with: 'user@gmail.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_on '会社登録へ'
        sleep(3)
        fill_in '会社名', with: "sample_company"
        fill_in '連絡先', with: "090-101-1001"
        fill_in '住所', with: "東京都 港区"
        fill_in '会社概要', with: "sample"
        click_on "登録"
        expect(User.all.count).to eq 1
      end
      it '会社の新規登録ができる' do
        fill_in '社員番号', with: 100001
        fill_in '名前', with: 'user_name'
        fill_in 'Eメールアドレス', with: 'user@gmail.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_on '会社登録へ'
        sleep(3)
        fill_in '会社名', with: "sample_company"
        fill_in '連絡先', with: "090-101-1001"
        fill_in '住所', with: "東京都 港区"
        fill_in '会社概要', with: "sample"
        click_on "登録"
        expect(Company.all.count).to eq 1
      end
    end
  end
end
