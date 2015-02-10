Rails.application.routes.draw do

  root 'static_pages#home'

  scope "api",  defaults: { format: :json } do
    get "statistics", :to => "static_pages#statistics", :as => "statistics"

    resource :leagues do
      get "index", :to => "leagues#index", :as => "index"
    end

    resource :players do
      get "index", :to => "players#index", :as => "index"
    end

    resources :players do
      get "show", :to => "players#show", :as => "show"
    end

    resources :leagues do
      member do
        patch "/add_player/:player_id", :to => "leagues#add_player", :as => "add_player",  defaults: { format: :json }
        patch "/remove_player/:player_id", :to => "leagues#remove_player", :as => "remove_player",  defaults: { format: :json }
        get "rounds/edit_all", :to => "rounds#edit_all", :as => "edit_all"
        get "rounds/generate_empty", :to => "rounds#generate_empty", :as => "generate_empty"
        get "rounds/generate_filled", :to => "rounds#generate_filled", :as => "generate_filled"
      end
      resources :rounds do
        resources :matches do
          member do
            patch "/update_player/:which/:player", :to => "matches#update_player", :as => "update_player"
          end
          resources :frames do
            resources :breaks do
            end
          end
        end
      end
    end
  end

  match "*path" => 'static_pages#home', via: :all
end
