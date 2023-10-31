package src.JdkProxy.MoreStaticProxy;

// 代理
public class UserServiceProxy implements UserService{
    private UserServiceImpl userService;

    public void setUserService(UserServiceImpl userService) {
        this.userService = userService;
    }

    public void add() {
        log("add");
        userService.add();
    }

    public void delete() {
        log("delete");
        userService.delete();
    }

    public void update() {
        log("update");
        userService.update();
    }

    public void query() {
        log("query");
        userService.query();
    }

    // 增加日志方法
    public void log(String msg){
        System.out.println("[Debug]使用了 " + msg +"方法");
    }
}
