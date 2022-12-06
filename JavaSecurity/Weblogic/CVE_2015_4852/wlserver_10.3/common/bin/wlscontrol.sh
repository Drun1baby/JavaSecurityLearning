#!/bin/sh
#
# Node manager shell script version.
#

#set -vx
#
# Reads a line from the specified file and returns it in REPLY.
# Error message supressed if file not found.
#
read_file()
{
  if [ -f "$1" ]; then
    read REPLY 2>$NullDevice <"$1"
  else
    return 1
  fi
}

#
# Writes a line to the specified file. The line will first be written
# to a temporary file which is then used to atomically overwrite the
# destination file. This prevents a simultaneous read from getting
# partial data.
#
write_file()
{
    file="$1"; shift
    echo $* >>$file.tmp
    mv -f "$file.tmp" "$file"
}

#
# Updates the state file with new server state information.
#
write_state()
{
    write_file "$StateFile" "$1"
}

#
# Prints informational message to server output log.
#
print_info()
{
    echo "<`date`)> <Info> <NodeManager> <"$@">"
}

#
# Prints error message to server output log.
#
print_err()
{
    echo "<`date`> <Error> <NodeManager> <"$@">"
}

#
# Returns true if the process with the specified pid is still alive.
#
is_alive()
{
    if [ -d /proc ]; then
        [ -r /proc/$1 ]
    else
        ps -p $1 2>$NullDevice | grep -q $1
    fi
}

#
# Returns true if the server state file indicates that the server has started.
#
server_is_started()
{
    if read_file "$StateFile"; then
        case $REPLY in
        *:Y:*) return 0 ;;
        esac
    fi
    return 1
}

#
# Returns true if the server state file indicates that the server has not yet started.
#
server_not_yet_started()
{
    if server_is_started; then
      return 1;
    else
      return 0;
    fi
}

#
# Returns true if the monitor is running otherwise false. Also will remove
# the monitor lock file if it is no longer valid.
#
monitor_is_running()
{
    if read_file "$LockFile" && is_alive $REPLY; then
	return 0
    fi
    rm -f "$LockFile"
    return 1
}
#
# Get the current time as an equivalent time_t.  Note that this may not be
# always right, but should be good enough for our purposes of monitoring
# intervals.

time_as_timet() {

    if [ x$BaseYear = x0 ]; then
        BaseYear=1970
    fi
    cur_timet=`date -u +"%Y %j %H %M %S" | awk '{
        base_year = 1970
        year=$1; day=$2; hour=$3; min=$4; sec=$5;
        yearsecs=int((year  - base_year)* 365.25 ) * 86400
        daysecs=day * 86400
        hrsecs=hour*3600
        minsecs=min*60
        total=yearsecs + daysecs + hrsecs + minsecs + sec
        printf "%08d", total
        }'`
}

#
# Update the base start time if it is 0.  Every time a server stops,
# if the time since last base time is > restart interval, it is reset
# to 0.  Next restart of the server will set the last base start time
# to the new time
#
update_base_time() {
    time_as_timet
    if [ $LastBaseStartTime -eq 0 ]; then
        LastBaseStartTime=$cur_timet
    fi
}

#
# Computes the seconds elapsed between last start time and current time
#
compute_diff_time() {
    #get current time as time_t
    time_as_timet
    diff_time=`expr $cur_timet - $LastBaseStartTime`
}

#
# Loads server startup properties into current environment.
#
load_properties()
{
    # We have to do some complicated stuff to make this come into our env.
    tmpfile="${PropsFile}.nmtmp"
    rm -f "$tmpfile"
    while read REPLY; do
	case $REPLY in
	*=*)
          name=`echo $REPLY | cut -f1 -d'='`
          value=`echo $REPLY | cut -f2- -d'='`
          echo ${name}=\'${value}\' >> $tmpfile
          ;;
	esac
    done <$PropsFile
    . "$tmpfile"
    rm -f "$tmpfile"
}

