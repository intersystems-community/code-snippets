Class eduardlebedyuk.changePasswords Extends %RegisteredObject
{
	ClassMethod test()
	{
	    zn "%SYS"
	    set NewPass = "NewPassString"
	    set rs=##Class(%ResultSet).%New("Security.Users:List")
	    set st = rs.Execute()
	    while rs.Next() { set st=$SYSTEM.Security.ChangePassword(rs.Get("Name"),NewPass)}
	}
}