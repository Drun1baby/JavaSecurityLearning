This service_migration directory is used to store pre/post migration scripts
to be executed during service_migration.  Once WebLogic Server has detected
a service needs to be migrated, it will first use Node Manager to execute the
specified post script on the machine where the server and service were located.
Then it will notify the Node Manager located on the new machine hosting the new
server to execute the specified pre script.  The post script should clean up
any external resources utilized by the migrating service enabling those
resources to be utilized on another machine, or again at a later date.  The
pre script should prepare any resources necessary for the service to migrate and
activate.

In some cases, scripts may need to dismount the disk from the previous server
and mount it on the backup server. These scripts are configured on the
Node Manager, using the PreScript() and PostScript() methods in the
MigratableTargetMBean, or using the Administration Console. In other cases, a
script may be needed to move (not copy) a custom file store directory to the 
backup server. The old configured file store directory should not be left for 
the next time the migratable target is hosted by the old server; therefore, the 
WebLogic administrator should delete or move the files to another directory.

Optionally, you may also want to use pre/post-migration scripts to perform any 
unmounting and mounting of shared storage, as needed. 
