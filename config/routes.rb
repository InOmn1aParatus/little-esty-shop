Rails.application.routes.draw do
  namespace :admin do
    resources :merchants
    resources :invoices
  end

  resources :merchants do
    resources :items
  end
end
