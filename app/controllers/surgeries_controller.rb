require './app/tools/z3interface/schedule'
require 'json'

class SurgeriesController < ApplicationController
  protect_from_forgery prepend: true, with: :exception

  def show
    start_date = params[:start_date][:year] + "-" + params[:start_date][:month] + "-" + params[:start_date][:day]
    end_date = params[:end_date][:year] + "-" + params[:end_date][:month] + "-" + params[:end_date][:day]
    session[:start_date] = start_date
    session[:end_date] = end_date
    dates = processDate(start_date, end_date)

    @surgeries = selectSurgeries(dates)
    initialClientTableJson(dates)
    initialSurgeriesJson(@surgeries)
  	render 'surgeries/show'
  end

  def selectSurgeries(dates) 
    surgeries = Array.new
    for date in dates
      s = Surgery.where(date: date)
      for surgery in s
        surgeries.push(surgery)
      end
    end
    return surgeries
  end

  def processDate(startD, endD)
    start_date = Date.parse(startD)
    end_date = Date.parse(endD)
    dates = (start_date..end_date).to_a
    return dates
  end

  def initialSurgeriesJson(surgeries)
    File.new("./db/json/surgeries.json", "w").syswrite(JSON.pretty_generate(surgeries.as_json))
  end

  def initialClientTableJson(dates)
    clientTable = {}
    nurses = Nurse.all

    array = Array.new
    for nurse in nurses
      array.push(nurse.id.to_s)
    end

    for date in dates
      s = Surgery.where(date: date)
      hash = {}
      for surgery in s
        hash.store(surgery.id, array)
      end
      clientTable.store(date, hash)
    end

    File.new("./db/json/clientTable.json", "w").syswrite(JSON.pretty_generate(clientTable.as_json))
  end

  def daySchedule
    @surgery = Surgery.find(params[:surgery_id])
  	@nurses = Nurse.all
  	render 'surgeries/schedule'
  end

  def addNurse
    surgery_id = params[:surgery_id]
    surgery_date = Surgery.find(surgery_id).date.to_s
    modifyClientTable(params[:nurse], surgery_id, surgery_date)
    @surgeries = selectSurgeries(processDate(session[:start_date], session[:end_date]))
    render 'surgeries/show'
  end

  def modifyClientTable(nurses_id, surgery_id, surgery_date)
    clientTable = JSON.parse(File.read("./db/json/clientTable.json"))
    if(clientTable.has_key?(surgery_date))
      if(clientTable[surgery_date].has_key?(surgery_id))
        clientTable[surgery_date][surgery_id] = nurses_id
      else
        clientTable[surgery_date].store(surgery_id, nurses_id)
      end
    else
      hash = {}
      hash.store(surgery_id, nurses_id)
      clientTable.store(surgery_date, hash)
    end
    File.new("./db/json/clientTable.json", "w").syswrite(JSON.pretty_generate(clientTable.as_json))
  end

  def runAlgorithm
    load('./app/tools/z3interface/schedule.rb')
    daySchedulez3()
    dayScheduleResult = JSON.parse(File.read("./z3py/generate/json/dayResult.json"))
    updateSurgeries(dayScheduleResult)
    @surgeries = selectSurgeries(processDate(session[:start_date], session[:end_date]))
    render 'surgeries/show'
  end

  def updateSurgeries(dayScheduleResult)
    dayScheduleResult.each_key { |date|
      dayScheduleResult[date]["day"].each_key { |surgery_id|
        surgery = Surgery.find(surgery_id.to_i)
        surgery.update(instrument_nurse_id: dayScheduleResult[date]["day"][surgery_id]["instrument"].to_i, 
          roving_nurse_id: dayScheduleResult[date]["day"][surgery_id]["roving"].to_i)
      }
    }
  end

  def backToIndex
    if(!session[:start_date].nil?)
      session[:start_date] = nil
    end
    if(!session[:end_date].nil?)
      session[:end_date] = nil
    end
    render 'schedules/show'
  end

  def backToList
    @surgeries = selectSurgeries(processDate(session[:start_date], session[:end_date]))
    render 'surgeries/show'
  end

end
