class SearchesController < ApplicationController

	def index
		@range = params[:range]
		@word = params[:word]
		if @range == "グループID"
			@group = Group.find_by(self_id: @word)
			if @group.present?
				@leader = User.find_by(id: @group.leader)
			end
		else
			@user = User.find_by(self_id: @word)
		end
		if @group.nil? && @user.nil?
			@range = nil
		end
	end
end
