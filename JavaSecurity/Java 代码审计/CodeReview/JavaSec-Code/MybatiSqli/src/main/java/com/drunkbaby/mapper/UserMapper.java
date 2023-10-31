package com.drunkbaby.mapper;

import com.drunkbaby.pojo.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
public interface UserMapper {

    /**
     * If using simple sql, we can use annotation. Such as @Select @Update.
     * If using ${username}, application will send a error.
     */

    @Select("select * from users where username = #{username}")
    User findByUserName(@Param("username") String username);

    @Select("select * from users where username = '${username}'")
    List<User> findByUserNameVuln01(@Param("username") String username);

    List<User> findByUserNameVuln02(String username);
    List<User> findByUserNameVuln03(@Param("order") String order);

    List<User> findByIdVuln04(@Param("id") String id);

    List<User> findByIdSec04(@Param("id") List id);


    User findById(Integer id);

    User OrderByUsername();
}
