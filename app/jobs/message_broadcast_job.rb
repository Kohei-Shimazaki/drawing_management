class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast(
      "team_channel_#{message.team_id}",
      message: render_message(message),
      team_id: message.team_id
    )
  end

  private
    def render_message(message)
      renderer = ApplicationController.renderer.new(
        http_host: 'pacific-shelf-39716.herokuapp.com',
        https: true
      )
      renderer.render(partial: 'messages/message', locals: { message: message })
    end
end
