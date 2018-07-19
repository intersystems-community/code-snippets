include Ensemble
Class DAiMor.fetchMessageHeaderData extends %RegisteredObject
{
 
Query Fetch(Namespace As %String) As %Query(ROWSPEC = "Namespace:%String,ID:%Integer,Type:Ens.DataType.MessageType,Priority:Ens.DataType.MessagePriority,Invocation:Ens.DataType.MessageInvocation,TimeCreated:Ens.DataType.UTC,TimeProcessed:Ens.DataType.UTC,Status:Ens.DataType.MessageStatus,IsError:%Boolean,ErrorStatus:%Status,CorrespondingMessageId:%Integer,SessionId:%Integer,SourceConfigName:%String,TargetConfigName:%String,SourceBusinessType:Ens.DataType.MessageBusinessType,TargetBusinessType:Ens.DataType.MessageBusinessType,BusinessProcessId:%Integer,TargetQueueName:%String,ReturnQueueName:%String,MessageBodyClassName:%String,MessageBodyId:%String,Description:%String,SuperSession:%String,Resent:%String") [ SqlProc ]
{
}
 
ClassMethod FetchExecute(ByRef qHandle As %Binary, Namespace As %String = "") As %Status
{
  set namespaces=""
  if Namespace'="" {
    set list=$lfs(Namespace,",")
    for i=1:1:$ll(list) {
      set ns=$zcvt($lg(list,i),"U")
      continue:'$d(^%SYS("Ensemble","InstalledNamespace",ns))
      set qHandle("list",ns)=""
    }
  }
  set queryDef=##class(%Dictionary.QueryDefinition).%OpenId(..%ClassName(1)_"||Fetch")
  set rowspec=$lfs(queryDef.Parameters.GetAt("ROWSPEC"))
  set qHandle("rowspec")=rowspec
  Quit $$$OK
}
 
ClassMethod FetchClose(ByRef qHandle As %Binary) As %Status [ PlaceAfter = FetchExecute ]
{
  Quit $$$OK
}
 
ClassMethod FetchFetch(ByRef qHandle As %Binary, ByRef Row As %List, ByRef AtEnd As %Integer = 0) As %Status [ PlaceAfter = FetchExecute ]
{
  set ns=$get(qHandle("current"))
  if ns="" do nextNamespace
  set rowspec=qHandle("rowspec")
   
  do queryRow
   
  set qHandle("current")=ns
  Quit $$$OK
queryRow
  quit:ns=""
  new $namespace
  set $namespace=ns
  if '$d(qHandle("query"),query) {
    set st=##class(%SQL.Statement).%New()
    do st.%Prepare("SELECT '"_ns_"' Namespace, * FROM Ens.MessageHeader")
    set query=st.%Execute()
    set qHandle("query")=query
  }
   
  if query.%Next() {
    set Row=$lb()
    for i=1:1:$ll(rowspec) {
      set prop=$p($lg(rowspec,i),":")
      set $li(Row,i)=query.%Get(prop)
    }
  } else {
    do nextNamespace
    do queryRow
  }
   
  quit 
nextNamespace
  kill qHandle("query")
  if $d(qHandle("list")) {
    set ns=$order(qHandle("list",ns))
  } else {
    set ns=$order(^%SYS("Ensemble","InstalledNamespace",ns))
  }
  if ns="" {
    set AtEnd=1
  }
  Quit
}
 
}
