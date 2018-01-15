require './app/tools/z3interface/schedule'
require 'json'

class SurgeriesController < ApplicationController
  protect_from_forgery prepend: true, with: :exception

  def show
  	d = params[:date]
  	@surgeries = Surgery.where(date: d)
  	render 'surgeries/show'
  end

  def schedule
    @surgery = Surgery.find(params[:surgery_id])
  	@nurses = Nurse.all
  	render 'surgeries/schedule'
  end

  def addNurse

    surgery_id = params[:surgery_id]
    nurses_id = params[:nurse]

    surgery = Surgery.find(surgery_id)

    # instrument_nurse.department = processDepartment(instrument_nurse.department)
    # puts(instrument_nurse.department)

    #此处应进行算法判断
    # if(true)
    #   surgery.update(instrument_nurse_id: instrument_nurse_id, roving_nurse_id: roving_nurse_id)
    # end

    # nurses = Nurse.all
    # time = Time.now

    # for nurse in nurses 
    #   nurse.department = processDepartment(nurse.department)
    #   nurse.is_experienced = processDepartment(nurse.is_experienced)
    #   nurse.birthday = time.year.to_i - nurse.birthday.to_s()[0, 5].to_i
    # end

    # nursesJson = File.new("./db/json/nurses.json", "w")
    # if nursesJson
    #   nursesJson.syswrite(nurses.to_json)
    # end

    # File.new("./db/json/doctors.json", "w").syswrite(Doctor.all.to_json)
    # File.new("./db/json/patients.json", "w").syswrite(Patient.all.to_json)
    # File.new("./db/json/surgeries.json", "w").syswrite(Surgery.all.to_json)
    # File.new("./db/json/leaves.json", "w").syswrite(Leave.all.to_json)
    # File.new("./db/json/departments.json", "w").syswrite(Department.all.to_json)

    @surgeries = Surgery.where(date: surgery.date)
    render 'surgeries/show'
  end

  def getScheduleResult
      # TODO: 这里的参数暂时省略了,这些参数应该是从数据库中获取
      client_table_data_str = File.read('./app/tools/z3interface/clientTable.json')
      surgery_time_data_str = File.read("./app/tools/z3interface/surgeryTimeTable.json")
      Schedule.schedule(client_table_data_str,surgery_time_data_str)
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
