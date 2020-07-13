class Users::InvitationsController < Devise::InvitationsController
  def new
    super
  end

  def create
    User.import(user_params)
    flash[:notice] = "ユーザー招待のメールを送信しました！"
    redirect_to new_user_invitation_path
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
  private
    def user_params
      params.require(:user).permit(:file, :invited_by)
    end
end