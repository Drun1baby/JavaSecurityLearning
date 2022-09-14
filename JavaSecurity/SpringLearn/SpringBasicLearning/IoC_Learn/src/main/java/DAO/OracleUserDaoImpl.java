package DAO;

public class OracleUserDaoImpl implements UserDao {
    @Override
    public void getUser() {
        System.out.println("Oracle 数据被调用");
    }
}
