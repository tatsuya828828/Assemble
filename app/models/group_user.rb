class GroupUser < ApplicationRecord
  belongs_to :group
  belongs_to :user

  enum join_status: { waiting_for_allow: 0, joined: 1 }
end
