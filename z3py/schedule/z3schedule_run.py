import z3schedule

def main() :
	nightResult = z3schedule.nightSchedule()
	if nightResult == None :
		print "Night Scheduling :Failure"
	else :
		print "Night Scheduling : Success"
	dayResult = z3schedule.daySchedule()
	if dayResult == None :
		print "Day Scheduling : Failure"
	else :
		print "Day Scheduling : Success"
	pass

if __name__ == "__main__" :
	main()
	pass