Sc2events::Application.routes.draw do

  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/login', :to => 'sessions#new'
  match '/logout', :to => 'sessions#destroy'

  resources :events, :only => [ :index, :show ] do
    member do
      post :star
      post :unstar
    end
  end
  match "/" => redirect("/events"), :as => 'root'

  namespace :admin do
    resources :events
  end
  match "/admin" => redirect("/admin/events")


end
