App.liked_users = App.cable.subscriptions.create "LikedUsersChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    html = data["tinder_user"]
    console.log "LikedUsersChannel"
    $(".likes-list .likes").prepend(html)
