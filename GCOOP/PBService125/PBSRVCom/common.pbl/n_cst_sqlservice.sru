$PBExportHeader$n_cst_sqlservice.sru
$PBExportComments$ดึงตาราง sql
forward
global type n_cst_sqlservice from nonvisualobject
end type
end forward

global type n_cst_sqlservice from nonvisualobject
end type
global n_cst_sqlservice n_cst_sqlservice

type variables
Public:

transaction						itr_sqlca
Exception						ithw_exception

n_cst_dbconnectservice		inv_transection
n_cst_datawindowsservice	inv_dwsrv

string		is_coopid , is_coopcontrol 
end variables

forward prototypes
public function integer of_initservice (n_cst_dbconnectservice atr_dbtrans) throws Exception
public function integer of_get_sql (string as_coopid, string as_applgroup, string as_function, string as_argument[], ref string as_sql) throws Exception
protected function integer of_setsrvdw (boolean ab_switch) throws Exception
end prototypes

public function integer of_initservice (n_cst_dbconnectservice atr_dbtrans) throws Exception;/***********************************************************
<description>
	ใช้สำหรับ Intial service
</description>

<arguments>  
	
</arguments> 

<return> 
	1						Integer	ถ้าไม่มีข้อผิดพลาด
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/10/2012 by Godji
</usage> 
***********************************************************/
// Service สำหรับสร้าง Sql Extend

itr_sqlca = atr_dbtrans.itr_dbconnection
is_coopcontrol	= atr_dbtrans.is_coopcontrol
is_coopid = atr_dbtrans.is_coopid

if isnull( inv_transection ) or not isvalid( inv_transection ) then
	inv_transection = create n_cst_dbconnectservice
	inv_transection = atr_dbtrans
end if

return 1
end function

public function integer of_get_sql (string as_coopid, string as_applgroup, string as_function, string as_argument[], ref string as_sql) throws Exception;string ls_sql , ls_sqlall , ls_sqltp , ls_replace , ls_pos
string ls_arg[]
integer li_index , li_count , li_len
long ll_st
boolean lb_err = false
n_ds lds_temp

if isnull( as_coopid ) then
	ithw_exception.text	= "พบข้อผิดพลาด(0.01)"
	ithw_exception.text	+= "<br>~r~nไม่พบข้อมูล"
	ithw_exception.text	+= "<br>~r~nรหัสสหกรณ์ : " + as_coopid
	Goto objdestroy
end if

if isnull( as_applgroup ) then
	ithw_exception.text	= "พบข้อผิดพลาด(0.02)"
	ithw_exception.text	+= "<br>~r~nไม่พบข้อมูล"
	ithw_exception.text	+= "<br>~r~nรหัสกลุ่มงาน : " + as_applgroup
	Goto objdestroy
end if

if isnull( as_function ) then
	ithw_exception.text	= "พบข้อผิดพลาด(0.03)"
	ithw_exception.text	+= "<br>~r~nไม่พบข้อมูล"
	ithw_exception.text	+= "<br>~r~nรหัสฟังก์ชั่น : " + as_function
	Goto objdestroy
end if

ls_arg[]		= as_argument[]

this.of_setsrvdw(true)

lds_temp	= create n_ds
lds_temp.settransobject( itr_sqlca )

ls_sql		= "select nvl( trim( sql_desc ) , '' ) as sql_desc "
ls_sql		+= "from cmsql "
ls_sql		+= "where coop_id = '" + as_coopid + "' "
ls_sql		+= "and applgroup_code = '" + as_applgroup + "' "
ls_sql		+= "and function_code = '" + as_function + "' "

try
	inv_dwsrv.of_create_dw( lds_temp , ls_sql , "" )
catch( Exception lthw_crtnds )
	ithw_exception.text	= "พบข้อผิดพลาด(0.05)"
	ithw_exception.text	+= "<br>~r~n" + lthw_crtnds.text
end try

lds_temp.settransobject( itr_sqlca )

if lds_temp.retrieve() < 1 then
	ithw_exception.text	= "พบข้อผิดพลาด(0.10)"
	ithw_exception.text	+= "<br>~r~nไม่พบข้อมูล"
	ithw_exception.text	+= "<br>~r~nรหัสสหกรณ์ : " + as_coopid
	ithw_exception.text	+= "<br>~r~nรหัสกลุ่มงาน : " + as_applgroup
	ithw_exception.text	+= "<br>~r~nรหัสฟังก์ชั่น : " + as_function
	ithw_exception.text	+= "<br>~r~n" + lds_temp.of_geterrormessage( )
	lb_err = true ; Goto objdestroy
end if

lds_temp.setsort( " order_no " )
lds_temp.sort()

/*Get Sql*/
li_count	= lds_temp.rowcount()

for li_index = 1 to li_count
	
	ls_sqltp	= lds_temp.object.sql_desc[li_index]
	
	ls_sqlall	+= ls_sqltp +" "
	
next

ls_sqlall		= trim( ls_sqlall )

/*Replace Arg*/
li_count	= upperbound( ls_arg[] )

if li_count >= 1 then
	for li_index = 1 to li_count
		ls_replace	= ls_arg[li_index]

		/*Fix argument -> {a1}...{a99}...{a999}*/
		/*Get pos*/
		ls_pos	= "{a" + string( li_index ) + "}"
		
		/*Find first argunmet*/
		ll_st	= pos( ls_sqlall , ls_pos , 1 )
		
		do while ll_st > 0
		
			/*Length of argument */
			li_len	= len( ls_pos )
			
			/*Replace argument*/
			ls_sqlall	= replace( ls_sqlall , ll_st , li_len , ls_replace )
			
			ll_st	= pos( ls_sqlall , ls_pos , 1 )
			
		loop
		
	next
end if

objdestroy:

this.of_setsrvdw(false)

if isvalid( lds_temp ) then destroy lds_temp

if lb_err then
	ithw_exception.text	= "n_cst_sqlservice.of_get_sql()" + "<br>~r~n" + ithw_exception.text
	throw ithw_exception
else
	as_sql	= ls_sqlall
end if

return 1
end function

protected function integer of_setsrvdw (boolean ab_switch) throws Exception;// Check argument
if isnull( ab_switch ) then
	return -1
end if

if ab_switch then
	if isnull( inv_dwsrv ) or not isvalid( inv_dwsrv ) then
		inv_dwsrv	= create n_cst_datawindowsservice
		inv_dwsrv.of_initservice( inv_transection )
		return 1
	end if
else
	if isvalid( inv_dwsrv ) then
		destroy inv_dwsrv
		return 1
	end if
end if

return 0
end function

on n_cst_sqlservice.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_sqlservice.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ithw_exception = create Exception
end event

event destructor;if isvalid(ithw_exception) then destroy ithw_exception
if isvalid(inv_transection) then destroy inv_transection
if isvalid(inv_dwsrv) then destroy inv_dwsrv
end event
