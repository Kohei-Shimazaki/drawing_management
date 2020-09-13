# frozen_string_literal: true

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
      @project = create(:project, customer: @customer)
      @category = create(:category, company: @company)
      visit new_user_invitation_path
      fill_in 'Eメールアドレス', with: 'sample@example.com'
      fill_in 'パスワード', with: 'password'
      find('#login_btn').click
      visit new_user_invitation_path
    end
    context '社員登録をする場合' do
      before do
        find('#user_invitation').click
        attach_file 'Excelファイル', "#{Rails.root}/spec/factories/test_1.xlsx"
        find('#user_invitation_btn').click
        sleep(5)
      end
      it '社員招待メールを送ることができる' do
        expect(User.all.count).to eq 3
      end
    end
    context '客先登録をする場合' do
      before do
        find('#customer_registration').click
      end
      it '正しい情報入力で新しい客先が作成できる' do
        fill_in 'customer_name_0', with: 'new_customer'
        fill_in 'customer_phone_number_0', with: '090-1111-1111'
        fill_in 'customer_location_0', with: 'new_customer_location'
        find('#create_customer_btn_0').click
        sleep(3)
        expect(Customer.all.count).to eq 2
      end
      it '客先名が欠けていると登録できない', js: true do
        fill_in 'customer_phone_number_0', with: '090-1111-1111'
        fill_in 'customer_location_0', with: 'new_customer_location'
        find('#create_customer_btn_0').click
        sleep(1)
        expect(page).to have_content '客先名を入力してください'
      end
      it '電話番号が欠けていると登録できない', js: true do
        fill_in 'customer_name_0', with: 'new_customer'
        fill_in 'customer_location_0', with: 'new_customer_location'
        find('#create_customer_btn_0').click
        sleep(1)
        expect(page).to have_content '電話番号を入力してください'
      end
    end
    context '客先を編集・削除する場合', js: true do
      before do
        find('#customer_registration').click
      end
      it '削除アイコンを押して、客先を削除できる', js: true do
        find("#customer_delete_#{@customer.id}").click
        page.accept_confirm
        sleep(3)
        expect(Customer.all.count).to eq 0
      end
      it '編集アイコンを押して、客先を編集できる', js: true do
        find("#customer_edit_#{@customer.id}").click
        fill_in "customer_name_#{@customer.id}", with: 'edit_customer'
        fill_in "customer_phone_number_#{@customer.id}", with: '090-1112-1111'
        fill_in "customer_location_#{@customer.id}", with: 'edit_customer_location'
        find("#create_customer_btn_#{@customer.id}").click
        sleep(3)
        expect(page).to have_content 'edit_customer'
      end
    end
    context 'プロジェクト登録をする場合', js: true do
      before do
        find('#project_registration').click
      end
      it '正しい情報入力でプロジェクトを登録できる' do
        fill_in 'project_name_0', with: 'new_project'
        fill_in 'project_location_0', with: 'new_project_location'
        fill_in 'project_explanation_0', with: 'new_project_explanation'
        find('#create_project_btn_0').click
        sleep(3)
        expect(Project.all.count).to eq 2
      end
      it 'プロジェクト名なしで登録できない', js: true do
        fill_in 'project_location_0', with: 'new_project_location'
        fill_in 'project_explanation_0', with: 'new_project_explanation'
        find('#create_project_btn_0').click
        sleep(1)
        expect(page).to have_content 'プロジェクト名を入力してください'
      end
    end
    context 'プロジェクトを編集・削除する場合', js: true do
      before do
        find('#project_registration').click
      end
      it '削除ボタンを押して、プロジェクトを削除できる', js: true do
        find("#project_delete_#{@project.id}").click
        page.accept_confirm
        sleep(3)
        expect(Project.all.count).to eq 0
      end
      it '編集ボタンを押して、プロジェクトを編集できる', js: true do
        find("#project_edit_#{@project.id}").click
        fill_in "project_name_#{@project.id}", with: 'edit_project'
        fill_in "project_location_#{@project.id}", with: 'edit_project_location'
        fill_in "project_explanation_#{@project.id}", with: 'edit_project_explanation'
        find("#create_project_btn_#{@project.id}").click
        sleep(3)
        expect(page).to have_content 'edit_project'
      end
    end
    context 'カテゴリー登録をする場合' do
      before do
        find('#category_registration').click
      end
      it '正しい情報入力でカテゴリーを登録できる' do
        fill_in 'category_name_0', with: 'new_category'
        fill_in 'category_explanation_0', with: 'new_category_explanation'
        find('#create_category_btn_0').click
        sleep(3)
        expect(Category.all.count).to eq 2
      end
      it 'カテゴリー名なしで登録できない', js: true do
        fill_in 'category_explanation_0', with: 'new_category_explanation'
        find('#create_category_btn_0').click
        sleep(1)
        expect(page).to have_content 'カテゴリ名を入力してください'
      end
    end
    context 'カテゴリーを編集・削除する場合' do
      before do
        find('#category_registration').click
      end
      it '削除ボタンを押して、カテゴリーを削除できる', js: true do
        find("#category_delete_#{@category.id}").click
        page.accept_confirm
        sleep(3)
        expect(Category.all.count).to eq 0
      end
      it '編集ボタンを押して、カテゴリーを編集できる', js: true do
        find("#category_edit_#{@category.id}").click
        fill_in "category_name_#{@category.id}", with: 'edit_category'
        fill_in "category_explanation_#{@category.id}", with: 'edit_category_explanation'
        find("#create_category_btn_#{@category.id}").click
        sleep(3)
        expect(page).to have_content 'edit_category'
      end
    end
  end
end
