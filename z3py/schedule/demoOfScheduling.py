#coding:utf-8
#!/usr/bin/python
# from __future__ import print_function
# Jiahong Zhou 2017
import sys
# path = "/Users/zhoujiahong/Jiahonglibs/z3-4.4.0-x64-osx-10.10.3/bin"
# path = "/Users/zhoujiahong/Jiahonglibs/z3-4.6.0-x64-osx-10.11.6/bin/python/z3"

import os
thisFilePath = os.path.split(os.path.realpath(__file__))[0]
rootPath = thisFilePath[0:-13]

z3path = rootPath + "z3py/bin/python/z3/"
# note: sys.path is the dictory for import python libs, find the libz3.dylib must use the PATH or Z3_LIB_DIRS
sys.path.append(z3path)

import __builtin__
__builtin__.Z3_LIB_DIRS = [rootPath + "z3py/bin/"]


import z3
import json
import random
import Queue
reload(sys)  # Python2.5 will delete sys.setdefaultencoding() while initialized environment, so we need reload agian
sys.setdefaultencoding('utf8')


nursesFileName = rootPath + "db/json/nurses.json"
surgeriesFileName = rootPath + "db/json/surgeries.json"


nurseTypes = ["instrument", "roving"]
# initialize the global variables
dayNumOfThisMonth = 31
nurseNumPerDay = 4
#for generating random integer 
minNurseNumPerDay = 5
maxNurseNumPerDay = 8
# nurseNumPerClass is 3
# but we never use the variable right now
nurseNumPerGroup = 3
groupNumPerNight = 3
# class nurse: generate by nurses.json
# we have to modified the __str__ when nurses.json is modified 
class Nurse :
	def __init__(self) :
		pass

	def __cmp__(self, other) :
		return self.priority >= other.priority
		pass

	def __str__(self) :
		return 	"id: " + self.id + \
				"\nhas_coach_qualification: " + self.has_coach_qualification + \
				"\nis_lactation: " + self.is_lactation + \
				"\nphone_number: " + self.phone_number + \
				"\nid_card_num: " + self.id_card_num + \
				"\nsalary: " + self.salary + \
				"\nqualification: " + self.qualification + \
				"\nis_pregnant: " + self.is_pregnant + \
				"\nbirthday: " + self.birthday + \
				"\nis_experienced: " + self.is_experienced + \
				"\ninaugural_date: " + self.inaugural_date + \
				"\ndepartment: " + self.department + \
				"\ngender: " + self.gender + \
				"\nname: " + self.name
		pass

class Surgery :
	def __init__(self) :
		pass

# generate nurses table by nurses.json
# return a dict <str(id), Nurse>
def getNurses(filename) :
	nursesFile = open(filename, "r")
	nursesStr = nursesFile.read()
	nursesDict = json.loads(nursesStr)
	# print type(nursesDict)
	# <type list>

	nurses = dict()
	for nurseDict in nursesDict :
		nurse = Nurse()
		nurse.__dict__ = nurseDict
		nurse.id = str(nurse.id)
		nurses[nurse.id] = nurse
		# print type(nurse.id)
	return nurses
	pass

# generate surgeries table by surgeries.json
# return surgeries dict <str(id), Surgery>, dict <str(date), list(ids of surgeries)>
def getSurgeries(filename) :
	surgeriesFile = open(filename, "r")
	surgeriesStr = surgeriesFile.read()
	surgeriesDict = json.loads(surgeriesStr)
	surgeries = dict()
	surgeryTable = dict()
	for surgeryDict in surgeriesDict :
		surgery = Surgery()
		surgery.__dict__ = surgeryDict
		surgery.id = str(surgery.id)
		surgeries[surgery.id] = surgery
		if surgeryTable.has_key(surgery.date) is not True:
			surgeryTable[surgery.date] = list()
		surgeryTable[surgery.date].append(surgery.id)
	# surgeriesString = json.dumps(surgeries["2017-12-01"][1], skipkeys=False, ensure_ascii=False, check_circular=True, allow_nan=True, cls=None, indent=True, separators=None, encoding="utf-8", default=None, sort_keys=False)
	# print surgeriesString
	return surgeries, surgeryTable
	pass


def generateDate(day) :
	if day < 10 :
		date = "{0}-{1}-0{2}".format("2017", "12", day)
	else :
		date = "{0}-{1}-{2}".format("2017", "12", day)
	return date
	pass


