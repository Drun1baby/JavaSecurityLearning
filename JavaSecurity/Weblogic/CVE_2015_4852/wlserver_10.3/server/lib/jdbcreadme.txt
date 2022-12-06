     JDBCREADME.TXT
     Progress(R) DataDirect(R) 
     DataDirect Connect(R) for JDBC(TM)
     Release 4.2.0.0000
     August 2010

***********************************************************************
Copyright (c) 1994-2010 Progress Software Corporation and/or its 
subsidiaries or affiliates. All Rights Reserved.

***********************************************************************

CONTENTS

Release 4.2.0 Features
Deprecated Connection Properties
Enhancement Requests and Fixes
Installation
Available DataDirect Connect for JDBC Drivers
Notes, Known Problems, and Restrictions
Using the Online Documents
DataDirect Connect for JDBC Files


     Release 4.2.0 Features

All Drivers
-----------
* New getAttribute() and setAttribute() methods of the ExtConnection 
  interface allow applications to more easily get and set client 
  information values in the database. 

DB2
---
* Support for DB2 V7R1 for iSeries
* Improved handling of Large Objects (LOBs), including:
  - New LobStreamingProtocol connection property for controlling 
    whether streaming or materialization occurs when fetching LOB and 
    XML data
  - New LongDataCacheSize connection property for controlling the
    caching of long data in result sets
  - Support for inline LOBs
* Ability to finetune query optimization, including:
  - New CurrentQueryOptimization connection property for specifying a 
    DB2 query optimization class to be used for query plan creation
  - New OptimizationProfile connection property for specifying a 
    DB2 optimization profile
  - New OptimizationProfileToFlush connection property for specifying 
    a DB2 optimization profile to be removed from the optimization 
    profile cache
* Support for AES encryption of user IDs and passwords on DB2 for 
  Linux/UNIX/Windows and DB2 for z/OS
* New ConcurrentAccessResolution connection property for specifying 
  whether a read transaction can access committed rows that are locked 
  by a write transaction when the application isolation level is 
  Read Committed or Repeatable Read
* Support for the DB2 Statement Concentrator and DB2 Connection 
  Concentrator
* Support for new DB2 V9.7 for Linux/UNIX/Windows features, including:
  - Support for alternative SQL syntax
  - Support for new scalar functions

Informix
--------
* Support for bulk load, including new BulkLoadBatchSize connection 
  property for controlling how many rows are loaded at one time

MySQL
-----
* Support for bulk load, including new BulkLoadBatchSize connection 
  property for controlling how many rows are loaded at one time

Oracle
------
* Support for new Oracle 11g R2 features, including:
  - Support for IPV6 
  - New EditionName connection property for specifying the name of the 
    Oracle edition used when establishing a connection 
  - New BulkLoadOptions connection property for enabling bulk load 
    Protocol options (Oracle 11g R2)
  - Support for Oracle columnar compression
  - Support for Grid Naming Service (GNS) functionality
* New ReportRecycleBin connection property for controlling whether 
  results contain items from the Oracle Recycle Bin for the 
  getTables(), getColumns(), and getTablePrivileges() methods 
  (Oracle 10g R1 and higher)
* Enhanced client information support, including:
  - New Action connection property for specifying the current action 
    within the current module
  - New ClientID connection property for setting a client identifier 
    in the database
  - New Module connection property for setting the module name in the 
    database

SQL Server
----------
* Support for the latest version of the Tabular Data Stream (TDS) 
  protocol.
* Improved handling of input and output parameter data types, 
  including:
  - New connection properties for describing the data type for 
    Date/Time/Timestamp and String input and output parameters 
    (DateTimeInputParameterType, DateTimeOutputParameterType, 
    StringInputParameterType, and StringOutputParameterType)
  - New connection properties for determining, at execute time, which 
    data type to use to send input and output parameters to 
    the database server (DescribeInputParameters and 
    DescribeOutputParameters)
* New SuppressConnectionWarnings connection property for suppressing
  informational warnings that occur when connecting
  
Sybase
------
* Support for Sybase Adaptive Server 15.5

