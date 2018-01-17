Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'nurses/show', to:"nurses#show"
  get 'schedules/show', to:"schedules#show"
  post 'surgeries/show', to:"surgeries#show"
  get 'surgeries/daySchedule', to:"surgeries#daySchedule"
  post 'surgeries/addNurse', to:"surgeries#addNurse"
  get 'surgeries/run', to:"surgeries#runAlgorithm"
  get 'surgeries/backToIndex', to:"surgeries#backToIndex"
  get 'surgeries/backToList', to:"surgeries#backToList"
  post 'schedules/nightSchedule', to:"schedules#nightSchedule"
  get 'schedules/backToIndex', to:"schedules#backToIndex"

  get 'schedules/index', to:"schedules#index"
  # root 'schedules#firstShow'
  root 'schedules#index'
end
