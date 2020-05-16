class DiariesController < ApplicationController
	before_action :not_group_user, except: [:show]

	def index
		@group = Group.find(params[:group_id])
		@diaries = Diary.where(group_id: @group.id)
	end

	def new
		@group = Group.find(params[:group_id])
		@diary = Diary.new
	end

	def create
		diary = Diary.new(diary_params)
		diary.save
		redirect_to group_diary_path(group_id: diary.group_id, id: diary.id)
	end

	def show
		@diary = Diary.find(params[:id])
		if @diary.private_status == "closed"
			not_group_user
		end
		@group = Group.find_by(id: @diary.group_id)
		if params[:comment] == "new"
			@diary_comment = DiaryComment.new
		end
	end

	def edit
		@diary = Diary.find(params[:id])
		@group = Group.find_by(id: @diary.group_id)
	end

	def update
		diary = Diary.find(params[:id])
		diary.update(diary_params)
		redirect_to group_diary_path(group_id: diary.group_id, id: diary.id)
	end

	def destroy
		diary = Diary.find(params[:id])
		group = diary.group_id
		diary.destroyj
		redirect_to group_diaries_path(group_id: group)
	end

	private

	def diary_params
		params.require(:diary).permit(:title, :body, :user_id, :group_id, :private_status)
	end

	def not_group_user
		@group = Group.find(params[:group_id])
		if @group.present?
			if @group.users.find_by(id: current_user.id).nil?
				redirect_back(fallback_location: root_path)
			end
		end
	end
end
