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
  	ActionCable.server.broadcast 'room_channel', content: content['content'][0], user_name: @new_direct_message.user.name, user_id: @new_direct_message.user.id
  end
end
