class TeamChannel < ApplicationCable::Channel
  def subscribed
    stream_from "team_channel_#{params['team_id']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Message.create!(
      content: data['message'],
      team_id: data['team_id'],
      user_id: current_user.id
    )
  end

  def notification(data)
    ActionCable.server.broadcast 'team_channel_1', notice: data['notice']
  end
end