# schedule for night of month
# return monthTable<type 'dict'>: <str(date), list(<list(ids of nurses)>)> list:[groupNumPerNight][nurseNumPerGroup]
def scheduleMonthTable(nurses) :
	monthTable = dict()
	nurseQueue = Queue.PriorityQueue()
	for id in nurses.keys() :
		nurse = nurses[id]
		nurse.priority = 1
		if nurse.qualification == "高" :
			nurse.priority = 3
		elif nurse.qualification == "中" :
			nurse.priority = 2
		elif nurse.qualification == "低" :
			nurse.priority = 1
		else :
			sys.stderr.write("error qualification: " + nurse.qualification + "\n") 
			# print nurse.qualification + " : error"
		nurseQueue.put(nurse)
	nurseQueueCopy = Queue.PriorityQueue()
	for day in range(1, dayNumOfThisMonth+1) :
		# all groups on day i
		groupsOneDay = list()
		for j in range(groupNumPerNight) :
			# all nurses of group j
			nursesOneGroup = list()
			for k in range(nurseNumPerGroup) :
				if nurseQueue.empty() : 
					# if nurseQueue is empty, we schedule from the maximum priority
					nurseQueue = nurseQueueCopy
					# nurseQueueCopy will Copy the nurseQueue again
					nurseQueueCopy = Queue.PriorityQueue()

				nurse = nurseQueue.get()
				# nurseQueueCopy copy the nurse
				nurseQueueCopy.put(nurse)

				nursesOneGroup.append(nurse.id)
			# print nursesOneGroup
			groupsOneDay.append(nursesOneGroup)
		# print groupsOneDay
		date = generateDate(day)
		# print date
		monthTable[date] = groupsOneDay


	# print monthTable
	return monthTable
	pass


# generate a fake scheduling table come from client
# nurseNumPerSurgeryForClient is None means we use random int
# return : clientTable dict <str(date), dict(<str(id of surgery), list(ids of nurses)>)>
# clientTable[date] is the ids of nurses could be scheduled on day date
def getScheduleFromClient(surgeryTable, nurses, nurseNumPerSurgeryForClient) :
	clientTable = dict()
	for date in surgeryTable.keys() :
		surgeriesOneDay = dict()
		for surgeryID in surgeryTable[date] :
			nursesOneSurgery = list()
			if nurseNumPerSurgeryForClient == None :
				nurseNumPerSurgeryForClient = random.randint(2, len(nurses)+1)
			for ni in range(1, nurseNumPerSurgeryForClient+1) :
				nursesOneSurgery.append(str(ni))
			surgeriesOneDay[surgeryID] = nursesOneSurgery
		clientTable[date] = surgeriesOneDay
	# print clientTable
	return clientTable
	pass

# # if nurseNum is None, nurseNum is randint(minNum, maxNum)
# # return nurseNumTable: nurseNumTable[i] is the num of nurses in day i+1
# # notice : nurseNumTable[i] is the number of nurses in day but not night
# def getNurseNumTable(nurseNum, minNum, maxNum) :
# 	nurseNums = list()
# 	if nurseNum == None :
# 		for i in range(dayNumOfThisMonth) :
# 			nurseNum = random.randint(minNum, maxNum)
# 			nurseNums.append(nurseNum)
# 	else :
# 		for i in range(dayNumOfThisMonth) :
# 			nurseNums.append(nurseNum)
# 	return nurseNums


def getSurgeryTimeTable(surgeryTable):
	pass

# TODO 
def matchDepartment(surgery, nurse) :
	return True
	pass

