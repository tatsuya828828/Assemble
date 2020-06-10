App.group = App.cable.subscriptions.create "GroupChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
        senderId = $("input[id='chat']").data("user") # idがchatのinputタグのdata属性がユーザーの情報をsenderIdとして定義
        senderGroup = $("input[id='chat']").data("group")
        if senderId == data.user_id && senderGroup == data.group_id # 上で定義したsenderIdとチャンネルで定義したdata.user_idを評価
          $('#messages').append("<div class='
          offset-lg-4
          col-lg-8'
          style='
          text-align: right;
          margin-bottom: 3px;'>"+"<p style='display: inline-block; margin-right: 5px'>"+data["time"]+"</p>"+"<div
          class='self-message'>"+"<p class='mb-0'>"+data["content"]+"</p>"+"</div>"+"<br>");
        else if senderId != data.user_id && senderGroup == data.group_id
          $('#messages').append("<div class='
          col-lg-8'
          style='
          text-align: left;
          margin-bottom: 3px;'>"+"<p class='mb-0' style='color: #fff;'>"+data["user_name"]+"</p>"+"<div
          class='other-message'>"+"<p class='mb-0'>"+data["content"]+"</p>"+"</div>"+"<p style='display: inline-block; margin-left: 5px;'> "+data["time"]+"</p>"+"<br>");

  speak: (content) ->
    @perform 'speak', content: content

jQuery(document).on 'click', '[id=submit]', (event) ->
	App.group.speak [$("input[id='chat']").val(), $('[data-user]').attr('data-user'), $('[data-group]').attr('data-group')]
	$("input[id='chat']").val("")
	event.preventDefault()