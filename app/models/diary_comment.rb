class DiaryComment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :diary

  validates :comment, presence: true, length: {maximum: 500}
end
