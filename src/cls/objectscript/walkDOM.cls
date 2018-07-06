Class objectscript.walkDOM Extends %Persistent
{
	ClassMethod dfs(node As %XML.Node)
	{
	    s entrynode=node.NodeId
	    do {
	    //element nodes with one whitespacetyped child are the ones we want to change
	    if (node.NodeType=$$$xmlELEMENTNODE){
	        s snode=node.NodeId     
	        if (node.MoveToFirstChild())            
	            {
	                i ('node.MoveToNextSibling()){
	                    i (node.NodeType=$$$xmlWHITESPACENODE){
	                        s node.NodeType=$$$xmlTEXTNODE
	                        s node.NodeId=snode
	                    }
	                }
	        }
	        s node.NodeId=snode     
	    }   
	    if (node.HasChildNodes()){
	        d node.MoveToFirstChild()
	        d ..dfs(node)
	    }
	    } while (node.NodeType'="" && node.MoveToNextSibling())
	    s node.NodeId=entrynode
	     
	}
	 
	ClassMethod test()
	{
	  set xml = "<root><value1>abcdefg</value1><value2><![CDATA[   ]]></value2></root>"
	 
	  s reader=##class(%XML.Reader).%New()
	  do reader.OpenString(xml)  
	  set writer = ##class(%XML.Writer).%New()
	  //do some magic
	  d ..dfs(reader.Document)
	   
	  w !,"with indent=1:",!
	  set writer.Indent = 1
	  do writer.OutputToString()
	  do writer.Document(reader.Document)
	  w writer.GetXMLString()
	  set writer.Indent = 0
	  w !,"with indent=0:",!
	  do writer.OutputToString()
	  do writer.Document(reader.Document)
	  w writer.GetXMLString()
	}
Storage Default
{
<Data name="walkDOMDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
</Data>
<DataLocation>^objectscript.walkDOMD</DataLocation>
<DefaultData>walkDOMDefaultData</DefaultData>
<IdLocation>^objectscript.walkDOMD</IdLocation>
<IndexLocation>^objectscript.walkDOMI</IndexLocation>
<StreamLocation>^objectscript.walkDOMS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}