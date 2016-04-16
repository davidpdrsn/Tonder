App.message = App.cable.subscriptions.create "MessageChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    if data.type == "response"
      console.log data
    else if data.type == "sent_message"
      console.log "sent_message!"
      el = $("[data-tinder-match-id=#{data.tinder_match_id}]")
      el.after data.tinder_user_html
      el.remove()

  startMessaging: ->
    ids = []
    $(".matches [data-tinder-match-id]").each (_index, element) ->
      if $(element).attr("data-messaged") is "false"
        ids.push $(element).attr("data-tinder-match-id")
    console.log ids
    message = prompt "What do you wanna say?"

    @perform(
      "start_messaging"
      tinder_ids: ids
      message: message
    )

$(document).on "click", "[data-behavior~=message-matches]", (e) ->
  App.message.startMessaging()
  e.preventDefault()