#
# Loads server startup properties from standard input into current
# environment and also saves them to the startup properties file.
# The Username and Password properties will be saved to the boot
# identity file instead.
#
save_properties()
{
    print_info "Saving startup properties to '$PropsFile'"
    rm -f "$PropsFile.tmp"
    while read REPLY; do
        case $REPLY in
        *=*)
             name=`echo $REPLY | cut -f1 -d'='`
             value=`echo $REPLY | cut -f2- -d'='`
             eval $name=\"$value\"
             case $name in
               Username) ;;
               Password) ;;
               TrustKeyStore) ;;
               CustomTrustKeyStoreFileName) ;;
               CustomTrustKeyStoreType) ;;
               CustomTrustKeyStorePassPhrase) ;;
               JavaStandardTrustKeyStorePassPhrase) ;;
               *)
                 echo "$name=$value" >>$PropsFile.tmp;;
              esac
        esac
    done
    mv -f "$PropsFile.tmp" "$PropsFile"
    if [ -n "$username" -a -n "$password" ]; then
       print_info "Creating boot identity file '$NMBootFile'"
       print_info "Investigating username: '$username' and password: '$password'"
       echo "username=$username" >"$NMBootFile.tmp"
       echo "password=$password" >>"$NMBootFile.tmp"
       unset username password
    elif [ -n "$Username" -a -n "$Password" ]; then
       print_info "Investigating Username: '$Username' and Password: '$Password'"
       echo "username=$Username" >"$NMBootFile.tmp"
       echo "password=$Password" >>"$NMBootFile.tmp"
       unset Username Password
    fi
    if [ -n "$NMBootFile.tmp" ]; then
        if [ -n "$TrustKeyStore" ]; then
           echo "TrustKeyStore=$TrustKeyStore" >>"$NMBootFile.tmp"
        fi
        if [ -n "$CustomTrustKeyStoreFileName" ]; then
           echo "CustomTrustKeyStoreFileName=$CustomTrustKeyStoreFileName" >>"$NMBootFile.tmp"
        fi
        if [ -n "$CustomTrustKeyStoreType" ]; then
           echo "CustomTrustKeyStoreType=$CustomTrustKeyStoreType" >>"$NMBootFile.tmp"
        fi
        if [ -n "$CustomTrustKeyStorePassPhrase" ]; then
           echo "CustomTrustKeyStorePassPhrase=$CustomTrustKeyStorePassPhrase" >>"$NMBootFile.tmp"
        fi
        if [ -n "$JavaStandardTrustKeyStorePassPhrase" ]; then
           echo "JavaStandardTrustKeyStorePassPhrase=$JavaStandardTrustKeyStorePassPhrase" >>"$NMBootFile.tmp"
        fi
        mv -f "$NMBootFile.tmp" "$NMBootFile"
        unset TrustKeyStore CustomTrustKeyStoreFileName
        unset CustomTrustKeyStoreType CustomTrustKeyStorePassPhrase
        unset JavaStandardTrustKeyStorePassPhrase
    fi
}

#
# Rotate the specified log file. Rotated log files are named
# <server-name>.outXXXXX where XXXXX is the current log count and the
# highest is the most recent. The log count starts at 00001 then cycles
# again if it reaches 99999.
#
save_log()
{
    # Make sure we aren't redirecting stdout/stderr to file before we rotate
    exec >>$NullDevice 2>&1
    fileLen=`echo ${OutFile} | wc -c`
    fileLen=`expr ${fileLen} + 1`
    lastLog=`ls -r1 "$OutFile"* | head -1`
    logCount=`ls -r1 "$OutFile"* | head -1 | cut -c $fileLen-`
    if [ -z "$logCount" ]; then
      logCount=0
    fi
    if [ "$logCount" -eq "99999" ]; then
      logCount=0
    fi
    logCount=`expr ${logCount} + 1`
    zeroPads=""
    case $logCount in
    [0-9]) zeroPads="0000" ;;
    [0-9][0-9]) zeroPads="000" ;;
    [0-9][0-9][0-9]) zeroPads="00" ;;
    [0-9][0-9][0-9][0-9]) zeroPads="0" ;;
    esac
    rotatedLog="$OutFile"$zeroPads$logCount
    mv -f "$OutFile" "$rotatedLog"
    print_info "Rotated server output log to '$rotatedLog'"
}


#
# Returns the command line and environment that is used when starting a
# server through the server start script.
#
get_script_environment()
{
    get_java_options
    # Enviroment variable settings for server start script. In this case,
    # there is no way to override BEA_HOME, JAVA_HOME, or the Java policy
    # file, and the remote start class path will get appended to the default
    # class path.
    SERVER_NAME=$ServerName
    [ -n "$ClassPath" ] && EXT_POST_CLASSPATH=$ClassPath
    SERVER_IP=$ServerIP
    [ -n "$AdminURL" ] && ADMIN_URL=$AdminURL
    # Script command name and args
    if [ -n "$CustomStartScriptName" ] ; then
       CommandName=$CustomStartScriptName
    else
        # Always use StartWebLogicScript as we pass all the necessary
        # information in the environment.  StartManagedWebLogic.sh overwrites
        # JAVA_OPTIONS, ADMIN_URL which will cause failures
        CommandName=$StartWebLogicScript
    fi
    CommandArgs=
}

