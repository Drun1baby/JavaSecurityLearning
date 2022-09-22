package com.drunkbaby.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.metadata.OrderItem;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.drunkbaby.mapper.EmployeeMapper;
import com.drunkbaby.mapper.PersonMapper;
import com.drunkbaby.pojo.Employee;
import com.drunkbaby.pojo.Person;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class SQLI {

    @Autowired
    private EmployeeMapper employeeMapper;

    @Autowired
    private PersonMapper personMapper;

    private static Logger logger = LoggerFactory.getLogger(SQLI.class);

    @RequestMapping("/mybatis_plus/test")
    public Employee test(@RequestParam("name") String name) {
        QueryWrapper<Employee> wrapper = new QueryWrapper<>();
        wrapper.eq("name",name);
        Employee employee = employeeMapper.selectOne(wrapper);
        return employee;
    }

    /**
     * http://localhost:8081/mybatis_plus/mpVuln01?name=drunkbaby&id=1%20and%20extractvalue(1,concat(0x7e,(select%20database()),0x7e))
     * @param name
     * @param id
     * @return
     * 实际的 apply 开发应用中的 SQL 注入
     */

    @RequestMapping("/mybatis_plus/mpVuln01")
    public Employee mpVuln01(String name, String id) {
        QueryWrapper<Employee> wrapper = new QueryWrapper<>();
        wrapper.eq("name",name).apply("id="+id);
        Employee employee = employeeMapper.selectOne(wrapper);
        return employee;
    }

    /**
     * http://localhost:8081/mybatis_plus/mpVuln02?id=1%20or%201=1
     * @param id
     * @return
     * 理想情况的 apply 关键字拼接导致的 SQL 注入
     */

    @RequestMapping("/mybatis_plus/mpVuln02")
    public List<Employee> mpVuln02( String id) {
        QueryWrapper<Employee> wrapper = new QueryWrapper<>();
        wrapper.apply("id="+id);
        return employeeMapper.selectList(wrapper);
    }

    /**
     * http://localhost:8081/mybatis_plus/last?id=1%20or%201=1
     * @param id
     * @return
     * last 关键字导致的 SQL 注入
     */

    @RequestMapping("/mybatis_plus/last")
    public List<Employee> mpVuln03( String id) {
        QueryWrapper<Employee> wrapper = new QueryWrapper<>();
        wrapper.last("order by " + id);
        return employeeMapper.selectList(wrapper);
    }

    /**
     * http://localhost:8081/mybatis_plus/exists?id=1%20or%201=1
     * @param id
     * @return
     * exists 关键字导致的 SQL 注入
     */

    @RequestMapping("/mybatis_plus/exists")
    public List<Employee> mpVuln04( String id) {
        QueryWrapper<Employee> wrapper = new QueryWrapper<>();
        wrapper.exists("select * from employees where id = " + id);
        return employeeMapper.selectList(wrapper);
    }

    /**
     * http://localhost:8081/mybatis_plus/notExists?id=1%20or%201=1
     * @param id
     * @return
     * notExists 关键字导致的 SQL 注入
     */

    @RequestMapping("/mybatis_plus/notExists")
    public List<Employee> mpVuln05( String id) {
        QueryWrapper<Employee> wrapper = new QueryWrapper<>();
        wrapper.notExists("select * from employees where id = " + id);
        return employeeMapper.selectList(wrapper);
    }

    /**
     * http://localhost:8081/mybatis_plus/having?id=1%20or%201=1
     * @param id
     * @return
     * having 关键字的 SQL 注入
     */

    @RequestMapping("/mybatis_plus/having")
    public List<Employee> mpVuln06( String id) {
        QueryWrapper<Employee> wrapper = new QueryWrapper<>();
        wrapper.select().groupBy("id").having("id >" + id);
        return employeeMapper.selectList(wrapper);
    }

    /**
     * http://localhost:8081/mybatis_plus/orderby01?id=1%20or%201=1
     * @param id
     * @return
     * order by
     */

    @RequestMapping("/mybatis_plus/orderby01")
    public List<Employee> orderby01( String id) {
        QueryWrapper<Employee> wrapper = new QueryWrapper<>();
        wrapper.select().orderBy(true, true, id);
        return employeeMapper.selectList(wrapper);
    }

    /**
     * http://localhost:8081/mybatis_plus/orderby02?id=1%20or%201=1
     * @param id
     * @return
     * Asc
     */

    @RequestMapping("/mybatis_plus/orderby02")
    public List<Employee> orderby02( String id) {
        QueryWrapper<Employee> wrapper = new QueryWrapper<>();
        wrapper.select().orderByAsc(id);
        return employeeMapper.selectList(wrapper);
    }

    /**
     * http://localhost:8081/mybatis_plus/orderby03?id=1%20or%201=1
     * @param id
     * @return
     * Desc
     */

    @RequestMapping("/mybatis_plus/orderby03")
    public List<Employee> orderby03( String id) {
        QueryWrapper<Employee> wrapper = new QueryWrapper<>();
        wrapper.select().orderByDesc(id);
        return employeeMapper.selectList(wrapper);
    }

    /**
     * http://localhost:8081/mybatis_plus/groupBy?id=1%20or%201=1
     * @param id
     * @return
     */

    @RequestMapping("/mybatis_plus/groupBy")
    public List<Employee> groupBy( String id) {
        QueryWrapper<Employee> wrapper = new QueryWrapper<>();
        wrapper.select().groupBy(id);
        return employeeMapper.selectList(wrapper);
    }

    /**
     * http://localhost:8081/mybatis_plus/inSql?id=1%20or%201=1
     * @param id
     * @return
     */

    @RequestMapping("/mybatis_plus/inSql")
    public List<Employee> inSql( String id) {
        QueryWrapper<Employee> wrapper = new QueryWrapper<>();
        wrapper.select().inSql(id, "select * from employees where id >" + id);
        return employeeMapper.selectList(wrapper);
    }

    /**
     * http://localhost:8081/mybatis_plus/notInSql?id=1%20or%201=1
     * @param id
     * @return
     */

    @RequestMapping("/mybatis_plus/notInSql")
    public List<Employee> notInSql( String id) {
        QueryWrapper<Employee> wrapper = new QueryWrapper<>();
        wrapper.select().notInSql(id, "select * from employees where id >" + id);
        return employeeMapper.selectList(wrapper);
    }

    /**
     * http://localhost:8081/mybatis_plus/PageVul01?id=1' and sleep(5)
     * @param id
     * @return
     */

    @RequestMapping("/mybatis_plus/PageVul01")
    public List<Person> mybatisPlusPageVuln01(Long page, Long size, String id){
        QueryWrapper<Person> queryWrapper = new QueryWrapper<>();
        Page<Person> personPage = new Page<>(1,2);
        personPage.addOrder(OrderItem.asc(id));
        IPage<Person> iPage= personMapper.selectPage(personPage, queryWrapper);
        List<Person> people = iPage.getRecords();
        return people;
    }

}
