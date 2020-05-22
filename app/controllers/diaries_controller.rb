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
		redirect_to diary_path(diary)
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
		redirect_to diary_path(diary)
	end

	def destroy
		diary = Diary.find(params[:id])
		diary.destroy
		redirect_to user_path(current_user)
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
