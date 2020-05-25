class RoomsController < ApplicationController

  def show
  	@room = Room.find(params[:id])
  	user = @room.users.where.not(id: current_user.id)
  	@user = user[0]
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
