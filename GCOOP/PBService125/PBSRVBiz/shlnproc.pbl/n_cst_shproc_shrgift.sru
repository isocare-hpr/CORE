$PBExportHeader$n_cst_shproc_shrgift.sru
forward
global type n_cst_shproc_shrgift from nonvisualobject
end type
end forward

global type n_cst_shproc_shrgift from nonvisualobject
end type
global n_cst_shproc_shrgift n_cst_shproc_shrgift

type variables
datetime		idtm_balancedate
n_ds			ids_balanceattrib

transaction	itr_sqlca
Exception	ithw_exception

n_cst_dbconnectservice		inv_connection
n_cst_progresscontrol		inv_progress
n_cst_stringservice			inv_stringsrv
end variables

forward prototypes
public function integer of_procshrgift (string as_xmlgiftcriteria, string as_procid) throws Exception
public function integer of_initservice (n_cst_dbconnectservice anv_dbtrans)
public function integer of_postshrgift (string as_xmlgiftcriteria, string as_postid, string as_branchid) throws Exception
public function integer of_init_shrgiftadjust (ref str_shrgift astr_shrgift) throws Exception
public function integer of_save_shrgiftadjust (ref str_shrgift astr_shrgift) throws Exception
public function integer of_setprogress (ref n_cst_progresscontrol anv_progress) throws Exception
private function integer of_save_shrgiftreturn (string as_memno, integer ai_giftyear, integer ai_giftperiod, string as_returnid, string as_branchid, datetime adtm_returndate) throws Exception
public function integer of_setoperateflag (ref n_ds ads_shrgift)
end prototypes

public function integer of_procshrgift (string as_xmlgiftcriteria, string as_procid) throws Exception;/***********************************************************
<description>
	สำหรับประมวลผลหนังสือยืนยันยอดหุ้น,หนี้,เงินฝาก,การค้ำประกัน
</description>

<arguments>  
	as_xmlgiftcriteria	String		เงื่อนไขการประมวลผลหนังสือยืนยันยอด
	as_procid{ref}		String		ผู้ที่ทำการประมวลผล
</arguments> 

<return> 
	1						Integer	ถ้าไม่มีข้อผิดพลาด
</return> 

<usage> 
	ส่งเงื่อนไขที่อยู่ในรูปแบบ XML พร้อม ผู้ที่ทำการประมวลผลเข้ามา
	ระบบจะทำการ Process ข้อมูลแล้วบันทึกลงฐานข้อมูลเอาไว้
	
	string		ls_xmlbalcriteria, ls_entryid
	
	ls_xmlbalcriteria	= dw_criteria.describe( "Datawindow.Data.XML" )
	ls_entryid			= entry_id
	
	lnv_lnoperate.of_procconfirmbalance( ls_xmlbalcriteria, ls_entryid )
	----------------------------------------------------------------------
	Revision History:
	Version 1.0 (Initial version) Modified Date 20/9/2010 by OhhO

</usage> 
***********************************************************/
string		ls_grptext, ls_memtext, ls_sql, ls_sqlext
string		ls_memno, ls_memgrp, ls_arg[]
integer	li_giftyear, li_giftperiod, li_rangetype
dec{2}	ldc_giftvalue, ldc_shrvalue, ldc_giftamt
dec{2}	ldc_shrstkvalue
long		ll_count, ll_index
n_ds		lds_memdata

ids_balanceattrib.reset()
ids_balanceattrib.importstring( XML!, as_xmlgiftcriteria )

if ids_balanceattrib.rowcount() <= 0 then
	ithw_exception.text	="ไม่พบข้อมูลเงือนไขการประมวลผล"
	throw ithw_exception
end if

li_giftyear		= ids_balanceattrib.getitemnumber( 1, "shrgift_year" )
li_giftperiod		= ids_balanceattrib.getitemnumber( 1, "shrgift_period" )
li_rangetype		= ids_balanceattrib.getitemnumber( 1, "rangedata_type" )
ls_grptext		= ids_balanceattrib.getitemstring( 1, "rangedata_grp" )
ls_memtext		= ids_balanceattrib.getitemstring( 1, "rangedata_mem" )

