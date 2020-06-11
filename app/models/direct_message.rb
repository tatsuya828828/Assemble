class DirectMessage < ApplicationRecord
  belongs_to :user
  belongs_to :room

  #===== DMの通知 ===================================
  has_many :notifications, dependent: :destroy
  #=================================================

  validates :content, presence: true
end
