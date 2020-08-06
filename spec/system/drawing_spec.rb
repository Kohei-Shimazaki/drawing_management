require 'rails_helper'

RSpec.describe '図面管理機能', type: :system do
  describe '図面登録機能' do
    before do
      @user = create(:user)
      @company = create(:company)
      @user.update(company_id: @company.id)
      @company.update(admin_id: @user.id)
      @customer = create(:customer, company: @company)
      @project = create(:project, customer: @customer)
      @team = create(:team, owner: @user, company: @company)
      @team_assign = create(:team_assign, user: @user, team: @team)
      visit new_user_session_path
      fill_in 'Eメールアドレス', with: 'sample@example.com'
      fill_in 'パスワード', with: 'password'
      find("#login_btn").click
      visit team_path(@team.id)
      click_on "図面新規"
    end
    context '正しい情報を入力する' do
      it '図面を登録できる' do
        fill_in "図名", with: "new_drawing"
        fill_in "図番", with: 100001
        fill_in "説明", with: "new_drawing_explanation"
        select @project.name, from: "drawing[project_id]"
        find('#drawing_submit_btn').click
        expect(Drawing.all.count).to eq 1
      end
    end
    context "正しい情報を入力していない" do
      it '図名なしでは図面を登録できない' do
        fill_in "図番", with: 100001
        fill_in "説明", with: "new_drawing_explanation"
        select @project.name, from: "drawing[project_id]"
        find('#drawing_submit_btn').click
        expect(page).to have_content '図名を入力してください'
      end
      it '図番なしでは図面を登録できない' do
        fill_in "図名", with: "new_drawing"
        fill_in "説明", with: "new_drawing_explanation"
        select @project.name, from: "drawing[project_id]"
        find('#drawing_submit_btn').click
        expect(page).to have_content '図番を入力してください'
      end
    end
  end
end
