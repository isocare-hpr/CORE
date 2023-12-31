$PBExportHeader$n_cst_membsrv_audit.sru
forward
global type n_cst_membsrv_audit from nonvisualobject
end type
end forward

global type n_cst_membsrv_audit from nonvisualobject
end type
global n_cst_membsrv_audit n_cst_membsrv_audit

type variables
Public:
// - Common return value constants:
constant integer 		SUCCESS = 1
constant integer 		FAILURE = -1
constant integer 		NO_ACTION = 0

// - Continue/Prevent return value constants:
constant integer 		CONTINUE_ACTION = 1
constant integer 		PREVENT_ACTION = 0

constant int STATUS_PENDING		= 8	// รออนุมัติ (สารพัด)
constant int STATUS_APPROVE		= 1	// อนุมัติ 
constant int STATUS_CLOSE		= -1 	// สถานะปิด
constant int STATUS_CANCEL		= -9 	// สถานะปิด



constant	integer	TYPE_STOP 		= 1
constant	integer	TYPE_CONTINUE	= 2
constant	integer	TYPE_INCREASE	= 3
constant	integer	 TYPE_DECREASE	= 4

string		is_coopcontrol, is_coopid

transaction		itr_sqlca
Exception		ithw_exception

n_cst_dbconnectservice		inv_transection
n_cst_dwxmlieservice			inv_dwxmliesrv
n_cst_progresscontrol		inv_progress
end variables

forward prototypes
public function integer of_initservice (n_cst_dbconnectservice atr_dbtrans) throws Exception
public function integer of_saverequest (ref str_adjust_mbinfo astr_mbinfo) throws Exception
public function integer of_getsharebase (decimal adc_salary, ref decimal adc_minshare, ref decimal adc_maxshare)
private function integer of_setsrvdwxmlie (boolean ab_switch)
public function integer of_initrequest (ref str_adjust_mbinfo astr_mbinfo) throws Exception
private function integer of_updatedwdata (n_ds ads_newinfo, string as_coopid, string as_memno) throws Exception
private function integer of_setpausekeepdown (string as_coopid, string as_memno, datetime adtm_opedate) throws Exception
public function integer of_setcontstatusdesc (string as_coopid, string as_memno) throws Exception
public function integer of_init_mbaudit (ref str_mbaudit astr_mbinfo) throws Exception
public function integer of_save_mbaudit (ref str_mbaudit astr_mbinfo) throws Exception
public function integer of_post_mbupdate_memno_impfile (string as_xmlmaincri, ref string as_xmldata, string as_xmlcollumn, datetime adtm_entry, string as_entryid)
private function string of_xmlexport (n_ds ads_info)
public function integer of_xmlimport (ref n_ds ads_info, string as_dwobjname, string as_xmlinfo)
public function integer of_importfile_to_datawindow (ref string as_xmldata, string as_pathfile) throws Exception
public function string of_getmemberno_fromfullname2 (string as_firstname, string as_lastname)
public function string of_getmemberno_fromfullname (string as_fullname)
public function integer of_set_mbupdate_memno_impfile (string as_xmlmaincri, ref string as_xmldata, string as_collumlist) throws Exception
private function integer of_setdsmodify (ref n_ds ads_requester, long al_row, boolean ab_keymodify)
public function integer of_save_sal (ref str_mbaudit astr_mbaudit) throws Exception
public function integer of_init_sal (ref str_mbaudit astr_mbaudit) throws Exception
public function integer of_setprogress (ref n_cst_progresscontrol anv_progress) throws Exception
end prototypes

public function integer of_initservice (n_cst_dbconnectservice atr_dbtrans) throws Exception;/***********************************************************
<description>
	ใช้สำหรับ Intial service
</description>

<arguments>  
	atr_dbtrans			n_cst_dbconnectservice	รายละเอียดการเชื่อมต่อฐานข้อมูล
</arguments> 

<return> 
	1						Integer	ถ้าไม่มีข้อผิดพลาด
</return> 

<usage> 
	เรียกใช้ครั้งเดียว และต้องเรียกใช้เป็นฟังก์ชั่นแรกหลังจาก create instance
	ก่อนที่จะเรียกใช้ฟังก์ชั่นอื่น ๆ
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 28/9/2010 by MiT
</usage> 
***********************************************************/

// Service Transection
if isnull( inv_transection ) or not isvalid( inv_transection ) then
	inv_transection	= create n_cst_dbconnectservice
end if

inv_transection	= atr_dbtrans
itr_sqlca 			= inv_transection.itr_dbconnection

inv_progress = create n_cst_progresscontrol

is_coopid			= inv_transection.is_coopid
is_coopcontrol	= inv_transection.is_coopcontrol

return 1
end function

public function integer of_saverequest (ref str_adjust_mbinfo astr_mbinfo) throws Exception;/***********************************************************
<description>
	บันทึกคำขอเปลี่ยนแปลงข้อมูลสมาชิก
</description>

</description>

<arguments>  
	astr_mbinfo			str_adjust_mbinfo		Structure ข้อมูลที่เปลี่ยนแปลง
</arguments> 

<return> 
	Integer				1 = success, Exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 19/10/2010 by MiT
</usage> 
	
***********************************************************/
string		ls_memno, ls_xmlmaster, ls_xmlmbdet, ls_xmlmbstatus, ls_xmlmoneytr, ls_xmlremarkstat
string		ls_xmlbfmaster, ls_xmlbfmbdet, ls_xmlbfmbstatus, ls_xmlbfmoneytr, ls_xmlbfremarkstat
integer	li_bfpauseflag, li_pauseflag
datetime	ldtm_opedate
string		ls_coopid
n_ds		lds_mbmaster, lds_mbdet, lds_mbstatus, lds_moneytr, lds_remarkstat, lds_bfmbstatus

ldtm_opedate		= astr_mbinfo.operate_date

// ค่าที่เปลี่ยนแปลงแล้ว
ls_xmlmaster		= astr_mbinfo.xmlmaster
ls_xmlmbdet		= astr_mbinfo.xmldetail
ls_xmlmbstatus		= astr_mbinfo.xmlstatus
ls_xmlmoneytr		= astr_mbinfo.xmlmoneytr
ls_xmlremarkstat	= astr_mbinfo.xmlremarkstat 

// ค่าก่อนเปลี่ยนแปลง
ls_xmlbfmaster			= astr_mbinfo.xmlbfmaster
ls_xmlbfmbdet			= astr_mbinfo.xmlbfdetail
ls_xmlbfmbstatus		= astr_mbinfo.xmlbfstatus
ls_xmlbfmoneytr		= astr_mbinfo.xmlbfmoneytr
ls_xmlbfremarkstat	= astr_mbinfo.xmlbfremarkstat 

// import เข้ามาใน datastore
lds_mbmaster	= create n_ds
lds_mbmaster.dataobject	= "d_mb_adjust_master"
lds_mbmaster.settransobject( itr_sqlca )

lds_mbdet	= create n_ds
lds_mbdet.dataobject	= "d_mb_adjust_mbdetail"
lds_mbdet.settransobject( itr_sqlca )

lds_mbstatus	= create n_ds
lds_mbstatus.dataobject	= "d_mb_adjust_status"
lds_mbstatus.settransobject( itr_sqlca )

lds_moneytr	= create n_ds
lds_moneytr.dataobject	= "d_mb_adjust_moneytr"
lds_moneytr.settransobject( itr_sqlca )

lds_remarkstat	= create n_ds
lds_remarkstat.dataobject	= "d_mb_adjust_remarkstat"
lds_remarkstat.settransobject( itr_sqlca )

lds_bfmbstatus	= create n_ds
lds_bfmbstatus.dataobject	= "d_mb_adjust_status"
lds_bfmbstatus.settransobject( itr_sqlca )

inv_dwxmliesrv.of_xmlimport( lds_mbmaster, ls_xmlmaster )
inv_dwxmliesrv.of_xmlimport( lds_mbdet, ls_xmlmbdet )
inv_dwxmliesrv.of_xmlimport( lds_mbstatus, ls_xmlmbstatus )
inv_dwxmliesrv.of_xmlimport( lds_moneytr, ls_xmlmoneytr )
inv_dwxmliesrv.of_xmlimport( lds_remarkstat, ls_xmlremarkstat )

inv_dwxmliesrv.of_xmlimport( lds_bfmbstatus, ls_xmlbfmbstatus )

ls_coopid			= lds_mbmaster.getitemstring(1,"coop_id")
ls_memno		= lds_mbmaster.getitemstring( 1, "member_no" )

// --------------------------------------------
// เริ่มทำการบันทึกข้อมูล
// --------------------------------------------

// ทำการบันทึกข้อมูลส่วน MbMaster
try
	this.of_updatedwdata( lds_mbmaster, ls_coopid,ls_memno )
	this.of_updatedwdata( lds_mbdet, ls_coopid,ls_memno )
	this.of_updatedwdata( lds_mbstatus, ls_coopid,ls_memno )
catch( Exception lthw_error )
	rollback using itr_sqlca ;
	throw lthw_error
end try

// ข้อมูลการรับจ่าย  ลบข้อมูลก่อนแล้วค่อยบันทึก
delete from mbmembmoneytr
where	( member_no = :ls_memno and coop_id =:ls_coopid )
using		itr_sqlca ;

if lds_moneytr.rowcount() > 0 then
	if lds_moneytr.update() = -1 then
		ithw_exception.text = "ไม่สามารถปรับปรุงรายละเอียดการรับจ่ายเงิน " + lds_moneytr.of_geterrormessage()
		rollback using itr_sqlca ;
		throw ithw_exception
	end if
end if

// หมายเหตุสถานะ ลบข้อมูลก่อนแล้วค่อยบันทึก
delete from	mbmembremarkstat
where	( member_no = :ls_memno and coop_id =:ls_coopid )
using		itr_sqlca ;

lds_remarkstat.setfilter( "operate_flag = 0" )
lds_remarkstat.filter()

if lds_remarkstat.rowcount() > 0 then
	lds_remarkstat.rowsdiscard( 1, lds_remarkstat.rowcount(), primary! )
end if

lds_remarkstat.setfilter( "" )
lds_remarkstat.filter()

if lds_remarkstat.rowcount() > 0 then
	if lds_remarkstat.update() = -1 then
		ithw_exception.text = "ไม่สามารถปรับปรุงหมายเหตุสถานะได้ " + lds_remarkstat.of_geterrormessage()
		rollback using itr_sqlca ;
		throw ithw_exception
	end if
end if

