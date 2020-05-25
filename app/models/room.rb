class Room < ApplicationRecord

  #===== Roomのユーザーとダイレクトメッセージ =================
  has_many :entries, dependent: :destroy
  has_many :users, through: :entries
  has_many :direct_messages, dependent: :destroy
  #========================================================
end