// ส่วนของหุ้นที่จะให้เป็นของขวัญ
ldc_giftvalue		= ids_balanceattrib.getitemdecimal( 1, "shrgift_value" )

select		share_value
into		:ldc_shrvalue
from		shsharetype
where	( sharetype_code = '01' )
using		itr_sqlca ;

ldc_giftamt		= ldc_giftvalue / ldc_shrvalue

try
	// ถ้าประมวลผลแบบย่อย
	choose case li_rangetype
		case 2	// ตามกลุ่ม
			inv_stringsrv.of_analyzestring( ls_grptext, ls_arg[] )
		case 3 // ตามทะเบียน
			inv_stringsrv.of_analyzestring( ls_memtext, ls_arg[] )
	end choose

	ls_sqlext		= ""
	
	// สร้าง Sql ตาม Argument ที่รับมา
	choose case li_rangetype
		case 2
			inv_stringsrv.of_buildsqlext( ls_arg[], "mbmembmaster.membgroup_code", ls_sqlext )
			ls_sqlext	= " and "+ls_sqlext
		case 3
			inv_stringsrv.of_buildsqlext( ls_arg[], "mbmembmaster.member_no", ls_sqlext )
			ls_sqlext	= " and "+ls_sqlext
	end choose
catch( Exception lthw_error )
	rollback using itr_sqlca ;
	throw lthw_error
end try

inv_progress.istr_progress.progress_text		= "ประมวลผลหุ้นของขวัญ"
inv_progress.istr_progress.progress_max		= 1
inv_progress.istr_progress.subprogress_text	= "กำลังดึงข้อมูลสมาชิกที่จะได้หุ้น..."
inv_progress.istr_progress.status					= 8

// ข้อมูลที่จะทำการประมวลผล
lds_memdata	= create n_ds
lds_memdata.dataobject	= "d_slproc_shrgift_infoprocmemb"
lds_memdata.settransobject( itr_sqlca )

ls_sql		= lds_memdata.getsqlselect()
ls_sql		= ls_sql + ls_sqlext

lds_memdata.setsqlselect( ls_sql )
lds_memdata.settransobject( itr_sqlca )

ll_count		= lds_memdata.retrieve()

inv_progress.istr_progress.subprogress_max	= ll_count

for ll_index = 1 to ll_count
	yield()
	if inv_progress.of_is_stop() then
		destroy lds_memdata
		rollback using itr_sqlca ;
		return 0
	end if
	
	// ตรวจสอบการสั่งหยุดทำงาน
	ls_memno			= lds_memdata.getitemstring( ll_index, "member_no" )
	ls_memgrp			= lds_memdata.getitemstring( ll_index, "membgroup_code" )
	ldc_shrstkvalue		= lds_memdata.getitemdecimal( ll_index, "sharestk_value" )
	
	inv_progress.istr_progress.subprogress_index	= ll_index
	inv_progress.istr_progress.subprogress_text	= "ทะเบียน "+ls_memno+" หุ้นของขวัญ "+string( ldc_giftvalue, "0" )
	
	delete from shsharegift
	where	( shrgift_year		= :li_giftyear ) and
				( shrgift_period		= :li_giftperiod ) and
				( member_no		= :ls_memno )
	using		itr_sqlca ;

	insert into shsharegift
				( shrgift_year, shrgift_period, member_no, sharetype_code, sharestk_value, shrgift_amt, shrgift_value, membgroup_code, shrgift_status, posting_status )
	values	( :li_giftyear, :li_giftperiod, :ls_memno, '01', :ldc_shrstkvalue, :ldc_giftamt, :ldc_giftvalue, :ls_memgrp, 1, 0 )
	using		itr_sqlca ;
	
	if itr_sqlca.sqlcode <> 0 then
		ithw_exception.text	= "ไม่สามารถบันทึกข้อมูลหุ้นของขวัญของสมาชิกทะเบียน "+ls_memno+ "~n"+itr_sqlca.sqlerrtext
		rollback using itr_sqlca ;
		destroy lds_memdata
		throw ithw_exception
	end if
