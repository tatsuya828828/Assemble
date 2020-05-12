class Group < ApplicationRecord
	
	has_many :group_users, dependent: :destroy
	# group_userモデルを通して、userモデルを参照可能に設定
	has_many :users, through: :group_users
	accepts_nested_attributes_for :group_users

	enum private_status: { closed: 0, open: 1 }

	validates :name, presence: true
	validates :leader,presence: true
	validates :private_status, presence: true
end
