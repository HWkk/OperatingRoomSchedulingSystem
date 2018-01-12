# z3interface说明文档
此接口用来转接用z3 Python包实现的schedule函数
## 函数接口说明
TODO
## 函数参数说明
TODO
## 数据格式说明
clientTable<type 'dict'>: <str(date), dict(<str(id of surgery), list(ids of nurses)>)>, come from client
这是clientTable的格式,对应就是字典，字典里面是个str作为key，这个key是date，然后date对应的value又是一个字典,这个字典里面str作为key，这个key是手术的id，然后对应的value是个list,这个list是存储多个护士的id,result.json文件格式类似
形式如下：
```json
{
    date: {
        surgery_id: [nurse_id, nurse_id, nurse_id, ...],
        surgery_id: [nurse_id, nurse_id, nurse_id, ...],
        ...
    }
}
```
例如:
```
{
    "2017-12-05":{
        "18": ["1", "2", ... "27" ],
        "17": ["1", "2", ... "28" ]
        ...
    },
    "2017-12-04": {
        "13": ["1", "2", ... "7"],
        "15": ["1", "2", ... "27"]
      ...
  },
  ...
}
```

surgeryTimeTable list<str(time), list(ids of surgery)>
这个是手术时间冲突的那个参数，是一个字典，key是一个str，这个str是time（类似于”2017-08-09:8:00-9:00"）,然后这个time对应的value是一个列表
列表里面存储的就是多个手术的id.
形式如下：
```json
{
    time_range: [surgery_id, surgery_id, ..., surgery_id],
    time_range: [surgery_id, surgery_id, ..., surgery_id],
    ...
}
```
例如：
```
{
    "2017-08-09:8:00-9:00" : ["1","2","3","4","5"],
    "2017-08-09:10:00-12:00" : ["5","6","7","8","9","10"],
    ...
}
```
schedule函数的返回结果形式如下：
```json
{
    date:{
        "day":{
            surgery_id: {
                "instrument": nurse_id,
                "roving": nurse_id
            }
        },
        "neight": {
            surgery_id: {
                "instrument": nurse_id,
                "roving": nurse_id
            }
        }
    }
}
```
例如：
```
{
    "2017-12-05": {
        "day": {
            "18": {
                "instrument": "25",
                "roving": "26"
            },
            "17": {
                "instrument": "21",
                "roving": "22"
            },
            ...
        },
        "neight": ["16", "8", "51", ... ,"19"]
    },
    "2017-12-04": {
        "day": {
            "18": {
                "instrument": "4",
                "roving": "24"
            },
            "15": {
                "instrument": "25",
                "roving": "26"
            },
            ...
        },
        "neight": ["22", "38", "10", ... , "49"]
    },
    ...
}
```
