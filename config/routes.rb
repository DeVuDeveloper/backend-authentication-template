Rails.application.routes.draw do
  namespace :auth do
    post "sign_up", to: "registrations#create"
  end
end
