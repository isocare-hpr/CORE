$PBExportHeader$n_cst_divsrv_memdet.sru
$PBExportComments$รายละเอียดสมาชิก
forward
global type n_cst_divsrv_memdet from nonvisualobject
end type
end forward

global type n_cst_divsrv_memdet from nonvisualobject
end type
global n_cst_divsrv_memdet n_cst_divsrv_memdet

type variables
Public:

string is_coopcontrol , is_coopid

transaction						itr_sqlca
Exception						ithw_exception

n_cst_dbconnectservice		inv_transection
n_cst_dwxmlieservice			inv_dwxmliesrv
n_cst_divsrv_proc_service	inv_procsrv
n_cst_doccontrolservice		inv_docsrv
end variables

forward prototypes
public function integer of_initservice (n_cst_dbconnectservice anv_dbtrans) throws Exception
public function integer of_save_memdet_methpay (ref str_divsrv_det astr_divsrv_det) throws Exception
public function integer of_init_detail (ref str_divsrv_det astr_divsrv_det) throws Exception
public function integer of_init_memdet_methpay (ref str_divsrv_det astr_divsrv_det) throws Exception
protected function integer of_setdsmodify (ref n_ds ads_requester, boolean ab_keymodify)
protected function integer of_setsrvdwxmlie (boolean ab_switch)
protected function integer of_setsrvproc (boolean ab_switch)
public function integer of_calmethpay (string as_methpay, decimal adc_expense, ref decimal adc_divbal, ref decimal adc_avgbal, ref decimal adc_etcbal, ref decimal adc_div, ref decimal adc_avg, ref decimal adc_etc) throws Exception
end prototypes

public function integer of_initservice (n_cst_dbconnectservice anv_dbtrans) throws Exception;/***********************************************************
<description>
	ไว้สำหรับเริ่มข้อมูลของ service ทำรายการเกี่ยวกับปันผล
</description>

<arguments>  
	atr_dbtrans					n_cst_dbconnectservice		user object สำหรับต่อฐานข้อมูล
</arguments> 

<return> 
	1								Integer		ถ้าไม่มีข้อมูลผิดพลาด
</return> 

<usage>
	สำหรับเริ่มข้อมูลของ service ทำรายการเกี่ยวกับปันผล
	ตัวอย่าง
	
	n_cst_dbconnectservice inv_db
	lnv_service = create n_cst_divavgoperate_service
	lnv_service.of_initservice( inv_db )
	
	----------------------------------------------------------------------
	Revision History:
	Version 1.0 (Initial version) Modified Date 16/11/2010 by Godji

</usage>

***********************************************************/
itr_sqlca = anv_dbtrans.itr_dbconnection

if isnull( inv_transection ) or not isvalid( inv_transection ) then
	inv_transection = create n_cst_dbconnectservice
	inv_transection = anv_dbtrans
end if

is_coopcontrol 	= anv_dbtrans.is_coopcontrol
is_coopid			= anv_dbtrans.is_coopid

return 1
end function

public function integer of_save_memdet_methpay (ref str_divsrv_det astr_divsrv_det) throws Exception;string ls_xmlmain , ls_xmldetail
string ls_coopid , ls_divyear , ls_memno, ls_methpay
dec ldc_div , ldc_avg , ldc_etc , ldc_expense
dec ldc_divbal , ldc_avgbal , ldc_etcbal
integer li_index , li_count, li_maxseqno
boolean lb_err = false

n_ds lds_memdet_main , lds_memdet_detail

this.of_setsrvproc( true )
this.of_setsrvdwxmlie( true )

lds_memdet_main = create n_ds
lds_memdet_main.dataobject = "d_divsrv_memdet_methpay_main"
lds_memdet_main.settransobject( itr_sqlca )

lds_memdet_detail = create n_ds
lds_memdet_detail.dataobject = "d_divsrv_memdet_methpay_detail"
lds_memdet_detail.settransobject( itr_sqlca )

ls_xmlmain		= astr_divsrv_det.xml_main
ls_xmldetail		= astr_divsrv_det.xml_detail

