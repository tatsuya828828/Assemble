class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :not_group_user, except: [:index,:chats]

  def index
  	@new_group = Group.new
    @request = params[:request]
  	back = 'url(/assets/top.png)'
  end

  def create
  	group = Group.new(group_params)
  	# グループIDを入力していた場合のみ値を保存
  	if group.self_id == ""
  		group.self_id = nil
  	end
  	group.save

  	# グループを作成した後、作成したユーザーをグループに追加
  	group_user = GroupUser.new(group_id: group.id, user_id: group.leader, join_status: "joined")
  	group_user.save

  	redirect_to group_path(group.id)
  end

  def show
  	@group = Group.find(params[:id])
  	@memo = Memo.new
    @new = params[:new]
  	@side = params[:side]
  end

  def edit
  	@group = Group.find(params[:id])
  end

  def update
  	group = Group.find(params[:id])
  	# グループIDを入力していた場合のみ値を保存
  	group.update(group_params)
  	if group.self_id == ""
  		group.update(self_id: nil)
  	end

  	redirect_to group_path(group.id)
  end

  def destroy_confirm
  	@group = Group.find(params[:group_id])
  end

  def destroy
  	group = Group.find(params[:id])
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
  end

  private

  def group_params
  	params.require(:group).permit(:name, :leader, :private_status, :self_id)
  end

  def not_group_user
    @group = Group.find(params[:id])
    if @group.present?
      if (@group.users.find_by(id: current_user.id)).nil?
        redirect_back(fallback_location: root_path)
      end
    end
  end

end
