$PBExportHeader$n_cst_lncoopsrv_calendar.sru
$PBExportComments$lcsrv ส่วนบริการใบคำขอต่างๆ
forward
global type n_cst_lncoopsrv_calendar from nonvisualobject
end type
end forward

global type n_cst_lncoopsrv_calendar from nonvisualobject
end type
global n_cst_lncoopsrv_calendar n_cst_lncoopsrv_calendar

type variables
n_ds				ids_calendarinfo

transaction		itr_sqlca
Exception		ithw_exception

string		is_coopcontrol, is_coopid
end variables

forward prototypes
public function integer of_getdaysinyear (integer ai_year) throws Exception
public function integer of_getdayattrib (datetime adtm_date, ref character ac_dayattrib) throws Exception
public function datetime of_getfirstdayofmonth (datetime adtm_date) throws Exception
public function datetime of_getlastdayofmonth (datetime adtm_date) throws Exception
public function datetime of_getlastdayofyear (datetime adtm_date) throws Exception
public function boolean of_isworkingdate (datetime adtm_checkdate) throws Exception
public function datetime of_relativeworkdate (datetime adtm_currentdate, integer ai_increase) throws Exception
public function datetime of_relativeworkdate (datetime adtm_currentdate, integer ai_increase, boolean ab_chkcurrentholiday) throws Exception
public function integer of_getaccountdate (integer ai_year, ref datetime adtm_start, ref datetime adtm_end) throws Exception
public function integer of_getaccountyear (datetime adtm_chkdate) throws Exception
public function integer of_initservice (n_cst_dbconnectservice atr_dbtrans)
public function datetime of_getfirstdayofyear (datetime adtm_chkdate) throws Exception
public function datetime of_getfirstdayofyear (integer ai_accyear) throws Exception
public function datetime of_getlastdayofyear (integer ai_year) throws Exception
private function integer of_getcalendarinfo (integer ai_year, integer ai_month, ref string as_daysetting) throws Exception
public function datetime of_getfirstdayofmonth (integer ai_year, integer ai_month) throws Exception
public function datetime of_getlastdayofmonth (integer ai_year, integer ai_month) throws Exception
private function datetime of_getfirstdayofmonth (integer ai_year, integer ai_month, string as_daysetting) throws Exception
private function datetime of_getlastdayofmonth (integer ai_year, integer ai_month, string as_daysetting) throws Exception
public function datetime of_getnextworkdate (datetime adtm_fromdate) throws Exception
public function datetime of_getprevworkdate (datetime adtm_fromdate) throws Exception
end prototypes

public function integer of_getdaysinyear (integer ai_year) throws Exception;datetime	ldtm_start, ldtm_end
integer	li_dayinyear

of_getaccountdate( ai_year, ldtm_start, ldtm_end )

li_dayinyear = daysafter( date( ldtm_end ), date( ldtm_start ) ) + 1

return li_dayinyear
end function

public function integer of_getdayattrib (datetime adtm_date, ref character ac_dayattrib) throws Exception;// สำหรับดูว่าวันที่ส่งเข้ามาเป็นวันอะไร ทำงาน/วันหยุด
integer	li_year, li_month, li_day
string		ls_daysetting

// Check Parameter
if date(adtm_date) = date('1900-01-01') or isnull(adtm_date) then
	ithw_exception.text	= "วันที่ที่จะตรวจสอบสถานะวัน (of_getdayattrib) มีค่าเป็น Null"
	throw ithw_exception
end if

li_year 	= year( date( adtm_date ) ) + 543
li_month	= month( date( adtm_date ) ) 
li_day		= day( date( adtm_date ) ) 

this.of_getcalendarinfo( li_year, li_month, ls_daysetting )

ac_dayattrib		= mid( ls_daysetting, li_day, 1 )

