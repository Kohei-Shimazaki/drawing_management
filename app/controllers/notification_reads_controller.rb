class NotificationReadsController < ApplicationController

  def create
    notification = Notification.find(params[:notification_id])
    notification_read = current_user.notification_reads.create(notification_id: params[:notification_id])
    notification_read.save
    redirect_to notification.redirect_path
  end

  def all_read
    notifications = current_user.teams.map{|team| team.notifications }.flatten
    read_notifications = current_user.has_read_notifications
    unread_notifications = notifications - read_notifications
    unread_notifications.each{ |notification| NotificationRead.create(user_id: current_user.id, notification_id: notification.id) }
    redirect_back(fallback_location: user_path(current_user))
  end
end
