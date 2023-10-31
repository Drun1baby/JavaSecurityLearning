package shiro.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import shiro.mapper.UserMapper;
import shiro.pojo.User;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    UserMapper userMapper;

    @Override
    public User queryUserByName(String name){
        return userMapper.queryUserByName(name);
    }
}
