class SurgeriesController < ApplicationController
  protect_from_forgery with: :exception

  def show
  	d = params[:date]
  	@surgeries = Surgery.where(date: d)
  	render 'surgeries/show'
  end

end
