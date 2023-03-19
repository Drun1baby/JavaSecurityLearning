package shiro.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;
import shiro.pojo.User;

@Repository
@Mapper
public interface UserMapper {
    public User queryUserByName(String name);
}
