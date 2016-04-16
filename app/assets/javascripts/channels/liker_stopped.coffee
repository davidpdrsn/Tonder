App.liker_stopped = App.cable.subscriptions.create "LikerStoppedChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $(".liker-actions").html data["liker"]
