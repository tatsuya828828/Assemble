class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #===== ユーザーのグループ ==================================
  has_many :group_users, dependent: :destroy
  # group_userモデルを通して、groupモデルを参照できるように設定
  has_many :groups, through: :group_users
  #========================================================

  #===== ユーザーのメモ =====================================
  has_many :memos, dependent: :destroy
  #========================================================
  

  validates :name,presence: true
  validates :self_id, presence: true

end
