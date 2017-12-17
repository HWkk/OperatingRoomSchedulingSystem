## DB design



### table1 : nurse

|           列名            |    数据类型     | 是否主键 | 参考外键 |      备注      |
| :---------------------: | :---------: | :--: | :--: | :----------: |
|   nurse_id（rails自动生成）   | varchar(20) | yes  |  -   |              |
|          name           | varchar(20) |  no  |  -   |              |
|         gender          |   char(2)   |  no  |  -   |     男/女      |
|        birthday         |    date     |  no  |  -   |              |
|       id_card_num       | varchar(20) |  no  |  -   |     身份证号     |
|      phone_number       | varchar(20) |  no  |  -   |              |
|         salary          |    float    |  no  |  -   |              |
|     inaugural_date      |    date     |  no  |  -   |     入职时间     |
|      is_lactation       |   boolean   |  no  |  -   |     0/1      |
|       is_pregnant       |   boolean   |  no  |  -   |     0/1      |
|       department        | varchar(20) |  no  |  -   | 可属多个专科，怎么设计？ |
|      qualification      | varchar(20) |  no  |  -   |  年资（高/中/低）   |
|     is_experienced      | varchar(20) |  no  |  -   | 可属多个专科，怎么设计？ |
| has_coach_qualification | varchar(20) |  no  |  -   | 0/1 可属多个专科吗？ |



### table2 : patient

|          列名           |    数据类型     | 是否主键 | 参考外键 |  备注  |
| :-------------------: | :---------: | :--: | :--: | :--: |
| patient_id（rails自动生成） | varchar(20) | yes  |  -   | 住院号  |
|         name          | varchar(20) |  no  |  -   |      |
|        gender         |   char(2)   |  no  |  -   |      |
|          age          |     int     |  no  |  -   |      |
|          bed          | varchar(20) |  no  |  -   |  床位  |
|       diagnosis       | varchar(40) |  no  |  -   |  诊断  |



### table3 : doctor

|          列名          |    数据类型     | 是否主键 | 参考外键 |  备注  |
| :------------------: | :---------: | :--: | :--: | :--: |
| doctor_id（rails自动生成） | varchar(20) | yes  |  -   |      |
|         name         | varchar(20) |  no  |  -   |      |



### table4 : surgery

|          列名           |     数据类型     | 是否主键 |             参考外键              |        备注        |
| :-------------------: | :----------: | :--: | :---------------------------: | :--------------: |
| surgery_id（rails自动生成） | varchar(20)  | yes  |               -               |                  |
|         date          |     date     |  no  |               -               |                  |
|         time          | varchar(20)  |  no  |               -               |  0830代表早上八点三十分   |
|         room          |     int      |  no  |               -               |       手术间        |
|         table         |     int      |  no  |               -               |       手术台        |
|      patient_id       |     int      |  no  |      patient.patient_id       |       住院号        |
|      department       | varchar(20)  |  no  |               -               |        专科        |
|         ward          | varchar(20)  |  no  |               -               | 病房（病房 + 专科 = 科室） |
|     surgery_name      | varchar(50)  |  no  |               -               |                  |
|   anesthesia_method   | varchar(20)  |  no  |               -               |       麻醉方法       |
|       doctor_id       | varchar(20)  |  no  |       doctor.doctor_id        |       主刀医师       |
|       assistant       | varchar(50)  |  no  |               -               | 手术助手（多个助手，文本解析）  |
|  instrument_nurse_id  | varchar(100) |  no  | nurse.nurse_id(文本解析的话可能用不了外键) |   器械护士（台上护士？）    |
|    roving_nurse_id    | varchar(20)  |  no  | nurse.nurse_id(文本解析的话可能用不了外键) |   巡回护士（供应护士？）    |
|        remark         | varchar(100) |  no  |               -               |        备注        |



### table5 : night_schedule

nurse1-3是值班护士，nurse4-9是后备应急护士。

|              列名              |    数据类型     | 是否主键 |      参考外键      |  备注  |
| :--------------------------: | :---------: | :--: | :------------: | :--: |
| night_schedule_id（rails自动生成） | varchar(20) | yes  |       -        |      |
|             date             |    date     |  no  |       -        |      |
|          nurse1_id           | varchar(20) |  no  | nurse.nurse_id |      |
|          nurse2_id           | varchar(20) |  no  | nurse.nurse_id |      |
|          nurse3_id           | varchar(20) |  no  | nurse.nurse_id |      |
|          nurse4_id           | varchar(20) |  no  | nurse.nurse_id |      |
|          nurse5_id           | varchar(20) |  no  | nurse.nurse_id |      |
|          nurse6_id           | varchar(20) |  no  | nurse.nurse_id |      |
|          nurse7_id           | varchar(20) |  no  | nurse.nurse_id |      |
|          nurse8_id           | varchar(20) |  no  | nurse.nurse_id |      |
|          nurse9_id           | varchar(20) |  no  | nurse.nurse_id |      |



### 