#
# Returns the command line and environment that is used when starting a
# server by invoking java directly.
#
get_java_environment()
{
    get_java_options
    if [ -x "$SetDomainEnvScript" ]; then
        # setDomainEnv.sh script exists, so call it to set up the default
        # environment. In this case, the remote start class path will be
        # appended to the default class path.
        print_info "Run $SetDomainEnvScript to set up the default environment"
        [ -n "$JavaVendor" ] && JAVA_VENDOR=$JavaVendor
        [ -n "$ClassPath" ] && EXT_POST_CLASSPATH=$ClassPath
        . "$SetDomainEnvScript"
        # If we have security policy already set, use it
        if echo $JAVA_OPTIONS | grep Djava.security.policy= > $NullDevice 2>&1
            then
            :
        else
            if [ "x$SecurityPolicyFile" != x ] ; then
                JAVA_OPTIONS="$JAVA_OPTIONS -Djava.security.policy=$SecurityPolicyFile"
            elif [ -f $WL_HOME/server/lib/weblogic.policy ]; then
                JAVA_OPTIONS="$JAVA_OPTIONS \
	-Djava.security.policy=$WL_HOME/server/lib/weblogic.policy"
            fi
        fi
    else
        # No setDomainEnv.sh script available, so set up default environment
        # ourselves strictly based on remote start properties
        print_info "No $SetDomainEnvScript script available, set up default environment based on remote start properties"
        [ -n "$ClassPath" ] && CLASSPATH=$ClassPath
        
        #Modified for SHLIB in hpux
        if [ `uname -s` = "HP-UX" ]; then
	   [ -n "$JavaLibraryPath" ] && SHLIB_PATH=$JavaLibraryPath
	#Modified for LIBPATH in AIX
	elif [ `uname -s` = "AIX" ]; then
           [ -n "$JavaLibraryPath" ] && LIBPATH=$JavaLibraryPath
        else
           [ -n "$JavaLibraryPath" ] && LD_LIBRARY_PATH=$JavaLibraryPath
	fi

        [ -n "$BeaHome" ] && BEA_HOME=$BeaHome
        JAVA_OPTIONS="$JAVA_OPTIONS \
	${SecurityPolicyFile+-Djava.security.policy=$SecurityPolicyFile}"
    fi

    [ -n "$JavaHome" ] && JAVA_HOME=$JavaHome
    
    # Set command name and arguments
    CommandName=$JAVA_HOME/bin/java
    CommandArgs="$JAVA_OPTIONS -Dweblogic.Name=$ServerName \
	${BEA_HOME+-Dbea.home=$BEA_HOME} \
	${AdminURL+-Dweblogic.management.server=$AdminURL} \
	weblogic.Server"
}

get_java_options()
{
    JAVA_OPTIONS="$Arguments $SSLArguments \
	-Dweblogic.nodemanager.ServiceEnabled=true"
    echo $JAVA_OPTIONS | grep weblogic.system.BootIdentityFile > $NullDevice 2>&1
    if [ $? != 0 ] ; then
       if [ -r "$NMBootFile" ]; then
         JAVA_OPTIONS="$JAVA_OPTIONS \
           -Dweblogic.system.BootIdentityFile=$RelNMBootFile"
       elif [ -r "$BootFile" ]; then
         JAVA_OPTIONS="$JAVA_OPTIONS \
           -Dweblogic.system.BootIdentityFile=$RelBootFile"
       fi
    fi
}

#
# Checks to make sure the specified domain directory is valid. Also
# creates necessary server directories for starting WLS.
#
check_dirs()
{
    # Make sure domain directory exists and is valid
    if [ ! -d "$DomainDir" ]; then
        echo "Domain directory '$DomainDir' not found.  Make sure domain directory exists and is accessible" >&2
        return 1
    fi
    if [ ! -f "$SaltFile" -a ! -f "$OldSaltFile" ]; then
        echo "Domain salt file '$SaltFile' not found.  See WLST help('nmEnroll') on how to populate the domain directory with nodemanager information" >&2
        return 1
    fi
    # Make sure necessary directories also exist
    mkdir -p "$ServerDir/logs"
    mkdir -p "$ServerDir/security"
    mkdir -p "$ServerDir/data/nodemanager"
}