DataDirect Connection Pool Manager
----------------------------------
* New getMaxPoolSizeBehavior() and setMaxPoolSizeBehavior() methods in 
  the PooledConnectionDataSource interface for controlling how the
  Pool Manager implements the maximum pool size.


     Deprecated Connection Properties

DB2
---
* CatalogIncludesSynonyms

Refer to the DATADIRECT CONNECT FOR JDBC USER'S GUIDE for details.

SQL Server
----------
* DescribeParameters
* ReceiveStringParameterType
* SendStringParametersAsUnicode

Refer to the DATADIRECT CONNECT FOR JDBC USER'S GUIDE for details.

  
     Enhancement Requests and Fixes

DD00040281 | All Drivers | Request for driver to clean up 
NullPointerExceptions to improve using drivers with debuggers.

DD00025827 | Oracle | Request for ability to set the PROGRAM column of 
the Oracle V$SESSION table at connection time.

DD00038411 | Oracle | Request to support querying tables using an 
Oracle database link.

DD00025704 | SQL Server | When executing DatabaseMetaData.isReadOnly(), 
driver returned false even if the database was read-only.

DD00027220 | SQL Server | Request to improve the error message that is 
returned when the driver cannot load DDJDBCAuth.dll.

DD00028171 | SQL Server | Request to reduce memory consumption and temp 
file usage when fetching LOBs.

DD00028680 | SQL Server | Request to create a temp directory when one 
does not yet exist to prevent empty stack exceptions when using the 
Apache Tomcat application server with the driver.  

DD00039419 | SQL Server | Request for ability to suppress information 
warnings generated by the database when connecting with the driver.

DD00029693 | Sybase | Driver generated an exception if a stored 
procedure output parameter did not have an input value bound to it.

DD00041216 | Sybase | When getDatabaseProductVersion() was called, the 
driver incorrectly returned the database version.

DD00042250 | Installer | The installer generated a "String index out of 
range: -4" exception when using a minor release version of Java SE 6 
(for example, version 1.6.0_10).

DD00029310 | Branding Tool | Request to add version checking of drivers 
to the Branding Tool.

DD00049800 | Pool Manager | Request ability to impose a hard limit on 
concurrent connections, similar to the ODBC and ADO.NET drivers.


     Installation

For All Users
--------------
* A complete installation of DataDirect Connect for JDBC requires 
  approximately 49 MB of hard disk space.

* J2SE 1.4 or higher is required to use DataDirect Connect for JDBC. 
  Standard installations of J2SE on some platforms do not include the 
  jar file containing the extended encoding set that is required to 
  support some of the less common database code pages. To verify 
  whether your J2SE version provides extended code page support, 
  make sure that the charsets.jar file is installed in the lib 
  subdirectory of your J2SE installation directory. If you do not 
  have the charsets.jar file, install the international version 
  of J2SE.

* After you have started the installation process, as described in the 
  DATADIRECT CONNECT FOR JDBC INSTALLATION GUIDE, a progress bar is 
  displayed on the screen. If you choose to cancel the installation at 
  this stage, files that have already been copied to your machine will 
  not be removed. You must delete these files manually from the 
  installation directory.

* The DataDirect Connect for JDBC installer accepts multiple product 
  keys. For details, refer to the DATADIRECT CONNECT FOR JDBC 
  INSTALLATION GUIDE.

For UNIX Users
--------------
If you receive an error message when executing any DataDirect Connect 
for JDBC shell script (.sh files), including installer.sh, make sure 
that the file has EXECUTE permission. To do this, use the chmod 
command. For example, to grant EXECUTE permission to the installer.sh 
file, change to the directory containing installer.sh and enter:

chmod +x installer.sh


     Available DataDirect Connect for JDBC Drivers

See http://www.datadirect.com/products/jdbc/matrix/jdbcpublic.htm for 
a complete list of supported databases.

Drivers
-------
DB2 (db2.jar) 
Informix (informix.jar) 
MySQL (mysql.jar)
Oracle (oracle.jar) 
SQL Server (sqlserver.jar) 
Sybase (sybase.jar)


     Notes, Known Problems, and Restrictions

