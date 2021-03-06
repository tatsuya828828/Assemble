class RoomsController < ApplicationController

  def show
  	@room = Room.find(params[:id])
    @back = "chat-room"

    unconfirmeds = Notification.where(room_id: @room.id, confirmer_id: current_user.id, confirm_status: "unconfirmed")
    if unconfirmeds.present?
      unconfirmeds.update_all(confirm_status: "confirmed")
    end
  	user = @room.users.where.not(id: current_user.id)
  	@dm_user = user[0]
  	@direct_messages = @room.direct_messages
  end

  def index
  end

  def create
  	room = Room.new
  	room.save
  	# 自分の情報を登録
  	entry_self = Entry.new
  	entry_self.room_id = room.id
  	entry_self.user_id = current_user.id
  	entry_self.save
  	# 相手の情報を登録
  	entry_other = Entry.new
  	entry_other.room_id = room.id
  	entry_other.user_id = params[:user_id]
  	entry_other.save
  	redirect_to
  end

  def destroy
  end

end