if ac_dayattrib <> "W" and ac_dayattrib <> "H" then
	ithw_exception.text	= "สถานะของวันที่ "+string( adtm_date, "dd/mm/" ) + string( year( date( adtm_date ) )+543 )+" ไม่อยู่ในรูปแบบที่นำมาใช้งานได้ กรุณาตรวจสอบ"
	throw ithw_exception
end if

return 1
end function

public function datetime of_getfirstdayofmonth (datetime adtm_date) throws Exception;string		ls_daysetting
integer	li_year, li_month

li_year		= year( date( adtm_date ) ) + 543
li_month		= month( date( adtm_date ) )

this.of_getcalendarinfo( li_year, li_month, ls_daysetting )

return this.of_getfirstdayofmonth( li_year, li_month )
end function

public function datetime of_getlastdayofmonth (datetime adtm_date) throws Exception;string		ls_daysetting
integer	li_year, li_month

li_year		= year( date( adtm_date ) ) + 543
li_month		= month( date( adtm_date ) )

this.of_getcalendarinfo( li_year, li_month, ls_daysetting )

return this.of_getlastdayofmonth( li_year, li_month )
end function

public function datetime of_getlastdayofyear (datetime adtm_date) throws Exception;integer	li_year

li_year		= this.of_getaccountyear( adtm_date )

return this.of_getlastdayofyear( li_year )
end function

public function boolean of_isworkingdate (datetime adtm_checkdate) throws Exception;char	lch_daytype

this.of_getdayattrib( adtm_checkdate, lch_daytype )

if lch_daytype = "W" then
	return true
end if

return false
end function

public function datetime of_relativeworkdate (datetime adtm_currentdate, integer ai_increase) throws Exception;return this.of_relativeworkdate( adtm_currentdate, ai_increase, false )
end function

public function datetime of_relativeworkdate (datetime adtm_currentdate, integer ai_increase, boolean ab_chkcurrentholiday) throws Exception;string		ls_workingdays
char 		lch_dayattrib, larrc_workingdays[]
integer	li_firstworkday, li_lastworkday, li_daysofmonth
integer	li_year, li_month, li_day, li_incnum, li_step
datetime	ldtm_fromdate, ldtm_return

setnull( ldtm_return )

// validate
if string( adtm_currentdate, "yyyymmdd" ) = "19000101" or isnull( adtm_currentdate ) then 
	return ldtm_return
end if

li_year 		= year( date( adtm_currentdate ) ) + 543
li_month		= month( date( adtm_currentdate ) ) 
li_day			= day( date( adtm_currentdate ) ) 

if this.of_getdayattrib( adtm_currentdate, lch_dayattrib ) <> 1 then
	return ldtm_return
end if

// ตรวจว่ามีการขยับวันเนื่องจากวันหยุดหรือเปล่า
if ab_chkcurrentholiday and lch_dayattrib <> "W" and ai_increase <> 0 then
	if ai_increase < 0 then
		ldtm_fromdate		= this.of_getprevworkdate( adtm_currentdate )
	elseif ai_increase > 0 then
		ldtm_fromdate		= this.of_getnextworkdate( adtm_currentdate )
	end if
else
	ldtm_fromdate	= adtm_currentdate
end if

li_incnum	= 0
li_step		= ( ai_increase / abs( ai_increase ) )

do while li_incnum <> ai_increase
	// ตรวจไล่ไปทีละวันของปฏิทิน
	ldtm_fromdate		= datetime( relativedate( date( ldtm_fromdate ), li_step ) )
	
	if this.of_getdayattrib( ldtm_fromdate, lch_dayattrib ) <> 1 then
		return ldtm_return
	end if
	
	if lch_dayattrib = "W" then
		li_incnum	= li_incnum + li_step
	end if
loop

ldtm_return		= ldtm_fromdate

return ldtm_return
end function

public function integer of_getaccountdate (integer ai_year, ref datetime adtm_start, ref datetime adtm_end) throws Exception;select 	accstart_date, accend_date
into		:adtm_start, :adtm_end
from 		cmaccountyear
where	( coop_id			= :is_coopcontrol )
and		( account_year = :ai_year )
using		itr_sqlca;

