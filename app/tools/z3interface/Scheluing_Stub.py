#coding=utf8
import json
def schedule(clientTable,surgeryTimeTable) :
    # schedule(nurses, surgeries, monthTable, clientTable, monthInfo, surgeryTimeTable)
    # 这是一个schedule函数的stub，没有实际意义，只是用来模拟schedule函数，这里只模拟两个参数
    # TODO: 参数补全
    print "calling shcedule..."
    print "clientTable:"
    print clientTable
    print "surgeryTimeTable"
    print surgeryTimeTable
    result = json.load(open("./app/tools/z3interface/result.json"))
    return result
