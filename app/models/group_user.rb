class GroupUser < ApplicationRecord
  belongs_to :group
  belongs_to :user

  #===== グループユーザーの通知 =============================
  has_many :notifications, dependent: :destroy
  #================================================

  enum join_status: { waiting_for_allow: 0, joined: 1 }
end
