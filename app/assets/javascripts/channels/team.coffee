document.addEventListener 'turbolinks:load', ->
  subscriptions = App.cable.subscriptions['subscriptions'];
  i = 0
  while i < $("#team_ids").data("team_id").length
    if (!subscriptions[i])
      App.team = App.cable.subscriptions.create {
        channel: "TeamChannel",
        team_id: $("#team_ids").data("team_id")[i]},

        connected: ->
          # Called when the subscription is ready for use on the server

        disconnected: ->
          # Called when the subscription has been terminated by the server

        received: (data) ->
          if data['message']
            $('#messages_'+data['team_id']).prepend data['message']
          if data['notice']
            alert "OK"

        speak: (message) ->
          team_id = $('#chat').data('team_id')
          @perform 'speak', message: message, team_id: team_id
    i++

$(document).on 'keypress', '[data-behavior~=team_speaker]', (event) ->
  if event.keyCode is 13 # return = send
    App.team.speak event.target.value
    event.target.value = ''
    event.preventDefault()
