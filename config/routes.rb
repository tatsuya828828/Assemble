Rails.application.routes.draw do
#===== 管理者 ========================================================================
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
  namespace :admin do
    resources :users, only: [:index, :show]
  end
#====================================================================================


#===== ユーザー ======================================================================
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }

  root 'home#top'

  #===== ユーザーとその友達 ===============================
  resources :users, only: [:show, :edit, :update] do
    resources :friends, only: [:index, :create, :update, :destroy]
  end
  #======================================================

#=====================================================================================


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


    #====== 日記と日記のコメント ==========================
    resources :diaries do
      post   'diary_comments', to: 'diary_comments#create',  as: 'comments'
      delete 'diary_comments', to: 'diary_comments#destroy', as: 'destroy_comment'
    end
    #===================================================

  end
#=====================================================================================


#===== 検索 ===========================================================================
  get '/searches', to: 'searches#index', as: 'searches'
#=====================================================================================

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end