The following are notes, known problems, or restrictions with 
Release 4.2.0 of DataDirect Connect for JDBC.

Documentation Errata for the DB2 Driver
---------------------------------------
On page 99 of the DATADIRECT CONNECT FOR JDBC USER'S GUIDE, the 
description of the CatalogOptions property is incorrect. The 
description should be:

Retrieving remarks information is expensive. If your application does 
not need to return this information, the driver can improve 
performance. Default driver behavior is to include remarks in 
the result set of calls to the following DatabaseMetaData methods: 
getColumns(), getExportedKeys(), getFunctionColumns(), getFunctions(), 
getImportedKeys(), getIndexInfo(), getPrimaryKeys(), 
getProcedureColumns(), and getProcedures(). Returning remarks adds 
to the complexity of the SQL statement formulated by the various 
DatabaseMetaData methods and can negatively impact performance.

Bulk Load (Oracle)
------------------
For the best performance when using the bulk load protocol against 
Oracle, an application must specify "enableBulkLoad=true" and perform 
its batches of parameterized inserts within a manual transaction. 
Using the bulk load protocol can impact the behavior of the driver. 
The application should do nothing else within the transaction. 
If another operation is performed BEFORE the inserts, the driver is 
unable to use the bulk load protocol and will choose a different 
approach. If some other "execute" is performed AFTER the inserts, 
the driver throws the following exception:

   An execute operation is not allowed at this time, due to unfinished 
   bulk loads. Please perform a "commit" or "rollback".

Using Bulk Load on Microsoft SQL Server 2000 and Higher
-------------------------------------------------------
For optimal performance, minimal logging and table locking must be 
enabled. Refer to the following Web sites for more information 
about enabling minimal logging:

http://msdn.microsoft.com/en-us/library/ms190422.aspx
http://msdn.microsoft.com/en-us/library/ms190203.aspx

Table locking, a bulk load option, is enabled by default. Table locking 
prevents other transactions from accessing the table you are loading to 
during the bulk load. See the description of the connection property 
named BulkLoadOptions in the DATADIRECT CONNECT FOR JDBC USER'S GUIDE 
for information about enabling and disabling bulk load options.

Starting the Performance Tuning Wizard
---------------------------------------
When starting the Performance Tuning Wizard, security features set in 
your browser can prevent the Performance Wizard from launching. 
A security warning message is displayed. Often, the warning message 
provides instructions for unblocking the Performance Wizard for the 
current session. To allow the Performance Wizard to launch without 
encountering a security warning message, the security settings in your 
browser can be modified. Check with your system administrator before 
disabling any security features.

Distributed Transactions Using JTA
----------------------------------
If you are using JTA for distributed transactions, you may encounter 
problems when performing certain operations, as shown in the following 
examples:

SQL SERVER 7

1. Problem: SQL Server 7 does not allow resource sharing because it 
cannot release the connection to a transaction until it commits or 
rolls back.

  xaResource.start(xid1, TMNOFLAGS)
  ...
  xaResource.end(xid1, TMSUCCESS)
  xaResource.start(xid2, TMNOFLAGS) ---> fail
 
2. Problem:  Table2 insert rolls back. It should not roll back because 
it is outside of the transaction scope.

  xaResource.start(xid1, TMNOFLAGS)
  stmt.executeUpdate("insert into table1 values (1)");
  xaResource.end(xid1, TMSUCCESS)
 
  stmt.executeUpdate("insert into table2 values (2)");
 
  xaResource.prepare(xid1);
  xaResource.rollback(xid1);
 
SQL SERVER 7 and SQL SERVER 2000

1. Problem: Recover should not return xid1 because it is not yet 
prepared.

  xaResource.start(xid1, TMNOFLAGS)
  xaResource.recover(TMSTARTRSCAN) ---> returns xid1 transaction

This problem has been resolved in DTC patch QFE28, fix number 
winse#47009, "In-doubt transactions are not correct removed from the 
in-doubt transactions list".

This Microsoft issue is documented at 
http://support.microsoft.com/default.aspx?scid=kb;en-us;828748.

