class TeamChannel < ApplicationCable::Channel
  def subscribed
    stream_from "team_channel_#{params['team_id']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    message = Message.create!(
      content: data['message'],
      team_id: data['team_id'],
      user_id: current_user.id
    )
  end

  def message_read(data)
    unless data['user_id'] == current_user.id
      message_read = MessageRead.create!(
        user_id: current_user.id,
        message_id: data['message_id'],
      )
      ActionCable.server.broadcast(
        "team_channel_#{message_read.message.team_id}",
        message_read: true,
        message_id: message_read.message.id,
        user_name: message_read.user.name
      )
    end
  end
end
