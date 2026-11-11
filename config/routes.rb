Rails.application.routes.draw do
  root "donuts#index"

  resources :donuts, only: [] do
    collection do
      post :gacha
    end
  end
end
