Rails.application.routes.draw do
  resources :donuts, only: [] do
    collection do
      post :gacha
    end
  end
end
