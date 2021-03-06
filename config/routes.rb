# frozen_string_literal: true

Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root 'static_pages#home'
  get 'home', to: 'static_pages#home'
  get 'contact', to: 'static_pages#contact'
  get 'about', to: 'static_pages#about'

  resources :events

  devise_for :users
  # as :user do
  #  get 'users/edit' => 'devise/registrations#edit',
  #      :as => 'edit_user_registration'
  #  put 'users' => 'devise/registrations#update', :as => 'user_registration'
  # end
  resources :users, except: %i[create new edit]

  # post 'create_user' => 'users#create', :as => 'create_user'

  resources :feedbacks
  authenticate :user do
    resources :freshmen, only: %i[new create edit update destroy]
  end
  resources :freshmen, only: %i[index show]

  get '/users/:id/edit_role' => 'users#edit_role', :as => 'edit_user_role'
  get '/users/:id/edit_info' => 'users#edit_personal_info',
      :as => 'edit_user_info'
  get '/dashboard' => 'static_pages#dashboard', :as => 'dashboard'
  patch 'edit_info/:id' => 'users#update_personal_info',
        :as => 'update_user_info'
  patch 'edit_role/:id' => 'users#update_role', :as => 'update_user_role'
end
