class Memo < ApplicationRecord
  belongs_to :user
  belongs_to :group

  #===== メモの通知 =============================
　has_many :notifications, dependent: :destroy
　#================================================

  validates :body, presence: true
end
