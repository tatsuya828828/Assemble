class UsersController < ApplicationController
	before_action :authenticate_user!, except: [:show]
  def show
  	@user = User.find(params[:id])
    @group_user = GroupUser.new

    # current_userの所持しているチャットルームに@userが所属しているルームがあるか探す
    @room = []
    current_user.rooms.each do |room|
      if (room.users.find_by(id: @user.id)).present?
        @room<<room
      end
    end

    # current_userの参加しているグループの中で@userの参加していないグループを探して@groupsに代入していく。
    @groups = []
    current_user.groups.each do |group|
      if (group.users.find_by(id: @user.id)).nil?
        @groups<<group
      end
    end

    if user_signed_in?
          # 友達の場合
      if current_user.friend?(@user)
        @user_info = current_user.sender_friends.find_by(receiver_id: @user.id, request_status: "friend")
        # 承認待ちの場合
      elsif current_user.wait_self?(@user)
        @user_info = current_user.sender_friends.find_by(receiver_id: @user.id, request_status: "waiting_for_allow")
        # 申請が来ている場合
      elsif current_user.waiting_other_user?(@user)
        @user_info = current_user.receiver_friends.find_by(sender_id: @user.id, request_status: "waiting_for_allow")
        # どれにも当てはまらない場合
      else
        @user_info = nil
      end


      if params[:request].present?
        @friend_requests = Friend.where(sender_id: current_user.id, request_status: "waiting_for_allow")
      else
        @friend_requests = Friend.where(receiver_id: current_user.id, request_status: "waiting_for_allow")
      end

      if @user == current_user
        @diaries = Diary.where(user_id: current_user.id)
      elsif @user.friend?(current_user)
    	  @diaries = Diary.where(user_id: @user.id, private_status: "friend_only").or(Diary.where(user_id: @user.id, private_status: "open")).or(Diary.where(user_id: @user.id, private_status: "full_open"))
      else
        @diaries = Diary.where(user_id: @user.id, private_status: "open").or(Diary.where(user_id: @user.id, private_status: "full_open"))
      end
    else
      @diaries = Diary.where(user_id: @user.id, private_status: "open").or(Diary.where(user_id: @user.id, private_status: "full_open"))
    end
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	user = User.find(params[:id])
  	if user.update(user_params)
  	 redirect_to action: :show
    else
      @user = User.find(params[:id])
      flash.now[:alert] = "既に使われています"
      render action: :edit
    end
  end

  def destroy
  	user = User.find(params[:id])
  	groups = Group.where(leader: user.id)
    if groups.present?
      groups.each do |group|
        self_diaries = group.diaries.where(group_id: group.id, user_id: user.id)
        self_diaries.destroy_all
        (group.diaries.where(private_status: "group_only").or(group.diaries.where(private_status: "open"))).update_all(private_status: "closed")
        group.diaries.update_all(group_id: nil)
        group.destroy
      end
    end
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