// ปรับปรุงสถานะการหยุดออกเรียกเก็บ
li_bfpauseflag	= lds_bfmbstatus.getitemnumber( 1, "pausekeep_flag" )
li_pauseflag		= lds_mbstatus.getitemnumber( 1, "pausekeep_flag" )

if li_bfpauseflag <> li_pauseflag then
	this.of_setpausekeepdown(ls_coopid, ls_memno, ldtm_opedate )
end if
	
// บันทึก log
n_cst_audit	lnv_log
string		ls_docno, ls_xmlbf, ls_xmlaf, ls_userid, ls_appname

ls_userid		= astr_mbinfo.userid
ls_appname = astr_mbinfo.appname 

lnv_log = create n_cst_audit
lnv_log.of_settransobject( itr_sqlca )

lnv_log.of_save( ls_coopid,ls_xmlbfmaster, ls_xmlmaster, "mbmembmaster", "member_no", "เลขสมาชิก", ls_memno, ls_userid, ls_appname )
lnv_log.of_save( ls_coopid,ls_xmlbfmbdet, ls_xmlmbdet, "mbmembmaster", "member_no", "เลขสมาชิก", ls_memno, ls_userid, ls_appname )
lnv_log.of_save( ls_coopid,ls_xmlbfmbstatus, ls_xmlmbstatus, "mbmembmaster", "member_no", "เลขสมาชิก", ls_memno, ls_userid, ls_appname )
lnv_log.of_save( ls_coopid,ls_xmlbfmoneytr, ls_xmlmoneytr, "mbmembmoneytr", "member_no, trtype_code", "เลขสมาชิก, รหัสการโอน", ls_memno, ls_userid, ls_appname )
lnv_log.of_save( ls_coopid,ls_xmlbfremarkstat, ls_xmlremarkstat, "mbmembremarkstat", "member_no, remarkstattype_code", "เลขสมาชิก, รหัสหมายเหตุสถานะ", ls_memno, ls_userid, ls_appname )

commit using itr_sqlca ;

destroy	lds_mbmaster
destroy	lds_mbdet
destroy	lds_mbstatus
destroy	lds_moneytr
destroy	lds_remarkstat

return 1
end function

public function integer of_getsharebase (decimal adc_salary, ref decimal adc_minshare, ref decimal adc_maxshare);/***********************************************************
<description>
	ดึงข้อมูลสมาชิก
</description>

</description>

<arguments>  
	adc_salary			decimal		เงินเดือน
	adc_minshare		decimal		หุ้นฐานขั้่นต่ำ
	adc_minshare		decimal		หุ้นฐานขั้นสูง	
</arguments> 

<return> 
	Integer				1 = success, Exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 14/12/2010 by MiT
</usage> 
	
***********************************************************/

dec{2} ldc_unitshare

select a.sharemonth_amt, a.maxsharemonth_amt, b.share_value
into	:adc_minshare, :adc_maxshare, :ldc_unitshare
from 	shsharetypemthrate a, shsharetype b
where ( a.sharetype_code = '01' ) and 
		 ( a.sharetype_code = b.sharetype_code ) and  
		  (( :adc_salary >= a.start_salary ) and ( :adc_salary < a.end_salary ))

using itr_sqlca ;

adc_minshare = adc_minshare * ldc_unitshare
adc_maxshare = adc_maxshare * ldc_unitshare

return 1
end function

private function integer of_setsrvdwxmlie (boolean ab_switch);// Check argument
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

public function integer of_initrequest (ref str_adjust_mbinfo astr_mbinfo) throws Exception;/***********************************************************
<description>
	ดึงข้อมูลสมาชิก
</description>

</description>

<arguments>  
	astr_mbinfo			str_adjust_mbinfo		Structure ข้อมูลที่เปลี่ยนแปลง
</arguments> 

<return> 
	Integer				1 = success, Exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 19/10/2010 by MiT
</usage> 
	
***********************************************************/

long		ll_rowcount, ll_listcount, ll_index, ll_row
string		ls_memno, ls_statcode,ls_coopid
string		ls_xmlmaster, ls_xmlmbdet, ls_xmlmbstatus, ls_xmlmoneytr, ls_xmlremarkstat
n_ds		lds_mbmaster, lds_mbdet, lds_mbstatus, lds_moneytr, lds_remarkstat, lds_remarklist

ls_coopid	  = astr_mbinfo.coop_id
ls_memno = astr_mbinfo.member_no

lds_mbmaster = create n_ds
lds_mbmaster.dataobject = "d_mb_adjust_master"
lds_mbmaster.settransobject( itr_sqlca )
ll_rowcount = lds_mbmaster.retrieve( ls_coopid,ls_memno )

lds_mbdet = create n_ds
lds_mbdet.dataobject = "d_mb_adjust_mbdetail"
lds_mbdet.settransobject( itr_sqlca )
ll_rowcount = lds_mbdet.retrieve( ls_coopid,ls_memno )

lds_mbstatus = create n_ds
lds_mbstatus.dataobject = "d_mb_adjust_status"
lds_mbstatus.settransobject( itr_sqlca )
ll_rowcount = lds_mbstatus.retrieve( ls_coopid,ls_memno )

lds_moneytr = create n_ds
lds_moneytr.dataobject = "d_mb_adjust_moneytr"
lds_moneytr.settransobject( itr_sqlca )
ll_rowcount = lds_moneytr.retrieve( ls_coopid,ls_memno )

lds_remarkstat = create n_ds
lds_remarkstat.dataobject = "d_mb_adjust_remarkstat"
lds_remarkstat.settransobject( itr_sqlca )
ll_rowcount = lds_remarkstat.retrieve( ls_coopid,ls_memno )

lds_remarklist	= create n_ds
lds_remarklist.dataobject = "d_mb_adjust_remarkstatlist"
lds_remarklist.settransobject( itr_sqlca )
ll_listcount	= lds_remarklist.retrieve()

if ll_listcount > 0 and ll_rowcount > 0 then
	for ll_index = 1 to ll_rowcount
		ls_statcode	= lds_remarkstat.getitemstring( ll_index, "remarkstattype_code" )
		
		ll_row		= lds_remarklist.find( "remarkstattype_code = '"+ls_statcode+"'", 1, lds_remarklist.rowcount() )
		if ll_row > 0 then
			lds_remarklist.deleterow( ll_row )
		end if
	next
end if

for ll_index = 1 to lds_remarklist.rowcount()
	ll_row		= lds_remarkstat.insertrow( 0 )
	
	lds_remarkstat.object.operate_flag[ ll_row ]			= 0
	lds_remarkstat.object.member_no[ ll_row ]				= ls_memno
	lds_remarkstat.object.remarkstattype_code[ ll_row ]	= lds_remarklist.object.remarkstattype_code[ ll_index ]
	lds_remarkstat.object.remarkstattype_desc[ ll_row ]	= lds_remarklist.object.remarkstattype_desc[ ll_index ]
next

if lds_remarkstat.rowcount() > 0 then
	lds_remarkstat.setsort( "remarkstattype_code asc" )
	lds_remarkstat.sort()
end if

ls_xmlmaster		= inv_dwxmliesrv.of_xmlexport( lds_mbmaster )
ls_xmlmbdet		= inv_dwxmliesrv.of_xmlexport( lds_mbdet )
ls_xmlmbstatus		= inv_dwxmliesrv.of_xmlexport( lds_mbstatus )
ls_xmlmoneytr		= inv_dwxmliesrv.of_xmlexport( lds_moneytr )
ls_xmlremarkstat	= inv_dwxmliesrv.of_xmlexport( lds_remarkstat )

// ส่งค่ากลับ
astr_mbinfo.xmlmaster		= ls_xmlmaster
astr_mbinfo.xmldetail			= ls_xmlmbdet
astr_mbinfo.xmlstatus		= ls_xmlmbstatus
astr_mbinfo.xmlmoneytr		= ls_xmlmoneytr
astr_mbinfo.xmlremarkstat	= ls_xmlremarkstat

destroy	lds_mbmaster
destroy	lds_mbdet
destroy	lds_mbstatus
destroy	lds_moneytr
destroy	lds_remarkstat
destroy	lds_remarklist

return 1
end function

private function integer of_updatedwdata (n_ds ads_newinfo, string as_coopid, string as_memno) throws Exception;/***********************************************************
<description>
	บันทึก data store
</description>

</description>

<arguments>  
	ads_newinfo		n_ds		ข้อมูลที่เปลี่ยนแปลง
</arguments> 

<return> 
	Integer				1 = success, Exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 19/10/2010 by MiT
</usage> 
	
***********************************************************/
string		ls_memno, ls_dwobject
long		ll_rowcount
integer	li_colcount
n_ds		lds_data

ls_dwobject		= ads_newinfo.dataobject

lds_data = create n_ds
lds_data.dataobject = ls_dwobject
lds_data.settransobject( itr_sqlca )
lds_data.retrieve( as_coopid,as_memno )

if ads_newinfo.rowcount() > 0 then
	li_colcount = integer( ads_newinfo.object.datawindow.column.count )
	
	lds_data.object.data[ 1 , 1, lds_data.rowcount(), li_colcount ] = ads_newinfo.object.data[ 1, 1 , ads_newinfo.rowcount(), li_colcount  ]
	
	if lds_data.update() <> 1 then
		ithw_exception.text += ls_dwobject+" - "+lds_data.of_geterrormessage()
		throw ithw_exception
	end if
end if

destroy lds_data

return 1
end function

private function integer of_setpausekeepdown (string as_coopid, string as_memno, datetime adtm_opedate) throws Exception;integer	li_payshrstatus, li_cntlon, li_cntlonpay, li_pausekeep, li_paystatus

// สถานะการหยุดออกเก็บ
select		pausekeep_flag
into		:li_pausekeep
from		mbmembmaster
where	( member_no	= :as_memno and coop_id =:as_coopid)
using		itr_sqlca ;