if inv_dwxmliesrv.of_xmlimport( lds_memdet_main , ls_xmlmain ) < 1 then
	ithw_exception.text = "~r~n<br>พบขอผิดพลาดในการนำเข้าข้อมูลแก้ไขวิธีการจ่ายปันผล-เฉลี่ยคืน(0.1)"
	ithw_exception.text += "~r~n<br>กรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

if inv_dwxmliesrv.of_xmlimport( lds_memdet_detail , ls_xmldetail ) < 1 then
	ithw_exception.text = "~r~n<br>พบขอผิดพลาดในการนำเข้าข้อมูลแก้ไขวิธีการจ่ายปันผล-เฉลี่ยคืน(ส่วนวิธีจ่าย 0.2)"
	ithw_exception.text += "~r~n<br>กรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

ls_coopid		= lds_memdet_main.object.coop_id[1]
ls_divyear		= lds_memdet_main.object.div_year[1]
ls_memno		= lds_memdet_main.object.member_no[1]

select nvl( div_balamt , 0 ) , nvl( avg_balamt , 0 ) , nvl( etc_balamt , 0 )
into :ldc_divbal , :ldc_avgbal , :ldc_etcbal
from yrdivmaster
where coop_id = :is_coopcontrol
and member_no = :ls_memno
and div_year = :ls_divyear
using itr_sqlca;

if ( ldc_divbal + ldc_avgbal + ldc_etcbal ) <= 0 then
	ithw_exception.text = "~r~n<br>พบขอผิดพลาดในการดึงข้อมูลยอดคงเหลือเงินปันผล-เฉลี่ยคืน(0.3)"
	ithw_exception.text += "~r~n<br>เลขสมาชิก : " + ls_memno
	ithw_exception.text += "~r~n<br>กรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

// หาค่าลำดับล่าสุดก่อน
select		nvl( max( seq_no ), 0 )
into		:li_maxseqno
from		yrdivmethpay
where	coop_id = :ls_coopid 
and div_year = :ls_divyear 
and member_no = :ls_memno 
and methpay_status = 1
using itr_sqlca;

li_count = lds_memdet_detail.rowcount()
for li_index = 1 to li_count
	lds_memdet_detail.object.coop_id[li_index]		= ls_coopid
	lds_memdet_detail.object.div_year[li_index]			= ls_divyear
	lds_memdet_detail.object.member_no[li_index]	= ls_memno
	lds_memdet_detail.object.seq_no[li_index]			= li_maxseqno + li_index
next

//** ค้างตรวจสอบวิธีทำรายการ
lds_memdet_detail.setsort( " coop_id , member_no , div_year , seq_no " )
lds_memdet_detail.sort()
li_count = lds_memdet_detail.rowcount()

for li_index = 1 to li_count
	ls_methpay		= lds_memdet_detail.object.methpaytype_code[li_index]
	ldc_expense		= lds_memdet_detail.object.expense_amt[li_index]
	
	try
		this.of_calmethpay( ls_methpay, ldc_expense , ldc_divbal , ldc_avgbal , ldc_etcbal , ldc_div , ldc_avg , ldc_etc )
	catch( Exception lthw_err )
		ithw_exception.text		= lthw_err.text
		lb_err = true 
	end try
	if lb_err then Goto objdestroy
	
	lds_memdet_detail.object.div_amt[li_index]			= ldc_div
	lds_memdet_detail.object.avg_amt[li_index]		= ldc_avg
	lds_memdet_detail.object.etc_amt[li_index]			= ldc_etc
	
next

//this.of_setdsmodify( lds_memdet_detail , false)
delete from yrdivmethpay where coop_id = :ls_coopid and div_year = :ls_divyear and member_no = :ls_memno and methpay_status = 0 using itr_sqlca;

if lds_memdet_detail.update() <> 1 then
	ithw_exception.text	= "บันทึกข้อมูลแก้ไขวิธีการจ่ายปันผล-เฉลี่ยคืนไม่ได้ (70.1)"
	ithw_exception.text	+= "~r~n<br> เลขที่สมาชิก : " + ls_memno
	ithw_exception.text	+= "~r~n<br>" + lds_memdet_detail.of_geterrormessage()
	ithw_exception.text	+= "~r~n<br>กรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

