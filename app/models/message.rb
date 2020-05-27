class Message < ApplicationRecord
  belongs_to :user
  belongs_to :group

  #===== メッセージの通知 =============================
　has_many :notifications, dependent: :destroy
　#================================================
  validates :content, presence: true
end
