import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.util.function.LongFunction;

public class RealEnv {
    public static void main(String[] args) {
        Logger logger = LogManager.getLogger(LongFunction.class);

        String username = "${java:os}";
        if (username != null) {
            logger.info("User {} login in!", username);
        }
        else {
            logger.error("User {} not exists", username);
        }
    }
}