require 'rails_helper'

RSpec.describe '質問管理機能', type: :system do
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
  describe '質問登録画面' do
    before do
      visit new_question_path(task_id: @task.id)
    end
    context '正しい情報を入力する場合' do
      before do
        fill_in "タイトル", with: "new_question"
        fill_in "内容", with: "new_question_content"
        find("#create_question_btn").click
      end
      it '質問が投稿できる' do
        expect(Question.all.count).to eq 1
      end
      it '質問をした通知が作成される' do
        expect(Notification.last.action_type).to eq 'question_to_task'
      end
    end
    context '正しい情報を入力していない場合' do
      it '質問が投稿できない' do
        fill_in "内容", with: "new_question_content"
        find("#create_question_btn").click
        expect(page).to have_content "タイトルを入力してください"
      end
    end
  end
  describe '質問詳細画面' do
    before do
      @question = create(:question, task: @task)
      visit question_path(@question)
    end
    context 'コメントを投稿する場合' do
      before do
        fill_in "内容", with: "new_comment"
        find("#comment_create_btn").click
        sleep(3)
      end
      it '正しい情報入力で、コメントを投稿できる' do
        expect(Comment.all.count).to eq 1
      end
      it 'コメントをした通知が作成される' do
        expect(Notification.last.action_type).to eq 'comment_to_question'
      end
    end
    context '正しい情報を入力していない場合' do
      it 'コメントできない' do
        find("#comment_create_btn").click
        sleep(1)
        expect(page).to have_content 'コメント内容を入力してください'
      end
    end
    context '質問にいいねをつける場合' do
      before do
        find(".like_btn").click
        sleep(3)
      end
      it 'いいねボタンをおすと、いいねがつけられる' do
        expect(Like.all.count).to eq 1
      end
    end
  end
end
