Class eduardlebedyuk.dynamicOrProxy
{
	classmethod test() {
		#if $$$comClassDefined("%Library.Array")
		    #define NewDynObj ##class(%Object).%New()
		    #define NewDynDTList ##class(%Array).%New()
		    #define NewDynObjList $$$NewDynDTList
		    #define Insert(%obj,%element) do %obj.$push(%element)
		    #define DynObjToJSON(%obj) w %obj.$toJSON()
		    #define ListToJSON(%obj) $$$DynObjToJSON(%obj)
		    #define ListSize(%obj) %obj.$size()
		    #define ListGet(%obj,%i) %obj.$get(%i-1)
		#else
		    #define NewDynObj ##class(%ZEN.proxyObject).%New()
		    #define NewDynDTList ##class(%ListOfDataTypes).%New()
		    #define NewDynObjList ##class(%ListOfObjects).%New()
		    #define Insert(%obj,%element) do %obj.Insert(%element)
		    #define DynObjToJSON(%obj) do %obj.%ToJSON()
		    #define ListToJSON(%obj) do ##class(%ZEN.Auxiliary.jsonProvider).%ObjectToJSON(%obj)
		    #define ListSize(%obj) %obj.Count()
		    #define ListGet(%obj,%i) %obj.Get(%i)
		#endif
		 
		set obj = $$$NewDynObj
		set obj.prop = "val"
		$$$DynObjToJSON(obj)
		 
		set dtList = $$$NewDynDTList
		s a=1
		$$$Insert(dtList,a)
		$$$ListToJSON(dtList)
	}
}