choose case li_pausekeep
	case 0	// เก็บทุกอย่างปกติ
		update	shsharemaster
		set			payment_status	= 1
		where	( member_no	= :as_memno and coop_id =:as_coopid)
		using		itr_sqlca ;
	
		if itr_sqlca.sqlcode <> 0 then
			ithw_exception.text	= "ไม่สามารถปรับปรุงสถานะการส่งหุ้นรายเดือนให้เป็นปกติได้ "+itr_sqlca.sqlerrtext
			throw ithw_exception
		end if
		
		update	lncontmaster
		set			payment_status	= 1
		where	( member_no	= :as_memno  and coop_id =:as_coopid ) and
					( contract_status	> 0 )
		using		itr_sqlca ;
	
		if itr_sqlca.sqlcode <> 0 then
			ithw_exception.text	= "ไม่สามารถปรับปรุงสถานะการส่งชำระหนี้ให้เป็นปกติได้ "+itr_sqlca.sqlerrtext
			throw ithw_exception
		end if
		
	case 1	// งดเก็บทุกอย่าง
		update	mbmembmaster
		set			pausekeep_date	= :adtm_opedate
		where	( member_no	= :as_memno  and coop_id =:as_coopid)
		using		itr_sqlca ;
		
		if itr_sqlca.sqlcode <> 0 then
			ithw_exception.text	= "ไม่สามารถปรับปรุงวันที่ขอหยุดเก็บของสมาชิกได้ "+itr_sqlca.sqlerrtext
			throw ithw_exception
		end if
		
		// ปรับปรุงสถานะให้เป็นหยุดเฉพาะกรณีที่เป็นส่งปกติเท่านั้น
		update	shsharemaster
		set			payment_status	= -1,
					paymentstop_date	= :adtm_opedate
		where	( member_no	= :as_memno  and coop_id =:as_coopid) and
					( payment_status	= 1 )
		using		itr_sqlca ;
	
		if itr_sqlca.sqlcode <> 0 then
			ithw_exception.text	= "ไม่สามารถปรับปรุงสถานะการหยุดส่งหุ้นได้ "+itr_sqlca.sqlerrtext
			throw ithw_exception
		end if
		
		// ปรับปรุงสถานะให้เป็นหยุดเฉพาะกรณีที่เป็นส่งปกติเท่านั้น
		update	lncontmaster
		set			payment_status			= -1,
					loanpaymentchg_date		= :adtm_opedate
		where	( member_no	= :as_memno ) and
					( payment_status	= 1 and coop_id =:as_coopid) and
					( contract_status > 0 )
		using		itr_sqlca ;
		
		if itr_sqlca.sqlcode <> 0 then
			ithw_exception.text	= "ไม่สามารถปรับปรุงสถานะการหยุดชำระหนี้ได้ "+itr_sqlca.sqlerrtext
			throw ithw_exception
		end if
		
	case 2	// งดเก็บเฉพาะหุ้น
		update	mbmembmaster
		set			pausekeep_date	= :adtm_opedate
		where	( member_no	= :as_memno and coop_id =:as_coopid)
		using		itr_sqlca ;
		
		if itr_sqlca.sqlcode <> 0 then
			ithw_exception.text	= "ไม่สามารถปรับปรุงวันที่ขอหยุดเก็บของสมาชิกได้ "+itr_sqlca.sqlerrtext
			throw ithw_exception
		end if
		
		// ปรับปรุงสถานะให้เป็นหยุดเฉพาะกรณีที่เป็นส่งปกติเท่านั้น
		update	shsharemaster
		set			payment_status	= -1,
					paymentstop_date	= :adtm_opedate
		where	( member_no	= :as_memno and coop_id =:as_coopid ) and
					( payment_status	= 1 )
		using		itr_sqlca ;
	
		if itr_sqlca.sqlcode <> 0 then
			ithw_exception.text	= "ไม่สามารถปรับปรุงสถานะการหยุดส่งหุ้นได้ "+itr_sqlca.sqlerrtext
			throw ithw_exception
		end if
		
		// สถานะของหนี้ปรับให้เป็นเก็บปกติ
		update	lncontmaster
		set			payment_status	= 1
		where	( member_no	= :as_memno and coop_id =:as_coopid) and
					( contract_status	> 0 )
		using		itr_sqlca ;
	
		if itr_sqlca.sqlcode <> 0 then
			ithw_exception.text	= "ไม่สามารถปรับปรุงสถานะการส่งชำระหนี้ให้เป็นปกติได้ "+itr_sqlca.sqlerrtext
			throw ithw_exception
		end if
		
	case 3	// งดเก็บเฉพาะหนี้
		update	mbmembmaster
		set			pausekeep_date	= :adtm_opedate
		where	( member_no	= :as_memno and coop_id =:as_coopid)
		using		itr_sqlca ;
		
		if itr_sqlca.sqlcode <> 0 then
			ithw_exception.text	= "ไม่สามารถปรับปรุงวันที่ขอหยุดเก็บของสมาชิกได้ "+itr_sqlca.sqlerrtext
			throw ithw_exception
		end if
		
		// หุ้นปรับให้เป็นส่งปกติ
		update	shsharemaster
		set			payment_status	= 1
		where	( member_no	= :as_memno and coop_id =:as_coopid)
		using		itr_sqlca ;
	
		if itr_sqlca.sqlcode <> 0 then
			ithw_exception.text	= "ไม่สามารถปรับปรุงสถานะการส่งหุ้นรายเดือนให้เป็นปกติได้ "+itr_sqlca.sqlerrtext
			throw ithw_exception
		end if
		
		// ปรับปรุงสถานะให้เป็นหยุดเฉพาะกรณีที่เป็นส่งปกติเท่านั้น
		update	lncontmaster
		set			payment_status			= -1,
					loanpaymentchg_date		= :adtm_opedate
		where	( member_no	= :as_memno and coop_id =:as_coopid ) and
					( payment_status	= 1 ) and
					( contract_status > 0 )
		using		itr_sqlca ;
		
		if itr_sqlca.sqlcode <> 0 then
			ithw_exception.text	= "ไม่สามารถปรับปรุงสถานะการหยุดชำระหนี้ได้ "+itr_sqlca.sqlerrtext
			throw ithw_exception
		end if
end choose

this.of_setcontstatusdesc( as_coopid,as_memno )

return 1
end function

public function integer of_setcontstatusdesc (string as_coopid, string as_memno) throws Exception;string		ls_statusdesc, ls_contno
integer	li_insurecollflag, li_paystatus, li_contlaw, li_trnstatus

declare data_cur cursor for
select		loancontract_no, insurecoll_flag, payment_status, contlaw_status, transfer_status
from		lncontmaster
where	( member_no		= :as_memno and coop_id =:as_coopid ) and
			( contract_status	> 0 )
using		itr_sqlca ;

open data_cur ;

fetch data_cur into :ls_contno, :li_insurecollflag, :li_paystatus, :li_contlaw, :li_trnstatus ;

do while itr_sqlca.sqlcode = 0
	
	ls_statusdesc	= ""
	
	if li_insurecollflag = 1 then
		ls_statusdesc	= ls_statusdesc + "I"
	end if
	
	if li_paystatus < 0 then
		ls_statusdesc	= ls_statusdesc + "S"
	end if
	
	if li_trnstatus = 1 then
		ls_statusdesc	= ls_statusdesc + "R"
	end if
	
	if li_contlaw = 3 then
		ls_statusdesc	= ls_statusdesc + "C"
	elseif li_contlaw = 4 then
		ls_statusdesc	= ls_statusdesc + "J"
	end if
	
	update	lncontmaster
	set			status_desc	= :ls_statusdesc
	where	( loancontract_no	= :ls_contno  and coop_id =:as_coopid)
	using		itr_sqlca ;
	
	if itr_sqlca.sqlcode <> 0 then
		ithw_exception.text	= "Generate สถานะสัญญา - ไม่สามารถปรับปรุงสถานะสัญญาได้ เลขที่สัญญา "+ls_contno+"  "+itr_sqlca.sqlerrtext
		throw ithw_exception
	end if
	
	fetch data_cur into :ls_contno, :li_insurecollflag, :li_paystatus, :li_contlaw, :li_trnstatus ;
loop

close data_cur ;

return 1
end function

public function integer of_init_mbaudit (ref str_mbaudit astr_mbinfo) throws Exception;/***********************************************************
<description>
	ดึงข้อมูลสมาชิก
</description>

</description>

<arguments>  
	astr_mbinfo			str_adjust_mbinfo		Structure ข้อมูลที่เปลี่ยนแปลง
</arguments> 

<return> 
	Integer				1 = success, Exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 19/10/2010 by MiT
</usage> 
	
***********************************************************/

string		ls_memno, ls_statcode, ls_coopid
string		ls_xmlmaster
boolean	lb_err = false

n_ds		lds_mbmaster , lds_moneytr

this.of_setsrvdwxmlie( true )

ls_memno		= astr_mbinfo.member_no

lds_mbmaster = create n_ds
lds_mbmaster.dataobject = "d_mb_audit_membmaster"
lds_mbmaster.settransobject( itr_sqlca )
lds_mbmaster.retrieve( is_coopcontrol,ls_memno )

lds_moneytr = create n_ds
lds_moneytr.dataobject = "d_mb_audit_membmoneytr"
lds_moneytr.settransobject( itr_sqlca )
lds_moneytr.retrieve( is_coopcontrol,ls_memno )

if lds_mbmaster.rowcount() <= 0 then
	ithw_exception.text	= "ไม่สามารถดึงข้อมูลสมาชิกเลขที่ "+ls_memno+" ได้ กรุณาตรวจสอบ"
	lb_err = true;Goto objdestroy
end if

lds_moneytr.retrieve( is_coopcontrol,ls_memno )

// ส่งค่ากลับ
astr_mbinfo.xmlmaster			= inv_dwxmliesrv.of_xmlexport( lds_mbmaster )
astr_mbinfo.xmlmoneytr			= inv_dwxmliesrv.of_xmlexport( lds_moneytr )

objdestroy:
if isvalid(lds_mbmaster) then destroy lds_mbmaster
if isvalid(lds_moneytr) then destroy lds_moneytr

this.of_setsrvdwxmlie( false )

if lb_err then
	ithw_exception.text = "n_cst_membsrv_allrequest.of_init_mbaudit()" + ithw_exception.text
	throw ithw_exception
end if

return 1
end function

public function integer of_save_mbaudit (ref str_mbaudit astr_mbinfo) throws Exception;/***********************************************************
<description>
	บันทึกคำขอเปลี่ยนแปลงข้อมูลสมาชิก
</description>

</description>

<arguments>  
	astr_mbinfo			str_adjust_mbinfo		Structure ข้อมูลที่เปลี่ยนแปลง
</arguments> 

<return> 
	Integer				1 = success, Exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 19/10/2010 by MiT
</usage> 
	
***********************************************************/
string		ls_lastdoc , ls_memno
string 	ls_trtype , ls_moneytype , ls_bank , ls_bankbranch , ls_bankaccid , ls_moneydesc
string		ls_trtypenw , ls_moneytypenw , ls_banknw , ls_bankbranchnw , ls_bankaccidnw
string		ls_old , ls_new
integer 	li_index , li_count , li_seq
integer li_find , li_cnt
boolean	lb_err = false , lb_chkmtr = false , lb_chg
n_ds		lds_mbmaster , lds_moneytr

