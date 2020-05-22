class GroupUsersController < ApplicationController
	before_action :authenticate_user!
	before_action :not_group_user, except: [:create, :destroy]

	def index
		@status = params[:status]
		@group = Group.find(params[:group_id])
		@leader = User.find_by(id: @group.leader)

		# サイドバーもどきのための情報
		if params[:user_id].present?
			# 承認などでgroup_userモデルの情報が必要なため、userモデルではなく、group_userモデルから取ってくる。
			group_user = GroupUser.find_by(id: params[:user_id])
			# 削除した後にredirect_backを使っているため情報が見つからなかった場合に、エラーが起きないよう、変数をnilにする。
			if group_user.present?
				@group_user = group_user
			else
				@group_user = nil
			end
		end

		# 受け取ったステータスによってページの表示内容を変える
		if @status == "waiting_user"
			@title = "受け取った申請"
			@group_users = GroupUser.where(group_id: @group, join_status: "waiting_for_allow")
		else
			@title = "参加しているユーザー"
			@group_users = GroupUser.where(group_id: @group, join_status: "joined")
		end
	end


	def create
		group_user = GroupUser.new(group_user_params)
		group_user.save
		if group_user.join_status == "joined"
			redirect_to group_users_path(group_id: group_user.group_id, status: "joined")
		else
			redirect_to groups_path
		end
	end


	def update
		group_user = GroupUser.find(params[:id])
		group_user.update(join_status: "joined")
		redirect_back(fallback_location: root_path)
	end


	def destroy
		if params[:destroy].present?
			user = GroupUser.find(params[:id])
			user_memos = Memo.where(group_id: user.group_id, user_id: user.user_id)
			user_diaries = Diary.where(group_id: user.group_id, user_id: user.user_id)
			user_memos.destroy_all
			user_diaries.update(group_id: nil)
			user.destroy
			redirect_to groups_path
		else
			group_user = GroupUser.find(params[:id])
			if group_user.user_id == current_user.id || group_user.group.leader == current_user.id
				group_user.destroy
				redirect_back(fallback_location: root_path)
			else
				redirect_back(fallback_location: root_path)
			end
		end
	end


	private

	def group_user_params
		params.permit(:user_id, :group_id, :join_status)
	end

	def not_group_user
		group_id = params[:group_id]
    	if (group_user = GroupUser.find_by(group_id: group_id, user_id: current_user.id, join_status: "joined")).nil?
        	redirect_back(fallback_location: root_path)
	    end
  	end
end
