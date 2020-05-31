class DiaryCommentsController < ApplicationController

	def create
		comment = DiaryComment.new(diary_comment_params)
		comment.save

		# 日記へコメントをしたときに相手へ通知へ送る
		notification = Notification.new(creator_id: comment.user_id, confirmer_id: comment.diary.user.id, confirm_status: "unconfirmed", diary_id: comment.diary_id, diary_comment_id: comment.id)
		notification.save

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
