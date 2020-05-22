class Admin::SearchesController < ApplicationController
  def index
  	@word = params[:wor]
  	if params[:range] == "ユーザー名"
  		@users = User.where(name: params[:word])
  	else
  		@user = User.find_by(self_id: params[:word])
  	end
  end
end