All Drivers
-----------
* The DataDirect Connect for JDBC drivers allow 
  PreparedStatement.setXXX methods and ResultSet.getXXX methods on 
  Blob/Clob data types, in addition to the functionality described 
  in the JDBC specification. The supported conversions typically are 
  the same as those for LONGVARBINARY/LONGVARCHAR, except where limited 
  by database support.

* Calling CallableStatement.registerOutputParameter(parameterIndex, 
  sqlType) with sqlType Types.NUMERIC or Types.DECIMAL sets the scale 
  of the output parameter to zero (0). According to the JDBC 
  specification, calling 
  CallableStatement.registerOutputParameter(parameterIndex, sqlType, 
  scale) is the recommended method for registering NUMERIC or 
  DECIMAL output parameters. 

* When attempting to create an updatable, scroll-sensitive result set 
  for a query that contains an expression as one of the columns, the 
  driver cannot satisfy the scroll-sensitive request. The driver 
  downgrades the type of the result returned to scroll-insensitive.

* The DataDirect Connect for JDBC drivers support retrieval of output 
  parameters from a stored procedure before all result sets and/or 
  update counts have been completely processed. When 
  CallableStatement.getXXX is called, result sets and update counts 
  that have not yet been processed by the application are discarded to 
  make the output parameter data available. Warnings are generated when 
  results are discarded.

* The preferred method for executing a stored procedure that generates 
  result sets and update counts is using CallableStatement.execute(). 
  If multiple results are generated using executeUpdate, the first 
  update count is returned. Any result sets prior to the first update 
  count are discarded. If multiple results are generated using 
  executeQuery, the first result set is returned. Any update counts 
  prior to the first result set are discarded. Warnings are generated 
  when result sets or update counts are discarded. 

* The ResultSet methods getTimestamp(), getDate(), and getTime() return 
  references to mutable objects. If the object reference returned from 
  any of these methods is modified, re-fetching the column using the 
  same method returns the modified value. The value is only modified in 
  memory; the database value is not modified.

DB2 (All Platforms)
-------------------
* The ResultSetMetaData.getObject method returns a Long object instead 
  of a BigDecimal object when called on BIGINT columns. In versions 
  previous to DataDirect Connect for JDBC 3.5, the DataDirect Connect 
  for JDBC DB2 driver returned a BigDecimal object.

* Scroll-sensitive result sets are not supported. Requests for 
  scroll-sensitive result sets are downgraded to scroll-insensitive 
  result sets when possible. When this happens, a warning is generated.

* The DB2 driver must be able to determine the data type of the column 
  or stored procedure argument to implicitly convert the parameter 
  value. Not all DB2 database versions support getting parameter 
  metadata for prepared statements. Implicit conversions are not 
  supported for database versions that do not provide parameter 
  metadata for prepared statements.

DB2 (Windows/UNIX/Linux)
------------------------
* Because of DRDA listener limitations, Clob data types are limited 
  to a maximum length of 32714 bytes except when connecting to 
  DB2 V8.1 and higher for Linux/UNIX/Windows. 

* Because of DRDA listener limitations, Blob data types are supported 
  only for DB2 V8.1 and higher for Linux/UNIX/Windows.

DB2 (iSeries)
-------------
Blob and Clob data types are supported only for DB2 V5R2 and higher.

Oracle
------
* When connecting to Oracle instances running in restricted mode 
  using a tnsnames.ora file, you must connect using a service name
  instead of a SID.

* If using Select failover and a result set contains LOBs, the driver 
  cannot recover work in progress for the last Select statement for 
  that result set. You must explicitly restart the Select statement if 
  a failover occurs. The driver will successfully recover work in 
  progress for any result sets that do not contain LOBs.

* If you install the Oracle driver and want to take advantage of JDBC 
  distributed transactions through JTA, you must install 
  Oracle8i R3 (8.1.7) or higher.

* Because JDBC does not support a cursor data type, the Oracle driver 
  returns REF CURSOR output parameters to the application as 
  result sets. For details about using REF CURSOR output parameters 
  with the driver, refer to the DATADIRECT CONNECT FOR JDBC USER'S 
  GUIDE.

