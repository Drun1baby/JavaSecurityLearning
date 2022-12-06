
This autodeploy directory provides a quick way to deploy applications
to a development server. When the WebLogic Server instance is running
in development mode, applications and modules in this directory are 
automatically deployed.

You can place J2EE applications such as the following in this directory:

* EAR files
* WAR, EJB JAR, or RAR archive files
* Exploded archive directories for applications or modules

The autodeploy directory is automatically created when you install
the WebLogic Server sample domains or when you use the Configuration
Wizard to create domains. 

To automatically deploy an application:

1. Start the WebLogic Server domain in development mode.
2. Place the application's exploded directory structure
or archive file in this autodeploy directory. 

STARTING WEBLOGIC SERVER IN DEVELOPMENT MODE

WebLogic Server domains start up in development mode by 
default. To change startup mode for a domain, follow 
the below instructions.

The startup mode applies to all WebLogic Server instances in a domain.
You can set the domain startup mode in any of the following ways:

*  With the startWebLogic start scripts in the bin directory. 
   startWebLogic.cmd (for Windows) and startWebLogic.sh (for Unix) 
   can be modified with any text editor.

   By default, the start scripts start WebLogic Server in development 
   mode so you do not need to modify the default scripts in order to 
   auto-deploy applications. If you want to start WebLogic Server in 
   production mode, use the 'production' argument with the start command 
   or modify the startup scripts.

*  Start the server in development mode from the command line with the
   -Dweblogic.ProductionModeEnabled=false setting. If you want to 
   start the server in production mode from the command line, use
   the -Dweblogic.ProductionModeEnabled=true setting.

       
*  Set the domain startup mode in the Administration Console by 
   selecting or deselecting the Production Mode box in the domain's
   Configuration->General page. See the Administration
   Console online help for more information about setting this
   attribute.


