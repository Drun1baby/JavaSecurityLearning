
/*
**	INSTJDBC.SQL
**	Installs XA stored procedures used by the JDBC driver 
*/


go
use master
go
dump tran master with no_log
go


/*
** drop procedures if they're already in the database
*/

sp_dropextendedproc 'xp_jdbc_open' 
go
sp_dropextendedproc 'xp_jdbc_open2' 
go
sp_dropextendedproc 'xp_jdbc_close'
go
sp_dropextendedproc 'xp_jdbc_close2'
go
sp_dropextendedproc 'xp_jdbc_start'
go
sp_dropextendedproc 'xp_jdbc_start2'
go
sp_dropextendedproc 'xp_jdbc_end'
go
sp_dropextendedproc 'xp_jdbc_end2'
go
sp_dropextendedproc 'xp_jdbc_prepare'
go
sp_dropextendedproc 'xp_jdbc_prepare2'
go
sp_dropextendedproc 'xp_jdbc_commit'
go
sp_dropextendedproc 'xp_jdbc_commit2'
go
sp_dropextendedproc 'xp_jdbc_rollback'
go
sp_dropextendedproc 'xp_jdbc_rollback2'
go
sp_dropextendedproc 'xp_jdbc_forget'
go
sp_dropextendedproc 'xp_jdbc_forget2'
go
sp_dropextendedproc 'xp_jdbc_recover'
go
sp_dropextendedproc 'xp_jdbc_recover2'
go
dump tran master with no_log
go



/*
**  add references for the stored procedures
*/

print 'creating JDBC XA procedures'
go

sp_addextendedproc 'xp_jdbc_open', 'sqljdbc.dll'
go
sp_addextendedproc 'xp_jdbc_open2', 'sqljdbc.dll'
go
sp_addextendedproc 'xp_jdbc_close', 'sqljdbc.dll'
go
sp_addextendedproc 'xp_jdbc_close2', 'sqljdbc.dll'
go
sp_addextendedproc 'xp_jdbc_start', 'sqljdbc.dll'
go
sp_addextendedproc 'xp_jdbc_start2', 'sqljdbc.dll'
go
sp_addextendedproc 'xp_jdbc_end', 'sqljdbc.dll'
go
sp_addextendedproc 'xp_jdbc_end2', 'sqljdbc.dll'
go
sp_addextendedproc 'xp_jdbc_prepare', 'sqljdbc.dll'
go
sp_addextendedproc 'xp_jdbc_prepare2', 'sqljdbc.dll'
go
sp_addextendedproc 'xp_jdbc_commit', 'sqljdbc.dll'
go
sp_addextendedproc 'xp_jdbc_commit2', 'sqljdbc.dll'
go
sp_addextendedproc 'xp_jdbc_rollback', 'sqljdbc.dll'
go
sp_addextendedproc 'xp_jdbc_rollback2', 'sqljdbc.dll'
go
sp_addextendedproc 'xp_jdbc_forget', 'sqljdbc.dll'
go
sp_addextendedproc 'xp_jdbc_forget2', 'sqljdbc.dll'
go
sp_addextendedproc 'xp_jdbc_recover', 'sqljdbc.dll'
go
sp_addextendedproc 'xp_jdbc_recover2', 'sqljdbc.dll'
go


/*
**  grant privileges so that all users can enlist in XA transactions
*/
grant execute on xp_jdbc_open to public
go
grant execute on xp_jdbc_open2 to public
go
grant execute on xp_jdbc_close to public
go
grant execute on xp_jdbc_close2 to public
go
grant execute on xp_jdbc_start to public
go
grant execute on xp_jdbc_start2 to public
go
grant execute on xp_jdbc_end to public
go
grant execute on xp_jdbc_end2 to public
go
grant execute on xp_jdbc_prepare to public
go
grant execute on xp_jdbc_prepare2 to public
go
grant execute on xp_jdbc_commit to public
go
grant execute on xp_jdbc_commit2 to public
go
grant execute on xp_jdbc_rollback to public
go
grant execute on xp_jdbc_rollback2 to public
go
grant execute on xp_jdbc_forget to public
go
grant execute on xp_jdbc_forget2 to public
go
grant execute on xp_jdbc_recover to public
go
grant execute on xp_jdbc_recover2 to public
go

print ''
print 'instxa.sql completed successfully.'
go

dump tran master with no_log
go
checkpoint
go
/**/
