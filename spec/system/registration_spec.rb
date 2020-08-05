require 'rails_helper'

RSpec.describe '登録機能', type: :system do
  describe '登録画面' do
    before do
      @user = create(:user)
      @company = create(:company)
      @user.update(company_id: @company.id)
      @company.update(admin_id: @user.id)
      @user2 = create(:user2, company: @company)
      visit new_user_invitation_path
      fill_in 'Eメールアドレス', with: 'sample2@example.com'
      fill_in 'パスワード', with: 'password'
      find("#login_btn").click
      visit new_user_invitation_path
    end
    context '客先登録をする場合' do
      before do
        find("#customer_registration").click
      end
      it '正しい情報入力で新しい客先が作成できる' do
        fill_in '客先名', with: 'new_customer'
        fill_in '客先連絡先', with: '090-1111-1111'
        fill_in '客先所在地', with: 'new_customer_location'
        find("#create_customer_btn").click
        sleep(3)
        expect(Customer.all.count).to eq 1
      end
      it '客先名が欠けていると登録できない' do
        fill_in '客先連絡先', with: '090-1111-1111'
        fill_in '客先所在地', with: 'new_customer_location'
        find("#create_customer_btn").click
        sleep(1)
        expect(page).to have_content "客先を登録できませんでした..."
      end
      it '連絡先が欠けていると登録できない' do
        fill_in '客先名', with: 'new_customer'
        fill_in '客先所在地', with: 'new_customer_location'
        find("#create_customer_btn").click
        sleep(1)
        expect(page).to have_content "客先を登録できませんでした..."
      end
    end
  end
end
