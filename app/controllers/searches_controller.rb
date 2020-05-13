class SearchesController < ApplicationController

	def index
		@range = params[:range]
		@word = params[:word]
		if @range == "グループID"
			@group = Group.find_by(self_id: @word)
			@leader = User.find_by(id: @group.leader)
		else
			@user = User.find_by(self_id: @word)
		end
	end
end
