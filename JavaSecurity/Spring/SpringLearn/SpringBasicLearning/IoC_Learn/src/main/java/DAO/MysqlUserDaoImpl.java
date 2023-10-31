package DAO;

public class MysqlUserDaoImpl implements UserDao {
    @Override
    public void getUser() {
        System.out.println("通过 MySQL 的方式获取 User");
    }
}