* By default, values for TIMESTAMP WITH TIME ZONE columns cannot be 
  retrieved using the ResultSet.getTimestamp() method because the 
  time zone information is lost. The Oracle driver returns NULL when 
  the getTimestamp() method is called on a TIMESTAMP WITH TIME ZONE 
  column and generates an exception. For details about using the 
  TIMESTAMP WITH TIME ZONE data type with the driver, refer to the 
  DATADIRECT CONNECT FOR JDBC USER'S GUIDE. 

* The Oracle driver describes columns defined as FLOAT or FLOAT(n) as a 
  DOUBLE SQL type. Previous to DataDirect Connect for JDBC 3.5, the 
  driver described these columns as a FLOAT SQL type. Both the DOUBLE 
  type and the FLOAT type represent a double precision floating 
  point number. This change provides consistent functionality with the 
  DataDirect Connect for ODBC Oracle driver. The TYPE_NAME field that 
  describes the type name on the Oracle database server was changed 
  from number to float to better describe how the column was created.

SQL Server
----------
* Microsoft SQL Server 7 and SQL Server 2000 Only: Although the 
  SQL Server driver fully supports the auto-generated keys feature as 
  described in the Microsoft SQL Server chapter of the DATADIRECT 
  CONNECT FOR JDBC USER'S GUIDE, some third-party products provide an 
  implementation that, regardless of the column name specified, cause 
  the driver to return the value of the identity column for the 
  following methods:

  Connection.prepareStatement(String sql, int[] columnIndexes)
  Connection.prepareStatement(String sql, String[] columnNames) 

  Statement.execute(String sql, int[] columnIndexes)
  Statement.execute(String sql, String[] columnNames)

  Statement.executeUpdate(String sql, int[] columnIndexes)
  Statement.executeUpdate(String sql, String[] columnNames)

  To workaround this problem, set the WorkArounds connection property
  to 1. When Workarounds=1, calling any of the auto-generated keys 
  methods listed above returns the value of the identity column 
  regardless of the name or index of the column specified to the 
  method. If multiple names or indexes are specified, the driver throws 
  an exception indicating that multiple column names or indexes cannot 
  be specified if connected to Microsoft SQL Server 7 or 
  SQL Server 2000.

* In some cases, when using Kerberos authentication, Windows XP and 
  Windows Server 2003 clients appear to use NTLM instead of Kerberos to 
  authenticate the user with the domain controller. In these cases, 
  user credentials are not stored in the local ticket cache and cannot 
  be obtained by the SQL Server driver, causing the Windows 
  Authentication login to fail. This is caused by a known problem in 
  the Sun 1.4.x JVM. As a workaround, the "os.name" system property can 
  be set to "Windows 2000" when running on a Windows XP or 
  Windows Server 2003 machine. For example:

  -Dos.name="Windows 2000"

* To ensure correct handling of character parameters, install 
  Microsoft SQL Server 7 Service Pack 2 or higher.

* Because of the way CHAR, VARCHAR, and LONGVARCHAR data types are 
  handled internally by the driver, parameters of these data types 
  exceeding 4000 characters in length cannot be compared or sorted, 
  except when using the IS NULL or LIKE operators.


     Using the Online Documents

The DataDirect Connect for JDBC books are provided in PDF and HTML 
versions. The PDF versions are provided on 
the Progress DataDirect Web site:

http://www.datadirect.com/techres/jdbcproddoc/index.ssp

You can view the PDF versions using Adobe Reader. To download Adobe 
Reader from the Web, go to Adobe's Web site at http://www.adobe.com.

The HTML versions of the DATADIRECT CONNECT FOR JDBC USER'S GUIDE and 
the DATADIRECT CONNECT FOR JDBC REFERENCE are installed in the help 
subdirectory of your product installation directory.


     DataDirect Connect(R) for JDBC Files 

When you extract the contents of the installation Jar file to your 
installer directory, you will notice the following files that are 
required to install DataDirect Connect for JDBC: 

