Rails.application.routes.draw do
  devise_for :users
	root 'jobs#index' 

	resources :jobs do
		resources :resumes
	end

	namespace :admin do
		resources :jobs do
			member do
				post :public
				post :hide
			end

			resources :resumes
		end
	end



end
