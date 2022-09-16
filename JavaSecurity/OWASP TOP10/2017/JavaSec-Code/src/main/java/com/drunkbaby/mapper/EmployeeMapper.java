package com.drunkbaby.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.drunkbaby.pojo.Employee;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.reflection.wrapper.BaseWrapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EmployeeMapper extends BaseMapper<Employee> {

    List<Employee> selectByName(@Param("name") String name);
}
