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
  	ActionCable.server.broadcast 'group_channel', content: content['content'][0], user_name: @new_message.user.name, user_id: @new_message.user.id
  end
end
