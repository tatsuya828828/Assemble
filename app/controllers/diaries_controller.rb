class DiariesController < ApplicationController
	before_action :authenticate_user!, except: [:show]
	before_action :group_diary
	

	def index
		# グループ公開以上のステータスの日記のみ公開
		@diaries = Diary.where(group_id: @group.id, private_status: "group_only").or(Diary.where(group_id: @group.id, private_status: "open")).or(Diary.where(group_id: @group.id, private_status: "full_open"))
	end

	def new
		@diary = Diary.new
	end

	def create
		diary = Diary.new(diary_params)
		diary.save
		if (diary.group_id).nil?
			redirect_to diary_path(diary)
		else
			redirect_to diary_path(id: diary.id, group_id: diary.group_id)
		end
	end

	def show
		@diary = Diary.find(params[:id])
		if @diary.private_status == "closed"
			if @diary.user_id != current_user.id
				redirect_back(fallback_location: root_path)
			end
		end
	end

	def edit
		@diary = Diary.find(params[:id])
	end

	def update
		diary = Diary.find(params[:id])
		diary.update(diary_params)
		if (diary.group_id).nil?
			redirect_to diary_path(diary)
		else
			redirect_to diary_path(id: diary.id, group_id: diary.group_id)
		end
	end

	def destroy
		diary = Diary.find(params[:id])
		if (diary.group_id).present?
			group = diary.group_id
		end
		diary.destroy
		if group.nil?
			redirect_to user_path(current_user)
		else
			redirect_to diaries_path(group_id: group)
		end
	end

	private

	def diary_params
		params.require(:diary).permit(:title, :body, :user_id, :group_id, :private_status, :image, :image_cache, :remove_image)
	end

	def group_diary
		if params[:group_id].present?
			@group = Group.find(params[:group_id])
		end
	end
end