next
	
// ถ้าไม่มี Error เลย
commit using itr_sqlca ;

inv_progress.istr_progress.status	= 1

return 1
end function

public function integer of_initservice (n_cst_dbconnectservice anv_dbtrans);// Service Transection
if isnull( inv_connection ) or not isvalid( inv_connection ) then
	inv_connection	= create n_cst_dbconnectservice
	inv_connection	= anv_dbtrans
end if


itr_sqlca 		= inv_connection.itr_dbconnection

ids_balanceattrib	= create n_ds
ids_balanceattrib.dataobject = "d_slproc_shrgift_criteria"

 
inv_stringsrv	= create n_cst_stringservice

// สร้าง Progress สำหรับแสดงสถานะการประมวลผล
inv_progress 	= create n_cst_progresscontrol

return 1
end function

public function integer of_postshrgift (string as_xmlgiftcriteria, string as_postid, string as_branchid) throws Exception;string		ls_memno, ls_shrtype, ls_refperiod, ls_tofromaccid
string		ls_sql, ls_sqlperiod, ls_sqlext, ls_grptext, ls_memtext
string		ls_arg[]
integer	li_shrstatus, li_laststmno
integer	li_giftyear, li_giftperiod, li_rangetype
long		ll_index, ll_count
dec{3}	ldc_giftamt, ldc_shrstkamt
dec{2}	ldc_giftvalue, ldc_shrstkvalue, ldc_shrvalue
datetime	ldtm_docdate, ldtm_opedate, ldtm_postdate
n_ds		lds_shrgiftdata

ids_balanceattrib.reset()
ids_balanceattrib.importstring( XML!, as_xmlgiftcriteria )

if ids_balanceattrib.rowcount() <= 0 then
	ithw_exception.text	="ไม่พบข้อมูลเงือนไขการประมวลผล"
	throw ithw_exception
end if

li_giftyear		= ids_balanceattrib.getitemnumber( 1, "shrgift_year" )
li_giftperiod		= ids_balanceattrib.getitemnumber( 1, "shrgift_period" )
li_rangetype		= ids_balanceattrib.getitemnumber( 1, "rangedata_type" )
ls_grptext		= ids_balanceattrib.getitemstring( 1, "rangedata_grp" )
ls_memtext		= ids_balanceattrib.getitemstring( 1, "rangedata_mem" )

// ส่วนของวันที่ที่ลงบัญชีและวันที่อายุหุ้น
ls_tofromaccid	= ids_balanceattrib.getitemstring( 1, "tofrom_accid" )
ldtm_docdate	= ids_balanceattrib.getitemdatetime( 1, "receipt_date" )
ldtm_opedate	= ids_balanceattrib.getitemdatetime( 1, "operate_date" )

try
	// ถ้าประมวลผลแบบย่อย
	choose case li_rangetype
		case 2	// ตามกลุ่ม
			inv_stringsrv.of_analyzestring( ls_grptext, ls_arg[] )
		case 3 // ตามทะเบียน
			inv_stringsrv.of_analyzestring( ls_memtext, ls_arg[] )
	end choose

	ls_sqlext			= ""
	
	// สร้าง Sql ตาม Argument ที่รับมา
	choose case li_rangetype
		case 2
			inv_stringsrv.of_buildsqlext( ls_arg[], "shsharegift.membgroup_code", ls_sqlext )
			ls_sqlext	= " and "+ls_sqlext
		case 3
			inv_stringsrv.of_buildsqlext( ls_arg[], "shsharegift.member_no", ls_sqlext )
			ls_sqlext	= " and "+ls_sqlext
	end choose
catch( Exception lthw_error )
	throw lthw_error
end try

