App.group = App.cable.subscriptions.create "GroupChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
      $('#messages').append(data["user"]+"<br>"+"<div class='theme-color'
      style='border-radius:5px;
      padding: 3px 10px;
      display: inline-block;
      margin-bottom: 3px;'>"+data["content"]+"</div>"+"<br>");

  speak: (content) ->
    @perform 'speak', content: content

jQuery(document).on 'keypress', '[data-behavior~=group_speaker]', (event) ->
	if event.keyCode is 13
		App.group.speak [event.target.value, $('[data-user]').attr('data-user'), $('[data-group]').attr('data-group')]
		event.target.value = ''
		event.preventDefault()