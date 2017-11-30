Rails.application.routes.draw do
  resources :food_orders do 
  	get :history, :on => :collection
  	get :update_status, :on => :member
  	get :user_history, :on => :collection
  end
  resources :nutritions
	devise_for :users
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root to: "home#index"
	resources :users, :home
	resources :sessions do 
		get :signin, :on => :collection
		get :signUP, :on => :collection

	end
end