inv_progress.istr_progress.progress_text		= "ผ่านรายการหุ้นของขวัญ"
inv_progress.istr_progress.progress_max		= 1
inv_progress.istr_progress.subprogress_text	= "กำลังดึงข้อมูลสมาชิกที่จะผ่านรายการ..."
inv_progress.istr_progress.status					= 8

// ข้อมูลหุ้นของขวัญที่ต้องการผ่านรายการ
lds_shrgiftdata	= create n_ds
lds_shrgiftdata.dataobject	= "d_slproc_shrgift_infopostshrgift"
lds_shrgiftdata.settransobject( itr_sqlca )

ls_sql				= lds_shrgiftdata.getsqlselect()

ls_sqlperiod		= " and ( shsharegift.shrgift_year = "+string( li_giftyear )+" ) and ( shsharegift.shrgift_period = "+string( li_giftperiod )+" )"
ls_sql				= ls_sql + ls_sqlperiod + ls_sqlext

lds_shrgiftdata.setsqlselect( ls_sql )
lds_shrgiftdata.settransobject( itr_sqlca )
ll_count	= lds_shrgiftdata.retrieve()

inv_progress.istr_progress.subprogress_max	= ll_count

// กำหนดค่าอื่นๆ
ls_refperiod		= string( li_giftyear )+string( li_giftperiod )
ldtm_postdate	= datetime( today(), now() )

for ll_index = 1 to ll_count
	// ตรวจสอบการสั่งหยุดทำงาน
	yield()
	if inv_progress.of_is_stop() then
		destroy lds_shrgiftdata
		rollback using itr_sqlca ;
		return 0
	end if
	
	ls_memno		= lds_shrgiftdata.getitemstring( ll_index, "member_no" )
	ls_shrtype		= lds_shrgiftdata.getitemstring( ll_index, "sharetype_code" )
	ldc_giftamt		= lds_shrgiftdata.getitemdecimal( ll_index, "shrgift_amt" )
	ldc_shrstkamt	= lds_shrgiftdata.getitemdecimal( ll_index, "sharestk_amt" )
	li_shrstatus		= lds_shrgiftdata.getitemnumber( ll_index, "sharemaster_status" )
	li_laststmno		= lds_shrgiftdata.getitemnumber( ll_index, "last_stm_no" )
	
	if isnull( ldc_shrstkamt ) then ldc_shrstkamt = 0
	if isnull( ldc_giftamt ) then ldc_giftamt = 0
	
	inv_progress.istr_progress.subprogress_index	= ll_index
	inv_progress.istr_progress.subprogress_text	= "ทะเบียน "+ls_memno+" หุ้นของขวัญ "+string( ldc_giftamt * 10, "0" )
	
	// ถ้าไม่มีมูลค่าหุ้นของขวัญข้าม
	if ldc_giftamt <= 0 then
		continue
	end if
	
	// ตรวจสอบสถานะหุ้นก่อนโอนให้
	if li_shrstatus <> 8 and li_shrstatus <> 1 then
		continue
	end if
	
	ldc_shrstkamt	= ldc_shrstkamt + ldc_giftamt
	li_laststmno		= li_laststmno + 1
	
	// บันทึกลง Statement ก่อน
	insert into shsharestatement
				( member_no, sharetype_code, seq_no, operate_date, slip_date, ref_docno, shritemtype_code, period,
				  share_amount, sharestk_amt, entry_id, entry_date, coopbranch_id, moneytype_code, item_status )
	values	( :ls_memno, :ls_shrtype, :li_laststmno, :ldtm_opedate, :ldtm_docdate, :ls_refperiod, 'SGF', 0,
				  :ldc_giftamt, :ldc_shrstkamt, :as_postid, :ldtm_postdate, :as_branchid, 'TRN', 1 )
	using		itr_sqlca ;
			  
	if itr_sqlca.sqlcode <> 0 then
		ithw_exception.text	= "ไม่สามารถเพิ่มรายการเคลื่อนไหวหุ้นของสมาชิกได้ ทะเบียน "+ls_memno+"~n"+itr_sqlca.sqlerrtext

		rollback using itr_sqlca ;
		destroy lds_shrgiftdata
		throw ithw_exception
	end if
	
	// ปรับปรุงแฟ้มหลัก ShareMaster
	update	shsharemaster
	set			sharestk_amt		= :ldc_shrstkamt,
				last_stm_no			= :li_laststmno
	where	( member_no		= :ls_memno ) and
				( sharetype_code	= :ls_shrtype )
	using		itr_sqlca ;
	if itr_sqlca.sqlcode <> 0 then
		ithw_exception.text	= "ไม่สามารถปรับปรุงรายการทุนเรือนหุ้นของสมาชิกได้ ทะเบียน "+trim( ls_memno )+"~n"+itr_sqlca.sqlerrtext
		rollback using itr_sqlca ;
		destroy lds_shrgiftdata
		throw ithw_exception
	end if
	
	// ปรับปรุงสถานะผ่านรายการ
	update	shsharegift
	set		posting_status		= 1,
			posting_date		= :ldtm_postdate,
			tofrom_accid		= :ls_tofromaccid,
			receipt_date			= :ldtm_docdate,
			operate_date		= :ldtm_opedate
	where	( member_no	= :ls_memno ) and
			( shrgift_year		= :li_giftyear ) and
			( shrgift_period		= :li_giftperiod )  
	using		itr_sqlca ;
	if itr_sqlca.sqlcode <> 0 then
		ithw_exception.text	= "ไม่สามารถปรับปรุงสถานะรายการได้ ทะเบียน "+ls_memno+ "~n"+itr_sqlca.sqlerrtext
		rollback using itr_sqlca ;
		destroy lds_shrgiftdata
		throw ithw_exception
	end if
