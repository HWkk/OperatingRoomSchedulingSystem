Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'schedules/show', to:"schedules#show"
  get 'surgeries/show', to:"surgeries#show"
  post 'surgeries/show', to:"surgeries#show"
  get 'surgeries/daySchedule', to:"surgeries#daySchedule"
  get 'surgeries/addNurse', to:"surgeries#addNurse"
  post 'surgeries/addNurse', to:"surgeries#addNurse"
  get 'surgeries/run', to:"surgeries#runAlgorithm"
  get 'surgeries/backToIndex', to:"surgeries#backToIndex"
  get 'surgeries/backToList', to:"surgeries#backToList"
  get 'schedules/nightSchedule', to:"schedules#nightSchedule"
  post 'schedules/nightSchedule', to:"schedules#nightSchedule"
  get 'schedules/backToIndex', to:"schedules#backToIndex"
  get 'schedules/backToIndex', to:"schedules#backToIndex"
  post 'schedules/backToIndex', to:"schedules#backToIndex"
  
  get 'schedules/nightSchedule/show', to:"schedules#nightScheduleShow"
  get 'surgeries/surgeriesList', to:"surgeries#surgeriesList" 


  get 'schedules/test', to:"schedules#test"
  root "schedules#firstShow"
  # root 'schedules#test'
end
