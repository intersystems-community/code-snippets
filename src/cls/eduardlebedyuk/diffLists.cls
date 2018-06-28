Class eduardlebedyuk.diffLists Extends %RegisteredObject
{
	/// Finds diff between two lists.<br>
	/// <b>old</b> - original list.<br>
	/// <b>new</b> - modified list.<br>
	/// <b>.added</b> - list with all added elements (present in new list, absent in old list.<br>
	/// <b>.deleted</b> - list with all deleted elements (present in old list, absent in new list.<br>
	classmethod test(old as %List, new as %List, output added as %List, output deleted as %List) as %Status [ Internal ]
	{
		set st=$$$OK
	    if ($LISTVALID(old)=0) quit $$$ERROR($$$AttributeValueMustBeList,"old")
	    if ($LISTVALID(new)=0) quit $$$ERROR($$$AttributeValueMustBeList,"new")
	    try {
	        for i=1:1:$LISTLENGTH(old)
	        {
	            set match=$LISTFIND(new,$LIST(old,i))
	            if match'=0
	            {
	                set $LIST(old,i)=""
	                set $LIST(new,match)=""
	            }
	        }
	        set added=new
	        set deleted=old
	    } catch ex {
	        set st=ex.AsStatus()
	    }
	    quit st
	}
}