// import เข้ามาใน datastore
lds_mbmaster	= create n_ds
lds_mbmaster.dataobject	= "d_mb_audit_membmaster"
lds_mbmaster.settransobject( itr_sqlca )

lds_moneytr = create n_ds
lds_moneytr.dataobject = "d_mb_audit_membmoneytr"
lds_moneytr.settransobject( itr_sqlca )

this.of_setsrvdwxmlie( true )

if not isnull( astr_mbinfo.xmlmoneytr ) or len( astr_mbinfo.xmlmoneytr ) > 0 then lb_chkmtr = true

try
	inv_dwxmliesrv.of_xmlimport( lds_mbmaster, astr_mbinfo.xmlmaster )
	if lb_chkmtr then inv_dwxmliesrv.of_xmlimport( lds_moneytr, astr_mbinfo.xmlmoneytr )
catch( Exception lthw_impxml )
	lb_err = true
end try
if lb_err then Goto objdestroy

ls_memno		= lds_mbmaster.getitemstring( 1, "member_no" )

/*
Gen Document
*/
SELECT TO_CHAR( TO_NUMBER( NVL( MAX( MODTBDOC_NO ) , 0 ) ) + 1 , 'FM000000000000000' ) AS DOCNO
INTO :ls_lastdoc
FROM SYS_LOGMODTB
WHERE COOP_ID = :is_coopcontrol
using itr_sqlca
;

lds_mbmaster.object.update_bylastdoc[1]	= ls_lastdoc

// --------------------------------------------
// เริ่มทำการบันทึกข้อมูล
// --------------------------------------------
/*
เปิดสถานะการอัพเดท

update mbmembmaster
set update_flag = 1
where coop_id = :is_coopcontrol
and member_no = :ls_memno
using itr_sqlca;
*/
// ทำการบันทึกข้อมูลส่วน MbMaster
try
	this.of_updatedwdata( lds_mbmaster,is_coopcontrol, ls_memno )
//	if lb_chkmtr then this.of_updatedwdata( lds_moneytr,is_coopcontrol, ls_memno )
catch( Exception lthw_error )
	ithw_exception.text	= lthw_error.text
	lb_err = true
end try

/*
ปิดสถานะการอัพเดท

update mbmembmaster
set update_flag = 0
where coop_id = :is_coopcontrol
and member_no = :ls_memno
using itr_sqlca;
*/
/*
ผ่านรายการ moneytr
*/

SELECT NVL( MAX( SEQ_NO ) , 0 )
into :li_seq
FROM SYS_LOGMODTBDET
WHERE COOP_ID = :is_coopcontrol
AND MODTBDOC_NO = :ls_lastdoc
using itr_sqlca;

declare lcs_mtr cursor for
select nvl( mt.trtype_code , '' ) as trtype_code , nvl( mt.moneytype_code , '' ) as moneytype_code , nvl( mt.bank_code , '' ) as bank_code , nvl( mt.bank_branch , '' ) as bank_branch , nvl( mt.bank_accid , '' ) as bank_accid , nvl( ct.moneytype_desc , '' ) as moneytype_desc
from mbmembmoneytr mt , cmucfmoneytype ct
where mt.moneytype_code = ct.moneytype_code(+)
and mt.coop_id = :is_coopcontrol
and mt.member_no = :ls_memno
using itr_sqlca;
open lcs_mtr ;
	fetch lcs_mtr into :ls_trtype , :ls_moneytype , :ls_bank , :ls_bankbranch , :ls_bankaccid , :ls_moneydesc ;
	do while itr_sqlca.sqlcode = 0

		li_find		= lds_moneytr.Find( " coop_id = '" + is_coopcontrol + "' and member_no = '" + ls_memno + "' and trtype_code = '" + ls_trtype + "'" , 1 , lds_moneytr.rowcount() )
		
		ls_old		= ls_moneytype + " " + ls_moneydesc
		if len( ls_bank ) > 0 then ls_old += " ธนาคาร " + ls_bank
		if len( ls_bankbranch ) > 0 then ls_old += " สาขา " + ls_bankbranch
		if len( ls_bankaccid ) > 0 then ls_old += " บัญชี " + ls_bankaccid
		
		if li_find = 0 then
			/*Delete*/
			
			li_seq++
			insert into sys_logmodtbdet
			( coop_id , modtbdoc_no , seq_no , clm_name , clmold_desc , clmnew_desc , clmtype_desc )
			values
			( :is_coopcontrol , :ls_lastdoc , :li_seq , :ls_trtype , :ls_old , '' , 'DELETE' )
			using itr_sqlca;
			if itr_sqlca.sqlcode <> 0 then
				ithw_exception.text = "พบข้อผิดพลาด ไม่สารมารถทำรายการได้ (70.01)"
				ithw_exception.text += string( itr_sqlca.sqlcode ) + " : " + itr_sqlca.sqlerrtext
				lb_err = true ; if lb_err then Goto objdestroy
			end if
			
			delete from mbmembmoneytr where coop_id = :is_coopcontrol and member_no = :ls_memno and trtype_code = :ls_trtype using itr_sqlca;
			if itr_sqlca.sqlcode <> 0 then
				ithw_exception.text = "พบข้อผิดพลาด ไม่สารมารถทำรายการลบข้อมูลได้ (70.02)"
				ithw_exception.text += string( itr_sqlca.sqlcode ) + " : " + itr_sqlca.sqlerrtext
				lb_err = true ; if lb_err then Goto objdestroy
			end if
			
		else
			/*Update*/
			
			ls_trtypenw 			= lds_moneytr.object.trtype_code[li_find] 
			ls_moneytypenw 	= lds_moneytr.object.moneytype_code[li_find] 
			ls_banknw 			= lds_moneytr.object.bank_code[li_find] 
			ls_bankbranchnw 	= lds_moneytr.object.bank_branch[li_find] 
			ls_bankaccidnw		= lds_moneytr.object.bank_accid[li_find]
			
			if isnull(ls_trtypenw) then ls_trtypenw = ""
			if isnull(ls_moneytypenw) then ls_moneytypenw = ""
			if isnull(ls_banknw) then ls_banknw = ""
			if isnull(ls_bankbranchnw) then ls_bankbranchnw = ""
			if isnull(ls_bankaccidnw) then ls_bankaccidnw = ""
			
			lb_chg = false
			if ls_trtype <> ls_trtypenw then lb_chg = true
			if ls_moneytype <> ls_moneytypenw then lb_chg = true
			if ls_bank <> ls_banknw then lb_chg = true
			if ls_bankbranch <> ls_bankbranchnw then lb_chg = true
			if ls_bankaccid <> ls_bankaccidnw then lb_chg = true
			
			if lb_chg then 
			
				ls_new		= ls_trtypenw + " " + ls_moneytypenw
				if len( ls_banknw ) > 0 then ls_new += " ธนาคาร " + ls_banknw
				if len( ls_bankbranchnw ) > 0 then ls_new += " สาขา " + ls_bankbranchnw
				if len( ls_bankaccidnw ) > 0 then ls_new += " บัญชี " + ls_bankaccidnw	
				
				li_seq++
				insert into sys_logmodtbdet
				( coop_id , modtbdoc_no , seq_no , clm_name , clmold_desc , clmnew_desc , clmtype_desc )
				values
				( :is_coopcontrol , :ls_lastdoc , :li_seq , :ls_trtype , :ls_old , :ls_new , 'UPDATE' )
				using itr_sqlca;
				if itr_sqlca.sqlcode <> 0 then
					ithw_exception.text = "พบข้อผิดพลาด ไม่สารมารถทำรายการได้ (70.03)"
					ithw_exception.text += string( itr_sqlca.sqlcode ) + " : " + itr_sqlca.sqlerrtext
					lb_err = true ; if lb_err then Goto objdestroy
				end if
				
				update mbmembmoneytr
				set moneytype_code = :ls_moneytypenw,
				bank_code 		= :ls_banknw , 
				bank_branch 		= :ls_bankbranchnw , 
				bank_accid			= :ls_bankaccidnw
				where coop_id 		= :is_coopcontrol
				and member_no 	= :ls_memno
				and trtype_code	= :ls_trtype
				using itr_sqlca;
				if itr_sqlca.sqlcode <> 0 then
					ithw_exception.text = "พบข้อผิดพลาด ไม่สารมารถทำรายการอัพเดทข้อมูลได้ (70.04)"
					ithw_exception.text += string( itr_sqlca.sqlcode ) + " : " + itr_sqlca.sqlerrtext
					lb_err = true ; if lb_err then Goto objdestroy
				end if
			end if
		end if
		
		fetch lcs_mtr into :ls_trtype , :ls_moneytype , :ls_bank , :ls_bankbranch , :ls_bankaccid , :ls_moneydesc;
	loop
close lcs_mtr ;

/*
Insert
*/
li_count	= lds_moneytr.rowcount()
for li_index = 1 to li_count
	
	ls_trtype		= lds_moneytr.object.trtype_code[li_index]
	
	select count(1)
	into :li_cnt
	from mbmembmoneytr
	where coop_id = :is_coopcontrol
	and member_no = :ls_memno
	and trtype_code = :ls_trtype
	using itr_sqlca;
	
	if li_cnt = 0 then
		
		ls_trtypenw 			= lds_moneytr.object.trtype_code[li_index] 
		ls_moneytypenw 	= lds_moneytr.object.moneytype_code[li_index] 
		ls_banknw 			= lds_moneytr.object.bank_code[li_index] 
		ls_bankbranchnw 	= lds_moneytr.object.bank_branch[li_index] 
		ls_bankaccidnw		= lds_moneytr.object.bank_accid[li_index]
		
		if isnull(ls_trtypenw) then ls_trtypenw = ""
		if isnull(ls_moneytypenw) then ls_moneytypenw = ""
		if isnull(ls_banknw) then ls_banknw = ""
		if isnull(ls_bankbranchnw) then ls_bankbranchnw = ""
		if isnull(ls_bankaccidnw) then ls_bankaccidnw = ""
		
		ls_new		= ls_trtypenw + " " + ls_moneytypenw
		if len( ls_banknw ) > 0 then ls_new += " ธนาคาร " + ls_banknw
		if len( ls_bankbranchnw ) > 0 then ls_new += " สาขา " + ls_bankbranchnw
		if len( ls_bankaccidnw	 ) > 0 then ls_new += " บัญชี " + ls_bankaccidnw	
		
		li_seq++
		insert into sys_logmodtbdet
		( coop_id , modtbdoc_no , seq_no , clm_name , clmold_desc , clmnew_desc , clmtype_desc )
		values
		( :is_coopcontrol , :ls_lastdoc , :li_seq , :ls_trtype , '' , :ls_new , 'INSERT' )
		using itr_sqlca;
		if itr_sqlca.sqlcode <> 0 then
			ithw_exception.text = "พบข้อผิดพลาด ไม่สารมารถทำรายการได้ (70.05)"
			ithw_exception.text += string( itr_sqlca.sqlcode ) + " : " + itr_sqlca.sqlerrtext
			lb_err = true ; if lb_err then Goto objdestroy
		end if
		
		insert into mbmembmoneytr
		( coop_id , member_no , trtype_code , moneytype_code , bank_code , bank_branch , bank_accid )
		values
		( :is_coopcontrol , :ls_memno , :ls_trtypenw , :ls_moneytypenw , :ls_banknw , :ls_bankbranchnw , :ls_bankaccidnw )
		using itr_sqlca;
		if itr_sqlca.sqlcode <> 0 then
			ithw_exception.text = "พบข้อผิดพลาด ไม่สารมารถทำรายการเพิ่มได้ (70.06)"
			ithw_exception.text += string( itr_sqlca.sqlcode ) + " : " + itr_sqlca.sqlerrtext
			lb_err = true ; if lb_err then Goto objdestroy
		end if
	end if
	
