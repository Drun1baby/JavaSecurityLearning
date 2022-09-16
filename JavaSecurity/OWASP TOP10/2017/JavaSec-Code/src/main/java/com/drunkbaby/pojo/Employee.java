package com.drunkbaby.pojo;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("employees")
public class Employee {

    private Integer id;
    private String name;
    private String work;

}