# nurses<type 'dict'>: <str(id of nurse), Nurse> info of all nurses, come from database
# surgeries<type 'dict'>: <str(id of surgery), Surgery> info of all surgeries, come from database
# monthTable<type 'dict'>: <str(date), list(<list(ids of nurses)>)> list:[groupNumPerNight][nurseNumPerGroup]
# clientTable<type 'dict'>: <str(date), dict(<str(id of surgery), list(ids of nurses)>)>, come from client
# monthInfo dict<str(date),dict<str("week" or "day"), int(which week of this month or which day of this week)>> come from client or generate by myself
# surgeryTimeTable list<str(time), list(ids of surgeries)>
def schedule(nurses, surgeries, monthTable, clientTable, monthInfo, surgeryTimeTable) :
	solver = z3.Solver()
	grid = dict()
	result = dict()
	for date in clientTable.keys() :
		# night
		nightNurses = list()
		for groupi in range (1, groupNumPerNight+1) :
			for nuri in range (1, nurseNumPerGroup+1) :
				value = z3.Int("night_%sgroup_%dnur_%d" %(date, groupi, nuri))
				grid[(date, groupi, nuri)] = value
				nightNurses.append(value)
				# constraint: make sure the nurses in night are the same as monthTable
				solver.add(value == int(monthTable[date][groupi-1][nuri-1]))
		# surgery
		for surgeryID in clientTable[date] :
			nightAndDayNurses = list(nightNurses)
			# nightAndDayNurses = [value for value in nightNurses]
			for nurseType in nurseTypes :
				value = z3.Int("day_%ssid_%stype_%s" %(date, surgeryID, nurseType))
				grid[(date, surgeryID, nurseType)] = value
				# department of surgery
				nurseIDs = clientTable[date][surgeryID]
				surgery = surgeries[surgeryID]
				orListForDepartment = list()
				# constraint: make sure all of the nurses come from client
				for nurseID in nurseIDs :
					nurse = nurses[nurseID]
					if matchDepartment(surgery, nurse) :
						# constraint: make sure the department of nurse matches with surgery
						orListForDepartment.append(z3.Or(value == int(nurseID)))
				# constraint: make sure the department of nurse matches with surgery
				# constraint: make sure all of the nurses come from client
				solver.add(z3.Or(orListForDepartment))
				nightAndDayNurses.append(value)
				
			# constraint: make sure nurses working for day are not working for night
			solver.add(z3.Distinct(nightAndDayNurses))
		# solver.add(z3.Eqel)
			
	# constraint: make sure the number of surgeries is limited by work hours
	for nurseID in nurses.keys() :

		for date in clientTable.keys() :
			dayNursesConstraint = list()
			for surgeryID in clientTable[date] :
				for nurseType in nurseTypes :
					value = grid[(date, surgeryID, nurseType)]
					dayNursesConstraint.append((value == int(nurseID), 1))
				#<type 'unicode'>
			if nurses[nurseID].is_pregnant == "true":
				solver.add(z3.PbLe(dayNursesConstraint, 1))
			else :
				solver.add(z3.PbLe(dayNursesConstraint, 1))

	# # constraint: make sure nurses are different in the same time
	# for surIDs in surgeryTimeTable :
	# 	sameTimeNurses = list()
	# 	for surID in surIDs :
	# 		for nurseType in nurseTypes :
	# 			value = grid[(surgeries[surID].date, surID, nurseType)]
	# 			sameTimeNurses.append(value)
	# 	# constraint: make sure nurses are different in the same time
	# 	solver.add(z3.Distinct(sameTimeNurses))

	# check sat
	if solver.check() != z3.sat :
		print "unsat"
		return None
	else :
		print "sat"
	# get the model
	
	model = solver.model()
	# get the result
	for date in clientTable.keys() :
		dateTable = dict()
		nightNurses = list()
		for groupi in range (1, groupNumPerNight+1) :
			for nuri in range (1, nurseNumPerGroup+1) :
				nurseID = str(model[grid[(date, groupi, nuri)]].as_long())
				nightNurses.append(nurseID)
				# assert
				assert nurseID == monthTable[date][groupi-1][nuri-1]
		dateTable["night"] = nightNurses
		dayTable = dict()
		for surgeryID in clientTable[date] :
			surgeryNurses = dict()
			for nurseType in nurseTypes :
				surgeryNurses[nurseType] = str(model[grid[date, surgeryID, nurseType]].as_long())
				# print model[grid[date, surgeryID, nurseType]].as_long()
				# print nurses[str(surgeryNurses[nurseType])].priority
			# constraint: make sure the qualification of roving nurse is higher than instrument nurse
			if nurses[surgeryNurses["instrument"]].priority > nurses[surgeryNurses["roving"]].priority :
				temp = surgeryNurses["instrument"]
				surgeryNurses["instrument"] = surgeryNurses["roving"]
				surgeryNurses["roving"] = temp

			assert nurses[surgeryNurses["instrument"]].priority <= nurses[surgeryNurses["roving"]].priority
			dayTable[surgeryID] = surgeryNurses

		dateTable["day"] = dayTable
		result[date] = dateTable
	return result
	pass


def main() :
	monthInfo = list()
	for day in range(1, dayNumOfThisMonth+1) :
		date = generateDate(day)
		monthInfo.append(date)
	with open (rootPath + "db/json/monthInfo.json", "w") as f :
		json.dump(monthInfo, f, skipkeys=False, ensure_ascii=False, check_circular=True, allow_nan=True, cls=None, indent=True, separators=None, encoding="utf-8", default=None, sort_keys=False)

	# nurses : contains info of all nurses
	nurses = getNurses(nursesFileName)
	surgeries, surgeryTable = getSurgeries(surgeriesFileName)
	# print surgeryTable
	# the table for night
	# monthTable = getMonthTable()
	monthTable = scheduleMonthTable(nurses)
	with open (rootPath + "db/json/monthTable.json", "w") as f :
		json.dump(monthTable, f, skipkeys=False, ensure_ascii=False, check_circular=True, allow_nan=True, cls=None, indent=True, separators=None, encoding="utf-8", default=None, sort_keys=False)

	# # the table come from client
	clientTable = getScheduleFromClient(surgeryTable, nurses, None)
	with open (rootPath + "db/json/clientTable.json", "w") as f :
		json.dump(clientTable, f, skipkeys=False, ensure_ascii=False, check_circular=True, allow_nan=True, cls=None, indent=True, separators=None, encoding="utf-8", default=None, sort_keys=False)

	monthInfo = None
	surgeryTimeTable = None
	result = schedule(nurses, surgeries, monthTable, clientTable, monthInfo, surgeryTimeTable)

	if result == None :
		print "result is none"
		return
	# print result
	# with open (rootPath + "db/json/result.json", "w") as f :
	# 	json.dump(result, f, skipkeys=False, ensure_ascii=False, check_circular=True, allow_nan=True, cls=None, indent=True, separators=None, encoding="utf-8", default=None, sort_keys=False)
	for date in clientTable.keys() :
		print date
		dateTable = result[date]
		nightNurses = dateTable["night"]
		dayTable = dateTable["day"]
		print "night: " ,nightNurses
		print "day: "
		for surgeryID in clientTable[date] :
			print surgeryID, ": " , dayTable[surgeryID]
	pass
		

if __name__ == '__main__':
    main()
    pass












