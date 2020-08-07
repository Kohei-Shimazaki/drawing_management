module NotificationsHelper
  def number_of_unread_notifications
    current_user.teams.inject(0){ |number, team| number + team.notifications.count } - current_user.notification_reads.count
  end
end
