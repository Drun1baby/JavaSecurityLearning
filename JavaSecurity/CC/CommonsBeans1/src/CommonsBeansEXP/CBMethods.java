import org.apache.commons.beanutils.PropertyUtils;

// PropertyUtils.getProperty 的应用
public class CBMethods {
    public static void main(String[] args) throws Exception{
        Baby baby = new Baby();
        System.out.println(PropertyUtils.getProperty(baby, "name"));
    }
}
