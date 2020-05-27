class Notification < ApplicationRecord
  belongs_to :group,      	  optional: true
  belongs_to :group_user,     optional: true
  belongs_to :friend,         optional: true
  belongs_to :diary,	      optional: true
  belongs_to :diary_comment,  optional: true
  belongs_to :direct_message, optional: true
  belongs_to :message,        optional: true
  belongs_to :memo, 		  optional: true

  belongs_to :creator,	 class_name: "User"
  belongs_to :confirmer, class_name: "User"


  enum confirm_status: {unconfirmed: 0, confirmed: 1}

end
