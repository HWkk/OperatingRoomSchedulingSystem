class SchedulesController < ApplicationController
  protect_from_forgery with: :exception
  def test
  end

  
  def firstShow
    initialJson()
    today = Time.new
    start_date = (today.year).to_s + "-" + today.month.to_s + "-01"
    if(today.month !=12)
      end_date = today.year.to_s + "-" + (today.month + 1).to_s + "-01"
    else
      end_date = (today.year+1).to_s + "-01-01"
    end
    
    dates = SurgeriesController.new.processDate(start_date, end_date)
    if(!(SurgeriesController.new.validateDateHasNightResult(dates)))
      flash[:day_notice] = "您还没有排当月的夜班，请先排当月的夜班再排白班"
      flash[:night_notice] = "还没有排夜班"
      render 'schedules/show'
    else
    render 'schedules/show'
    end
  end

  def show
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
    index = 1
    result = Array.new
    while index <= 14
      d = Department.find(index)
      result.push(d.name)
      index = index + 1
    end
    return result
  end

  def nightSchedule
    night_schedule = params[:night_schedule]
    dates = processNightScheduleDate(night_schedule)
    File.new("./db/json/monthInfo.json", "w").syswrite(JSON.pretty_generate(dates.as_json))
    load('./app/tools/z3interface/schedule.rb')
    nightSchedulez3()
    nightScheduleResult = JSON.parse(File.read("./z3py/generate/json/nightResult.json"))
    updateNightSchedule(nightScheduleResult)
    @schedules = findSchedules(dates)
    render 'schedules/nightSchedule'
  end

  def nightScheduleShow
    dates = processNightScheduleDateShow()
    File.new("./db/json/monthInfo.json", "w").syswrite(JSON.pretty_generate(dates.as_json))
    load('./app/tools/z3interface/schedule.rb')
    nightSchedulez3()
    nightScheduleResult = JSON.parse(File.read("./z3py/generate/json/nightResult.json"))
    updateNightSchedule(nightScheduleResult)
    @schedules = findSchedules(dates)
    render 'schedules/nightSchedule'
  end


  def processNightScheduleDateShow()
    today = Time.new
    start_date = (today.year).to_s + "-" + today.month.to_s + "-01"
    if(today.month !=12)
      end_date = today.year.to_s + "-" + (today.month + 1).to_s + "-01"
    else
      end_date = (today.year+1).to_s + "-01-01"
    end
    dates = SurgeriesController.new.processDate(start_date, end_date)
    dates.delete_at(dates.length - 1)
    return dates
  end


  def updateNightSchedule(nightScheduleResult)
    nightScheduleResult.each_key { |date|
      schedule = NightSchedule.find_by(date: date)
      if(schedule == nil)
        schedule = NightSchedule.create(date: date, nurse1_id: nightScheduleResult[date]["night"][0].to_i,
          nurse2_id: nightScheduleResult[date]["night"][1].to_i,
          nurse3_id: nightScheduleResult[date]["night"][2].to_i,
          nurse4_id: nightScheduleResult[date]["night"][3].to_i,
          nurse5_id: nightScheduleResult[date]["night"][4].to_i,
          nurse6_id: nightScheduleResult[date]["night"][5].to_i,
          nurse7_id: nightScheduleResult[date]["night"][6].to_i,
          nurse8_id: nightScheduleResult[date]["night"][7].to_i,
          nurse9_id: nightScheduleResult[date]["night"][8].to_i)
      else
        schedule.update(nurse1_id: nightScheduleResult[date]["night"][0].to_i,
          nurse2_id: nightScheduleResult[date]["night"][1].to_i,
          nurse3_id: nightScheduleResult[date]["night"][2].to_i,
          nurse4_id: nightScheduleResult[date]["night"][3].to_i,
          nurse5_id: nightScheduleResult[date]["night"][4].to_i,
          nurse6_id: nightScheduleResult[date]["night"][5].to_i,
          nurse7_id: nightScheduleResult[date]["night"][6].to_i,
          nurse8_id: nightScheduleResult[date]["night"][7].to_i,
          nurse9_id: nightScheduleResult[date]["night"][8].to_i)
      end
    }
  end

  def processNightScheduleDate(night_schedule)
    start_date = night_schedule[:year] + "-" + night_schedule[:month] + "-01"
    if(night_schedule[:month].to_i != 12)
      end_date = night_schedule[:year] + "-" + (night_schedule[:month].to_i + 1).to_s + "-01"
    else
      end_date = (night_schedule[:year].to_i + 1).to_s + "-01-01"
    end
    dates = SurgeriesController.new.processDate(start_date, end_date)
    dates.delete_at(dates.length - 1)
    return dates
  end

  def findSchedules(dates)
    hash = {}
    for date in dates
      array = Array.new
      schedule = NightSchedule.find_by(date: date)
      array.push(Nurse.find(schedule.nurse1_id).name)
      array.push(Nurse.find(schedule.nurse2_id).name)
      array.push(Nurse.find(schedule.nurse3_id).name)
      array.push(Nurse.find(schedule.nurse4_id).name)
      array.push(Nurse.find(schedule.nurse5_id).name)
      array.push(Nurse.find(schedule.nurse6_id).name)
      array.push(Nurse.find(schedule.nurse7_id).name)
      array.push(Nurse.find(schedule.nurse8_id).name)
      array.push(Nurse.find(schedule.nurse9_id).name)
      hash.store(date, array)
    end
    return hash
  end

  def backToIndex
    render 'schedules/show'
  end
end
