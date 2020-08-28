# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    @user = User.new(sign_up_params)
    unless @user.valid?
      render :new and return
    end

    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    @company = Company.new
    render :new_company
  end

  def new_company
  end

  def create_company
    @user = User.new(session["devise.regist_data"]["user"])
    @company = Company.new(company_params)
    unless @company.valid?
      render :new_company and return
    end
    @company.save
    @user.company_id = @company.id
    @user.save
    @company.admin_id = @user.id
    @company.save
    sign_in(:user, @user)
    redirect_to user_path(@user)
  end

protected

  def company_params
    params.require(:company).permit(
      :name,
      :icon,
      :location,
      :phone_number,
      :overview,
    )
  end

  def after_update_path_for(resource)
    user_path(resource)
  end
  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
