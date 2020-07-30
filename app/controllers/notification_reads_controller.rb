class NotificationReadsController < ApplicationController

  def create
    notification = Notification.find(params[:notification_id])
    notification_read = current_user.notification_reads.create(notification_id: params[:notification_id])
    notification_read.save
    redirect_to notification.redirect_path
  end

end