objdestroy:
if isvalid(lds_memdet_main) then destroy lds_memdet_main
if isvalid(lds_memdet_detail) then destroy lds_memdet_detail

this.of_setsrvproc( false )
this.of_setsrvdwxmlie( false )

if lb_err then
	astr_divsrv_det.xml_main	= ""
	astr_divsrv_det.xml_detail	= ""
	rollback using itr_sqlca ;
	ithw_exception.text = "n_cst_divsrv_memdet_detail.of_save_memdet_methpay()" + ithw_exception.text
	throw ithw_exception
else 
	commit using itr_sqlca;
end if

return 1
end function

public function integer of_init_detail (ref str_divsrv_det astr_divsrv_det) throws Exception;string ls_xmlmain
string ls_coopid , ls_divyear , ls_memno
boolean lb_err = false

n_ds lds_det_main , lds_det_list , lds_det_mast , lds_det_meth , lds_det_stm
n_ds lds_det_shr_day , lds_det_shr_mth , lds_det_lon_con

this.of_setsrvproc( true )
this.of_setsrvdwxmlie( true )

lds_det_main = create n_ds
lds_det_main.dataobject = "d_divsrv_det_main"
lds_det_main.settransobject( itr_sqlca )

lds_det_list = create n_ds
lds_det_list.dataobject = "d_divsrv_det_listyear"
lds_det_list.settransobject( itr_sqlca )

lds_det_mast = create n_ds
lds_det_mast.dataobject = "d_divsrv_det_master"
lds_det_mast.settransobject( itr_sqlca )

lds_det_meth = create n_ds
lds_det_meth.dataobject = "d_divsrv_det_methpay"
lds_det_meth.settransobject( itr_sqlca )

lds_det_stm = create n_ds
lds_det_stm.dataobject = "d_divsrv_det_stm"
lds_det_stm.settransobject( itr_sqlca )

lds_det_shr_day = create n_ds
lds_det_shr_day.dataobject = "d_divsrv_det_shr_day"
lds_det_shr_day.settransobject( itr_sqlca )

lds_det_shr_mth = create n_ds
lds_det_shr_mth.dataobject = "d_divsrv_det_shr_mth"
lds_det_shr_mth.settransobject( itr_sqlca )

lds_det_lon_con = create n_ds
lds_det_lon_con.dataobject = "d_divsrv_det_lon_con"
lds_det_lon_con.settransobject( itr_sqlca )

ls_xmlmain		= astr_divsrv_det.xml_main

if inv_dwxmliesrv.of_xmlimport( lds_det_main , ls_xmlmain ) < 1 then
	ithw_exception.text = "~r~nพบขอผิดพลาดในการนำเข้าข้อมูลแก้ไขวิธีการจ่ายปันผล-เฉลี่ยคืน(0.1)"
	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

ls_coopid		= lds_det_main.object.coop_id[1]
ls_memno		= lds_det_main.object.member_no[1]

