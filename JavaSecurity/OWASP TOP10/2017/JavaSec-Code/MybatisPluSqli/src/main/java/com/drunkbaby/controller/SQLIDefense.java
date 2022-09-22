package com.drunkbaby.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.drunkbaby.mapper.EmployeeMapper;
import com.drunkbaby.mapper.PersonMapper;
import com.drunkbaby.pojo.Employee;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.slf4j.Logger;

import java.util.List;

@RestController
public class SQLIDefense {

    @Autowired
    private EmployeeMapper employeeMapper;

    @Autowired
    private PersonMapper personMapper;

    private static Logger logger = LoggerFactory.getLogger(SQLIDefense.class);

    /**
     * http://localhost:8081/mybatis_plus/mpSec02??id=1%20or%201=1
     * @param id
     * @return
     * 对于 mpVuln01 和 mpVuln02 的修复
     */

    @RequestMapping("/mybatis_plus/mpSec02")
    public List<Employee> mpSec02(String id) {
        QueryWrapper<Employee> wrapper = new QueryWrapper<>();
        wrapper.apply("id={0}", id);
        return employeeMapper.selectList(wrapper);
    }
}
