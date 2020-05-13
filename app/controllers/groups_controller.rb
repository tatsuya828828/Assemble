class GroupsController < ApplicationController

  def index
  	@group = Group.new
  	@back = 'url(/assets/CorkBoard.png)'

  end

  def create
  	group = Group.new(group_params)
  	# グループIDを入力していた場合のみ値を保存
  	if group.self_id == ""
  		group.self_id = nil
  	end
  	group.save

  	# グループを作成した後、作成したユーザーをグループに追加
  	group_user = GroupUser.new(group_id: group.id, user_id: group.leader)
  	group_user.save

  	redirect_to group_path(group.id)
  end

  def show
  	@group = Group.find(params[:id])
  	@memo = Memo.new
  	@side = params[:side]
  end

  def update
  	group = Group.find(params[:id])
  	# グループIDを入力していた場合のみ値を保存
  	group.update(group_params)
  	if group.self_id == ""
  		group.update(self_id: nil)
  		binding.pry
  	end
  	
  	redirect_to group_path(group.id)
  end

  private

  def group_params
  	params.require(:group).permit(:name, :leader, :private_status, :self_id)
  end

end
