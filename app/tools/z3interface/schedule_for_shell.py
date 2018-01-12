import sys
import Scheluing_Stub as schedule
argv = sys.argv
counts = len(argv)
if counts != 3:
    print "ERROR: num of args should be 3"
    sys.exit(1)
print schedule.schedule(argv[1],argv[2])
