class Contact < ApplicationRecord
  belongs_to :user

  enum confirm_status:  { unconfirmed: 0, admin_confirmed: 1, user_confirmed: 2}
  enum response_status: { before_reply: 0, already_replyed: 1}

  validates :title, presence: true
  validates :body,  presence: true

end
