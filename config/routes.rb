# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'contacts#index'
  resources :csv_files, only: %i[index new create]
  resources :contacts, only: %i[index]
  resources :contact_logs, only: %i[index]
end
