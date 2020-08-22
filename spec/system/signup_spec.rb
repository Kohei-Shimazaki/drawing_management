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
        fill_in '会社名', with: "sample_company"
        fill_in '連絡先', with: "090-101-1001"
        fill_in '住所', with: "東京都 港区"
        fill_in '会社概要', with: "sample"
        click_on "登録"
        expect(Company.all.count).to eq 1
      end
    end
    context 'ユーザーがログインしている場合' do
      before do
        fill_in '社員番号', with: 100001
        fill_in '名前', with: 'user_name'
        fill_in 'Eメールアドレス', with: 'user@gmail.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_on '会社登録へ'
        fill_in '会社名', with: "sample_company"
        fill_in '連絡先', with: "090-101-1001"
        fill_in '住所', with: "東京都 港区"
        fill_in '会社概要', with: "sample"
        click_on "登録"
      end
      it "ユーザー登録画面にアクセスできない" do
        expect(page).to have_content '新規チーム'
      end
      it "ログアウトできる" do
        click_on "ログアウト"
        expect(page).to have_content 'ログイン'
      end
    end
  end
  describe 'ログイン画面' do
    before do
      @user = create(:user)
      company = create(:company)
      @user.update(company_id: company.id)
      company.update(admin_id: @user.id)
      visit new_user_session_path
    end
    context 'アカウントがあり、ログインしていない場合' do
      it 'マイページにアクセスできない' do
        visit user_path(@user.id)
        expect(page).to have_content 'アカウント登録もしくはログインしてください。'
      end
      it '正しい情報入力でログインできる' do
        fill_in 'Eメールアドレス', with: 'sample@example.com'
        fill_in 'パスワード', with: 'password'
        find("#login_btn").click
        expect(page).to have_content 'ログアウト'
      end
      it "誤った情報入力ではログインできない" do
        fill_in 'Eメールアドレス', with: 'sample@example.com'
        fill_in 'パスワード', with: 'failurepassword'
        find("#login_btn").click
        expect(page).to have_content 'Eメールアドレスまたはパスワードが違います。'
      end
    end
  end
  describe 'トップ画面' do
    before do
      company = create(:company, id: 1)
      visit root_path
    end
    it 'ゲストログインができる' do
      click_on "ゲストログイン"
      expect(page).to have_content "ゲストユーザーとしてログインしました。"
    end
  end
end
