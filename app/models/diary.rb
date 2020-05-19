class Diary < ApplicationRecord
  belongs_to :user
  belongs_to :group

  #===== 日記に対するコメント ===========================
  has_many :diary_comments, dependent: :destroy
  #===================================================

  #===== 日記をグループ外にも公開するかしないか ============
  enum private_status: {closed: 0, open: 1}
  #===================================================


  mount_uploader :image, ImageUploader
  
  validates :title, presence: true
  validates :body, presence: true
  validates :private_status, presence: true
end
