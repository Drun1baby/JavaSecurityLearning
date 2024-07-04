package org.example;

import javax.management.MBeanServer;
import javax.management.ObjectName;
import javax.management.remote.JMXConnectorServer;
import javax.management.remote.JMXConnectorServerFactory;
import javax.management.remote.JMXServiceURL;
import java.lang.management.ManagementFactory;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

public class jmxDemo {
    public static void main(String[] args) throws Exception{
        MBeanServer mBeanServer = ManagementFactory.getPlatformMBeanServer();
        ObjectName mbsName = new ObjectName("test:type=HelloWorld");
        HelloWorld mbean = new HelloWorld();
        mBeanServer.registerMBean(mbean, mbsName);

        // 创建一个 RMI Registry
        Registry registry = LocateRegistry.createRegistry(1099);
        // 构造 JMXServiceURL，绑定创建的 RMI
        JMXServiceURL jmxServiceURL = new JMXServiceURL("service:jmx:rmi:///jndi/rmi://localhost:1099/jmxrmi");
        // 构造JMXConnectorServer，关联 mbserver
        JMXConnectorServer jmxConnectorServer = JMXConnectorServerFactory.newJMXConnectorServer(jmxServiceURL, null, mBeanServer);
        jmxConnectorServer.start();
        System.out.println("JMXConnectorServer is ready");

        System.out.println("press any key to exit.");
        System.in.read();

    }
}
