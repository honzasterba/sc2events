Sc2events::Application.routes.draw do

  match '/auth/:provider/callback', :to => 'sessions#create'

  resources :events, :only => [ :index, :show ] do
    post :star
  end

end
