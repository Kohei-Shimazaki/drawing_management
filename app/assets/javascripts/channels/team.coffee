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
          # speakメソッドで受け取ったチャットを受け取る
          if data['message']
            $('#messages_'+data['team_id']).prepend data['message']
          # Notificationのインスタンスが作成されるとチームメンバーに通知が届く
          if data['notification'] && data['user_id'] != $("#team_coffee_datas").data("user_id")
            $('#notifications').prepend data['notification']
            $("#unread_notifications").text String(Number($("#unread_notifications").text()) + 1)
          # チャット画面を開くと、チャット画面に既読表示が出る
          if data['message_read']
            $('#message_read_count_'+data['message_id']).text String(Number($('#message_read_count_'+data['message_id']).text()) + 1)
            if $('#message_read_users_'+data['message_id']).text().replace(/\r?\n/g,"").replace(/^\s+/g, "") == ":         "
              $('#message_read_users_'+data['message_id']).text $('#message_read_users_'+data['message_id']).text()+data['user_name']
            else
              $('#message_read_users_'+data['message_id']).text $('#message_read_users_'+data['message_id']).text()+"/"+data['user_name']

        speak: (message) ->
          team_id = $('#chat').data('team_id')
          @perform 'speak', message: message, team_id: team_id

        message_read: ->
          @perform 'message_read',
            message_id: Number($("#message_id").text()),
            user_id: Number($("#message_user_id").text()),
            team_id: $('#chat').data('team_id')

        message_id = null
        setInterval ->
          if $("#chat").data('team_id')
            if message_id
              if message_id != Number($("#message_id").text())
                App.team.message_read()
                message_id = Number($("#message_id").text())
            else
              message_id = Number($("#message_id").text())

    i++

$(document).on 'keypress', '[data-behavior~=team_speaker]', (event) ->
  if event.keyCode is 13 # return = send
    App.team.speak event.target.value
    event.target.value = ''
    event.preventDefault()