// set ค่าในการดึงข้อมูลสมาชิก
try
	inv_procsrv.of_set_sqldw_column( lds_det_main, " and mbmembmaster.coop_id = '" + ls_coopid + "' " ) // ใส่เงื่อนไขอื่นๆ
	inv_procsrv.of_set_sqldw_column( lds_det_main, " and mbmembmaster.member_no = '" + ls_memno + "' " ) // ใส่เงื่อนไขอื่นๆ
	inv_procsrv.of_set_sqldw_column( lds_det_list, " where yrbgmaster.coop_id = '" + ls_coopid + "' " ) // ใส่เงื่อนไขอื่นๆ
	inv_procsrv.of_set_sqldw_column( lds_det_list, " and yrbgmaster.member_no = '" + ls_memno + "' " ) // ใส่เงื่อนไขอื่นๆ
	inv_procsrv.of_set_sqldw_column( lds_det_mast, " and yrbgmaster.coop_id = '" + ls_coopid + "' " ) // ใส่เงื่อนไขอื่นๆ
	inv_procsrv.of_set_sqldw_column( lds_det_mast, " and yrbgmaster.member_no = '" + ls_memno + "' " ) // ใส่เงื่อนไขอื่นๆ
	inv_procsrv.of_set_sqldw_column( lds_det_meth, " where yrdivmethpay.coop_id = '" + ls_coopid + "' " ) // ใส่เงื่อนไขอื่นๆ
	inv_procsrv.of_set_sqldw_column( lds_det_meth, " and yrdivmethpay.member_no = '" + ls_memno + "' " ) // ใส่เงื่อนไขอื่นๆ
	inv_procsrv.of_set_sqldw_column( lds_det_stm, " where yrdivstatement.coop_id = '" + ls_coopid + "' " ) // ใส่เงื่อนไขอื่นๆ
	inv_procsrv.of_set_sqldw_column( lds_det_stm, " and yrdivstatement.member_no = '" + ls_memno + "' " ) // ใส่เงื่อนไขอื่นๆ
	inv_procsrv.of_set_sqldw_column( lds_det_shr_day, " where yrbgshrstatement.coop_id = '" + ls_coopid + "' " ) // ใส่เงื่อนไขอื่นๆ
	inv_procsrv.of_set_sqldw_column( lds_det_shr_day, " and yrbgshrstatement.member_no = '" + ls_memno + "' " ) // ใส่เงื่อนไขอื่นๆ
	inv_procsrv.of_set_sqldw_column( lds_det_shr_mth, " where yrbgshrmth.coop_id = '" + ls_coopid + "' " ) // ใส่เงื่อนไขอื่นๆ
	inv_procsrv.of_set_sqldw_column( lds_det_shr_mth, " and yrbgshrmth.member_no = '" + ls_memno + "' " ) // ใส่เงื่อนไขอื่นๆ
	inv_procsrv.of_set_sqldw_column( lds_det_lon_con, " where yrbglonmaster.coop_id = '" + ls_coopid + "' " ) // ใส่เงื่อนไขอื่นๆ
	inv_procsrv.of_set_sqldw_column( lds_det_lon_con, " and yrbglonmaster.member_no = '" + ls_memno + "' " ) // ใส่เงื่อนไขอื่นๆ
catch( Exception lthw_setdwsql )
	ithw_exception.text	+= "~r~nพบขอผิดพลาด (0.2)"
	ithw_exception.text	+= lthw_setdwsql.text
	lb_err = true
end try
if lb_err then Goto objdestroy

if lds_det_main.retrieve() < 1 then
	ithw_exception.text = "~r~nพบขอผิดพลาดในการดึงข้อมูลรายละเอียดสมาชิก(รายละเอียดสมาชิก 10.1)"
	ithw_exception.text += "~r~nเลขสมาชิก : " + ls_memno
	ithw_exception.text += "~r~n" + lds_det_main.of_geterrormessage( )
	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

lds_det_list.retrieve()
lds_det_mast.retrieve()
lds_det_meth.retrieve()
lds_det_stm.retrieve()
lds_det_shr_day.retrieve()
lds_det_shr_mth.retrieve()
lds_det_lon_con.retrieve()

astr_divsrv_det.xml_main			= inv_dwxmliesrv.of_xmlexport(lds_det_main)
astr_divsrv_det.xml_list			= inv_dwxmliesrv.of_xmlexport(lds_det_list)
astr_divsrv_det.xml_master		= inv_dwxmliesrv.of_xmlexport(lds_det_mast)
astr_divsrv_det.xml_methpay		= inv_dwxmliesrv.of_xmlexport(lds_det_meth)
astr_divsrv_det.xml_statement	= inv_dwxmliesrv.of_xmlexport(lds_det_stm)
astr_divsrv_det.xml_shr_day	= inv_dwxmliesrv.of_xmlexport(lds_det_shr_day)
astr_divsrv_det.xml_shr_mth	= inv_dwxmliesrv.of_xmlexport(lds_det_shr_mth)
astr_divsrv_det.xml_lon_con	= inv_dwxmliesrv.of_xmlexport(lds_det_lon_con)

