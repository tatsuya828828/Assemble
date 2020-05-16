App.group = App.cable.subscriptions.create "GroupChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
        senderId = $("input[id='chat']").data("user") # idがchatのinputタグのdata属性がユーザーの情報をsenderIdとして定義
        if senderId == data.user_id # 上で定義したsenderIdとチャンネルで定義したdata.user_idを評価
          $('#messages').append("<div class='
          offset-lg-6
          col-lg-6'
          style='
          text-align: right;
          margin-bottom: 3px;'>"+"<div class='theme-color'
          style='border-radius:5px;
          padding: 3px 10px;
          display: inline-block;
          margin-bottom: 3px;'>"+data["content"]+"</div>"+"<br>");
        else if senderId != data.user_id
          $('#messages').append("<div class='
          col-lg-6'
          style='
          text-align: left;
          margin-bottom: 3px;'>"+data["user_name"]+"<br>"+"<div class='theme-color'
          style='border-radius:5px;
          padding: 3px 10px;
          display: inline-block;
          margin-bottom: 3px;'>"+data["content"]+"</div>"+"<br>");

  speak: (content) ->
    @perform 'speak', content: content

jQuery(document).on 'click', '[id=submit]', (event) ->
	App.group.speak [$("input[id='chat']").val(), $('[data-user]').attr('data-user'), $('[data-group]').attr('data-group')]
	$("input[id='chat']").val("")
	event.preventDefault()