require './app/tools/z3interface/schedule'
require 'json'

class SurgeriesController < ApplicationController
  protect_from_forgery prepend: true, with: :exception

  def show
  	d = params[:date]
  	@surgeries = Surgery.where(date: d)
    initialClientTable(d, @surgeries)
  	render 'surgeries/show'
  end

  def initialClientTable(date, surgeries)
    clientTable = {}
    hash = {}
    nurses = Nurse.all

    array = Array.new
    for nurse in nurses
      array.push(nurse.id.to_s)
    end

    for surgery in surgeries
      hash.store(surgery.id, array)
    end
    clientTable.store(date, hash)
    File.new("./db/json/clientTable.json", "w").syswrite(JSON.pretty_generate(clientTable.as_json))
  end

  def schedule
    @surgery = Surgery.find(params[:surgery_id])
  	@nurses = Nurse.all
  	render 'surgeries/schedule'
  end

  def addNurse
    surgery_id = params[:surgery_id]
    nurses_id = params[:nurse]
    surgery_date = Surgery.find(surgery_id).date.to_s
    modifyClientTable(nurses_id, surgery_id, surgery_date)
    @surgeries = Surgery.where(date: surgery_date)
    render 'surgeries/show'
  end

  def modifyClientTable(nurses_id, surgery_id, surgery_date)
    # array = Array.new
    # for nurse_id in nurses_id
    #   array.push(nurse_id)
    # end

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
    #此处应进行算法判断
    # if(true)
    #   surgery.update(instrument_nurse_id: instrument_nurse_id, roving_nurse_id: roving_nurse_id)
    # end
    @surgeries = Surgery.where(date: params[:date])
    render 'surgeries/show'
  end

  def getScheduleResult
      # TODO: 这里的参数暂时省略了,这些参数应该是从数据库中获取
      client_table_data_str = File.read('./app/tools/z3interface/clientTable.json')
      surgery_time_data_str = File.read("./app/tools/z3interface/surgeryTimeTable.json")
      Schedule.schedule(client_table_data_str,surgery_time_data_str)
  end

end
