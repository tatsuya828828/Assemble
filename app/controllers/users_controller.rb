class UsersController < ApplicationController
	before_action :authenticate_user!
  def show
  	@user = User.find(params[:id])
  	

  	if current_user.friend?(@user)
  		@user_info = current_user.sender_friends.find_by(receiver_id: @user.id, request_status: "friend")
  	elsif current_user.wait_self?(@user)
  		@user_info = current_user.sender_friends.find_by(receiver_id: @user.id, request_status: "waiting_for_allow")
  	elsif current_user.waiting_other_user?(@user)
  		@user_info = current_user.receiver_friends.find_by(sender_id: @user.id, request_status: "waiting_for_allow")
  	else
  		@user_info = nil
  	end


  	if params[:request].present?
  		@friend_requests = Friend.where(sender_id: current_user.id, request_status: "waiting_for_allow")
  	else
  		@friend_requests = Friend.where(receiver_id: current_user.id, request_status: "waiting_for_allow")
  	end
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	user = User.find(params[:id])
  	user.update(user_params)
  	redirect_to action: :show
  end

  def destroy
  	user = User.find(params[:id])
  	group = Group.where(leader: user.id)
  	group.destroy_all
  	user.destroy
  	redirect_to root_path
  end

  def destroy_confirm
  	@user = User.find(params[:user_id])
  end

  private

  def user_params
  	params.require(:user).permit(:name, :self_id , :image, :image_cache, :remove_image)
  end

end
