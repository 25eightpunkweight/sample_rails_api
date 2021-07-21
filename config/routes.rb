Rails.application.routes.draw do
  resources :guest_details
  resources :guest_phone_numbers
  resources :guests
  resources :reservations
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
