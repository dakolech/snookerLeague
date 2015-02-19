Rails.application.routes.draw do

  root 'static_pages#home'

  scope "api",  defaults: { format: :json } do

    get "statistics", :to => "static_pages#statistics", :as => "statistics"

    get "leagues/index", :to => "leagues#index", :as => "index_leagues"
    get "players/index", :to => "players#index", :as => "index_players"

    resources :players, only: [:show, :create, :update, :destroy] do
      get "show", :to => "players#show", :as => "show"
    end

    resources :leagues, only: [:show, :create, :edit, :update, :destroy] do
      member do
        patch "/add_player/:player_id", :to => "leagues#add_player", :as => "add_player"
        patch "/remove_player/:player_id", :to => "leagues#remove_player", :as => "remove_player"
        get "rounds/edit_all", :to => "rounds#edit_all", :as => "edit_all"
        get "rounds/generate_empty", :to => "rounds#generate_empty", :as => "generate_empty"
        get "rounds/generate_filled", :to => "rounds#generate_filled", :as => "generate_filled"
      end

      resources :rounds, only: [:update] do
      end
    end

    resources :matches, only: [:edit, :update] do
      member do
        patch "/update_player/:which/:player", :to => "matches#update_player", :as => "update_player"
      end
      resources :frames, only: [:update] do
        resources :breaks, only: [:create, :update, :destroy] do
        end
      end
    end

  end

  match "*path" => 'static_pages#home', via: :all
end
