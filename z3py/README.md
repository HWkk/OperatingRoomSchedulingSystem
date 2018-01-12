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
	nightSchedule() : nightResult.json(此时key:“day”对应值为空，只有“night"的值)
	daySchedule() : dayResult.json

使用方式：
	1， 将调用相关接口需要准备的文件放到文件夹./db/json/下面
	2， 调用相关接口，不用参数（参数就是文件，文件名已经写死了，这里没必要修改文件名）
	3， 接口调用完成后会将结果写出到相关文件（./z3py/schedule/generate/nightResult.json 和 ./z3py/schedule/generate/dayResult.json）