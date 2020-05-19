class SearchesController < ApplicationController
	before_action :authenticate_user!

	def index
		@range = params[:range]
		@word = params[:word]
		if @range == "グループID"
			@group = Group.find_by(self_id: @word, private_status: "open")
			if @group.present?
				@leader = User.find_by(id: @group.leader)
			end
		else
			@user = User.find_by(self_id: @word)
			if @user.present?
				friend = Friend.find_by(sender_id: current_user.id, receiver_id: @user.id)
				if friend.present?
					if friend.request_status == "friend"
					@friend = friend
					elsif friend.request_status == "waiting_for_allow"
					@friend = friend
					end
				else
					@friend = Friend.find_by(sender_id: @user.id, receiver_id: current_user.id, request_status: "waiting_for_allow")
				end
			end
		end
		if @group.nil? && @user.nil?
			@range = nil
		end
	end
end
