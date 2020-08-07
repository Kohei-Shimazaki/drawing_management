class Users::InvitationsController < Devise::InvitationsController
  def new
    @customer = current_user.company.customers.build
    @project = Project.new
    @category = current_user.company.categories.build
    super
  end

  def create
    redirect_to new_user_invitation_path and return if params[:user].nil?
    user_count = User.all.count
    User.import(user_params, current_user)
    if user_count < User.all.count
      flash[:notice] = "ユーザー招待のメールを送信しました！"
    else
      flash[:notice] = "ユーザー招待のメールを送信できませんでした"
    end
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
