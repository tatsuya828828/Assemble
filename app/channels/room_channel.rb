class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(content)
  	@new_direct_message = DirectMessage.new(content: content['content'][0], user_id: content['content'][1].to_i, room_id: content['content'][2].to_i)
    @new_direct_message.save


    @new_direct_message.room.users.each do |user|
      if user != @new_direct_message.user
        notification = Notification.new(creator_id: @new_direct_message.user_id, direct_message_id: @new_direct_message.id, confirm_status: "unconfirmed", room_id: @new_direct_message.room_id)
        notification.confirmer_id = user.id
        notification.save
      end
    end
  	ActionCable.server.broadcast 'room_channel', content: content['content'][0], user_name: @new_direct_message.user.name, user_id: @new_direct_message.user.id, room_id: @new_direct_message.room.id
  end
end
