class SchedulesController < ApplicationController
  protect_from_forgery with: :exception

  @count = 0

  def show
    if(@count == 0)
  	 initialJson()
     @count = @count + 1
    end
  end

  def initialJson
  	nurses = Nurse.all
    time = Time.now
    departments = getDepartments()

    for nurse in nurses 
      nurse.department = processDepartment(nurse.department, departments)
      nurse.is_experienced = processDepartment(nurse.is_experienced, departments)
      nurse.birthday = time.year.to_i - nurse.birthday.to_s()[0, 5].to_i
    end
	  File.new("./db/json/nurses.json", "w").syswrite(JSON.pretty_generate(nurses.as_json))
    File.new("./db/json/doctors.json", "w").syswrite(JSON.pretty_generate(Doctor.all.as_json))
    File.new("./db/json/patients.json", "w").syswrite(JSON.pretty_generate(Patient.all.as_json))
    File.new("./db/json/leaves.json", "w").syswrite(JSON.pretty_generate(Leave.all.as_json))
    File.new("./db/json/departments.json", "w").syswrite(JSON.pretty_generate(Department.all.as_json))
  end

  def processDepartment(nurses_d, departments)

    index = 0
    result = Array.new()
    while index < 14
      if(nurses_d[index] == "1")
        result.push(departments[index])
      end
      index = index + 1
    end
    return result
  end

  def getDepartments
    array = Array.new
    index = 1
    result = Array.new()
    while index <= 14
      d = Department.find(index)
      result.push(d.name)
      index = index + 1
    end
    return array
  end

end
