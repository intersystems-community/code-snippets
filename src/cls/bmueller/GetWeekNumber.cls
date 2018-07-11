Class bmueller.GetWeekNumber Extends %RegisteredObject
{
	/// comments for calculating weeknumber ala DIN 1355 / ISO 8601 :
	/// - Monday is first day of week
	/// - a week belongs to a year in that 3 or more days of the week resides.
	/// - 4th of January is always in the first weeknumber of the year.
	/// - 28th of December is always in last weeknumber of the year.
	/// 
	ClassMethod GetWNStart(Year As %String) As %Date
	{
	 s d4j = $zdh("04/01/"_Year) // 4. January
	 s wt = ..WeekDay(d4j)
	 s offset = 4 - wt // Offset from day 1 of first week to 01.01. 
	 s result = $zdh("01/01/"_Year) + offset
	 q result
	}
	 
	ClassMethod WeekNumber(Date As %Date) As %Integer [ SqlProc ]
	{
	  s $ztrap="WeekNumberErr"
	  q ..GetWeekNumber(Date)
WeekNumberErr
	  q ""
	}
	 
	ClassMethod GetWeekNumber(Date As %Date, Year As %String = {$e($zd(Date,8),1,4)}) As %Integer
	{
	 s firstWNDay = ..GetWNStart(Year) //first day of first weeknumber
	 s lastWNDay = ..GetWNStart(Year+1)-1 // last day of last weeknumber
	 i firstWNDay > Date { 
	   q ..GetWeekNumber(Date,Year-1)
	 }
	 i lastWNDay < Date { 
	 q ..GetWeekNumber(Date,Year+1)
	 }
	 q ((Date-firstWNDay)\7)+1
	}
	 
	/// weekday as Integer
	/// 1 - Monday
	/// 2 - Thuesday
	/// ...
	/// 7 - Sunday
	ClassMethod WeekDay(Date As %Date) As %Integer
	{
	 s wt = $zd(Date,10) // weekday from d4j
	 if wt=0 { // correct start of week to Monday (european)
	   s wt = 7
	 }
	 q wt
	}
}