next

objdestroy:
if isvalid(lds_mbmaster) then destroy lds_mbmaster
if isvalid(lds_moneytr) then destroy lds_moneytr
this.of_setsrvdwxmlie( false )

if lb_err then
	rollback using itr_sqlca ;
	ithw_exception.text = "n_cst_membsrv_allrequest.of_save_mbaudit()" + ithw_exception.text
	throw ithw_exception
end if

return 1
end function

public function integer of_post_mbupdate_memno_impfile (string as_xmlmaincri, ref string as_xmldata, string as_xmlcollumn, datetime adtm_entry, string as_entryid);
string		ls_cardperson , ls_memberno , ls_mthexpensedesc, ls_colname, ls_fullname,ls_colnameold,ls_colnamenew,ls_colmemno,ls_valuenew
string		ls_valueold,ls_sqlupdate,ls_sql, ls_sqlwhere,ls_year, ls_docno,ls_prefix,ls_colid
dec{2}	ldc_mthexpenseamt
integer	li_seqno, li_collkey, li_length
long		ll_index , ll_count , ll_listindex , ll_listcount,li_lastdocno
n_ds   lds_data, lds_maincri,lds_xmlcollumn

lds_data = create n_ds
lds_maincri = create n_ds
lds_xmlcollumn = create n_ds

lds_maincri.dataobject = "d_mb_update_data_imp_main_cri"
lds_data.dataobject = "d_mb_imp_data_import"
lds_xmlcollumn.dataobject  = "d_mb_imp_collumn_list"

of_xmlimport( lds_maincri, "d_mb_update_data_imp_main_cri", as_xmlmaincri )
of_xmlimport( lds_data, "d_mb_imp_data_import", as_xmldata )
of_xmlimport( lds_xmlcollumn, "d_mb_imp_collumn_list", as_xmlcollumn )

if lds_maincri.rowcount() > 0 then
	ls_colname = lds_maincri.getitemstring( 1,"col_name")
	li_collkey  = lds_maincri.getitemnumber(1,"col_key")
	ls_colmemno  = trim( lds_maincri.getitemstring( 1,"col_memno"))
		
	ll_count = lds_data.rowcount()
	lds_xmlcollumn.setfilter("post_flag = 1")
	lds_xmlcollumn.filter()

	ll_listcount  = lds_xmlcollumn.rowcount()
end if

select last_documentno, document_prefix,  document_year, document_length
into :li_lastdocno,  :ls_prefix,			:ls_year,		:li_length
from cmdocumentcontrol 
where document_code = 'AUDITMBFILE' using itr_sqlca ; 

for ll_index = 1 to ll_count

	ls_memberno = trim( lds_data.getitemstring( ll_index , ls_colmemno ))
	// สำหรับใช้ทะเบียนสมาชิกแล้วเข้า msg err
	if isnull( ls_memberno ) then ls_memberno = ''
	
	
	if len( ls_memberno ) <  5 or  ls_memberno = '00000000'  then continue;
	
	// หาลำดับทำรายการล่าสุด
	li_lastdocno ++
	ls_docno = ls_prefix + right( ls_year,2) + right('00000000'+string( li_lastdocno, '0000#') , li_length )
	
	insert into mbaudit
	( docno,		member_no,		approve_id,		approve_date ,    ref_doc  )
	values
	( :ls_docno,  :ls_memberno,    :as_entryid,    :adtm_entry,   'imp file'   ) using itr_sqlca ;
	
	ls_sqlupdate = " update mbmembmaster set "
	ls_sqlwhere = " where member_no = '" + ls_memberno + "'"
	for ll_listindex = 1 to ll_listcount
		
		ls_colnamenew	= trim(lds_xmlcollumn.object.col_af[ ll_listindex ])
		ls_colnameold	= trim(lds_xmlcollumn.object.col_bf[ ll_listindex ])
		ls_colname	= trim(lds_xmlcollumn.object.engcol_name[ ll_listindex ])
		ls_colid	= trim(lds_xmlcollumn.object.col_id[ ll_listindex ])
		
		//อ่านค่าจาก Datawindow
		ls_valuenew		= trim( lds_data.getitemstring( ll_index , ls_colnamenew ))
		ls_valueold	= trim( lds_data.getitemstring( ll_index , ls_colnameold ))
		
		if  ls_valuenew  = ls_valueold or len( ls_colnameold ) < 4 then continue;
		
		ls_sqlupdate += " " + ls_colname + " = '" + ls_valuenew +"' ,"
		
		insert into  mbaudithistory
		(	docno,		col_id,		old_value,		new_value  )
		values
		( :ls_docno,   :ls_colid,   :ls_valueold,     :ls_valuenew    ) using itr_sqlca ;
		
		
		
	next
	ls_sql = left(ls_sqlupdate,len(ls_sqlupdate) -1) + ls_sqlwhere

	execute immediate :ls_sql using itr_sqlca;
next

update cmdocumentcontrol
set last_documentno = :li_lastdocno
where document_code = 'AUDITMBFILE' using itr_sqlca ; 

commit using itr_sqlca ;
return 1
end function

private function string of_xmlexport (n_ds ads_info);/***********************************************************
<description>
	Export xml เข้าสู่ datastore
</description>

<arguments>  
	ads_info				n_ds		datastore ที่จะ export ข้อมูล
</arguments> 

<return> 
	String		 	xml ที่ export ได้
</return> 

<usage> 
	Revision History:
	Version 1.0 (Initial version) Modified Date 13/10/2010 by MiT
</usage> 
***********************************************************/
string		ls_xml

if ( ads_info.rowcount() > 0 ) then
	ls_xml = string( ads_info.describe( "Datawindow.data.XML" ) )
else
	ls_xml = ""
end if

return ls_xml
end function

public function integer of_xmlimport (ref n_ds ads_info, string as_dwobjname, string as_xmlinfo);/***********************************************************
<description>
	Import Xml
</description>

<arguments>  
	ads_info				n_ds		datastore ที่จะ import ข้อมูลเข้า
	as_dwobjname		String		ชื่อ dw object
	as_xmlinfo			String		ข้อมูลในรูปแบบ xml ที่ต้องการ import
</arguments> 

<return> 
	Integer	 	จำนวนแถวที่ import ได้
					-1   No rows or startrow value supplied is greater than the number of rows in the string
					-3   Invalid argument
					-4   Invalid input
					-11   XML Parsing Error; XML parser libraries not found or XML not well formed
					-12   XML Template does not exist or does not match the DataWindow
					-13    Unsupported DataWindow style for import
					-14    Error resolving DataWindow nesting
</return> 

<usage> 
	Revision History:
	Version 1.0 (Initial version) Modified Date 13/10/2010 by MiT
</usage> 
***********************************************************/
integer	li_row

if not isvalid( ads_info ) or isnull( ads_info ) then
	ads_info = create n_ds
end if

ads_info.dataobject = as_dwobjname
ads_info.settransobject( itr_sqlca )

if ( as_xmlinfo = "" ) then return 0

li_row = ads_info.importstring( XML!, as_xmlinfo )

return li_row
end function

public function integer of_importfile_to_datawindow (ref string as_xmldata, string as_pathfile) throws Exception;
string		ls_cardperson , ls_memberno , ls_mthexpensedesc, ls_colname, ls_fullname,ls_sql,ls_colnamenew,ls_colnameold
string		ls_coldesc, ls_type,ls_sqlwhere,ls_coltype,ls_valueold,ls_colmemno,ls_colnamelist
dec{2}	ldc_mthexpenseamt
integer	li_seqno, li_collkey, li_mcount,li_postflag
long		ll_index , ll_count , ll_listindex , ll_listcount
n_ds   lds_data, lds_maincri, lds_xmlcollumn,lds_bfmeminfo

lds_data = create n_ds

lds_data.dataobject = "d_mb_imp_data_import"

if len( as_pathfile )  >= 6 then
	long	ll_row

	lds_data.importfile(as_pathfile, 1)
	
end if

as_xmldata	= of_xmlexport( lds_data )

destroy lds_data
return 1
end function

public function string of_getmemberno_fromfullname2 (string as_firstname, string as_lastname);// ตรวจสอบเลขที่บัตรประชาชน
string		ls_memberno, ls_prename, ls_firstname, ls_surname, ls_name, ls_fullname
long		ll_row
integer li_pos


// หาทะเบียนสมาชิกจากชื่อ นามสกุล
ls_memberno  = " "
select		a.member_no
into		:ls_memberno
from		mbmembmaster a
where	a.memb_name = :as_firstname  and a.memb_surname = :as_lastname  using itr_sqlca ;
		
return ls_memberno
end function

public function string of_getmemberno_fromfullname (string as_fullname);// ตรวจสอบเลขที่บัตรประชาชน
string		ls_memberno, ls_prename, ls_firstname, ls_surname, ls_name, ls_fullname
long		ll_row
integer li_pos


li_pos = pos( as_fullname,'  ', 1 )
if li_Pos > 0 then
	ls_name = trim(left(  as_fullname, li_pos - 1 )) 
	ls_surname = trim(mid( as_fullname, li_pos , len( as_fullname ) ))
else
	li_pos = pos( as_fullname,' ', 1 )
	ls_name = trim(left(  as_fullname, li_pos - 1 )) 
	ls_surname = trim(mid( as_fullname, li_pos , len( as_fullname ) ))
	if li_pos <= 0 then
		return 'err'
	end if