if ( itr_sqlca.sqlcode <> 0 ) then
	ithw_exception.text	= "ไม่พบข้อมูลปีบัญชีที่ระบุมา ("+string( ai_year )+")"
	throw ithw_exception
end if

return 1
end function

public function integer of_getaccountyear (datetime adtm_chkdate) throws Exception;integer	li_year

select		account_year
into		:li_year
from		cmaccountyear
where	( coop_id		= :is_coopcontrol )
and		( accstart_date <= :adtm_chkdate )
and		( accend_date >= :adtm_chkdate )
using	itr_sqlca ;
		
if sqlca.sqlcode = 0 then
	ithw_exception.text	= "วันที่ที่ระบุมา ("+string( adtm_chkdate, "dd/mm/" )+string( year( date( adtm_chkdate ) )+543 )+") ไม่พบข้อมูลปีบัญชี"
	throw ithw_exception
end if

return li_year
end function

public function integer of_initservice (n_cst_dbconnectservice atr_dbtrans);itr_sqlca			= atr_dbtrans.itr_dbconnection
is_coopcontrol	= atr_dbtrans.is_coopcontrol
is_coopid			= atr_dbtrans.is_coopid

ids_calendarinfo = create n_ds
ids_calendarinfo.dataobject = "d_lcsrv_info_calendar"
ids_calendarinfo.settransobject( itr_sqlca )
ids_calendarinfo.retrieve( is_coopcontrol )

return 1
end function

public function datetime of_getfirstdayofyear (datetime adtm_chkdate) throws Exception;integer	li_year

li_year		= this.of_getaccountyear( adtm_chkdate )

return this.of_getfirstdayofyear( li_year )
end function

public function datetime of_getfirstdayofyear (integer ai_accyear) throws Exception;datetime	ldtm_startacc, ldtm_endacc

this.of_getaccountdate( ai_accyear, ldtm_startacc, ldtm_endacc )

return this.of_getfirstdayofmonth( ldtm_startacc )
end function

public function datetime of_getlastdayofyear (integer ai_year) throws Exception;integer	li_row, li_year, li_month, li_day
date		ld_date
datetime	ldtm_lastdate, ldtm_startacc, ldtm_endacc

this.of_getaccountdate( ai_year, ldtm_startacc, ldtm_endacc )

ld_date		= date( ldtm_endacc )
li_year		= year( ld_date )
li_month		= month( ld_date )

li_row		= ids_calendarinfo.find( "year = " + string( li_year + 543) + " and  month = " + string( li_month ), 1, ids_calendarinfo.rowcount( ) )

if li_row <= 0 then
	ithw_exception.text	= "ไม่พบข้อมูลปฏิทินประจำปี ("+string( li_year )+") เดือน ("+string( li_month )+") กรุณาติดต่อผู้ดูแลระบบ"
	throw ithw_exception
end if

li_day		= ids_calendarinfo.getitemnumber(li_row, "lastworkdate")

ldtm_lastdate	= datetime(date(li_year, li_month, li_day))

return ldtm_lastdate
end function

private function integer of_getcalendarinfo (integer ai_year, integer ai_month, ref string as_daysetting) throws Exception;integer		li_row

li_row = ids_calendarinfo.find( "year = " + string( ai_year ) + " and  month = " + string( ai_month ), 1, ids_calendarinfo.rowcount() )

if li_row = 0 then
	ithw_exception.text	= "ไม่พบข้อมูลปฏิทินประจำปี ("+string( ai_year )+") เดือน ("+string( ai_month )+") กรุณาติดต่อผู้ดูแลระบบ"
	throw ithw_exception
end if

as_daysetting		= trim( ids_calendarinfo.getitemstring( li_row, "workdays" ) )

return 1
end function

public function datetime of_getfirstdayofmonth (integer ai_year, integer ai_month) throws Exception;string		ls_daysetting