next

destroy lds_shrgiftdata

commit using itr_sqlca ;

inv_progress.istr_progress.status		= 1

return 1
end function

public function integer of_init_shrgiftadjust (ref str_shrgift astr_shrgift) throws Exception;/***********************************************************
<description>
	สำหรับ Init รายการหุ้นของขวัญของสมาชิกที่ส่งทะเบียนเข้ามา (ได้ค่า XML กลับไป)
</description>

<arguments>  
	str_shrgift{ref}		Structure รายการหุ้นของขวัญ
		Attrib ภายใน Structure ที่ต้องใช้คือ
		- member_no		String			ทะเบียนสมาชิก
		- xml_memdet		String			XML รายละเอียดสมาชิกที่จะได้ค่ากลับไป
		- xml_shrgiftlist		String			XML รายการหุ้นของขวัญที่จะได้ค่ากลับไป
</arguments>

<return> 
	Integer
	1			ถ้าไม่มีข้อผิดพลาด
</return> 

<usage> 
	เรียกใช้โดยส่งข้อมูลผ่าน Structure เข้ามาฟังก์ชั่นจะส่งรายละเอียด
	รายการหุ้นของขวัญกลับไปในรูปแบบ XML
	
	str_shrgift	lstr_shrgift
	
	lstr_shrgift.member_no			= dw_master.getitemstring( 1, "member_no" )
	
	lnv_shrgift.of_init_shrgiftadjust( lstr_shrgift )
	
	dw_master.reset()
	dw_master.importstring( XML!, lnv_shrgift.xml_memdet )
	
	dw_shrgiftlist.reset()
	dw_shrgiftlist.importstring( XML!, lnv_shrgift.xml_shrgiftlist )
	----------------------------------------------------------------------
	Revision History:
	Version 1.0 (Initial version) Modified Date 20/9/2010 by OhhO

</usage> 
***********************************************************/
string		ls_memno
long		ll_count
n_ds		lds_temp

astr_shrgift.xml_memdet		= ""
astr_shrgift.xml_shrgiftlist	= ""

ls_memno	= astr_shrgift.member_no

select		count( member_no )
into		:ll_count
from		shsharegift
where	( member_no	= :ls_memno )
using		itr_sqlca ;

if isnull( ll_count ) then ll_count = 0

