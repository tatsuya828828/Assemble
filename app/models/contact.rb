class Contact < ApplicationRecord
  belongs_to :user

  enum confirm_status:  { unconfirmed: 0, confirmed: 1}
  enum response_status: { before_reply: 0, already_replyed: 1}

  validates :title, presence: true
  validates :body,  presence: true
  validates :reply, presence: true

end