end if
ls_fullname = trim(ls_name)  + trim(ls_surname )
// หาทะเบียนสมาชิกจากชื่อ นามสกุล
ls_memberno  = " "
select		a.member_no
into		:ls_memberno
from		mbmembmaster a, mbucfprename b
where	a.prename_code = b.prename_code 
and (  b.prename_desc ||a.memb_name || a.memb_surname)	= :ls_fullname using itr_sqlca ;

if len( ls_memberno ) <  6 then
	select		a.member_no
	into		:ls_memberno
	from		mbmembmaster a, mbucfprename b
	where	a.prename_code = b.prename_code 
	and (  b.prename_short ||a.memb_name || a.memb_surname)	= :ls_fullname using itr_sqlca ;
	
end if

if len( ls_memberno ) <  6 then
	select		a.member_no
	into		:ls_memberno
	from		mbmembmaster a, mbucfprename b
	where	a.prename_code = b.prename_code 
	and 	(  a.memb_name || a.memb_surname)	= :ls_fullname using itr_sqlca ;
	
end if

if len( ls_memberno ) <  6 then
	ls_prename = left( ls_name, 3) 
	if ls_prename = "นาย" or ls_prename = "นาง" or ls_prename = "น.ส" then
		if ls_prename = "น.ส" then
			ls_name = mid( ls_name,5,len( ls_name ))
		else
			ls_name = mid( ls_name,4,len( ls_name ))
		end if
	else
		li_pos = pos( ls_name,'.', 4 )
		if li_pos > 0 then
			ls_name = mid( ls_name,li_pos,len( ls_name))
		end if
		
		
	end if
	ls_name += '%'
		ls_surname += '%'
		select member_no
		into :ls_memberno
		from mbmembmaster where memb_name like :ls_name and memb_surname like :ls_surname using itr_sqlca ;
		
		if len( ls_memberno ) < 5 then
			select member_no
			into :ls_memberno
			from mbmembmaster where resign_status = 0 and member_status = 1  and  memb_name like :ls_name and memb_surname like :ls_surname using itr_sqlca ;
		end if
end if

		
return ls_memberno
end function

public function integer of_set_mbupdate_memno_impfile (string as_xmlmaincri, ref string as_xmldata, string as_collumlist) throws Exception;
string		ls_cardperson , ls_memberno , ls_mthexpensedesc, ls_colname, ls_fullname,ls_sql,ls_colnamenew,ls_colnameold
string		ls_coldesc, ls_type,ls_sqlwhere,ls_coltype,ls_valueold,ls_colmemno,ls_colnamelist, ls_fullname2,ls_colname2
dec{2}	ldc_mthexpenseamt
integer	li_seqno, li_collkey, li_mcount,li_postflag, li_checkflag
long		ll_index , ll_count , ll_listindex , ll_listcount
n_ds   lds_data, lds_maincri, lds_xmlcollumn,lds_bfmeminfo

lds_data = create n_ds
lds_maincri = create n_ds
lds_xmlcollumn   = create n_ds
lds_bfmeminfo = create n_ds

lds_maincri.dataobject = "d_mb_update_data_imp_main_cri"
lds_data.dataobject = "d_mb_imp_data_import"
lds_xmlcollumn.dataobject = "d_mb_imp_collumn_list"


lds_bfmeminfo.dataobject = "d_mb_bfadjust_edit_from_file"

lds_bfmeminfo.settransobject(itr_sqlca)

inv_dwxmliesrv.of_xmlimport( lds_maincri, as_xmlmaincri )
inv_dwxmliesrv.of_xmlimport( lds_data, as_xmldata )
inv_dwxmliesrv.of_xmlimport( lds_xmlcollumn, as_collumlist )

ls_colname = trim(lds_maincri.getitemstring( 1,"col_name"))


li_collkey  = lds_maincri.getitemnumber(1,"col_key")
li_checkflag = lds_maincri.getitemnumber(1,"delete_flag")
ls_colmemno = trim(lds_maincri.getitemstring(1,"col_memno")) 
ls_colname = trim(lds_maincri.getitemstring( 1,"col_name"))
ll_listcount =  lds_xmlcollumn.rowcount()

ll_count = lds_data.rowcount()

for ll_index = 1 to ll_count
	
	if li_collkey = 1  then 	
		ls_memberno = trim( lds_data.getitemstring( ll_index,ls_colname  ))
		ls_memberno = right( '00000000'+ ls_memberno,8)
	end if
	
	if li_collkey = 2  then 
		ls_cardperson = trim( lds_data.getitemstring( ll_index,ls_colname  ))
		
		// หาทะเบียนสมาชิกจากเลขที่บัตรประชาชน
		select		max(member_no)
		into		:ls_memberno
		from		mbmembmaster
		where	card_person		= :ls_cardperson  using itr_sqlca ; //and member_status = 1

		
	end if
	
	if li_collkey = 3  then 	
		ls_colname2 = trim(lds_maincri.getitemstring( 1,"col_name2"))
		ls_fullname = trim( lds_data.getitemstring( ll_index,ls_colname  ))
		ls_fullname2 = trim( lds_data.getitemstring( ll_index,ls_colname2  ))
		
		if len( trim( ls_fullname2 )) >  4 then
			ls_memberno = this.of_getmemberno_fromfullname2( ls_fullname,ls_fullname2 )
		else
			ls_memberno = this.of_getmemberno_fromfullname( ls_fullname )
		end if
		
	end if
	
	lds_data.setitem( ll_index,ls_colmemno, ls_memberno  )
	
	if len( ls_memberno ) > 5 and li_checkflag = 1 then
		
		
		li_mcount = lds_bfmeminfo.retrieve( ls_memberno )
		
		if li_mcount <= 0 then
			
			
		else
			
			for ll_listindex = 1 to ll_listcount
			
				ls_colnamenew	= trim(lds_xmlcollumn.object.col_af[ ll_listindex ])
				ls_colnameold	= trim(lds_xmlcollumn.object.col_bf[ ll_listindex ])
				ls_colnamelist	= trim(lds_xmlcollumn.object.engcol_name[ ll_listindex ])
				ls_type 			= trim(lds_xmlcollumn.object.column_type[ ll_listindex ])
				li_postflag	= 		lds_xmlcollumn.object.post_flag[ ll_listindex ]
				if li_postflag = 0 or isnull( li_postflag) then continue;
				
				if li_mcount > 0 then
				//	ls_coldesc = ls_colnamelist + ".coltype"
				//	ls_coltype = lds_bfmeminfo.describe(ls_coldesc)
				//	ls_type  =  left(ls_coltype,4)
					choose case lower(ls_type)
					case "date"
						ls_valueold	= string( lds_bfmeminfo.getitemdatetime( li_mcount , ls_colnamelist ),'dd/mm/yyyy')
					case "varc","char"
						ls_valueold	= trim( lds_bfmeminfo.getitemstring( li_mcount , ls_colnamelist ))
					case "number"
						ls_valueold	= string( lds_bfmeminfo.getitemnumber( li_mcount , ls_colnamelist ))
					case "deci"
						if ls_coltype = "decimal(0)" then
							ls_valueold	= string( lds_bfmeminfo.getitemnumber( li_mcount , ls_colnamelist ),"#,##0")
						else
							ls_valueold	= string( lds_bfmeminfo.getitemnumber( li_mcount , ls_colnamelist ),"#,##0.00")
						end if
					case else
						//ls_valueold	= string( lds_bfmeminfo.getitemany( ll_index , ls_colnamelist ))
					end choose
			
					
					lds_data.setitem( ll_index, ls_colnameold, ls_valueold )
					
				end if
				
			
			
		next
	end if
	end if
next
as_xmldata =  inv_dwxmliesrv.of_xmlexport( lds_data )

if lds_data.rowcount() <= 0  then
			ithw_exception.text	= "ไม่สามารถทำข้อมูลได้ "+itr_sqlca.sqlerrtext
			throw ithw_exception
end if

return ll_count
end function

private function integer of_setdsmodify (ref n_ds ads_requester, long al_row, boolean ab_keymodify);string		ls_iskey
long		ll_index, ll_count

ads_requester.setitemstatus( al_row, 0, primary!, datamodified! )

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

return 1
end function

public function integer of_save_sal (ref str_mbaudit astr_mbaudit) throws Exception;string ls_memno , ls_recv , ls_entryid
integer li_periodstatus , li_lastperiod 
long ll_seq
dec{2} ldc_oldsal , ldc_oldshrbase , ldc_oldshrperiod
dec{2} ldc_newsal , ldc_minshr , ldc_maxshr , ldc_newshrperiod , ldc_newshrbase
dec{2} ldc_minshrhold , ldc_maxshrhold , ldc_minshrlow , ldc_minshrstop , ldc_tminshrlow , ldc_tminshrstop
datetime ldtm_oper
boolean lb_err

ls_entryid		= astr_mbaudit.userid
ldtm_oper		= astr_mbaudit.operate_date

inv_progress.istr_progress.progress_text = "ปรับปรุงเงินเดือน"
inv_progress.istr_progress.progress_index = 0
inv_progress.istr_progress.progress_max = 6
inv_progress.istr_progress.subprogress_text = "เตรียมข้อมูล"
inv_progress.istr_progress.subprogress_index = 0
inv_progress.istr_progress.subprogress_max = 1
inv_progress.istr_progress.status = 8

if isnull( ldtm_oper ) or string( ldtm_oper , 'dd/mm/yyyy' ) = '01/01/1900' then
	ithw_exception.text	= "ไม่พบข้อมูลวันทำรายการ กรุณาตรวจสอบ(0.01)"
	lb_err = true ; Goto objdestroy;
end if

ls_recv		= right( string( integer( string( ldtm_oper , 'yyyy' ) ) + 543 ) , 2 ) + string( ldtm_oper , 'mm' )

inv_progress.istr_progress.subprogress_text = "ดึงข้อมูลทำรายการ โปรดรอสักครู่..."
inv_progress.istr_progress.subprogress_index = 0
inv_progress.istr_progress.subprogress_max = 1
/*1*/
select count( 1 ) into :ll_seq from mbadjsalary where coop_id = :is_coopcontrol and operate_date = :ldtm_oper using itr_sqlca ;
if itr_sqlca.sqlcode <> 0 or isnull( ll_seq ) then ll_seq = 0

