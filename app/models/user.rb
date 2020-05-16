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

  #===== ユーザーの日記 =====================================
  has_many :diarys, dependent: :destroy
  #========================================================

  #===== ユーザーが投稿した日記へのコメント ====================
  has_many :diary_comments, dependent: :destroy
  #========================================================


  #===== 自分が申請したユーザー(receiver)との関連 =======================
  # 申請したユーザー(sender)から見て、承認する側のユーザー(receiver)を(中間テーブルを介して)集める。なので親は、sender_id(申請を送る側)
  has_many :sender_friends, foreign_key: :sender_id, class_name: "Friend", dependent: :destroy
  # 中間テーブルを介してreceiverモデルのユーザー(申請したユーザー)を集めることをsendersと定義
  has_many :senders, through: :sender_friends, source: :receiver
  #========================================================


  #===== 自分に申請してきたユーザー(sender)との関連 ====================
  # 承認する側のユーザー(receiver)から見て、申請してくるユーザー(sender)を(中間テーブルを介して)集める。なので親は、receiver_id(承認する側)
  has_many :receiver_friends, foreign_key: :receiver_id, class_name: "Friend", dependent: :destroy
  # 中間テーブルを介してsenderモデルのユーザー(承認する側)を集めることをreceiversと定義
  has_many :receivers, through: :receiver_friends, source: :sender
  #================================================================


  validates :name,    presence: true
  validates :self_id, presence: true

end