#
# Starts the WebLogic server by calling the server start script.
#
start_server_script()
{
    # Get script command line and environment
    get_script_environment

    if [ ! -x "$CommandName" ]; then
        print_err "Script not found: $CommandName"
        print_info "Will attempt to start the server using Java command line"
        start_server
        return $?
    fi

    # If migratable then add server ip
    if [ -n "$ServerIP" ]; then
        print_info "Adding IP $ServerIP for migratable server"
        if [ -z "$Interface" ]; then
            print_err "Interface not specified. Please set "\
                "Interface=<your network interface> in wlscontrol.sh."
        fi
        wlsifconfig.sh -addif $Interface $ServerIP $NetMask
    fi

    print_info "Starting WLS with command line: $CommandName $CommandArgs"
    write_state STARTING:N:N
    if $CommandName $CommandArgs; then
        print_info "Server start script exited"
    else
        print_info "Server start exited with non-zero status ($?)"
    fi
    # If migratable then remove server ip
    if [ -n "$ServerIP" ]; then
        print_info "Removing ip $ServerIP for migratable server"
        if [ -z "$Interface" ]; then
            print_err "Interface not specified. Please set "\
                "Interface=<your network interface> in wlscontrol.sh."
        fi
        wlsifconfig.sh -removeif $Interface $ServerIP
    fi

    if [ -n "$CustomStopScriptName" ]; then
        if [ -x "$CustomStopScriptName" ] ; then
            print_info "Launching post stop script $CustomStopScriptName"
            $CustomStopScriptName
            print_info "Completed $CustomStopScriptName with status ($?)"
            
        else
            print_err "Stop Script not found: $CustomStopScriptName"
        fi
    fi
    return 0
}

#
# Starts WebLogic server by calling java directly.
#
start_server()
{
    # Get java command line and environment
    get_java_environment
    if [ ! -x "$CommandName" ]; then
        print_err "Java executable not found: $CommandName"
        write_state FAILED_NOT_RESTARTABLE:N:Y
        return 1
    fi
    # If migratable then add server ip
    if [ -n "$ServerIP" ]; then
        print_info "Adding IP $ServerIP for migratable server"
        if [ -z "$Interface" ]; then
            print_err "Interface not specified. Please set "\
                "Interface=<your network interface> in wlscontrol.sh."
        fi
        wlsifconfig.sh -addif $Interface $ServerIP $NetMask
    fi
    # Print server start command
    print_info "Starting WLS with command line: $CommandName $CommandArgs"
    print_info "CLASSPATH = ${CLASSPATH-?}"
    #modified for HPUX & AIX
    
     if [ `uname -s` = "HP-UX" ]; then
    
        print_info "SHLIB_PATH =${SHLIB_PATH-?}"
 	elif [ `uname -s` = "AIX" ]; then
     
        print_info "LIBPATH =${LIBPATH-?}"
    
     else
        print_info "LD_LIBRARY_PATH = ${LD_LIBRARY_PATH-?}"
    
     fi

    
    print_info "JAVA_HOME = ${JAVA_HOME-?}"
    print_info "JAVA_VENDOR = ${JAVA_VENDOR-?}"
    # Set initial server state
    write_state STARTING:N:N
    # Start the server process
    if $CommandName $CommandArgs; then
        print_info "Server process exited"
    else
        ServerExitStatus=$?
        print_info "Server process exited with non-zero status ($ServerExitStatus)"
    fi
    # If migratable then remove server ip
    if [ -n "$ServerIP" ]; then
        print_info "Removing ip $ServerIP for migratable server"
        if [ -z "$Interface" ]; then
            print_err "Interface not specified. Please set "\
                "Interface=<your network interface> in wlscontrol.sh."
        fi
        wlsifconfig.sh -removeif $Interface $ServerIP
    fi
    if [ -n "$CustomStopScriptName" ]; then
        if [ -x "$CustomStopScriptName" ] ; then
            print_info "Launching post stop script $CustomStopScriptName"
            $CustomStopScriptName
            print_info "Completed $CustomStopScriptName with status ($?)"
        else
            print_err "Stop Script not found: $CustomStopScriptName"
        fi
    fi
    return 0
}