inv_progress.istr_progress.subprogress_text = "ตรวจสอบสมาชิกที่ปรับปรุงเงินเดือน โปรดรอสักครู่..."
inv_progress.istr_progress.subprogress_index = 0
inv_progress.istr_progress.subprogress_max = 1
/*2*/
/*insert data*/
insert into mbadjsalary
( coop_id , adjslip_no , adjsal_type , operate_date , sharetype_code , member_no , new_salary , posting_flag , entry_id , entry_date , entry_bycoopid )
select :is_coopcontrol , ( :ls_recv || lpad ( to_char( :ll_seq + rownum ) , 11 , '0' ) ) as adjslip_no , 'PRC' as adjsal_type , :ldtm_oper as operate_date , '01' as sharetype_code , 
m.member_no , mast.salary_amount , 0 as posting_flag , '' as entry_id , sysdate as entry_date , :is_coopid as entry_bycoopid
from mbadjsalarytemp mast , mbmembmaster m 
where m.coop_id = mast.coop_id
and m.salary_id = mast.salary_id
and m.salary_amount <> mast.salary_amount
and m.resign_status = 0
and mast.coop_id = :is_coopcontrol
using itr_sqlca ;
if itr_sqlca.sqlcode <> 0 then
	ithw_exception.text	= "ไม่สามารถทำรายการได้ นำเข้าข้อมูลปรับปรุงเงินเดือน(60.01)"
	ithw_exception.text	+= string( itr_sqlca.sqlcode ) + " : " + itr_sqlca.sqlerrtext
	ithw_exception.text	+= "กรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy;
end if

inv_progress.istr_progress.subprogress_text = "ปรับปรุงหุ้นส่งต่อเดือน โปรดรอสักครู่..."
inv_progress.istr_progress.subprogress_index = 0
inv_progress.istr_progress.subprogress_max = 1
/*3*/
/*update share_base & share_period*/
declare data_shr cursor for
select mas.member_no , payment_status , last_period ,
nvl( m.salary_amount , 0 ) as old_salary , nvl( sm.periodbase_amt , 0 ) as old_sharebase , nvl( sm.periodshare_amt , 0 ) as old_shareperiod ,
nvl( mas.new_salary , 0 ) as new_salary , nvl( stm.minshare_amt , 0 ) as minshare_amt , nvl( stm.maxshare_amt , 99999 ) as maxshare_amt ,
( ( nvl( mas.new_salary , 0 ) * nvl( stm.sharerate_percent , 0 ) ) / ( 100 * st.unitshare_value ) ) as new_shareperiod ,
nvl( st.minshare_hold , 0 ) as minshare_hold , nvl( st.maxshare_hold , 0 ) as maxshare_hold , 
nvl( st.minshare_low , 0 ) as minshare_low , nvl( st.minshare_stop , 0 ) as minshare_stop , 
nvl( st.timeminshare_low , 0 ) as timeminshare_low , nvl( st.timeminshare_stop , 0 ) as timeminshare_stop
from mbadjsalary mas , mbmembmaster m , shsharemaster sm , shsharetypemthrate stm , shsharetype st
where mas.coop_id = st.coop_id
and mas.sharetype_code = st.sharetype_code
and mas.coop_id = m.coop_id
and mas.member_no = m.member_no
and mas.coop_id = sm.coop_id
and mas.member_no = sm.member_no
and mas.sharetype_code = sm.sharetype_code
and m.member_type = stm.member_type
and mas.new_salary between stm.start_salary and stm.end_salary
and mas.coop_id = :is_coopcontrol
and mas.operate_date = :ldtm_oper
and mas.adjsal_type = 'PRC'
and mas.posting_flag = 0
using itr_sqlca;
open data_shr ;
	fetch data_shr into 	:ls_memno , :li_periodstatus , :li_lastperiod ,
								:ldc_oldsal , :ldc_oldshrbase , :ldc_oldshrperiod ,
								:ldc_newsal , :ldc_minshr , :ldc_maxshr , :ldc_newshrperiod ,
								:ldc_minshrhold , :ldc_maxshrhold , :ldc_minshrlow , :ldc_minshrstop , :ldc_tminshrlow , :ldc_tminshrstop ;
	do while itr_sqlca.sqlcode = 0
		
		if li_periodstatus = 1 then
			/*ส่งปกติ*/
			
			/*น้อยกว่าหุ้นขั้นต่ำ / น้อยกว่างวดส่งขั้นต่ำ หรือป่าว รอทำ*/

			/*ตรวจสอบส่งหุ้นขั้นต่ำ/ขั้นสูงตามเกรณ์เงินเดือน*/
			if ldc_newshrperiod < ldc_minshr then
				/* % น้อยกว่าขั้นต่ำใช้ขั้นต่ำ */
				ldc_newshrperiod = ldc_minshr
			end if
			
			if ldc_newshrperiod > ldc_maxshr then
				/* % น้อยกว่าขั้นสูงใช้ขั้นสูง */
				ldc_newshrperiod = ldc_maxshr
			end if
			
			ldc_newshrbase	= ldc_newshrperiod	/*หุ้นฐาน*/
			
			/*ตรวจสอบค่าใหม่กับค่าเก่า*/
			if ldc_newshrperiod < ldc_oldshrperiod then
				ldc_newshrperiod		= ldc_oldshrperiod
			end if
			
		else
			/*งดส่งไม่ต้องสนใจ*/
			ldc_newshrperiod		= ldc_oldshrperiod
		end if

		update mbadjsalary mas
		set mas.old_salary 		= :ldc_oldsal , 
		mas.old_sharebase 		= :ldc_oldshrbase , 
		mas.old_shareperiod		= :ldc_oldshrperiod ,
		mas.new_sharebase		= :ldc_newshrbase ,
		mas.new_shareperiod 	= :ldc_newshrperiod
		where mas.coop_id = :is_coopcontrol
		and mas.operate_date = :ldtm_oper
		and mas.member_no = :ls_memno
		and mas.adjsal_type = 'PRC'
		and mas.posting_flag = 0
		using itr_sqlca;
		if itr_sqlca.sqlcode <> 0 then
			ithw_exception.text	= "ไม่สามารถทำรายการได้ อัพเดทข้อมูลหุ้นส่งต่อเดือน (60.02)"
			ithw_exception.text	+= string( itr_sqlca.sqlcode ) + " : " + itr_sqlca.sqlerrtext
			ithw_exception.text	+= "กรุณาตรวจสอบ"
			lb_err = true ; Goto objdestroy;
		end if
		
		/*2.1*/
		
		fetch data_shr into :ls_memno , :li_periodstatus , :li_lastperiod ,
								 :ldc_oldsal , :ldc_oldshrbase , :ldc_oldshrperiod ,
								 :ldc_newsal , :ldc_minshr , :ldc_maxshr , :ldc_newshrperiod ,
								 :ldc_minshrhold , :ldc_maxshrhold , :ldc_minshrlow , :ldc_minshrstop , :ldc_tminshrlow , :ldc_tminshrstop ;
	loop
close data_shr ;

inv_progress.istr_progress.subprogress_text = "อัพเดทเงินเดือน โปรดรอสักครู่..."
inv_progress.istr_progress.subprogress_index = 0
inv_progress.istr_progress.subprogress_max = 1
/*4*/
/* Update Salary Amount( Mbmembmaster ) */
update mbmembmaster m
set m.salary_amount		= ( 	select ms.new_salary
										from mbadjsalary ms
										where ms.coop_id = m.coop_id
										and ms.member_no = m.member_no
										and ms.coop_id = :is_coopcontrol
										and ms.operate_date = :ldtm_oper
										and ms.adjsal_type = 'PRC'
										and ms.posting_flag = 0
									)
where m.coop_id = :is_coopcontrol
and exists( 	select 1 from mbadjsalary mas
				where mas.coop_id = m.coop_id
				and mas.member_no = m.member_no
				and mas.coop_id = :is_coopcontrol
				and mas.operate_date = :ldtm_oper
				and mas.adjsal_type = 'PRC'
				and mas.posting_flag = 0
			)
using itr_sqlca;
if itr_sqlca.sqlcode <> 0 then
	ithw_exception.text	= "ไม่สามารถทำรายการได้ อัพเดทเงินเดือนได้ (70.01)"
	ithw_exception.text	+= string( itr_sqlca.sqlcode ) + " : " + itr_sqlca.sqlerrtext
	ithw_exception.text	+= "กรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy;
end if

inv_progress.istr_progress.subprogress_text = "อัพเดทหุ้นส่งต่อเดือน โปรดรอสักครู่..."
inv_progress.istr_progress.subprogress_index = 0
inv_progress.istr_progress.subprogress_max = 1
/*5*/
/* Update Share Period Amount( Shsharemaster ) */
update shsharemaster sm
set ( sm.periodbase_amt , sm.periodshare_amt ) = 
		( 	
			select ms.new_sharebase , ms.new_shareperiod
			from mbadjsalary ms
			where ms.coop_id = sm.coop_id
			and ms.member_no = sm.member_no
			and ms.coop_id = :is_coopcontrol
			and ms.operate_date = :ldtm_oper
			and ms.adjsal_type = 'PRC'
			and ms.posting_flag = 0
			)
where sm.coop_id = :is_coopcontrol
and sm.payment_status = 1
and exists( 	select 1 from mbadjsalary mas
				where mas.coop_id = sm.coop_id
				and mas.member_no = sm.member_no
				and mas.coop_id = :is_coopcontrol
				and mas.operate_date = :ldtm_oper
				and mas.adjsal_type = 'PRC'
				and mas.posting_flag = 0
			)
using itr_sqlca;
if itr_sqlca.sqlcode <> 0 then
	ithw_exception.text	= "ไม่สามารถทำรายการได้ อัพเดทหุ้นส่งต่อเดือนได้ (70.02)"
	ithw_exception.text	+= string( itr_sqlca.sqlcode ) + " : " + itr_sqlca.sqlerrtext
	ithw_exception.text	+= "กรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy;
end if

inv_progress.istr_progress.subprogress_text = "อัพเดทหุ้นสถานะผ่านรายการ โปรดรอสักครู่..."
inv_progress.istr_progress.subprogress_index = 0
inv_progress.istr_progress.subprogress_max = 1
/*6*/
/* Update Posting( Mbadjsalary ) */
update mbadjsalary mas
set mas.posting_flag = 1
where mas.coop_id = :is_coopcontrol
and mas.operate_date = :ldtm_oper
and mas.adjsal_type = 'PRC'
and mas.posting_flag = 0
using itr_sqlca;
if itr_sqlca.sqlcode <> 0 then
	ithw_exception.text	= "ไม่สามารถทำรายการได้ อัพเดทสถานะผ่านรายการได้ (70.03)"
	ithw_exception.text	+= string( itr_sqlca.sqlcode ) + " : " + itr_sqlca.sqlerrtext
	ithw_exception.text	+= "กรุณาตรวจสอบ"
	lb_err = true ; Goto objdestroy;
end if

inv_progress.istr_progress.subprogress_index = 1

objdestroy:

