package shiro.service;

import org.springframework.stereotype.Repository;
import shiro.pojo.User;

@Repository
public interface UserService {

    public User queryUserByName(String name);
}
