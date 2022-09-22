package com.drunkbaby.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.drunkbaby.pojo.Person;
import org.springframework.stereotype.Repository;

@Repository
public interface PersonMapper extends BaseMapper<Person> {
}
