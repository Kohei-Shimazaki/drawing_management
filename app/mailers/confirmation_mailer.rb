class ConfirmationMailer < ApplicationMailer
  def confirmation_mail(users, admin)
    @users = users
    mail to: admin.email, subject: "招待メール送信完了のお知らせ"
  end
end
