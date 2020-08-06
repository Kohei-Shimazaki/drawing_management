require 'rails_helper'

RSpec.describe 'レビジョン・タスク管理機能', type: :system do
  before do
    @user = create(:user)
    @company = create(:company)
    @user.update(company_id: @company.id)
    @company.update(admin_id: @user.id)
    @user2 = create(:user2, company: @company)
    @customer = create(:customer, company: @company)
    @project = create(:project, customer: @customer)
    @team = create(:team, owner: @user, company: @company)
    @team_assign = create(:team_assign, user: @user, team: @team)
    @team_assign2 = create(:team_assign, user: @user2, team: @team)
    @drawing = create(:drawing, team: @team, project: @project)
    @task = create(:task, staff: @user, approver: @user, drawing: @drawing)
    visit new_user_session_path
    fill_in 'Eメールアドレス', with: 'sample@example.com'
    fill_in 'パスワード', with: 'password'
    find("#login_btn").click
  end
  describe 'タスク登録画面' do
    before do
      visit "tasks/new?drawing_id=#{@drawing.id}"
    end
    context 'タスクを登録する場合' do
      it '正しい情報入力でタスクを登録できる' do
        fill_in "タイトル", with: "new_task"
        fill_in "期限", with: Date.today
        fill_in "内容", with: "new_task_content"
        select @user.name, from: "task[staff_id]"
        select @user2.name, from: "task[approver_id]"
        find('#task_create_btn').click
        expect(Task.all.count).to eq 2
      end
      it '正しい情報を入力しないとタスク登録できない' do
        fill_in "期限", with: Date.today
        fill_in "内容", with: "new_task_content"
        select @user.name, from: "task[staff_id]"
        select @user2.name, from: "task[approver_id]"
        find('#task_create_btn').click
        expect(page).to have_content 'タイトルを入力してください'
      end
    end
    context 'タスクを編集する場合' do
      before do
        @task = create(:task, staff: @user, approver: @user, drawing: @drawing)
        visit edit_task_path(@task.id)
      end
      it '正しい情報入力でタスクを編集できる' do
        fill_in "タイトル", with: "edit_task"
        fill_in "期限", with: Date.today
        fill_in "内容", with: "edit_task_content"
        select @user.name, from: "task[staff_id]"
        select @user2.name, from: "task[approver_id]"
        find('#task_update_btn').click
        expect(Task.second.title).to eq "edit_task"
      end
      it '正しい情報を入力しないとタスクを更新できない' do
        fill_in "タイトル", with: ""
        fill_in "期限", with: Date.today
        fill_in "内容", with: "edit_task_content"
        select @user.name, from: "task[staff_id]"
        select @user2.name, from: "task[approver_id]"
        find('#task_update_btn').click
        expect(page).to have_content 'タイトルを入力してください'
      end
    end
  end
  describe 'レビジョン登録画面' do
    before do
      visit drawing_path(@drawing.id)
      click_on "レビジョン新規"
    end
    context 'レビジョンを登録する場合' do
      it '正しい情報入力でレビジョンを登録できる' do
        attach_file 'ファイル', "#{Rails.root}/spec/factories/test.jpg"
        fill_in 'コメント', with: "new_revision"
        find("#revision_submit_btn").click
        expect(Revision.all.count).to eq 1
      end
      it '正しい情報を入力しないとレビジョンを登録できない' do
        fill_in 'コメント', with: "new_revision"
        find("#revision_submit_btn").click
        expect(page).to have_content "ファイルがありません"
      end
    end
  end
  describe '図面詳細画面' do
    before do
      visit drawing_path(@drawing.id)
      click_on "レビジョン新規"
      attach_file 'ファイル', "#{Rails.root}/spec/factories/test.jpg"
      fill_in 'コメント', with: "new_revision"
      find("#revision_submit_btn").click
      visit drawing_path(@drawing.id)
    end
    context 'レビジョンにタスクを紐づける場合' do
      before do
        select @task.title, from: "task[task_id]"
        click_on "レビジョン登録"
      end
      it 'タスクのstatusがapproval_waitingに変わる' do
        expect(page).to have_content "承認待ち"
      end
      it 'タスク承認待ちの通知が作られる' do
        expect(Notification.last.action_type).to eq "task_approval_waiting"
      end
    end
    context 'タスクを承認する場合' do
      before do
        select @task.title, from: "task[task_id]"
        click_on "レビジョン登録"
        sleep(1)
        find("#task_completed_#{@task.id}").click
      end
      it 'タスクのstatusがcompletedに変わる' do
        expect(page).to have_content "完了"
      end
      it 'タスク完了の通知が作られる' do
        expect(Notification.last.action_type).to eq "task_completed"
      end
    end
    context 'タスク承認を解除する場合' do
      before do
        select @task.title, from: "task[task_id]"
        click_on "レビジョン登録"
        sleep(1)
        find("#task_completed_#{@task.id}").click
        find("#task_approval_rescission_#{@task.id}").click
      end
      it 'タスク承認取り消しの通知が作成される' do
        expect(Notification.last.action_type).to eq "task_approval_rescission"
      end
    end
  end
end