if ll_count <= 0 then
	ithw_exception.text	= "ไม่พบข้อมูลหุ้นของขวัญของเลขที่สมาชิก "+ls_memno+" กรุณาตรวจสอบ"
	throw ithw_exception
end if

// รายละเอียดสมาชิก
lds_temp		= create n_ds
lds_temp.dataobject	= "d_loansrv_info_memdetail"
lds_temp.settransobject( itr_sqlca )
ll_count		= lds_temp.retrieve( ls_memno )

if ll_count <= 0 then
	ithw_exception.text	= "ไม่พบข้อมูลทะเบียนสมาชิก "+ls_memno+" กรุณาตรวจสอบ"
	throw ithw_exception
end if

astr_shrgift.xml_memdet		= lds_temp.describe( "Datawindow.Data.XML" )

// รายการหุ้นของขวัญ
lds_temp.dataobject	= "d_slproc_shrgift_adjust"
lds_temp.settransobject( itr_sqlca )
ll_count		= lds_temp.retrieve( ls_memno )

this.of_setoperateflag( lds_temp )

astr_shrgift.xml_shrgiftlist	= lds_temp.describe( "Datawindow.Data.XML" )

return 1
end function

public function integer of_save_shrgiftadjust (ref str_shrgift astr_shrgift) throws Exception;/***********************************************************
<description>
	สำหรับแก้ไขและยกเลิกรายการหุ้นของขวัญ
</description>

<arguments>  
	str_shrgift		Structure รายการหุ้นของขวัญ
		Attrib ภายใน Structure ที่ต้องใช้คือ
		- xml_shrgiftlist			String			XML รายการหุ้นของขวัญ
		- cancel_id				string			ผู้ทำรายการ
		- branch_id				string			สาขาที่ทำรายการ
		- cancel_date			datetme		วันที่ที่ยกเลิก
</arguments> 

<return> 
	Integer
	1		ถ้าไม่มีข้อผิดพลาด
</return> 

<usage> 
	เรียกใช้โดยส่งข้อมูลผ่าน Structure เข้ามาฟังก์ชั่นจะทำการบันทึกรายการแก้ไขรายการยกเลิกหุ้นของขวัญและผ่านรายการไปตัดยอดในทะเบียนหลักด้วย
	
	str_shrgift		lstr_shrgift
	
	lstr_shrgift.xml_shrgiftlist		= dw_master.describe( "Datawindow.Data.XML" )
	lstr_shrgift.cancel_id				= entry_id
	lstr_shrgift.branch_id				= branch_id
	lstr_shrgift.cancel_date			= workdate
	
	lnv_shrgift.of_save_shrgiftadjust( lstr_shrgift )
	----------------------------------------------------------------------
	Revision History:
	Version 1.0 (Initial version) Modified Date 11/10/2010 by OhhO

</usage> 
***********************************************************/

string		ls_memno, ls_xmlshrgift, ls_cancelid, ls_branchid
long		ll_index, ll_count
integer	li_giftyear, li_giftperiod, li_cancelflag, li_poststatus, li_shrgiftstatus
dec{2}	ldc_shrgiftval
dec{3}	ldc_shrgiftamt
datetime	ldtm_cancel
n_ds		lds_temp

ls_xmlshrgift	= astr_shrgift.xml_shrgiftlist
ls_cancelid		= astr_shrgift.cancel_id
ls_branchid		= astr_shrgift.branch_id
ldtm_cancel		= astr_shrgift.cancel_date

lds_temp		= create n_ds
lds_temp.dataobject	= "d_slproc_shrgift_adjust"
lds_temp.settransobject( itr_sqlca )

lds_temp.importstring( XML!, ls_xmlshrgift )

ll_count	= lds_temp.rowcount()

