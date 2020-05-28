class DiariesController < ApplicationController
	before_action :authenticate_user!, except: [:show]
	before_action :group_diary
	before_action :hash_init

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

		# 日記の公開範囲が当てはまるとき友達へ通知を送る
		if (diary.private_status != "closed") && (diary.private_status != "group_only")
			current_user.sended_friends.each do |friend|
				notification = Notification.new(diary_id: diary.id, confirm_status: "unconfirmed", creator_id: current_user.id)
				notification.confirmer_id = friend.receiver.id
				notification.save
			end
			redirect_to diary_path(diary)
		# 日記の公開範囲がグループのみだったときはグループユーザーのみ通知を送る
		elsif diary.private_status == "group_only"
			group = Group.find_by(id: diary.group_id)
			group.users.each do |user|
				notification = Notification.new(diary_id: diary.id, confirm_status: "unconfirmed", creator_id: current_user.id, group_id: diary.group_id)
				if user != current_user
					notification.confirmer_id = user.id
					notification.save
				end
			end
			redirect_to diary_path(id: diary.id, group_id: diary.group_id)
		else
			redirect_to diary_path(diary)
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

	def hash_init
     options = {
       bucket: 'our-space-image',
       region: 'ap-northeast-1', # japan[Tokyo]
       keyStart: 'uploads/diary/', # uploads/filename.png
       acl: 'public-read',
       accessKey: ENV['AWS_ACCESS_ID'], # 環境変数などで設定して直に書かない
       secretKey: ENV['AWS_ACCESS_KEY'], #　環境変数などで設定して直に書かない
     }
      @aws_image = FroalaEditorSDK::S3.data_hash(options)
      @aws_video = FroalaEditorSDK::S3.data_hash(options)
      @aws_file = FroalaEditorSDK::S3.data_hash(options)
	end
end
