class MemosController < ApplicationController
	before_action :authenticate_user!

	def create
		memo = Memo.new(memo_params)
		memo.save

		# メモを貼ったときにグループのユーザーへ通知
		group = Group.find_by(id: memo.group_id)
		group.users.each do |user|
			if user != current_user
				notification = Notification.new(creator_id: memo.user_id, group_id: memo.group_id, memo_id: memo.id, confirm_status: "unconfirmed")
				notification.confirmer_id = user.id
				notification.save
			end
		end
		redirect_to group_path(memo.group_id)
	end

	def destroy
		memo = Memo.find(params[:id])
		group_id = memo.group_id
		memo.destroy
		redirect_to group_path(group_id)
	end

	private

	def memo_params
		params.require(:memo).permit(:body, :group_id, :user_id)
	end
end
