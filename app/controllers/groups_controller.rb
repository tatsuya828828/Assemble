class GroupsController < ApplicationController

  def index
  	@group = Group.new
  end

  def create
  	self_id = params[:self_id]
  	group = Group.new(group_params)
  	# グループIDを入力していた場合のみ値を保存
  	if self_id.present?
  		group.self_id = self_id
  	end
  	binding.pry
  	group.save

  	# グループを作成した後、作成したユーザーをグループに追加
  	group_user = GroupUser.new(group_id: group.id, user_id: group.leader)
  	group_user.save

  	redirect_to group_path(group.id)
  end

  def show
  end

  def edit
  end

  private

  def group_params
  	params.require(:group).permit(:name, :leader, :private_status)
  end

end
