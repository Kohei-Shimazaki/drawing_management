require 'rails_helper'

RSpec.describe '登録機能', type: :system do
  describe '登録画面' do
    before do
      @user = create(:user)
      @company = create(:company)
      @user.update(company_id: @company.id)
      @company.update(admin_id: @user.id)
      @user2 = create(:user2, company: @company)
      @customer = create(:customer, company: @company)
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
        fill_in 'customer_name_0', with: 'new_customer'
        fill_in 'customer_phone_number_0', with: '090-1111-1111'
        fill_in 'customer_location_0', with: 'new_customer_location'
        find("#create_customer_btn_0").click
        sleep(3)
        expect(Customer.all.count).to eq 2
      end
      it '客先名が欠けていると登録できない' do
        fill_in 'customer_phone_number_0', with: '090-1111-1111'
        fill_in 'customer_location_0', with: 'new_customer_location'
        find("#create_customer_btn_0").click
        sleep(1)
        expect(page).to have_content "客先を登録できませんでした..."
      end
      it '連絡先が欠けていると登録できない' do
        fill_in 'customer_name_0', with: 'new_customer'
        fill_in 'customer_location_0', with: 'new_customer_location'
        find("#create_customer_btn_0").click
        sleep(1)
        expect(page).to have_content "客先を登録できませんでした..."
      end
    end
    context '客先を編集・削除する場合' do
      before do
        find("#customer_registration").click
      end
      it '削除アイコンを押して、客先を削除できる' do
        find("#customer_delete_#{@customer.id}").click
        page.accept_confirm
        sleep(3)
        expect(Customer.all.count).to eq 0
      end
      it '編集アイコンを押して、客先を編集できる' do
        find("#customer_edit_#{@customer.id}").click
        fill_in "customer_name_#{@customer.id}", with: 'edit_customer'
        fill_in "customer_phone_number_#{@customer.id}", with: '090-1112-1111'
        fill_in "customer_location_#{@customer.id}", with: 'edit_customer_location'
        find("#create_customer_btn_#{@customer.id}").click
        sleep(3)
        expect(page).to have_content "edit_customer"
      end
    end
    context 'プロジェクト登録をする場合' do
      before do
        find("#project_registration").click
      end
      it 'プロジェクト登録をする' do
      end
    end
  end
end
