class NotificationsController < ApplicationController
  def index
  	unconfirmeds = Notification.where(confirmer_id: current_user.id, confirm_status: "unconfirmed")
  	unconfirmeds.update_all(confirm_status: "confirmed")
  	@notifications = Notification.where(confirmer_id: current_user.id)
  end

  def destroy
  end

  def destroy_all
  end

end
