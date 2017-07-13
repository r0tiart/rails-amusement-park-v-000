Rails.application.routes.draw do

	root "application#welcome"
	resources :users, only: [:new, :create, :index, :show, :update, :edit]
	resources :attractions

	get "signin" => "sessions#new"
	resources :sessions, only: [:create, :destroy]
	post "ride/:id" => "attractions#ride", as: "ride"

end