for ll_index = 1 to ll_count
	ls_memno		= lds_temp.getitemstring( ll_index, "member_no" )
	li_giftyear		= lds_temp.getitemnumber( ll_index, "shrgift_year" )
	li_giftperiod		= lds_temp.getitemnumber( ll_index, "shrgift_period" )
	li_cancelflag		= lds_temp.getitemnumber( ll_index, "operate_flag" )
	li_shrgiftstatus	= lds_temp.getitemnumber( ll_index, "shrgift_status" )
	li_poststatus		= lds_temp.getitemnumber( ll_index, "posting_status" )
	ldc_shrgiftval	= lds_temp.getitemdecimal( ll_index, "shrgift_value" )
	
	ldc_shrgiftamt	= ldc_shrgiftval / 10
	
	// ถ้าผ่านรายการไปแล้ว และไม่ได้ยกเลิกข้ามไปทำอันถัดไป
	if li_cancelflag = 0 and li_poststatus = 1 then
		continue
	end if
	
	if li_cancelflag = 1 and li_poststatus = 1 then
		
		// ถ้าสถานะหุ้นของขวัญเป็นปกติมาก่อนต้องคืนหุ้น
		if li_shrgiftstatus = 1 then
			// คืนหุ้นของขวัญ
			try
				this.of_save_shrgiftreturn( ls_memno, li_giftyear, li_giftperiod, ls_cancelid, ls_branchid, ldtm_cancel )
			catch( Exception lthw_error )
				rollback using itr_sqlca ;
				throw lthw_error
			end try
			
			update	shsharegift
			set			shrgift_status	= -99,
						cancel_id			= :ls_cancelid,
						cancel_date		= :ldtm_cancel
			where	( member_no	= :ls_memno ) and
						( shrgift_year	= :li_giftyear ) and
						( shrgift_period	= :li_giftperiod )
			using		itr_sqlca ;
		else
			continue
		end if
	elseif li_cancelflag = 1 and li_poststatus = 0 then
		update	shsharegift
		set			shrgift_status	= -9,
					cancel_id			= :ls_cancelid,
					cancel_date		= :ldtm_cancel
		where	( member_no	= :ls_memno ) and
					( shrgift_year	= :li_giftyear ) and
					( shrgift_period	= :li_giftperiod )
		using		itr_sqlca ;
	else
		update	shsharegift
		set			shrgift_status	= 1,
					shrgift_amt		= :ldc_shrgiftamt,
					shrgift_value	= :ldc_shrgiftval
		where	( member_no	= :ls_memno ) and
					( shrgift_year	= :li_giftyear ) and
					( shrgift_period	= :li_giftperiod )
		using		itr_sqlca ;
	end if
	
	if itr_sqlca.sqlcode <> 0 then
		ithw_exception.text	= "ไม่สามารถปรับปรุงรายการหุ้นของขวัญได้ กรุณาตรวจสอบ"+itr_sqlca.sqlerrtext
		rollback using itr_sqlca ;
		throw ithw_exception
	end if
next

// ถ้าไม่มี error
commit using itr_sqlca ;

// ดึงข้อมูลอีกครั้ง
ll_count	= lds_temp.retrieve( ls_memno )

// Set สถานะ
this.of_setoperateflag( lds_temp )

astr_shrgift.xml_shrgiftlist	= lds_temp.describe( "Datawindow.Data.XML" )

return 1
end function

public function integer of_setprogress (ref n_cst_progresscontrol anv_progress) throws Exception;anv_progress = inv_progress

return 1
end function

private function integer of_save_shrgiftreturn (string as_memno, integer ai_giftyear, integer ai_giftperiod, string as_returnid, string as_branchid, datetime adtm_returndate) throws Exception;string		ls_refperiod
integer	li_laststm, li_shrstatus, li_giftyear, li_giftperiod
dec{3}	ldc_shrstkamt, ldc_giftamt
datetime	ldtm_opedate, ldtm_docdate, ldtm_returndate

select		shrgift_amt, receipt_date
into		:ldc_giftamt, :ldtm_docdate
from		shsharegift
where	( member_no	= :as_memno ) and
			( shrgift_year	= :ai_giftyear ) and
			( shrgift_period	= :ai_giftperiod )
using		itr_sqlca ;

ldtm_opedate		= datetime( today(), now() )