if lb_err then
	ithw_exception.text = "n_cst_membsrv_audit.of_save_sal()" + ithw_exception.text
	throw ithw_exception
	rollback using itr_sqlca;
else
	commit using itr_sqlca;
end if

inv_progress.istr_progress.status = 1

return 1
end function

public function integer of_init_sal (ref str_mbaudit astr_mbaudit) throws Exception;string ls_memno
integer li_periodstatus , li_lastperiod 
dec{2} ldc_oldsal , ldc_oldshrbase , ldc_oldshrperiod
dec{2} ldc_newsal , ldc_minshr , ldc_maxshr , ldc_newshrperiod , ldc_newshrbase
dec{2} ldc_minshrhold , ldc_maxshrhold , ldc_minshrlow , ldc_minshrstop , ldc_tminshrlow , ldc_tminshrstop
datetime ldtm_oper
boolean lb_err

/*
ldtm_oper		= astr_mbaudit.operate_date

if isnull( ldtm_oper ) or string( ldtm_oper , 'dd/mm/yyyy' ) = '01/01/1900' then
	ithw_exception.text	= "ไม่พบข้อมูลวันทำรายการ กรุณาตรวจสอบ(0.01)"
	lb_err = true ; Goto objdestroy;
end if

declare data_shr cursor for
select mas.member_no , payment_status , last_period ,
nvl( m.salary_amount , 0 ) as old_salary , nvl( sm.periodbase_amt , 0 ) as old_sharebase , nvl( sm.periodshare_amt , 0 ) as old_shareperiod ,
nvl( mas.new_salary , 0 ) as new_salary , nvl( stm.minshare_amt , 0 ) as minshare_amt , nvl( stm.maxshare_amt , 99999 ) as maxshare_amt ,
( ( nvl( mas.new_salary , 0 ) * nvl( stm.sharerate_percent , 0 ) ) / ( 100 * st.unitshare_value ) ) as new_shareperiod ,
nvl( st.minshare_hold , 0 ) as minshare_hold , nvl( st.maxshare_hold , 0 ) as maxshare_hold , 
nvl( st.minshare_low , 0 ) as minshare_low , nvl( st.minshare_stop , 0 ) as minshare_stop , 
nvl( st.timeminshare_low , 0 ) as timeminshare_low , nvl( st.timeminshare_stop , 0 ) as timeminshare_stop
from mbadjsalary mas , mbmembmaster m , shsharemaster sm , shsharetypemthrate stm , shsharetype st
where mas.coop_id = st.coop_id
and mas.sharetype_code = st.sharetype_code
and mas.coop_id = m.coop_id
and mas.member_no = m.member_no
and mas.coop_id = sm.coop_id
and mas.member_no = sm.member_no
and mas.sharetype_code = sm.sharetype_code
and m.member_type = stm.member_type
and mas.new_salary between stm.start_salary and stm.end_salary
and mas.coop_id = :is_coopcontrol
and mas.operate_date = :ldtm_oper
and mas.adjsal_type = 'PRC'
and mas.posting_flag = 0
using itr_sqlca;
open data_shr ;
	fetch data_shr into 	:ls_memno , :li_periodstatus , :li_lastperiod ,
								:ldc_oldsal , :ldc_oldshrbase , :ldc_oldshrperiod ,
								:ldc_newsal , :ldc_minshr , :ldc_maxshr , :ldc_newshrperiod ,
								:ldc_minshrhold , :ldc_maxshrhold , :ldc_minshrlow , :ldc_minshrstop , :ldc_tminshrlow , :ldc_tminshrstop ;
	do while itr_sqlca.sqlcode = 0
		
		if li_periodstatus = 1 then
			/*ส่งปกติ*/
			
			/*น้อยกว่าหุ้นขั้นต่ำ / น้อยกว่างวดส่งขั้นต่ำ หรือป่าว รอทำ*/

			/*ตรวจสอบส่งหุ้นขั้นต่ำ/ขั้นสูงตามเกรณ์เงินเดือน*/
			if ldc_newshrperiod < ldc_minshr then
				/* % น้อยกว่าขั้นต่ำใช้ขั้นต่ำ */
				ldc_newshrperiod = ldc_minshr
			end if
			
			if ldc_newshrperiod > ldc_maxshr then
				/* % น้อยกว่าขั้นสูงใช้ขั้นสูง */
				ldc_newshrperiod = ldc_maxshr
			end if
			
			ldc_newshrbase	= ldc_newshrperiod	/*หุ้นฐาน*/
			
			/*ตรวจสอบค่าใหม่กับค่าเก่า*/
			if ldc_newshrperiod < ldc_oldshrperiod then
				ldc_newshrperiod		= ldc_oldshrperiod
			end if
			
		else
			/*งดส่งไม่ต้องสนใจ*/
			ldc_newshrperiod		= ldc_oldshrperiod
		end if

		update mbadjsalary mas
		set mas.old_salary 		= :ldc_oldsal , 
		mas.old_sharebase 		= :ldc_oldshrbase , 
		mas.old_shareperiod		= :ldc_oldshrperiod ,
		mas.new_sharebase		= :ldc_newshrbase ,
		mas.new_shareperiod 	= :ldc_newshrperiod
		where mas.coop_id = :is_coopcontrol
		and mas.operate_date = :ldtm_oper
		and mas.member_no = :ls_memno
		and mas.adjsal_type = 'PRC'
		and mas.posting_flag = 0
		using itr_sqlca;
		if itr_sqlca.sqlcode <> 0 then
			ithw_exception.text	= "ไม่สามารถทำรายการได้ อัพเดทข้อมูลหุ้นส่งต่อเดือน (70.01)"
			ithw_exception.text	+= string( itr_sqlca.sqlcode ) + " : " + itr_sqlca.sqlerrtext
			ithw_exception.text	+= "กรุณาตรวจสอบ"
			lb_err = true ; Goto objdestroy;
		end if
		
		fetch data_shr into :ls_memno , :li_periodstatus , :li_lastperiod ,
								 :ldc_oldsal , :ldc_oldshrbase , :ldc_oldshrperiod ,
								 :ldc_newsal , :ldc_minshr , :ldc_maxshr , :ldc_newshrperiod ,
								 :ldc_minshrhold , :ldc_maxshrhold , :ldc_minshrlow , :ldc_minshrstop , :ldc_tminshrlow , :ldc_tminshrstop ;
	loop
close data_shr ;

objdestroy:

if lb_err then
	ithw_exception.text = "n_cst_membsrv_audit.of_int_sal()" + ithw_exception.text
	throw ithw_exception
	rollback using itr_sqlca;
else
	commit using itr_sqlca;
end if

*/

return 1

/*
old
/*Update Old Salary( Mbadjsalary )*/
//update mbadjsalary mas
//set 	( 	mas.old_salary , mas.old_sharebase , mas.old_shareperiod ) = 
//		( 	
//			select m.salary_amount , sm.periodbase_amt , sm.periodshare_amt
//			from mbmembmaster m , shsharemaster sm
//			where m.coop_id = sm.coop_id
//			and m.member_no = sm.member_no 
//			and m.coop_id = mas.coop_id
//			and m.member_no = mas.member_no
//		)
//where mas.coop_id = :is_coopcontrol
//and mas.operate_date = :ldtm_oper
//and mas.adjsal_type = 'PRC'
//and mas.posting_flag = 0
//using itr_sqlca;
//if itr_sqlca.sqlcode <> 0 then
//	ithw_exception.text	= "ไม่สามารถทำรายการได้ อัพเดทข้อมูลเก่า (70.01)"
//	ithw_exception.text	+= string( itr_sqlca.sqlcode ) + " : " + itr_sqlca.sqlerrtext
//	ithw_exception.text	+= "กรุณาตรวจสอบ"
//	lb_err = true ; Goto objdestroy;
//end if

/*Update New Salary( Mbadjsalary )*/
//update mbadjsalary mas
//set 	( 	mas.new_sharebase ) = 
//		( 	select ( 
//			case 
//			when ( ( mas.new_salary * stmr.sharerate_percent ) / ( 100 * st.unitshare_value ) ) < stmr.minshare_amt then stmr.minshare_amt 
//			when ( ( mas.new_salary * stmr.sharerate_percent ) / ( 100 * st.unitshare_value ) ) > stmr.maxshare_amt then stmr.maxshare_amt 
//			else 0 end ) as shramt
//			from shsharetypemthrate stmr , shsharetype st , mbmembmaster m
//			where stmr.coop_id = st.coop_id
//			and stmr.sharetype_code = st.sharetype_code
//			and m.coop_id = mas.coop_id
//			and m.member_no = mas.member_no
//			and m.member_type = stmr.member_type
//			and stmr.coop_id = mas.coop_id
//			and stmr.sharetype_code = mas.sharetype_code
//			and mas.new_salary between stmr.start_salary and stmr.end_salary
//		)
//where mas.coop_id = :is_coopcontrol
//and mas.operate_date = :ldtm_oper
//and mas.adjsal_type = 'PRC'
//and mas.posting_flag = 0
//using itr_sqlca;
//if itr_sqlca.sqlcode <> 0 then
//	ithw_exception.text	= "ไม่สามารถทำรายการได้ อัพเดทข้อมูลใหม่ (70.02)"
//	ithw_exception.text	+= string( itr_sqlca.sqlcode ) + " : " + itr_sqlca.sqlerrtext
//	ithw_exception.text	+= "กรุณาตรวจสอบ"
//	lb_err = true ; Goto objdestroy;
//end if

/*Update Share Period( Mbadjsalary )*/
//update mbadjsalary mas
//set mas.new_shareperiod = ( case when mas.old_shareperiod < mas.new_sharebase then mas.new_sharebase else mas.old_shareperiod end )
//where mas.coop_id = :is_coopcontrol
//and mas.operate_date = :ldtm_oper
//and mas.adjsal_type = 'PRC'
//and mas.posting_flag = 0
//using itr_sqlca;
//if itr_sqlca.sqlcode <> 0 then
//	ithw_exception.text	= "ไม่สามารถทำรายการได้ อัพเดทข้อมูลหุ้นส่งต่อเดือน (70.03)"
//	ithw_exception.text	+= string( itr_sqlca.sqlcode ) + " : " + itr_sqlca.sqlerrtext
//	ithw_exception.text	+= "กรุณาตรวจสอบ"
//	lb_err = true ; Goto objdestroy;
//end if
*/
end function

public function integer of_setprogress (ref n_cst_progresscontrol anv_progress) throws Exception;anv_progress = inv_progress

return 1
end function

on n_cst_membsrv_audit.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_membsrv_audit.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ithw_exception = create Exception
end event

event destructor;this.of_setsrvdwxmlie( false )
end event

