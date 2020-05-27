class DirectMessage < ApplicationRecord
  belongs_to :user
  belongs_to :room

  #===== DMの通知 ===================================
  has_many :notifications, dependent: :destroy
  #===================================================
end