BuildAdapters.jar          File used to create resource adapters
ddjdbc42.jar               File used to install the drivers
DDProcInfo.bat             Batch file to start the 
                           Processor Information Utility
DDProcInfo.jar             Processor Information Utility
fixes.txt                  File describing fixes
installer.bat              Batch file to start the GUI installer
installer.sh               Shell script to start the GUI installer
installer.properties       Support file for the installer
Java Technology Restrictions notice.txt   
                           Copyright notice required by  
                           Oracle/Sun Microsystems, Inc
JDBCInstaller.jar          File containing the installer                                          
LicenseTool.jar            File required to extend an evaluation 
                           installation
mysqllicense.txt           License agreement for MySQL
notices.txt                Third-Party vendor license agreements
jdbcreadme.txt             This file 

When you install DataDirect Connect for JDBC, the installer copies all 
the following directories and files to the product installation 
directory (as determined by the user), represented by INSTALL_DIR.

To INSTALL_DIR/DB2/bind:
------------------------
iSeries/*.*               Files for explicitly creating DB2 packages 
                          on iSeries
LUW/*.*                   Files for explicitly creating DB2 packages
                          on Linux/UNIX/Windows
zOS/*.*                   Files for explicitly creating DB2 packages
                          on z/OS

To INSTALL_DIR/Examples:
------------------------

bulk/Load From File/bulkLoadFileDemo.java	
                          Java source example for bulk loading from a
                          CSV file
bulk/Load From File/load.txt
                          Sample data for the example
bulk/Streaming/bulkLoadStreamingDemo.java	
                          Java source example for bulk loading from a 
                          result set
bulk/Threaded Streaming/bulkLoadThreadedStreamingDemo.java	
                          Java source example for multi-threaded bulk 
                          loading from a result set
bulk/Threaded Streaming/README.txt
                          Instructions on how to use the 
                          thread.properties file
bulk/Threaded Streaming/thread.properties
                          Properties file for the example                         
connector/ConnectorSample.ear      
                          J2EE Application Enterprise Archive file 
                          containing the ConnectorSample application 
connector/connectorsample.htm      
                          "Using DataDirect Connect for JDBC Resource 
                          Adapters" document
connector/graphics/*.*    Images referenced by the "Using DataDirect 
                          Connect for JDBC Resource Adapters" document 
connector/src/ConnectorSample.jsp  
                          Source for the JavaServer Page used to access 
                          the ConnectorSample application
connector/src/connectorsample/ConnectorSample.java     
                          Java source file defining the remote 
                          interface for the ConnectorSample EJB
connector/src/connectorsample/ConnectorSampleBean.java  
                          Java source file defining the home interface 
                          for the ConnectorSample EJB
connector/src/connectorsample/ConnectorSampleHome.java  
                          Java source file containing the 
                          implementation for the ConnectorSample EJB
JNDI/JNDI_FILESYSTEM_Example.java  
                          Example Java(TM) source files
JNDI/JNDI_LDAP_Example.java        
                          Example Java source files


INSTALL_DIR/Help: 
----------------

Help.htm                  HTML help system entry file
/*.*                      Support folders for the HTML help system 


To INSTALL_DIR/lib:
-------------------
db2.jar                   DataDirect Connect for JDBC DB2 Driver 
                          and DataSource classes
informix.jar              DataDirect Connect for JDBC Informix 
                          Driver and DataSource classes
mysql.jar                 DataDirect Connect for JDBC MySQL
                          Driver and DataSource classes
oracle.jar                DataDirect Connect for JDBC Oracle 
                          Driver and DataSource classes
sqlserver.jar             DataDirect Connect for JDBC SQL Server 
                          Driver and DataSource classes
sybase.jar                DataDirect Connect for JDBC Sybase 
                          Driver and DataSource classes
db2packagemanager.jar     DataDirect DB2 Package Manager jar file 
DDJDBCAuthxx.dll          Windows DLL that provides support for 
                          NTLM authentication (32-bit), where xx is the 
                          Build number of the DLL
DDJDBC64Authxx.dll        Windows DLL that provides support for 
                          NTLM authentication (Itanium 64-bit), 
                          where xx is the Build number of the DLL
DDJDBCx64Authxx.dll       Windows DLL that provides support for 
                          NTLM authentication (AMD64 and 
                          Intel EM64T 64-bit), where xx is the 
                          Build number of the DLL
DB2PackageManager.bat     Batch file to start the DataDirect DB2 
                          Package Manager
DB2PackageManager.sh      Shell script to start the DataDirect DB2 
                          Package Manager
JDBCDriver.policy         Security policy file listing permissions that 
                          must be granted to the driver to use Kerberos 
                          authentication with a Security Manager
JDBCDriverLogin.conf      Configuration file that instructs the driver 
                          to use the Kerberos login module for 
                          authentication
krb5.conf                 Kerberos configuration file


To INSTALL_DIR/lib/JCA/META-INF:
-------------------------------
db2.xml                   DB2 resource adapter deployment descriptor
informix.xml              Informix resource adapter deployment 
                          descriptor
mysql.xml                 MySQL resource adapter deployment descriptor
oracle.xml                Oracle resource adapter deployment descriptor
sqlserver.xml             SQL Server resource adapter deployment 
                          descriptor
sybase.xml                Sybase resource adapter deployment descriptor
MANIFEST.MF               Manifest file

To INSTALL_DIR/pool manager:
----------------------------
pool.jar                  All DataDirect Connection Pool Manager 
                          classes

To INSTALL_DIR/SQLServer JTA/32-bit:
------------------------------------
instjdbc.sql              File for installing JTA stored procedures
sqljdbc.dll               File for use with JTA stored procedures 
                          (32-bit version)

To INSTALL_DIR/SQLServer JTA/64-bit:
------------------------------------
instjdbc.sql              File for installing JTA stored procedures
sqljdbc.dll               File for use with JTA stored procedures 
                          (Itanium 64-bit version)

To INSTALL_DIR/SQLServer JTA/x64-bit:
------------------------------------
instjdbc.sql              File for installing JTA stored procedures
sqljdbc.dll               File for use with JTA stored Procedures 
                          (AMD64 and Intel EM64T 64-bit version)

To INSTALL_DIR/sun/lib:
-----------------------
jndi.jar                  Redistributable Sun Microsystems components 
                          for JNDI 1.2
fs/*.*                    Redistributable Sun Microsystems components 
                          for the File System JNDI Provider
ldap/*.*                  Redistributable Sun Microsystems components 
                          for the LDAP JNDI Provider

To INSTALL_DIR/testforjdbc:
---------------------------
Config.txt                Configuration file for DataDirect Test 
testforjdbc.bat           Batch file to start DataDirect Test
testforjdbc.sh            Shell script to start DataDirect Test
lib/testforjdbc.jar       DataDirect Test classes

To INSTALL_DIR/wizards:
-----------------------
index.html                HTML file to launch the Performance Tuning 
                          Wizard applet
JDBCPerf.jar              Jar file containing the classes for the 
                          Performance Tuning Wizard applet
images/*.*                Graphic files used by the Performance Tuning 
                          Wizard applet


In addition, installation creates the following files in 
INSTALL_DIR/lib if you choose to install the resource adapters:

db2.rar                   DB2 resource archive file
informix.rar              Informix resource archive file
mysql.rar                 MySQL resource archive file
oracle.rar                Oracle resource archive file
sqlserver.rar             SQL Server resource archive file
sybase.rar                Sybase resource archive file


---------------------
End of JDBCREADME.TXT

ontaining the classes for the 
                          Performance Tuning Wizard applet
images/*.*                Graphic files used by the Performance Tuning 
                          Wizard applet


In addition, installation creates the following files in 
INSTALL_DIR/lib if you choose to install the resource adapters:

db2.rar                   DB2 resource archive file
informix.rar              Informix resource archive file
mysql.rar                 MySQL resource archive file
oracle.rar                Oracle resource archive file
sqlserver.rar             SQL Server resource archive file
sybase.rar                Sybase resource archive file


---------------------
End of JDBCREADME.TXT

