Rails.application.routes.draw do

  resources :players

  resources :leagues do
      member do
        get "/add_player/:player_id", :to => "leagues#add_player", :as => "add_player"
        get "/remove_player/:player_id", :to => "leagues#remove_player", :as => "remove_player"
        get "rounds/edit", :to => "rounds#edit_all", :as => "edit_all"
        get "rounds/generate_empty", :to => "rounds#generate_empty", :as => "generate_empty"
        get "rounds/generate_filled", :to => "rounds#generate_filled", :as => "generate_filled"
        get "rounds/edit_all_angular", :to => "rounds#edit_all_angular", :as => "edit_all_angular"
      end
    resources :rounds do
      resources :matches do
        member do
          patch "/update_players/:which/:player", :to => "matches#update_players", :as => "update_players"
        end
        resources :breaks do

        end
      end
    end
  end

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
