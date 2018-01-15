class SchedulesController < ApplicationController
  protect_from_forgery with: :exception

  def show
  	initialJson()
  end

  def initialJson
  	nurses = Nurse.all
    time = Time.now

    for nurse in nurses 
      nurse.department = processDepartment(nurse.department)
      nurse.is_experienced = processDepartment(nurse.is_experienced)
      nurse.birthday = time.year.to_i - nurse.birthday.to_s()[0, 5].to_i
    end
	File.new("./db/json/nurses.json", "w").syswrite(JSON.pretty_generate(nurses.as_json))
    File.new("./db/json/doctors.json", "w").syswrite(JSON.pretty_generate(Doctor.all.as_json))
    File.new("./db/json/patients.json", "w").syswrite(JSON.pretty_generate(Patient.all.as_json))
    File.new("./db/json/surgeries.json", "w").syswrite(JSON.pretty_generate(Surgery.all.as_json))
    File.new("./db/json/leaves.json", "w").syswrite(JSON.pretty_generate(Leave.all.as_json))
    File.new("./db/json/departments.json", "w").syswrite(JSON.pretty_generate(Department.all.as_json))
  end

  def processDepartment(departments)
    index = 0
    result = Array.new()
    while index < 14
      if(departments[index] == "1")
        d = Department.find(index + 1)
        result.push(d.name)
      end
      index = index + 1
    end
    return result
  end

end
