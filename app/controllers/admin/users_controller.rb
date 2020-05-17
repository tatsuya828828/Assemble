class Admin::UsersController < ApplicationController
	before_action :authenticate_admin!

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
	end

	def update
		user = User.find(params[:id])
		user.update(valid_status: params[:status])
		redirect_back(fallback_location: admin_root_path)
	end

end
