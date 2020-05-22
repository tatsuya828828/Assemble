class DiaryCommentsController < ApplicationController

	def create
		comment = DiaryComment.new(diary_comment_params)
		comment.save
		redirect_back(fallback_location: root_path)
	end

	def destroy
		comment = DiaryComment.find(params[:id])
		comment.destroy
		redirect_back(fallback_location: root_path)
	end

	private

	def diary_comment_params
		params.permit(:comment, :user_id, :diary_id)
	end

end
