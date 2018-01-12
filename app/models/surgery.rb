class Surgery < ApplicationRecord
	def getPatient(patient_id)
		return Patient.find(patient_id)
	end

	def getDoctor(doctor_id)
		return Doctor.find(doctor_id)
	end

	def getNurses(nurses_id)
		nurses = Array.new
		if(nurses_id == nil)
			return nurses
		end

		ids = nurses_id.split(",")
		for id in ids
			nurses.push(Nurse.find(id).name)
		end
		return nurses
	end

	
end
