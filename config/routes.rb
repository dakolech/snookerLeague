Rails.application.routes.draw do

  root 'static_pages#home'


  #get "statistics1", :to => "static_pages#statistics", :as => "statistics"
  scope "api" do
    get "statistics", :to => "static_pages#statistics", :as => "statistics"

    resource :leagues, :only => [] do
      get "index", :to => "leagues#index", :as => "index"
    end

    resource :players, :only => [] do
      get "index_angular", :to => "players#index_angular", :as => "index_angular"
    end

    resources :players do
      get "show_angular", :to => "players#show_angular", :as => "show_angular"
      get "number_of_breaks_angular/:border", :to => "players#number_of_breaks_angular", :as => "number_of_breaks_angular"
      get "update_break_angular", :to => "players#update_break_angular", :as => "update_break_angular"
    end

    resources :leagues do
      member do
        #get "show_angular", :to => "leagues#show_angular", :as => "show_angular"
        get "edit_angular", :to => "leagues#edit_angular", :as => "edit_angular"
        patch "/add_player/:player_id", :to => "leagues#add_player", :as => "add_player",  defaults: { format: :json }
        patch "/remove_player/:player_id", :to => "leagues#remove_player", :as => "remove_player",  defaults: { format: :json }
        get "rounds/edit", :to => "rounds#edit_all", :as => "edit_all"
        get "rounds/generate_empty", :to => "rounds#generate_empty", :as => "generate_empty"
        get "rounds/generate_filled", :to => "rounds#generate_filled", :as => "generate_filled"
        get "rounds/edit_all_angular", :to => "rounds#edit_all_angular", :as => "edit_all_angular"
      end
      resources :rounds do
        resources :matches do
          member do
            patch "/update_players/:which/:player", :to => "matches#update_players", :as => "update_players"
            get "/edit_angular", :to => "matches#edit_angular", :as => "edit_angular"
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



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
