Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'nurses/show', to:"nurses#show"
  get 'schedules/show', to:"schedules#show"
  get 'surgeries/show', to:"surgeries#show"
  get 'surgeries/schedule', to:"surgeries#schedule"
  post 'surgeries/addNurse', to:"surgeries#addNurse"

end
