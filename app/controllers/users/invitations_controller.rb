class Users::InvitationsController < Devise::InvitationsController
  def new
    @customer = current_user.company.customers.build
    super
  end

  def create
    User.import(user_params, current_user)
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
      params.require(:user).permit(:file)
    end
end
