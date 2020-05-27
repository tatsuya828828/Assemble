App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    senderId = $("input[id='direct-chat']").data("user") # idがchatのinputタグのdata属性がユーザーの情報をsenderIdとして定義
    senderRoom = $("input[id='direct-chat']").data("room")
    if senderId == data.user_id && senderRoom == data.room_id # 上で定義したsenderIdとチャンネルで定義したdata.user_idを評価
      $('#direct_messages').append("<div class='
      offset-lg-6
      col-lg-6'
      style='
      text-align: right;
      margin-bottom: 3px;'>"+"<div
      style='border-radius:5px;
      border: 1px solid black;
      color: black;
      background-color: #fff;
      word-break:break-all;
      padding: 3px 10px;
      display: inline-block;
      margin-bottom: 3px;'>"+data["content"]+"</div>"+"<br>");
    else if senderId != data.user_id && senderRoom == data.room_id
          $('#direct_messages').append("<div class='
          col-lg-6'
          style='
          text-align: left;
          margin-bottom: 3px;'>"+data["user_name"]+"<br>"+"<div
          style='border-radius:5px;
          border: 1px solid black;
          color: black;
          background-color: #fff;
          word-break:break-all;
          padding: 3px 10px;
          display: inline-block;
          margin-bottom: 3px;'>"+data["content"]+"</div>"+"<br>");

  speak: (content) ->
    @perform 'speak', content: content

jQuery(document).on 'click', '[id=direct-submit]', (event) ->
	App.room.speak [$("input[id='direct-chat']").val(), $('[data-user]').attr('data-user'), $('[data-room]').attr('data-room')]
	$("input[id='direct-chat']").val("")
	event.preventDefault()