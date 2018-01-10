class Nurse < ApplicationRecord
  def findAllNurses
  	nurses = Nurse.all
  	return nurses
  end
end
