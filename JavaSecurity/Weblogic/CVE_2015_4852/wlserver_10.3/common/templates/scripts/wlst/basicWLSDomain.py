#=======================================================================================
# This is an example of a simple WLST offline configuration script. The script creates 
# a simple WebLogic domain using the Basic WebLogic Server Domain template. The script 
# demonstrates how to open a domain template, create and edit configuration objects, 
# and write the domain configuration information to the specified directory.
#
# This sample uses the demo Pointbase Server that is installed with your product.
# Before starting the Administration Server, you should start the demo Pointbase server
# by issuing one of the following commands:
#
# Windows: WL_HOME\common\eval\pointbase\tools\startPointBase.cmd
# UNIX: WL_HOME/common/eval/pointbase/tools/startPointBase.sh
#
# (WL_HOME refers to the top-level installation directory for WebLogic Server.)
#
# The sample consists of a single server, representing a typical development environment. 
# This type of configuration is not recommended for production environments.
#
# Please note that some of the values used in this script are subject to change based on 
# your WebLogic installation and the template you are using.
#
# Usage: 
#      java weblogic.WLST <WLST_script> 
#
# Where: 
#      <WLST_script> specifies the full path to the WLST script.
#=======================================================================================

#=======================================================================================
# Open a domain template.
#=======================================================================================

readTemplate("E:/Coding/JavaSec/wlserver_10.3/common/templates/domains/wls.jar")

#=======================================================================================
# Configure the Administration Server and SSL port.
#
# To enable access by both local and remote processes, you should not set the 
# listen address for the server instance (that is, it should be left blank or not set). 
# In this case, the server instance will determine the address of the machine and 
# listen on it. 
#=======================================================================================

cd('Servers/AdminServer')
set('ListenAddress','')
set('ListenPort', 7001)

create('AdminServer','SSL')
cd('SSL/AdminServer')
set('Enabled', 'True')
set('ListenPort', 7002)

#=======================================================================================
# Define the user password for weblogic.
#=======================================================================================

cd('/')
cd('Security/base_domain/User/weblogic')
# Please set password here before using this script, e.g. cmo.setPassword('value')

#=======================================================================================
# Create a JMS Server.
#=======================================================================================

cd('/')
create('myJMSServer', 'JMSServer')

#=======================================================================================
# Create a JMS System resource. 
#=======================================================================================

cd('/')
create('myJmsSystemResource', 'JMSSystemResource')
cd('JMSSystemResource/myJmsSystemResource/JmsResource/NO_NAME_0')

#=======================================================================================
# Create a JMS Queue and its subdeployment.
#=======================================================================================

myq=create('myQueue','Queue')
myq.setJNDIName('jms/myqueue')
myq.setSubDeploymentName('myQueueSubDeployment')

cd('/')
cd('JMSSystemResource/myJmsSystemResource')
create('myQueueSubDeployment', 'SubDeployment')

#=======================================================================================
# Create and configure a JDBC Data Source, and sets the JDBC user.
#=======================================================================================

cd('/')
create('myDataSource', 'JDBCSystemResource')
cd('JDBCSystemResource/myDataSource/JdbcResource/myDataSource')
create('myJdbcDriverParams','JDBCDriverParams')
cd('JDBCDriverParams/NO_NAME_0')
set('DriverName','com.pointbase.jdbc.jdbcUniversalDriver')
set('URL','jdbc:pointbase:server://localhost/demo')
set('PasswordEncrypted', 'PBPUBLIC')
set('UseXADataSourceInterface', 'false')
create('myProps','Properties')
cd('Properties/NO_NAME_0')
create('user', 'Property')
cd('Property/user')
cmo.setValue('PBPUBLIC')

cd('/JDBCSystemResource/myDataSource/JdbcResource/myDataSource')
create('myJdbcDataSourceParams','JDBCDataSourceParams')
cd('JDBCDataSourceParams/NO_NAME_0')
set('JNDIName', java.lang.String("myDataSource_jndi"))

cd('/JDBCSystemResource/myDataSource/JdbcResource/myDataSource')
create('myJdbcConnectionPoolParams','JDBCConnectionPoolParams')
cd('JDBCConnectionPoolParams/NO_NAME_0')
set('TestTableName','SYSTABLES')

#=======================================================================================
# Target resources to the servers. 
#=======================================================================================

cd('/')
assign('JMSServer', 'myJMSServer', 'Target', 'AdminServer')
assign('JMSSystemResource.SubDeployment', 'myJmsSystemResource.myQueueSubDeployment', 'Target', 'myJMSServer')
assign('JDBCSystemResource', 'myDataSource', 'Target', 'AdminServer')

#=======================================================================================
# Write the domain and close the domain template.
#=======================================================================================

setOption('OverwriteDomain', 'true')
writeDomain('E:/Coding/JavaSec/user_projects/domains/basicWLSDomain')
closeTemplate()

#=======================================================================================
# Exit WLST.
#=======================================================================================

exit()
