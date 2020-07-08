class Users::InvitationsController < Devise::InvitationsController
  def new
    super
  end

  def create
    User.import(params[:user])
    flash[:notice] = "ユーザー招待のメールを送信しました！"
    redirect_to new_user_indivation_path
  end

  def edit
    super
  end

  def update
    super
  end

  def destroy
    super
  end
end