objdestroy:
if isvalid(lds_det_main) then destroy lds_det_main
if isvalid(lds_det_list) then destroy lds_det_list
if isvalid(lds_det_mast) then destroy lds_det_mast
if isvalid(lds_det_meth) then destroy lds_det_meth
if isvalid(lds_det_stm) then destroy lds_det_stm
if isvalid(lds_det_shr_day) then destroy lds_det_shr_day
if isvalid(lds_det_shr_mth) then destroy lds_det_shr_mth
if isvalid(lds_det_lon_con) then destroy lds_det_lon_con

this.of_setsrvproc( false )
this.of_setsrvdwxmlie( false )

if lb_err then
	rollback using itr_sqlca ;
	ithw_exception.text = "n_cst_divsrv_memdet_detail.of_init_detail()" + ithw_exception.text
	throw ithw_exception
end if

return 1
end function

public function integer of_init_memdet_methpay (ref str_divsrv_det astr_divsrv_det) throws Exception;string ls_xmlmain
string ls_coopid , ls_divyear , ls_memno
boolean lb_err = false

n_ds lds_memdet_main , lds_memdet_detail

this.of_setsrvproc( true )
this.of_setsrvdwxmlie( true )

lds_memdet_main = create n_ds
lds_memdet_main.dataobject = "d_divsrv_memdet_methpay_main"
lds_memdet_main.settransobject( itr_sqlca )

lds_memdet_detail = create n_ds
lds_memdet_detail.dataobject = "d_divsrv_memdet_methpay_detail"
lds_memdet_detail.settransobject( itr_sqlca )

ls_xmlmain		= astr_divsrv_det.xml_main

if inv_dwxmliesrv.of_xmlimport( lds_memdet_main , ls_xmlmain ) < 1 then
	ithw_exception.text = "~r~nพบขอผิดพลาดในการนำเข้าข้อมูลแก้ไขวิธีการจ่ายปันผล-เฉลี่ยคืน(0.1)"
	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

ls_coopid		= lds_memdet_main.object.coop_id[1]
ls_divyear		= lds_memdet_main.object.div_year[1]
ls_memno		= lds_memdet_main.object.member_no[1]

// set ค่าในการดึงข้อมูลสมาชิก
try
	inv_procsrv.of_set_sqldw_column( lds_memdet_main, " and yrbgmaster.div_year = '" + ls_divyear + "' " ) // ใส่เงื่อนไขอื่นๆ
	inv_procsrv.of_set_sqldw_column( lds_memdet_main, " and yrbgmaster.coop_id = '" + ls_coopid + "' " ) // ใส่เงื่อนไขอื่นๆ
	inv_procsrv.of_set_sqldw_column( lds_memdet_main, " and yrbgmaster.member_no = '" + ls_memno + "' " ) // ใส่เงื่อนไขอื่นๆ
	inv_procsrv.of_set_sqldw_column( lds_memdet_detail, " where yrdivmethpay.div_year = '" + ls_divyear + "' " ) // ใส่เงื่อนไขอื่นๆ
	inv_procsrv.of_set_sqldw_column( lds_memdet_detail, " and yrdivmethpay.coop_id = '" + ls_coopid + "' " ) // ใส่เงื่อนไขอื่นๆ
	inv_procsrv.of_set_sqldw_column( lds_memdet_detail, " and yrdivmethpay.member_no = '" + ls_memno + "' " ) // ใส่เงื่อนไขอื่นๆ
	inv_procsrv.of_set_sqldw_column( lds_memdet_detail, " and yrdivmethpay.methpay_status = '0' " ) // ใส่เงื่อนไขอื่นๆ
catch( Exception lthw_setdwsql )
	ithw_exception.text	+= "~r~nพบขอผิดพลาด (0.2)"
	ithw_exception.text	+= lthw_setdwsql.text
	lb_err = true
end try
if lb_err then Goto objdestroy

if lds_memdet_main.retrieve() < 1 then
	ithw_exception.text = "~r~nพบขอผิดพลาดในการดึงข้อมูลแก้ไขวิธีการจ่ายปันผล-เฉลี่ยคืน(รายละเอียดสมาชิก 10.1)"
	ithw_exception.text += "~r~nเลขสมาชิก : " + ls_memno
	ithw_exception.text += "~r~n" + lds_memdet_main.of_geterrormessage( )
	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

