class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :not_group_user, except: [:index, :create, :chats, :destroy_confirm]

  def index
  	@new_group = Group.new
    @waiting_for_allows = GroupUser.where(user_id: current_user.id, join_status: "waiting_for_allow")
  end

  def create
  	group = Group.new(group_params)
  	# グループIDを入力していた場合のみ値を保存
  	if group.self_id == ""
  		group.self_id = nil
  	end
  	if group.save
    	# グループを作成した後、作成したユーザーをグループに追加
    	group_user = GroupUser.new(group_id: group.id, user_id: group.leader, join_status: "joined")
    	group_user.save
  	  redirect_to group_path(group.id)
    else
      @new_group = Group.new
      @request = params[:request]
      flash.now[:alert] = "既に使われています"
      render action: :index
    end
  end

  def show
  	@group = Group.find(params[:id])
    @diaries = Diary.where(group_id: @group.id, private_status: "group_only").or(Diary.where(group_id: @group.id, private_status: "open")).or(Diary.where(group_id: @group.id, private_status: "full_open"))
  	@memo = Memo.new
    # メモ作成ボタンを押した時に表示
    @new = params[:new]

    @waiting_for_allows = GroupUser.where(group_id: @group.id, join_status: "waiting_for_allow")

    notifications = Notification.where(confirmer_id: current_user.id, message_id: nil, confirm_status: "unconfirmed", group_id: @group.id)
    notifications.update_all(confirm_status: "confirmed")
  end

  def edit
  	@group = Group.find(params[:id])
  end

  def update
  	group = Group.find(params[:id])
  	# グループIDを入力していた場合のみ値を保存
  	if group.update(group_params)
    	if group.self_id == ""
    		group.update(self_id: nil)
    	end
    	redirect_to group_path(group.id)
    else
      @group = Group.find(params[:id])
      flash.now[:alert] = "既に使われています"
      render action: :edit
    end
  end

  def destroy_confirm
    @group = Group.find(params[:group_id])
    if @group.users.find_by(id: current_user.id).nil?
      redirect_back(fallback_location: root_path)
    end
    if params[:destroy] == "user"
       @group_user = GroupUser.find_by(user_id: current_user, group_id: @group.id)
    end
  end

  def destroy
  	group = Group.find(params[:id])
    diaries = Diary.where(group_id: group.id)
    if diaries.present?
      change_diaries = diaries.where(private_status: "group_only").or(diaries.where(private_status: "open"))
      change_diaries.update_all(private_status: "closed")
      diaries.update_all(group_id: nil)
    end
  	group.destroy
  	redirect_to groups_path
  end

  def chats
    @group = Group.find(params[:group_id])
    if @group.users.find_by(id: current_user.id).nil?
      redirect_back(fallback_location: root_path)
    end
    @messages = @group.messages
    if params[:user_id].present?
      @user = User.find(params[:user_id])
    end

    notifications = Notification.where(group_id: @group.id, confirmer_id: current_user.id)
    notifications = notifications.where.not(message_id: nil)
    notifications.update_all(confirm_status: "confirmed")
  end

  private

  def group_params
  	params.require(:group).permit(:name, :leader, :private_status, :self_id, :image, :image_cache, :remove_image)
  end

  def not_group_user
    group = Group.find(params[:id])
    if group.present?
      if (group.users.find_by(id: current_user.id)).nil?
        redirect_back(fallback_location: root_path)
      end
    end
  end

end