this.of_getcalendarinfo( ai_year, ai_month, ls_daysetting )

return of_getfirstdayofmonth( ai_year, ai_month, ls_daysetting )
end function

public function datetime of_getlastdayofmonth (integer ai_year, integer ai_month) throws Exception;string		ls_daysetting

this.of_getcalendarinfo( ai_year, ai_month, ls_daysetting )

return of_getlastdayofmonth( ai_year, ai_month, ls_daysetting )
end function

private function datetime of_getfirstdayofmonth (integer ai_year, integer ai_month, string as_daysetting) throws Exception;integer	li_day
datetime	ldtm_firstdate

li_day		= pos( as_daysetting, "W" )

if li_day > 0 then
	ldtm_firstdate	= datetime(date( ai_year - 543, ai_month, li_day ) )
else
	setnull( ldtm_firstdate	 )
end if

return ldtm_firstdate
end function

private function datetime of_getlastdayofmonth (integer ai_year, integer ai_month, string as_daysetting) throws Exception;integer	li_day
datetime	ldtm_lastdate

li_day		= lastpos( as_daysetting, "W" )

if li_day > 0 then
	ldtm_lastdate	= datetime(date( ai_year - 543, ai_month, li_day ) )
else
	setnull( ldtm_lastdate	 )
end if

return ldtm_lastdate
end function

public function datetime of_getnextworkdate (datetime adtm_fromdate) throws Exception;string		ls_daysetting
integer	li_year, li_month, li_day, li_next
datetime	ldtm_nextdate

// validate
if isnull( adtm_fromdate ) or string( adtm_fromdate, "yyyymmdd" ) = "19000101" then
	return adtm_fromdate
end if

li_year 		= year( date( adtm_fromdate ) ) + 543
li_month		= month( date( adtm_fromdate ) ) 
li_day			= day( date( adtm_fromdate ) ) 

this.of_getcalendarinfo( li_year, li_month, ls_daysetting )

li_next		= pos( ls_daysetting, "W", li_day + 1 )

// ถ้าไม่มีวันทำการถัดไปของเดือนนั้น ขยับเดือน
if li_next = 0 then 
	li_month ++
	if li_month = 13 then
		li_year ++
		li_month = 1
	end if
	
	ldtm_nextdate = this.of_getfirstdayofmonth( li_year, li_month )
	
else
	ldtm_nextdate = datetime( date( li_year - 543, li_month, li_next ) )
end if

return ldtm_nextdate
end function

public function datetime of_getprevworkdate (datetime adtm_fromdate) throws Exception;string		ls_daysetting
integer	li_year, li_month, li_day, li_previous
datetime	ldtm_prevdate

// validate
if isnull( adtm_fromdate ) or string( adtm_fromdate, "yyyymmdd" ) = "19000101" then
	return adtm_fromdate
end if

li_year 		= year( date( adtm_fromdate ) ) + 543
li_month		= month( date( adtm_fromdate ) ) 
li_day			= day( date( adtm_fromdate ) ) 

this.of_getcalendarinfo( li_year, li_month, ls_daysetting )

li_previous	= lastpos( ls_daysetting, "W", li_day - 1 )

// ถ้าน้อยกว่าวันทำการของเดือนนั้น ขยับเดือน
if li_previous = 0 then 
	li_month --
	if li_month = 0 then
		li_year --
		li_month = 12
	end if
	
	ldtm_prevdate		= this.of_getlastdayofmonth( li_year, li_month )
else
	ldtm_prevdate		= datetime( date( li_year - 543, li_month, li_previous ) )
end if
	
return ldtm_prevdate
end function

event constructor;ithw_exception		= create Exception
end event

on n_cst_lncoopsrv_calendar.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_lncoopsrv_calendar.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;if isvalid( ithw_exception ) then destroy ithw_exception
if isvalid( ids_calendarinfo ) then destroy ids_calendarinfo

end event