select		sharestk_amt, last_stm_no, sharemaster_status
into		:ldc_shrstkamt, :li_laststm, :li_shrstatus
from		shsharemaster
where	( member_no 		= :as_memno ) and
			( sharetype_code	= '01' )
using		itr_sqlca ;

if isnull( ldc_shrstkamt ) then ldc_shrstkamt = 0
if isnull( li_laststm ) then li_laststm = 0

// ตรวจสอบสถานะหุ้นก่อนเรียกคืน
if li_shrstatus <> 8 and li_shrstatus <> 1 then
	ithw_exception.text	= "สถานะหุ้นของสมาชิก ทะเบียน "+as_memno+" เป็นสถานะที่ไม่สามารถเรียกคืนหุ้นของขวัญได้ ( สถานะ "+string( li_shrstatus )+" ) กรุณาตรวจสอบ"
	throw ithw_exception
end if

ls_refperiod		= string( ai_giftyear )+string( ai_giftperiod )
ldc_shrstkamt	= ldc_shrstkamt - ldc_giftamt
li_laststm		= li_laststm + 1

// บันทึกลง Statement ก่อน
insert into shsharestatement
			( member_no, sharetype_code, seq_no, operate_date, slip_date, ref_docno, shritemtype_code, period,
			  share_amount, sharestk_amt, entry_id, entry_date, coopbranch_id, moneytype_code, item_status )
values	( :as_memno, '01', :li_laststm, :adtm_returndate, :ldtm_docdate, :ls_refperiod, 'RGF', 0,
			  :ldc_giftamt, :ldc_shrstkamt, :as_returnid, :adtm_returndate, :as_branchid, 'TRN', -9 )
using		itr_sqlca ;
		  
if itr_sqlca.sqlcode <> 0 then
	ithw_exception.text	= "เรียกคืนหุ้นของขวัญ ไม่สามารถเพิ่มรายการเคลื่อนไหวหุ้นของสมาชิกได้ ทะเบียน "+as_memno+"~n"+itr_sqlca.sqlerrtext
	throw ithw_exception
end if

// ปรับปรุงสถานะรายการใน Statement
update	shsharestatement
set			item_status		= -9
where	( member_no			= :as_memno ) and
			( sharetype_code		= '01' ) and
			( shritemtype_code	= 'SGF' ) and
			( ref_docno				= :ls_refperiod )
using		itr_sqlca ;
if itr_sqlca.sqlcode <> 0 then
	ithw_exception.text	= "เรียกคืนหุ้นของขวัญ ไม่สามารถปรับปรุงสถานะยกเลิกในรายการเคลื่อนไหวหุ้นได้ ทะเบียน "+as_memno+"~n"+itr_sqlca.sqlerrtext
	throw ithw_exception
end if
		
// ปรับปรุงแฟ้มหลัก ShareMaster
update	shsharemaster
set			sharestk_amt		= :ldc_shrstkamt,
			last_stm_no			= :li_laststm
where	( member_no		= :as_memno ) and
			( sharetype_code	= '01' )
using		itr_sqlca ;
if itr_sqlca.sqlcode <> 0 then
	ithw_exception.text	= "เรียกคืนหุ้นของขวัญ ไม่สามารถปรับปรุงรายการทุนเรือนหุ้นของสมาชิกได้ ทะเบียน "+trim( as_memno )+"~n"+itr_sqlca.sqlerrtext
	throw ithw_exception
end if

return 1
end function

public function integer of_setoperateflag (ref n_ds ads_shrgift);integer		li_status
long			ll_index, ll_count

ll_count		= ads_shrgift.rowcount()

for ll_index = 1 to ll_count
	li_status		= ads_shrgift.getitemnumber( ll_index, "shrgift_status" )
	
	if li_status = 1 then
		ads_shrgift.object.operate_flag[ ll_index ]	= 0
	else
		ads_shrgift.object.operate_flag[ ll_index ]	= 1
	end if
next

return 1
end function

on n_cst_shproc_shrgift.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_shproc_shrgift.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ithw_exception = create Exception
end event

