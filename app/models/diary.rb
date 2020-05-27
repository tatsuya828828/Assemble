class Diary < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true

  #===== 日記に対するコメント ===========================
  has_many :diary_comments, dependent: :destroy
  #===================================================

  #===== 日記の通知 ===================================
  has_many :notifications, dependent: :destroy
  #===================================================


  # 日記の公開範囲
  enum private_status: {closed: 0, friend_only: 1, group_only: 2, open: 3, full_open: 4}


  mount_uploader :image, ImageUploader

  validates :title, presence: true
  validates :body, presence: true
  validates :private_status, presence: true
end
