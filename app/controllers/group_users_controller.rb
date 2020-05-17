class GroupUsersController < ApplicationController
	before_action :authenticate_user!

	def index
		@status = params[:status]
		@group = Group.find(params[:group_id])

		if params[:id].present?
			@group_user = GroupUser.find(params[:id])
		end

		if @status == "waiting_user"
			@title = "受け取った申請"
			@group_users = GroupUser.where(group_id: @group, join_status: "waiting_for_allow")
		else
			@title = "グループに参加しているユーザー"
			@group_users = GroupUser.where(group_id: @group, join_status: "joined")
		end
	end


	def create
		group_user = GroupUser.new(group_user_params)
		group_user.save
		if group_user.join_status == "joined"
			redirect_to group_users_path(group_id: group_user.group_id, status: "joined")
		else
			redirect_to root_path
		end
	end


	def update
		group_user = GroupUser.find(params[:id])
		group_user.update(join_status: "joined")
		redirect_back(fallback_location: root_path)
	end


	def destroy
		group_user = GroupUser.find(params[:id])
		group = group_user.group_id
		group_user.destroy
		redirect_back(fallback_location: root_path)
	end


	private

	def group_user_params
		params.permit(:user_id, :group_id, :join_status)
	end
end
