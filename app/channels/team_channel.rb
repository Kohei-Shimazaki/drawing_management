class TeamChannel < ApplicationCable::Channel
  def subscribed
    stream_from "team_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Message.create!(content: data['message'], team_id: data['team_id'], user_id: data['user_id'] )
  end
end
