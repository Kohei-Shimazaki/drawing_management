document.addEventListener 'turbolinks:load', ->
  subscriptions = App.cable.subscriptions['subscriptions'];
  i = 0
  while i < $("#team_coffee_datas").data("team_ids").length
    if (!subscriptions[i])
      App.team = App.cable.subscriptions.create {
        channel: "TeamChannel",
        team_id: $("#team_coffee_datas").data("team_ids")[i]},

        connected: ->
          # Called when the subscription is ready for use on the server

        disconnected: ->
          # Called when the subscription has been terminated by the server

        received: (data) ->
          if data['message']
            $('#messages_'+data['team_id']).prepend data['message']
          if data['notification'] && data['user_id'] != $("#team_coffee_datas").data("user_id")
            $('#notifications').prepend data['notification']
            $("#unread_notifications").text String(Number($("#unread_notifications").text()) + 1)
          if data['message_read']
            $('#message_read_count_'+data['message_id']).text String(Number($('#message_read_count').text()) + 1)
            if $('#message_read_users_'+data['message_id']).text().replace(/\r?\n/g,"").replace(/^\s+/g, "") == ":         "
              $('#message_read_users_'+data['message_id']).text $('#message_read_users').text()+data['user_name']
            else
              $('#message_read_users_'+data['message_id']).text $('#message_read_users').text()+"/"+data['user_name']

        speak: (message) ->
          team_id = $('#chat').data('team_id')
          @perform 'speak', message: message, team_id: team_id

        message_read: ->
          @perform 'message_read',
            message_id: Number($("#message_id").text()),
            user_id: Number($("#message_user_id").text()),
            team_id: $('#chat').data('team_id')

        message_created_at = null
        setInterval ->
          if $("#chat").data('team_id')
            if message_created_at
              if message_created_at != $("#message_created_at").text()
                App.team.message_read()
                message_created_at = $("#message_created_at").text()
            else
              message_created_at = $("#message_created_at").text()

    i++

$(document).on 'keypress', '[data-behavior~=team_speaker]', (event) ->
  if event.keyCode is 13 # return = send
    App.team.speak event.target.value
    event.target.value = ''
    event.preventDefault()
