package com.drunkbaby.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.drunkbaby.mapper.EmployeeMapper;
import com.drunkbaby.pojo.Employee;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class EmployeeController {

    @Autowired
    private EmployeeMapper employeeMapper;

    @RequestMapping("/mybatis_plus/test")
    public Employee mpVuln01(@RequestParam("name") String name) {
        QueryWrapper<Employee> wrapper = new QueryWrapper<>();
        wrapper.eq("name",name);
        Employee employee = employeeMapper.selectOne(wrapper);
        return employee;
    }

}