if lds_memdet_detail.retrieve() < 0 then
	ithw_exception.text = "~r~nพบขอผิดพลาดในการดึงข้อมูลแก้ไขวิธีการจ่ายปันผล-เฉลี่ยคืน(รายละเอียดวิธีจ่าย 10.2)"
	ithw_exception.text += "~r~nเลขสมาชิก : " + ls_memno
	ithw_exception.text += "~r~n" + lds_memdet_detail.of_geterrormessage( )
	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy
end if

astr_divsrv_det.xml_main		= inv_dwxmliesrv.of_xmlexport(lds_memdet_main)
astr_divsrv_det.xml_detail		= inv_dwxmliesrv.of_xmlexport(lds_memdet_detail)

objdestroy:
if isvalid(lds_memdet_main) then destroy lds_memdet_main
if isvalid(lds_memdet_detail) then destroy lds_memdet_detail

this.of_setsrvproc( false )
this.of_setsrvdwxmlie( false )

if lb_err then
	astr_divsrv_det.xml_main	= ""
	astr_divsrv_det.xml_detail	= ""
	rollback using itr_sqlca ;
	ithw_exception.text = "n_cst_divsrv_memdet_detail.of_init_memdet_methpay()" + ithw_exception.text
	throw ithw_exception
end if

return 1
end function

protected function integer of_setdsmodify (ref n_ds ads_requester, boolean ab_keymodify);string		ls_iskey
long		ll_index, ll_count , ll_row , ll_rwcount

ll_rwcount	= ads_requester.rowcount()
for ll_row = 1 to ll_rwcount
	ads_requester.setitemstatus( ll_row, 0, primary!, datamodified! )
	
	// ปรับ Attrib ทุก Column ให้เป็น Update ซะ
	ll_count	= long( ads_requester.describe( "DataWindow.Column.Count" ) )
	for ll_index = 1 to ll_count
		
		ls_iskey	= ads_requester.describe("#"+string( ll_index )+".Key")
		
		// ถ้าเป็น PK และเงื่อนไขคือไม่ปรับ Key ไม่ต้องปรับสถานะ
		if upper( ls_iskey ) = "YES" and not( ab_keymodify ) then
			continue
		end if
		
		ads_requester.setitemstatus( 1, ll_index, primary!, datamodified! )
	next
next

return 1
end function

protected function integer of_setsrvdwxmlie (boolean ab_switch);// Check argument
if isnull( ab_switch ) then
	return -1
end if

if ab_switch then
	if isnull( inv_dwxmliesrv ) or not isvalid( inv_dwxmliesrv ) then
		inv_dwxmliesrv	= create n_cst_dwxmlieservice
		return 1
	end if
else
	if isvalid( inv_dwxmliesrv ) then
		destroy inv_dwxmliesrv
		return 1
	end if
end if

return 0
end function

protected function integer of_setsrvproc (boolean ab_switch);// Check argument
if isnull( ab_switch ) then
	return -1
end if

if ab_switch then
	if isnull( inv_procsrv ) or not isvalid( inv_procsrv ) then
		inv_procsrv	= create n_cst_divsrv_proc_service
		return 1
	end if
else
	if isvalid( inv_procsrv ) then
		destroy inv_procsrv
		return 1
	end if
end if

return 0
end function

public function integer of_calmethpay (string as_methpay, decimal adc_expense, ref decimal adc_divbal, ref decimal adc_avgbal, ref decimal adc_etcbal, ref decimal adc_div, ref decimal adc_avg, ref decimal adc_etc) throws Exception;string ls_cuttype
integer	li_count
dec ldc_expense , ldc_divbal , ldc_avgbal , ldc_etcbal
dec ldc_div , ldc_avg , ldc_etc

ldc_expense		= adc_expense
ldc_divbal		= adc_divbal
ldc_avgbal		= adc_avgbal
ldc_etcbal		= adc_etcbal

// ถ้าไม่มีค่าให้ออกเลย
if ldc_expense <= 0 then
	adc_div		= 0
	adc_avg		= 0
	adc_etc		= 0
	
	return 1
end if

// ตรวจก่อนว่ามีการกำหนดไว้มั้ย
select		nvl( count(1), 0 )
into		:li_count
from		yrucfcutorder 
where	coop_id = :is_coopcontrol 
and		methpaytype_code		= :as_methpay
using		itr_sqlca ;

