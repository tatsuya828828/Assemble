class GroupChannel < ApplicationCable::Channel
  def subscribed
    stream_from "group_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(content)
  	@new_message = Message.new(content: content['content'][0], user_id: content['content'][1].to_i, group_id: content['content'][2].to_i)
  	@new_message.save

    # DMを送ったグループユーザーに通知を送る
    @new_message.group.users.each do |user|
      if user != @new_message.user
        notification = Notification.new(creator_id: @new_message.user_id, message_id: @new_message.id, group_id: @new_message.group_id, confirm_status: "unconfirmed")
        notification.confirmer_id = user.id
        notification.save
      end
    end
  	ActionCable.server.broadcast 'group_channel', content: content['content'][0], user_name: @new_message.user.name, user_id: @new_message.user.id, group_id: @new_message.group.id, time: @new_message.created_at.strftime("%-H:%M")
  end
end
