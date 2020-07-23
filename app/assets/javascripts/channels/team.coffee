document.addEventListener 'turbolinks:load', ->

  App.team = App.cable.subscriptions.create {
    channel: "TeamChannel",
    team_id: $("#chat").data("team_id")},

    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      $('#messages_'+data['team_id']).prepend data['message']

    speak: (message) ->
      team_id = $('#chat').data('team_id')
      @perform 'speak', message: message, team_id: team_id

    notification: ->
      @perform 'notification', notice: true

$(document).on 'keypress', '[data-behavior~=team_speaker]', (event) ->
  if event.keyCode is 13 # return = send
    App.team.speak event.target.value
    event.target.value = ''
    event.preventDefault()
