Rails.application.routes.draw do

  namespace :admin do
    get 'contacts/show'
    get 'contacts/index'
  end
#===== 管理者 ========================================================================
  devise_for :admins, skip: :all
  devise_scope :admin do
    get 'admins/sign_in',     to: 'admins/sessions#new', as: 'new_admin_session'
    post 'admins/sign_in',    to: 'admins/sessions#create', as: 'admin_session'
    delete 'admins/sign_out', to: 'admins/sessions#destroy', as: 'destroy_admin_session'
  end

  namespace :admin do
    root 'home#top'
    resources :users,    only: [:index, :show, :update]
    resources :searches, only: [:index]
    resources :contacts, only: [:index, :show, :update, :destroy]
  end
#====================================================================================


#===== 問い合わせ  ===================================================================
  resources :contacts, only: [:index, :show, :new, :create, :destroy]
#===================================================================================


#===== ユーザー ======================================================================
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }

  root 'home#top'

  get '/about', to: 'home#about', as: 'about'
  get '/help',  to: 'home#help',  as: 'help'

  #===== ユーザーとその友達 ===============================
  resources :users, only: [:show, :edit, :update, :destroy] do
    get 'destroy_confirm', to: 'users#destroy_confirm'
    resources :friends, only: [:index, :create, :update, :destroy]
  end
  #======================================================

#=====================================================================================


#===== ダイレクトメッセージとルーム ====================
resources :rooms, only: [:index, :show, :create, :destroy] do
  resources :entries, only: [:create, :destroy]
end
#===================================================


#===== 通知一覧 =====================================
resources :notifications, only: [:index, :destroy] do
  collection do
    get '/destroy_all', to: 'notifications#destroy_all', as: 'destroy_all'
  end
end
#===================================================


#====== 日記と日記のコメント ==========================
  resources :diaries do
    post   'diary_comments',     to: 'diary_comments#create',  as: 'comments'
    delete 'diary_comments/:id', to: 'diary_comments#destroy', as: 'comment_destroy'
  end
#===================================================


#==== グループ ========================================================================
  resources :groups do

    # グループ削除確認ページ
    get 'destroy_confirm', to: 'groups#destroy_confirm'
    get 'chats',           to: 'groups#chats', as: 'chats'

    #====== グループユーザー ==============================
    get    'group_users',     to: 'group_users#index',   as: 'users'
    post   'group_users',     to: 'group_users#create',  as: 'join_user'
    put    'group_users/:id', to: 'group_users#update',  as: 'user'
    patch  'group_users/:id', to: 'group_users#update'
    delete 'group_users/:id', to: 'group_users#destroy', as: 'destroy_user'
    #====================================================


    #====== メモ ========================================
    resources :memos, only: [:create, :destroy]
    #===================================================

  end
#=====================================================================================


#===== 検索 ===========================================================================
  get '/searches', to: 'searches#index', as: 'searches'
#=====================================================================================

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
