
module Schedule
    def schedule(client_table_data_str, surgery_time_data_str)
        # TODO: 这里的参数不止两个，其他参数省略了
        # str.gsb(/\s+/,"")方法可以去掉字符串中所有空白符
        cmd = 'python ./app/tools/z3interface/schedule_for_shell.py'+' '+client_table_data_str.gsub(/\s+/,"")+' '+ surgery_time_data_str.gsub(/\s+/,"")
        result = system(cmd)
        # print result
        return result
    end
end
