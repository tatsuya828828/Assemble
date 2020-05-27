class Group < ApplicationRecord
	#===== グループのユーザー =========================
	has_many :group_users, dependent: :destroy
	# group_userモデルを通して、userモデルを参照可能に設定
	has_many :users, through: :group_users
	accepts_nested_attributes_for :group_users
	#================================================

	#===== グループのメモ==============================
	has_many :memos, dependent: :destroy
	#================================================

	#===== グループのメッセージ ========================
	has_many :messages, dependent: :destroy
	#================================================

	#===== グループの日記 =============================
	has_many :diaries
	#================================================

	#===== グループの通知 =============================
	has_many :notifications, dependent: :destroy
	#================================================

	enum private_status: { closed: 0, open: 1 }


	mount_uploader :image, ImageUploader

	
	validates :name, 		   presence: true
	validates :leader, 		   presence: true
	validates :private_status, presence: true
end
