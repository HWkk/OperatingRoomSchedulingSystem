class NursesController < ApplicationController
  protect_from_forgery with: :exception

  def show
  	@nurses = Nurse.all
  	#puts(@nurses.to_json)
  end

end
