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

		group = Group.find_by(id: group_user.group_id)
		# グループに招待した場合
		if group_user.join_status == "joined"
			group.users.each do |user|
				if user.id != group.leader
					notification = Notification.new(creator_id: current_user.id, group_id: group.id, group_user_id: group_user.id, confirm_status: "unconfirmed")
					notification.confirmer_id = user.id
					notification.save
				end
			end
			redirect_to group_users_path(group_id: group_user.group_id, status: "joined")
		# グループに参加申請を送った場合
		else
			notification = Notification.new(creator_id: current_user.id, group_id: group_user.group_id, group_user_id: group_user.id, confirm_status: "unconfirmed")
			notification.confirmer_id = group.leader
			notification.save
			redirect_to groups_path
		end
	end


	def update
		group_user = GroupUser.find(params[:id])
		group_user.update(join_status: "joined")

		# 承認した場合グループのユーザーに通知を送る
		group_user.group.users.each do |user|
			if user != current_user
				notification = Notification.new(creator_id: current_user.id, group_id: group_user.group_id, group_user_id: group_user.id, confirm_status: "unconfirmed")
				notification.confirmer_id = user.id
				notification.save
			end
		end

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
