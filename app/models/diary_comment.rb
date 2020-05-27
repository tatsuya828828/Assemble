class DiaryComment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :diary

  #===== 日記へのコメントの通知 ===================================
  has_many :notifications, dependent: :destroy
  #===================================================

  validates :comment, presence: true, length: {maximum: 500}
end
