class Friend < ApplicationRecord

	#===== Userモデルをsenderとreceiverいう名前の擬似モデルとして分けて使えるように設定 =====
	belongs_to :sender,   class_name: "User"
	belongs_to :receiver, class_name: "User"
	#================================================================================

	#===== 友達申請の通知 ===================================
	has_many :notifications, dependent: :destroy
	#===================================================

	#===== 申請する前を0、申請した後を1、承認されて友達になった後を2と設定して状態を分ける =====
	enum request_status: {waiting_for_allow: 0, friend: 1}
	#================================================================================


	validates :sender_id, 	presence: true
	validates :receiver_id, presence: true

end
