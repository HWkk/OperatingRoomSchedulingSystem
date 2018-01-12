接口：
	nightSchedule()
	daySchedule()

调用接口需要准备的文件(没有参数，只有文件):
 	nightSchedule() : nurses.json
 	daySchedult() : nurses.json(护士信息)
 					surgeries.json(手术信息)
 					clientTable.json
 					surgeryTimeTable.json
 					monthInfo.json(暂时保留，不一定需要)

输出文件：
	nightSchedule() : result.json(此时key:“day”对应值为空，只有“night"的值)
	daySchedule() : result.json