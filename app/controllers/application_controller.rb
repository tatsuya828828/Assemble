class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?

	# deviseのコントローラーをオーバーライドしてログイン後の遷移先を設定
	def after_sign_in_path_for(resource)
		case resource
			# 管理者がログインしたとき
		when Admin
			admin_root_path
			# ユーザーがログインしたとき
		when User
			groups_path
		end
	end

	# deviseのコントローラーをオーバーライドしてログアウト後の遷移先を設定
	def after_sign_out_path_for(resource)
		root_path
	end

	# ユーザー登録時にname,self_idのカラムを持ってくるように設定

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :name, :self_id, :image])
	end
	# configureは設定する
	# permittedは許可
	# parametersはパラメーター
	# つまりdeviseで利用できるパラメーターを設定する定義
	# sanitizerとは消毒液、つまり打ち消し
end
