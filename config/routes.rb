Rails.application.routes.draw do
	root to: 'articles#index'
	get 'article/import', to: 'articles#import'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
