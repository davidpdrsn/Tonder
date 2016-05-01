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

  pretendMessage: (id) ->
    @perform(
      "pretend_message"
      match_id: id
    )

  startMessaging: ->
    ids = []
    $(".matches [data-tinder-match-id]").each (_index, element) ->
      if $(element).attr("data-messaged") is "false" and $(element).find("input[type=checkbox]").is(":checked")
        ids.push $(element).attr("data-tinder-match-id")
    console.log ids

    if ids.length == 0
      alert "No people selected"
    else
      message = prompt "What do you wanna say?"

      unless message is ""
        @perform(
          "start_messaging"
          match_ids: ids
          message: message
        )

$(document).on "click", "[data-behavior~=message-matches]", (e) ->
  App.message.startMessaging()
  e.preventDefault()

$(document).on "click", "[data-behavior~=select-all]", (e) ->
  $(".matches input[type=checkbox]").prop 'checked', true
  e.preventDefault()

$(document).on "click", "[data-behavior~=select-none]", (e) ->
  $(".matches input[type=checkbox]:not([disabled])").prop 'checked', false
  e.preventDefault()

$(document).on "click", "[data-behavior~=pretend-message]", (e) ->
  matchId = $(@).parents("[data-tinder-match-id]").first().attr("data-tinder-match-id")
  App.message.pretendMessage(matchId)
  e.preventDefault()