if li_count > 0 then
	declare data_cur cursor for
	select cuttype_code 
	from yrucfcutorder 
	where coop_id = :is_coopcontrol
	and methpaytype_code = :as_methpay
	order by cuttype_order 
	using itr_sqlca;
	open data_cur ;
		fetch data_cur into :ls_cuttype ;
		do while itr_sqlca.sqlcode = 0
			
		
			choose case ls_cuttype
				case "DIV"
					if ldc_divbal > 0 then
						if ldc_expense > ldc_divbal then
							ldc_expense		= ldc_expense - ldc_divbal
							ldc_div			= ldc_divbal
							ldc_divbal		= 0
						else
							ldc_divbal		= ldc_divbal - ldc_expense
							ldc_div			= ldc_expense
							ldc_expense		= 0
						end if
					end if
				case "AVG"
					if ldc_avgbal > 0 then
						if ldc_expense > ldc_avgbal then
							ldc_expense		= ldc_expense - ldc_avgbal
							ldc_avg			= ldc_avgbal
							ldc_avgbal		= 0
						else
							ldc_avgbal		= ldc_avgbal - ldc_expense
							ldc_avg			= ldc_expense
							ldc_expense		= 0
						end if
					end if
				case "ETC"
					if ldc_etcbal > 0 then
						if ldc_expense > ldc_etcbal then
							ldc_expense		= ldc_expense - ldc_etcbal
							ldc_etc			= ldc_etcbal
							ldc_etcbal		= 0
						else
							ldc_etcbal		= ldc_etcbal - ldc_expense
							ldc_etc			= ldc_expense
							ldc_expense		= 0
						end if
					end if
			end choose
			
			if ldc_expense = 0 then
				close data_cur ;
				exit
			end if
			
			fetch data_cur into :ls_cuttype ;
		loop
	close data_cur;
else
	
	if ldc_expense > 0 and ldc_etcbal > 0 then
		// ตัดพวกค้างจ่ายก่อน
		if ldc_expense > ldc_etcbal then
			ldc_expense		= ldc_expense - ldc_etcbal
			ldc_etc			= ldc_etcbal
			ldc_etcbal		= 0
		else
			ldc_etcbal		= ldc_etcbal - ldc_expense
			ldc_etc			= ldc_expense
			ldc_expense		= 0
		end if
	end if

	if ldc_expense > 0 and ldc_avgbal > 0 then
		// ตัดพวกเฉลี่ยคืน
		if ldc_expense > ldc_avgbal then
			ldc_expense		= ldc_expense - ldc_avgbal
			ldc_avg			= ldc_avgbal
			ldc_avgbal		= 0
		else
			ldc_avgbal		= ldc_avgbal - ldc_expense
			ldc_avg			= ldc_expense
			ldc_expense		= 0
		end if
		
	end if
	
	if ldc_expense > 0 and ldc_divbal > 0 then
		// ตัดปันผล
		if ldc_expense > ldc_divbal then
			ldc_expense		= ldc_expense - ldc_divbal
			ldc_div			= ldc_divbal
			ldc_divbal		= 0
		else
			ldc_divbal		= ldc_divbal - ldc_expense
			ldc_div			= ldc_expense
			ldc_expense		= 0
		end if
	end if
end if


adc_divbal	= ldc_divbal
adc_avgbal	= ldc_avgbal
adc_etcbal	= ldc_etcbal
adc_div		= ldc_div
adc_avg		= ldc_avg
adc_etc		= ldc_etc

if ldc_expense = adc_expense then
	ithw_exception.text		= "~r~n<br>n_cst_divsrv_memdet_detail.of_calmethpay()"
	ithw_exception.text		+= "~r~n<br>ไม่สามารถแยกยอดการทำรายการได้"
	ithw_exception.text		+= "~r~n<br>กรุณาตรวจสอบลำดับการหักเงินปันผลเฉลี่ยคืน"
	throw ithw_exception
end if

return 1
end function

on n_cst_divsrv_memdet.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_divsrv_memdet.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ithw_exception = create Exception
end event

