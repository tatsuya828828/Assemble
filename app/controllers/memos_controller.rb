class MemosController < ApplicationController

	def create
		memo = Memo.new(memo_params)
		memo.save
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
