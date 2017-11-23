Rails.application.routes.draw do
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	resource :dashboard
	resource :session
	resources :citations
	resources :users do
		member do
			get :change_password_begin
			put :change_password
		end
	end
end
