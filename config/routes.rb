Sc2events::Application.routes.draw do

  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/login', :to => 'sessions#new'
  match '/logout', :to => 'sessions#destroy'

  resources :events, :only => [ :index, :show ] do
    member do
      post :star
    end
  end

  match "/" => redirect("/events")

end
