Sc2events::Application.routes.draw do

  match '/auth/:provider/callback', :to => 'sessions#create'

  resources :sessions, :only => [ :create ]

  resources :events, :only => [ :index, :show ] do
    post :star
  end

  match "/" => redirect("/events")

end