start_and_monitor_server()
{
    trap "rm -f $LockFile" 0
    # Start server and monitor loop
    count=0
    while true; do
        # Save previous server output log
        [ -f "$OutFile" ] && save_log
        # Disconnect input and redirect stdout/stderr to server output log
        exec 0<$NullDevice
        [ -z "$Debug" ] && exec >>$OutFile 2>&1
        count=`expr ${count} + 1`
        update_base_time
        if [ "x$StartScriptEnabled" = xtrue ]; then
            start_server_script
        else
            start_server
        fi
        read_file "$StateFile"
    	case $REPLY in
            *:N:*)  print_err "Server startup failed (will not be restarted)"
		            write_state FAILED_NOT_RESTARTABLE:N:Y
		            return 1
		            ;;
            SHUTTING_DOWN:*:N |\
            FORCE_SHUTTING_DOWN:*:N)
		            print_info "Server was shut down normally"
		            write_state SHUTDOWN:Y:N
		            return 0
		            ;;
	    esac
        compute_diff_time
        if [ $diff_time -gt $RestartInterval ]
        then
            #Reset count
            #bug9732615 - need to set to 1 so that we don't restart an extra
            #time.
            count=1
            LastBaseStartTime=0
        fi
        if [ $AutoRestart != true ]; then
            print_err "Server failed but is not restartable because auto "\
                      "restart is disabled."
            write_state FAILED_NOT_RESTARTABLE:Y:N
	        return 1
        elif [ $count -gt $RestartMax ]; then
            print_err "Server failed but is not restartable because the "\
                      "maximum number of restart attempts has been exceeded"
            write_state FAILED_NOT_RESTARTABLE:Y:N
	        return 1
        fi
        print_info "Server failed so attempting to restart"
	    # Optionally sleep for RestartDelaySeconds seconds before restarting
	    if [ $RestartDelaySeconds -gt 0 ]; then
	        write_state FAILED:Y:Y
	        sleep $RestartDelaySeconds
	    fi
    done
}

#
# Process node manager START command. Starts server with current startup
# properties and enters the monitor loop which will automatically restart
# the server when it fails.
#
do_start()
{
    # Make sure server is not already started
    if monitor_is_running; then
	echo "Server '$ServerName' has already been started" >&2
	return 1
    fi
    # If monitor is not running, but if we can determine that the WLS
    # process is running, then say that server is already running.
    if read_file "$PidFile" && is_alive $REPLY; then
	echo "Server '$ServerName' has already been started" >&2
	return 1
    fi
    # Remove previous state file
    rm -f "$StateFile"
    # Change to server root directory
    cd "$DomainDir"
    # Now start the server and monitor loop
    start_and_monitor_server &
    # Create server lock file
    write_file "$LockFile" $!
    # Wait for server to start up
    while  is_alive $! && server_not_yet_started; do
	sleep 1
    done
    if  server_not_yet_started; then
	echo "Server failed to start (see server output log for details)" >&2
	return 1
    fi
    return 0
}

#
# Process node manager KILL command to kill the currently running server.
# Returns true if successful otherwise returns false if the server process
# was not running or could not be killed.
#
do_kill()
{
    # Check for pid file
    read_file "$PidFile"

    if [ "$?" = "0" ]; then
      srvr_pid=$REPLY
    fi

    # Make sure server is started
    monitor_is_running

    if [ "$?" != "0" -a x$srvr_pid = x ]; then
        echo "Server '$ServerName' is not currently running" >&2
        return 1
    fi

    # Check for pid file
    if [ x$srvr_pid = x ]; then
      echo "Could not kill server process (pid file not found).  Make sure that the nodemanager native library is supported on the platform and can be loaded using the library path specified for the server" >&2
      return 1
    fi
    # Kill the server process
    kill $srvr_pid
    # Now wait for up to 10 seconds for monitor to die
    count=0
    while [ $count -lt 10 ] && monitor_is_running; do
      sleep 1
      count=`expr ${count} + 1`
    done
    if monitor_is_running; then
      echo "Server process did not terminate in 10 seconds after being signaled to terminate" 2>&1
      return 1
    fi
}

do_command()
{
    case $NMCMD in
    START)  check_dirs
            [ -r "$PropsFile" ] && load_properties
            do_start
            ;;
    STARTP) check_dirs
            save_properties
            do_start
            ;;
    STAT)   do_stat
            ;;
    EXECSCRIPT) do_execute_script ;;

