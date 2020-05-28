class NotificationsController < ApplicationController
  def index
  	unconfirmeds = Notification.where(confirmer_id: current_user.id, confirm_status: "unconfirmed", direct_message_id: nil, message_id: nil)
  	unconfirmeds.update_all(confirm_status: "confirmed")
  	@notifications = Notification.where(confirmer_id: current_user.id, direct_message_id: nil, message_id: nil)
  end

  def destroy
  end

  def destroy_all
  end

end
