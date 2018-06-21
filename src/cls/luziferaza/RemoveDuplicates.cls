Class luziferaza.RemoveDuplicates as %RegisteredObject {
ClassMethod test() As %String
{
 s str="Hello,, world!",str2=""
 s symb=","
  
 f i=1:1:$l(str,symb)
 {
  s p=$p(str,symb,i)
  i ($tr(p," ")'="") &; i'=1     {s str2=str2_symb_p}
  elseif ($tr(p," ")'="") &; i=1 {s str2=str2_p}
 }
  
w str2
}
}