#    Handled differently
#    GETSTATES)   do_getstates
#            ;;
#    VERS*)  echo "$FullVersion" ;;
#
    KILL)   do_kill ;;
    GETLOG) cat "$OutFile" 2>$NullDevice ;;
    GETNMLOG) echo "GETNMLOG not applicable for script based nodemanager" >&2 ;;
    *)      echo "Unrecognized command: $1" >&2 ;;
    esac
}

do_execute_script()
{
if [ -z "$ExecuteScriptPath" ]; then
   print_err "Script path not provided" 2>&1
   exit -100
fi

StartDir=$CWD
cd $MigrationScriptDir
if [ ! -f $ExecuteScriptPath ]; then
    print_err "Unable to find file $ExecuteScriptPath in the correct service migration script directory $MigrationScriptDir." 2>&1
    exit 1
fi

$ExecuteScriptPath
ExitCode=$?

if [ $ExitCode != 0 ]; then
 print_err "The script '$ExecuteScriptPath' failed with exit code '$ExitCode'"
 exit $ExitCode
fi
cd $StartDir

}


do_stat()
{
    valid_state=0

    if read_file "$StateFile"; then
      statestr=$REPLY
      state=`echo $REPLY| sed 's/_ON_ABORTED_STARTUP//g'`
      state=`echo $state | sed 's/:.//g'`
    else
      statestr=UNKNOWN:N:N
      state=UNKNOWN
    fi

    if monitor_is_running; then
      valid_state=1
    elif read_file "$PidFile" && is_alive $REPLY; then
      valid_state=1
    fi

    cleanup=N

    if [ $valid_state = 0 ]; then
       case $statestr in
         SHUTTING_DOWN:*:N |\
         FORCE_SHUTTING_DOWN:*:N)
           state=SHUTDOWN
           write_state $state:Y:N
           ;;
         *UNKNOWN*)
           ;;
         *SHUT*)
           ;;
         *FAIL*)
           ;;
         *:Y:*)
           state=FAILED_NOT_RESTARTABLE
           cleanup=Y
           ;;
         *:N:*)
           state=FAILED_NOT_RESTARTABLE
           cleanup=Y
           ;;
       esac

       if [ $cleanup = Y ]; then
          [ -r "$PropsFile" ] && load_properties
	  # cleanup should not be done in a get state function, because it is
	  # repeatedly called, and can be done over and over if state files
	  # are left around after migration.  Cleanup should be a separate call.

          # NOTE
	  # keeping the logic with the written state - maybe cleanup should
	  # be renamed
          if server_is_started; then
            write_state $state:Y:N
          else
            write_state $state:N:N
          fi
       fi
    fi

    if  [ x$InternalStatCall = xY ];
    then
       ServerState=$state
    else
       echo $state
    fi
}

do_getstates()
{

    InternalStatCall=Y
    result=""
    if [ -d  $DomainDir/servers ]; then
      for i in `ls $DomainDir/servers`
      do
  
        ServerName=`expr //$i : '.*/\(.*\)'`
        if [ -d $DomainDir/servers/$ServerName/data/nodemanager ]; then
          ServerDir=$DomainDir/servers/$ServerName
          StateFile=$ServerDir/data/nodemanager/$ServerName.state
          PidFile=$ServerDir/data/nodemanager/$ServerName.pid
          LockFile=$ServerDir/data/nodemanager/$ServerName.lck
          PropsFile=$ServerDir/data/nodemanager/startup.properties
          do_stat
          srvr_state=$ServerState
          result="${result}${ServerName}=${state} "
        fi
     done
   fi
    InternalStatCall=N
    echo $result
}

build_wlscontrol()
{
    if [ ! -z "$Debug" ]; then
      WLSControl="$WLSControl -v"
    fi
    if [ -n "$StartScriptEnabled" ]; then
      WLSControl="$WLSControl -c"
    fi
    if [ -n "$CustomStartScriptName" ]; then
      WLSControl="$WLSControl -f $CustomStartScriptName"
    fi
    if [ -n "$CustomStopScriptName" ]; then
      WLSControl="$WLSControl -p $CustomStopScriptName"
    fi
}


