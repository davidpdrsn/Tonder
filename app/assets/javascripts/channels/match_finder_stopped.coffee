App.match_finder_stopped = App.cable.subscriptions.create "MatchFinderStoppedChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    console.log "match_finder_stopped"
    $(".matches-actions").html data["match_finder"]
