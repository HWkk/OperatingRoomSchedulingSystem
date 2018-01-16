import sys,os,json
cwd = os.getcwd()
sys.path.append(os.getcwd()+"/z3py/schedule")
import z3schedule
argv = sys.argv

if argv[1] == 'daySchedule':
    dayResult = z3schedule.daySchedule()
    if dayResult == None:
        print 'None'
    else:
        print dayResult
elif argv[1] == 'nightSchedule':
    nightResult = z3schedule.nightSchedule()
    if nightResult == None:
        print 'None'
    else:
        print nightResult
else:
    print "Usage: schedule_for_shell daySchedule|nightSchedule"
    exit(0)