do_crashrecovery_alldomains()
{
    Domains=`cut -f1 -s -d'=' $NodeManagerHome/nodemanager.domains`
    for domain in $Domains; do
      DomainName=$domain
      WLSControl="wlscontrol.sh -n $NodeManagerHome -d $DomainName"
      build_wlscontrol
      $WLSControl CRASHRECOVERY &
    done
}

do_crashrecovery()
{

    WLSControl="wlscontrol.sh -n $NodeManagerHome -r $DomainDir -d $DomainName"
    build_wlscontrol
    if [ -d $DomainDir/servers ]; then
      for i in `ls $DomainDir/servers`
      do 
        ServerName=`expr //$i : '.*/\(.*\)'`
        ServerDir=$DomainDir/servers/$ServerName
        if [ -d $ServerDir/data/nodemanager ]; then
          LockFile=$ServerDir/data/nodemanager/$ServerName.lck
          if read_file "$LockFile" && ! is_alive $REPLY; then
            PidFile=$ServerDir/data/nodemanager/$ServerName.pid
            if read_file "$PidFile" && ! is_alive $REPLY; then     
               $WLSControl -s $ServerName START &
            fi
          fi
        fi
      done
    fi
}

#
# Prints command usage message.
#
print_usage()
{
    cat <<EOF
Usage: wlscontrol [OPTIONS] CMD
Where options include:
  -n nmdir   Sets the node manager directory (default $PWD)
  -s server  Sets the server name (default myserver)
  -d domain  Sets the domain name (default mydomain)
  -r rootdir Sets the server root directory
  -c         Use start scripts to start servers
  -f script  Full path to script to use for -c option (default startWebLogic.sh)
  -p script  Post stop script to run if any after a server stops
  -v         Enable verbose output
  -h         Prints this help message
EOF
}


# Default settings
# Default NM Home
WL_HOME="E:\Coding\JavaSec\wlserver_10.3"
NodeManagerHome="${WL_HOME}/common/nodemanager"
if [ ! -d $NodeManagerHome ] ; then
   NodeManagerHome=$PWD
fi
if [ -d ${WL_HOME}/common/bin ] ; then
   PATH=$PATH:${WL_HOME}/common/bin
fi

FullVersion="NodeManager version 10.3"
DomainDir=
DomainName=
ServerName=
AutoRestart=true
RestartMax=2
RestartDelaySeconds=0
StartScriptEnabled=
CustomStartScriptName=
CustomStopScriptName=
ExecuteScriptPath=
LastBaseStartTime=0
NullDevice=/dev/null

# The name of the interface that you are using for the addresses must
# be configured here.
# 
# Optionally the NetMask can be specified, except on Windows platforms where it
# is required for netsh and on Linux platforms where its absence can crash
# the machine
Interface=${WLS_Interface:-""}
NetMask=${WLS_NetMask:-""}
# Set the UseMACBroadcast attribute to "true" in order to have arping use
# MAC level broadcasting.  arping is called after binding IP addresses
# on Linux systems.
UseMACBroadcast=${WLS_UseMACBroadcast:-"false"}

# Exit on any errors
##set -e is commented out because it is too strict with bourne shell
##set -e

#
# Do the eval dance to get the arguments parsed right.  This gets the args
# that are quoted  but are separate arguments to exec to be reassembled as
# a single argument.
#
eval "set -- $@"


# Parse command line options
while getopts cd:f:hn:p:r:s:e:v flag "$@"; do
  case $flag in
  n) NodeManagerHome=$OPTARG ;;
  s) ServerName=$OPTARG ;;
  d) DomainName=$OPTARG ;;
  r) DomainDir=$OPTARG ;;
  x) Debug=1 ;;
  c) StartScriptEnabled=true ;;
  f) CustomStartScriptName=$OPTARG ;;
  p) CustomStopScriptName=$OPTARG ;;
  e) ExecuteScriptPath=$OPTARG ;;
  h) print_usage
     exit 0 ;;
  *) echo "Unrecognized option: $OPTARG" >&2
     exit 1 ;;
  esac
done

cygwin=no
uname=`uname -s`
case $uname in
   CYGWIN*) NullDevice=nul
            cygwin=yes;;
   *) ;;
esac

if [ ${OPTIND} -gt 1 ]; then
  shift `expr ${OPTIND} - 1`
fi

if [ $# -lt 1 ]; then
  print_usage
  exit 1
fi

#Handle version requests

NMCMD=`echo $1 | tr '[a-z]' '[A-Z]'`

case $NMCMD in
    VERS*)  echo "$FullVersion"
            exit 0;;
