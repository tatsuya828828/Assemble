class DiaryCommentsController < ApplicationController
	before_action :authenticate_user!

	def create
		group = params[:group_id]
		comment = DiaryComment.new(diary_comment_params)
		comment.save
		redirect_to group_diary_path(group_id: group, id: comment.diary_id)
	end

	def destroy
		comment = DiaryComment.find(params[:id])
		comment.save
		redirect_back(fallback_location: root_path)
	end

	private

	def diary_comment_params
		params.permit(:comment, :user_id, :diary_id)
	end

end