esac


if [ $NMCMD = "CRASHRECOVERY" -a -z "$DomainName" ]; then
  do_crashrecovery_alldomains
  exit 0
fi


if [ -z "$DomainName" ]; then
  print_err "Domain Name not provided" 2>&1
  print_usage
  exit 1
fi


# If no domain directory specified, then look up domain name in domains
# file. Otherwise, default to the current directory.
if [ -z "$DomainDir" -o "x-" = "x$DomainDir" ]; then
    DomainsFile=$NodeManagerHome/nodemanager.domains
    if [ -f $DomainsFile ]; then
	# we must look for "$DomainName=" 
	# usually after a new line, does not contain other characters around it
	# so we avoid mistaking mydom for dom (grep will happily grab mydom if 
	# it sees it first...)  -w will fail to find mydom=relativePath because
	# it sees "relativePath" as a word around mydom= on Linux.
	DomainDir=`grep -s "^$DomainName=" "$DomainsFile" | cut -f2 -d'=' 2>$NullDevice`
      if [ $? != 0 -o -z "$DomainDir" ]; then
        DomainDir=$PWD
      fi
    else
      DomainDir=$PWD
    fi
fi


# Absolutize directory path
DomainDir=`cd "$DomainDir"; pwd`


if [ x$cygwin = xyes ]; then
  # Figure out what the cygdrive is actually named
  CYGDRIVE=`mount -ps | tail -1 | awk '{print $1}' | sed -e 's%/$%%'`
  # Convert /cygdrive/c to c:
  DomainDir=`echo $DomainDir | sed "s;$CYGDRIVE/\(.\)/;\1:/;"`
fi

case $NMCMD in
    GETSTATES)  
            do_getstates
            exit 0;;
    CRASHRECOVERY)
            do_crashrecovery
            exit 0;;
esac

if [ -z "$ServerName" ]; then
   print_err "Server Name not provided" 2>&1
   print_usage
   exit 1
fi

#
#If custom stop script is specified and is not absolute, make sure that
#it is relative to the rootdir/bin directory.
#

if [ -n "$CustomStopScriptName" ]; then
  echo x$CustomStopScriptName  | grep '^x/' > $NullDevice 2>&1
  if [ $? != 0 ]; then
    CustomStopScriptName=$DomainDir/bin/$CustomStopScriptName
  fi
fi

if [ -n "$CustomStartScriptName" ]; then
  echo x$CustomStartScriptName  | grep '^x/' > $NullDevice 2>&1
  if [ $? != 0 ]; then
    CustomStartScriptName=$DomainDir/bin/$CustomStartScriptName
  fi
fi


# Directory and file names
ServerDir=$DomainDir/servers/$ServerName
SaltFile=$DomainDir/security/SerializedSystemIni.dat
OldSaltFile=$DomainDir/SerializedSystemIni.dat
StateFile=$ServerDir/data/nodemanager/$ServerName.state
PropsFile=$ServerDir/data/nodemanager/startup.properties
PidFile=$ServerDir/data/nodemanager/$ServerName.pid
LockFile=$ServerDir/data/nodemanager/$ServerName.lck
BootFile=$ServerDir/security/boot.properties
RelBootFile=servers/$ServerName/security/boot.properties
NMBootFile=$ServerDir/data/nodemanager/boot.properties
RelNMBootFile=servers/$ServerName/data/nodemanager/boot.properties
OutFile=$ServerDir/logs/$ServerName.out
SetDomainEnvScript=$DomainDir/bin/setDomainEnv.sh
StartWebLogicScript=$DomainDir/bin/startWebLogic.sh
MigrationScriptDir=$DomainDir/bin/service_migration

# export needed variables in one place

export CLASSPATH EXT_POST_CLASSPATH JAVA_OPTIONS LD_LIBRARY_PATH

#modified for hpux and AIX

if [ `uname -s` = "HP-UX" ]; then
  export SHLIB_PATH
elif [ `uname -s` = "AIX" ]; then
  export LIBPATH
fi
 
 
export SERVER_NAME SERVER_IP ADMIN_URL
export BEA_HOME WL_HOME JAVA_HOME JAVA_VENDOR

export Interface NetMask DomainName ServerDir ServerName UseMACBroadcast
export CustomStopScriptName DomainDir ServerDir NodeManagerHome
export MigrationScriptDir ExecuteScriptPath

# Process command
do_command
