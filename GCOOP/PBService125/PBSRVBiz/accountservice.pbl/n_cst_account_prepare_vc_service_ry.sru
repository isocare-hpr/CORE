$PBExportHeader$n_cst_account_prepare_vc_service_ry.sru
$PBExportComments$ตัวบริการ เตรียมข้อมูลระบบบัญชี ของการทางพิเศษ
forward
global type n_cst_account_prepare_vc_service_ry from NonVisualObject
end type
end forward

/// <summary> ตัวบริการ เตรียมข้อมูลระบบบัญชี ของการทางพิเศษ
/// </summary>
global type n_cst_account_prepare_vc_service_ry from NonVisualObject
end type
global n_cst_account_prepare_vc_service_ry n_cst_account_prepare_vc_service_ry

type variables
public:
n_cst_progresscontrol	inv_progresscontrol

protected:
Exception		ithw_exception
transaction		itr_sqlca

string				is_acccash ,is_benifit_total_acc , is_benifit_account_id , is_pay[], is_rcv[] , is_vcdocno[]
string				is_account_pl_pf, is_finstatus_code, is_vctype_docno
integer			ii_present_year, ii_begin_year, ii_begin_period
datetime			idtm_beginning_of_accou,idtm_ending_of_account
integer			ii_split_vcdetail  = 0 , ii_set_vcdetail  = 1
string				is_vcpaydocno, is_vcrcvdocno,is_vcrcvtrndocno

n_cst_datetimeservice		inv_datetime
n_cst_doccontrolservice		inv_docservice
n_cst_stringservice			inv_string
n_cst_progresscontrol		inv_progress
n_cst_account_service		inv_account_service

datastore	ids_vcproc
n_ds			ids_vcrcvpay, ids_vcrcvpaydet,  ids_vcrcv, ids_vcrcvdet,  ids_vcpay, ids_vcpaydet, ids_voucher,ids_voucherdet 
n_ds			ids_acccont , ids_mapaccid
end variables

forward prototypes
public function integer of_settrans (n_cst_dbconnectservice anv_db)
private function any of_getattribmapaccid (string as_coopid, string as_system, string as_slipitem, string as_shrlontype, integer ai_itemstatus, string as_attribmap) throws Exception
public function integer of_vcproc (datetime adtm_sysdate, string as_sysgencode, string as_coopid, string as_userid) throws Exception
private function string of_getvoucher_no (datetime adtm_date, string as_voucher_type, ref string as_voucher_no, string as_coopid) throws Exception
private function integer of_vccashdppay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_addvoucher (string as_vcdocno, datetime adtm_vcdate, string as_vctype, string as_vcdesc, decimal adc_vcamt, DataStore ads_vchead, string as_system_code, string as_coopid, string as_userid) throws Exception
private function integer of_vccashlnpay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vccashlnrcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vccashdprcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vccashfinpay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vccashfinrcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_additem (string as_coopid, string as_voucherno, string as_syscode, string as_vcgrpno, string as_accid, string as_accside, decimal adc_itemamt, long al_sortorder, ref n_ds ads_voucherdet, string as_userid) throws Exception
private function integer of_additemdesc (string as_coopid, string as_voucherno, string as_syscode, string as_vcgrpno, string as_accid, string as_accside, decimal adc_itemamt, string as_desc, long al_sortorder, ref n_ds ads_voucherdet) throws Exception
private function integer of_vccashshrcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vccashshpay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrnpayin (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrnpayout (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrnshrrcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrnshrpay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrnfinrcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrnfinpay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrnpayout_atm (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrn_kpmonth (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrn_cancel_kp_month (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrn_cancel_kp_month_slip (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrnpayin_shr (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vccashlnrcv_shr (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrndppay_rcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
public function integer of_gen_vc_close_year (integer ai_year, integer ai_period, string as_coopid) throws Exception
private function integer of_vccashfinrcv_tax (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_set_voucher_no (datetime adtm_date, string as_coopid, string as_type) throws Exception
private function integer of_vctrndppay_rcv_due (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrnpayin_shr_dept (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrndppay_atm (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vccashdprcv_fee (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
end prototypes

public function integer of_settrans (n_cst_dbconnectservice anv_db);//////////////////////////////////////////////////////////////////////////////
//	Function Name:	of_init
//
//	Arguments:
//	anv_db			object ที่ใช้สำหรับการเชื่อมต่อฐานข้อมูล
//
//	Returns:  		integer
//						ค่าที่ส่งออกไป บอกผลลัพท์ว่า function นี้ถูกเรียกใช้แล้ว
//
//	Description: 	เพื่อทำการกำหนดค่าการเชื่อมต่อฐานข้อมูลให้กับ ตัวแปร instant itr_sqlca
//////////////////////////////////////////////////////////////////////////////

itr_sqlca	= anv_db.itr_dbconnection

inv_docservice				= create n_cst_doccontrolservice
inv_string					= create n_cst_stringservice
inv_datetime				= create n_cst_datetimeservice
inv_progresscontrol			= create n_cst_progresscontrol

inv_docservice.of_settrans( anv_db )

//หาบัญชีเงินสด
select  	cash_account_code
into		:is_acccash 
from		accconstant 
using    	itr_sqlca  ;	

//หาประเภทการรันเลขเอกสาร 01 = ขึ้นเลขใหม่ทุกเดือน , 02= ขึ้นเลขใหม่ทุกปี
select  	finstatus_code
into		:is_vctype_docno 
from		accconstant 
using    	itr_sqlca  ;	

if IsNull( is_vctype_docno ) or is_vctype_docno = "" then is_vctype_docno = '02'

ids_vcrcv	= create n_ds
ids_vcrcv.dataobject	= "d_vc_gnrate_voucher"
ids_vcrcv.settransobject( itr_sqlca )

ids_vcrcvdet	= create n_ds
ids_vcrcvdet.dataobject	= "d_vc_gnrate_voucherdet"
ids_vcrcvdet.settransobject( itr_sqlca )

ids_vcpay	= create n_ds
ids_vcpay.dataobject	= "d_vc_gnrate_voucher"
ids_vcpay.settransobject( itr_sqlca )

ids_vcpaydet	= create n_ds
ids_vcpaydet.dataobject	= "d_vc_gnrate_voucherdet"
ids_vcpaydet.settransobject( itr_sqlca )

ids_vcrcvpay	= create n_ds
ids_vcrcvpay.dataobject	= "d_vc_gnrate_voucher"
ids_vcrcvpay.settransobject( itr_sqlca )

ids_vcrcvpaydet	= create n_ds
ids_vcrcvpaydet.dataobject	= "d_vc_gnrate_voucherdet"
ids_vcrcvpaydet.settransobject( itr_sqlca )

ids_voucher	= create n_ds
ids_voucher.dataobject	= "d_vc_gnrate_voucher"
ids_voucher.settransobject( itr_sqlca )

ids_voucherdet	= create n_ds
ids_voucherdet.dataobject	= "d_vc_gnrate_voucherdet"
ids_voucherdet.settransobject( itr_sqlca )

ids_mapaccid	= create n_ds
ids_mapaccid.dataobject	= "d_vc_mapaccid"
ids_mapaccid.settransobject( itr_sqlca )
ids_mapaccid.retrieve( )

ids_acccont 	= create n_ds
ids_acccont.dataobject	= "d_vc_acccont"
ids_acccont.settransobject( itr_sqlca )
ids_acccont.retrieve( )

return 1
end function

private function any of_getattribmapaccid (string as_coopid, string as_system, string as_slipitem, string as_shrlontype, integer ai_itemstatus, string as_attribmap) throws Exception;/***********************************************************
<description>
	ประมวลผลดึง รหัสบัญชี จาก vcmapaccid
</description>

<arguments>

</arguments> 

<return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/

integer	li_row
any		la_attrib


if isnull( as_shrlontype ) or trim( as_shrlontype ) = "" then as_shrlontype = "00"

if isnull( ai_itemstatus ) then ai_itemstatus = 1

// validate parameter
li_row	= ids_mapaccid.find( " coop_id = '"+as_coopid+"' and system_code = '"+as_system+"' and slipitemtype_code = '"+as_slipitem+"' and shrlontype_code = '"+as_shrlontype+&
							   "' and shrlontype_status = "+string( ai_itemstatus )  , 0 , ids_mapaccid.rowcount() )
if li_row > 0 then	
	la_attrib	= ids_mapaccid.GetitemString( li_row,as_attribmap  )	
end if

return la_attrib
end function

public function integer of_vcproc (datetime adtm_sysdate, string as_sysgencode, string as_coopid, string as_userid) throws Exception;/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี สอ.ครูระยอง
</description>
<arguments>
sysdate , sysgen , coopid , userid
</arguments>
<return> 
	Integer	1 = success,  throwable = failure
</return> 
<usage> 	
	Revision History:
	Version 1.0 (Initial version) Modified Date 23/09/2016 by Sakuraii
</usage> 
***********************************************************/

string		ls_coopid ,  ls_userid , ls_sysgencode
integer		li_recv, li_pay, li_trn, li_atm, li_dtm, li_kep
integer		li_chk, li_row  , li_count, li_check
datetime	ldtm_vcdate
boolean		lb_genamt

ldtm_vcdate			=	adtm_sysdate
ls_sysgencode		=	as_sysgencode
ls_coopid			=	trim ( as_coopid )   
ls_userid			=	trim ( as_userid  ) 


////////////////////    set เลขที่ voucher_no   ///////////////////////////////////
li_check = this.of_set_voucher_no( adtm_sysdate , as_coopid, is_vctype_docno )  //01 = ขึ้นเลขใหม่ทุกเดือน , 02= ขึ้นเลขใหม่ทุกปี

choose case ls_sysgencode
		
	case "ALL"	// ทั้งหมด ##	
		li_recv	=	1
		li_pay	=	1
		li_trn	=	1
		li_kep	=	1

	case  "ANC" //ทั้งหมดยกเว้นเงินสด ##
		li_trn	=	1

	case "CSH"  //เงินสด ##
		li_recv	=	1
		li_pay	=	1

	case "ATM" //รายการ ATM
		li_atm	=	1
		
	case "KEP" //รายการเรียกเก็บประจำเดือน
		li_kep	=	1
		
	case "DTM" //รายการถอนเงินฝากตู้ ATM
		li_dtm	=	1

end choose		

//+++++++++++++++++++++++++++++++++++++++++++++
//รายการรับเงินสด  ===CSH
//+++++++++++++++++++++++++++++++++++++++++++++

if li_recv = 1 then
//รับชำระเงินสด + ซื้อหุ้น##
li_chk = this.of_vccashlnrcv_shr( ldtm_vcdate , ls_coopid  , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	

//รายการเงินฝาก
li_chk = this.of_vccashdprcv( ldtm_vcdate ,ls_coopid ,  ls_userid ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
	
	//รายการเงินฝาก ค่าปรับ
li_chk = this.of_vccashdprcv_fee( ldtm_vcdate ,ls_coopid ,  ls_userid ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	

//การเงินรับ
li_chk = this.of_vccashfinrcv( ldtm_vcdate ,ls_coopid ,  ls_userid ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
	//รับภาษีหัก ณ ที่จ่าย
	li_chk = this.of_vccashfinrcv_tax( ldtm_vcdate ,ls_coopid ,  ls_userid ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
		
end if

//+++++++++++++++++++++++++++++++++++++++++++++
//รายการจ่ายเงินสด  ====CSH
//+++++++++++++++++++++++++++++++++++++++++++++
if li_pay  = 1 then	
//จ่ายเงินกู้ เงินสด ##
	li_chk = this.of_vccashlnpay ( ldtm_vcdate , ls_coopid , ls_userid  )  
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	

//ถอนเงินรวมปิดบัญชี  ##
	li_chk = this.of_vccashdppay( ldtm_vcdate ,ls_coopid ,  ls_userid ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	

	//การเงินจ่ายของสหกรณ์
	li_chk = this.of_vccashfinpay( ldtm_vcdate ,ls_coopid ,  ls_userid ) 
		if li_chk = 1 then
			lb_genamt = true
		else
			rollback using itr_sqlca ;
			throw ithw_exception
		end if
	
		//ซื้อหุ้น เงินสด
	li_chk = this.of_vccashshpay( ldtm_vcdate ,ls_coopid ,  ls_userid ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
end if

//+++++++++++++++++++++++++++++++++++++++++++++
//รายการเงินโอนการเงิน  ====TRN
//+++++++++++++++++++++++++++++++++++++++++++++
if li_trn = 1 then
	 //*****************ชำระหนี้ slslippayin *****************************
	//รับชำระหนี้ ##
	li_chk = this.of_vctrnpayin_shr( ldtm_vcdate , ls_coopid  , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
	
	//ถอเงินฝาก ชำระหนี้ ## 
	li_chk = this.of_vctrnpayin_shr_dept( ldtm_vcdate , ls_coopid  , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
	
	//**********************จ่ายกู้ หักกลบ  slslippayout slslippayin **************************
	//จ่ายเงินกู้ + หักกลบ##
	li_chk = this.of_vctrnpayout( ldtm_vcdate , ls_coopid  , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
	
	//*************************เงินฝาก dpdeptslip ***************************************
	//ฝาก - ถอน ปกติ
	li_chk = this.of_vctrndppay_rcv( ldtm_vcdate , ls_coopid  , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
	
	 //ฝาก - ถอน ครบกำหนด		
	li_chk = this.of_vctrndppay_rcv_due( ldtm_vcdate , ls_coopid  , ls_userid  )
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if		

	//***************************** หุ้น slslippayin slslippayout *********************************
	//โอนเงินซื้อหุ้น
	li_chk = this.of_vctrnshrrcv( ldtm_vcdate , ls_coopid  , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	

	// คืนค่าหุ้น
	li_chk = this.of_vctrnshrpay( ldtm_vcdate , ls_coopid  , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	

	//******************************** การเงิน finslip **************************************
	// การเงินรับ
	li_chk = this.of_vctrnfinrcv( ldtm_vcdate , ls_coopid  , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	

	// การเงินจ่าย
	li_chk = this.of_vctrnfinpay( ldtm_vcdate , ls_coopid  , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
end if 


//+++++++++++++++++++++++++++++++++++++++++++++
//รายการเงินโอนการเงิน ATM ====TRN
//+++++++++++++++++++++++++++++++++++++++++++++

if li_atm = 1 then
		//จ่ายเงินกู้ ATM##
li_chk = this.of_vctrnpayout_atm( ldtm_vcdate , ls_coopid  , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
end if


//+++++++++++++++++++++++++++++++++++++++++++++
//รายการเรียกเก็บประจำเดือน====TRN
//+++++++++++++++++++++++++++++++++++++++++++++

if 	li_kep = 1 then
		//เรียกเก็บ
li_chk = this.of_vctrn_kpmonth( ldtm_vcdate , ls_coopid  , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
	//ยกเลิกกระดาษทำการ(ยกเลิกเรียกเก็บ)
	li_chk = this.of_vctrn_cancel_kp_month( ldtm_vcdate , ls_coopid  , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
	//ยกเลิกใบเสร็จ(ยกเลิกเรียกเก็บ)
	li_chk = this.of_vctrn_cancel_kp_month_slip( ldtm_vcdate , ls_coopid  , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
	
end if

//+++++++++++++++++++++++++++++++++++++++++++++
//รายการถอนเงินฝาก atm ====TRN
//+++++++++++++++++++++++++++++++++++++++++++++
if li_dtm = 1 then
	li_chk = this.of_vctrndppay_atm( ldtm_vcdate , ls_coopid  , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
end if


//*********************************************

//update
if ids_vcrcvdet.update() <> 1 then
	rollback using	itr_sqlca ; 
end if

if ids_vcpaydet.update() <> 1 then
	rollback using	itr_sqlca ; 
end if

if ids_vcrcvpaydet.update() <> 1 then
	rollback using	itr_sqlca ; 
end if 

commit  	using	itr_sqlca ; 

return 1
end function

private function string of_getvoucher_no (datetime adtm_date, string as_voucher_type, ref string as_voucher_no, string as_coopid) throws Exception;/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี  สร้างเลขที่เอกสาร
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/

string				ls_column, ls_year, ls_date, ls_month, ls_docno
integer			li_year, li_fount
datetime			ldtm_operate

ls_column			= "CMVOUCHERNO_" + trim (as_voucher_type)
ls_docno			= inv_docservice.of_getnewdocno( as_coopid ,ls_column )

ldtm_operate		= adtm_date
ls_date				= string(date(ldtm_operate),'dd')
ls_month				= string(date(ldtm_operate),'mm')
ls_year				= string(date(ldtm_operate),'yyyy')
li_year				= integer(ls_year)+543
ls_year				= RightA(string(li_year),2)
as_voucher_no		= as_voucher_type + ls_year+ ls_month + rightA( ls_docno, 4 )
li_fount				= 0

// ตรวจสอบดูว่ามีข้อมูลใน DB หรือยัง
select		count( * )
into		:li_fount
from		vcvoucher
where	coop_id			= :as_coopid  and  
			voucher_no		= :as_voucher_no 
using itr_sqlca ;

if isnull( li_fount ) then li_fount = 0

if ( li_fount > 0 ) then
	this.of_getvoucher_no( adtm_date , as_voucher_type , as_voucher_no ,as_coopid   )
end if

return  as_voucher_no
end function

private function integer of_vccashdppay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception;/***********************************************************
Version 2.0
<description>
	ประมวลผลดึงรายการบัญชี   ==> ถอน + ปิดบัญชี แยกดอกเบี้ย เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
	Version 2.0 (Initial version) Modified Date 19/02/2015 by Sakuraii
</usage> 
***********************************************************/
string			ls_slipno, ls_accid, ls_accintarrid, ls_colname, ls_colsort, ls_depttype, ls_tofromaccid
string			ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp, ls_desc, ls_voucher_type, ls_itemdesc
long			ll_index, ll_count, ll_sortacc, ll_index2
dec{2}			ldc_itempay, ldc_int_amt, ldc_intreturn, ldc_taxreturn, ldc_itempaynet, ldc_tax, ldc_orther
string			ls_acccash, ls_coopid, ls_accint, ls_tax, ls_feeid, ls_deptgroupcode, ls_accid_bf
integer			li_payfee_meth

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	="d_vc_slip_data_cashdppay"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpsystem		= "DEP"
ls_tmpvcgrp			= "PAY"
ll_index2			= 1
////// สร้างเลข Voucher
	 
	 if  is_vcpaydocno    =  ""  then
			ls_voucher_type	= "PV"
			ls_desc  		= "เงินสดจ่ายประจำวัน"		
			is_vcpaydocno	= this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcpaydocno , as_coopid  )
			this.of_addvoucher( is_vcpaydocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcpay , 'CSH'  , as_coopid  , as_userid )		
		else
			ids_vcpay.retrieve( is_vcpaydocno )
			ids_vcpaydet.retrieve( is_vcpaydocno )
	 end if 	

//end if		

for ll_index = 1 to ll_count

	ls_slipno				= lds_slipdata.object.deptslip_no[ ll_index ]
	ls_depttype				= lds_slipdata.object.depttype_code[ ll_index ]
	ls_tofromaccid			= lds_slipdata.object.tofrom_accid[ ll_index ]
	ldc_itempay				= lds_slipdata.object.deptslip_amt[ ll_index ]
	ldc_int_amt				= lds_slipdata.object.int_amt[ ll_index ]	
	ldc_intreturn			= lds_slipdata.object.int_return[ ll_index ]
	ls_deptgroupcode		= lds_slipdata.object.deptgroup_code[ ll_index ]
	ldc_itempay				= lds_slipdata.object.deptslip_amt[ ll_index ] 
	ldc_taxreturn			= lds_slipdata.object.tax_return[ ll_index ]
	ldc_itempaynet			= lds_slipdata.object.deptslip_netamt[ ll_index ]
	ls_coopid				= lds_slipdata.object.coop_id[ ll_index ]
	ldc_tax					= lds_slipdata.object.tax_amt[ ll_index ] 
	ldc_orther				=  lds_slipdata.object.other_amt[ ll_index ]  //ค่าปรับเงินฝาก
	li_payfee_meth			= lds_slipdata.object.payfee_meth[ ll_index ] //วิธีการปรับ 1.ปรับเงินสด 2.ปรับจากยอดถอน 3.ปรับจากในบัญชี
	
	if isnull( ldc_tax ) then ldc_tax = 0
	if isnull( ldc_int_amt ) then ldc_int_amt = 0
	if isnull( ldc_taxreturn ) then ldc_taxreturn = 0
	if isnull( ldc_intreturn ) then ldc_intreturn = 0
	if isnull( ldc_orther ) then ldc_orther = 0
	if IsNull( li_payfee_meth ) then li_payfee_meth = 1

		//กรณ๊เงินสด ถ้าปรับจากยอดถอน ให้ลงรายการถอนเต็มจำนวน แล้วลงรายการรับเป็นค่าปรับ
	if li_payfee_meth = 2 then
		ldc_itempaynet = ldc_itempaynet + ldc_orther
	end if
	
		
	ls_accid				= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1,  "account_id"  ) )
	ls_accintarrid			= string( of_getattribmapaccid( as_coopid, "DEP", "DEP", ls_depttype, 1, "accintarr_id"  ) )
	ls_accint				= string( of_getattribmapaccid( as_coopid, "DEP", "DEP", ls_depttype, 1, "accint_id"  ) )
	ls_tax					= string( of_getattribmapaccid( as_coopid, "DEP", "DEP", ls_depttype, 1, "acctax_id"  ) )	
	ls_feeid				= string( of_getattribmapaccid( as_coopid ,"DEP", "FEE", "00", 1,  "account_id"  ) ) //ค่าปรับ
			
	ls_accside		= "DR"
	ls_accrevside	= "CR"	
	
	if  isnull (ls_tofromaccid ) or ls_tofromaccid <>  is_acccash then
		ls_tofromaccid		= 	is_acccash
	end if
	
	
		// รายการฝั่ง DR
	if ( ldc_itempaynet > 0 ) then
		this.of_additemdesc( as_coopid , is_vcpaydocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempaynet, "เงินสดจ่ายประจำวัน", ll_sortacc, ids_vcpaydet )  
	end if
	
	//	รายการฝั่ง CR
	if ( ldc_itempaynet > 0 ) then
		this.of_additemdesc( as_coopid , is_vcpaydocno, "CSH", "CSH", ls_tofromaccid, ls_accrevside, ldc_itempaynet, "เงินสดจ่ายประจำวัน", 1, ids_vcpaydet ) 
	end if

	
	// Update สถานะการผ่าน Voucher
	if	not isnull(is_vcpaydocno)    	then
		update	dpdeptslip
		set		posttovc_flag	= 1,	
				voucher_no		= :is_vcpaydocno
		where	( deptslip_no	= :ls_slipno ) and
				( deptcoop_id 	= :as_coopid) and
				( coop_id 		= :ls_coopid)
		using itr_sqlca;
	end if
	
	ls_accid_bf = ls_accid
		
next

// update Vc
if ids_vcpay.update() <> 1 then
	return -1
end if
	
if ids_vcpaydet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

destroy (lds_slipdata)
return 1
end function

private function integer of_addvoucher (string as_vcdocno, datetime adtm_vcdate, string as_vctype, string as_vcdesc, decimal adc_vcamt, DataStore ads_vchead, string as_system_code, string as_coopid, string as_userid) throws Exception;/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี  บันทึก รายการหลัก
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/

string				ls_userid
long				ll_row
datetime			ldtm_entry
integer			li_cash_type, li_vcdocmax

ldtm_entry			= datetime ( today() , now() )
ls_userid				= trim ( as_userid )

choose case as_vctype
	case  	'PV'
		li_cash_type			= 1	
	case	'RV'	
		li_cash_type			= 1	
	case	'TV'	
		li_cash_type			= 2
	case	'JV'	
		li_cash_type			= 2
	case else
		li_cash_type			= 3
end choose		

ll_row	= ads_vchead.insertrow( 0 )

ads_vchead.setitem( ll_row, "coop_id", as_coopid ) 
ads_vchead.setitem( ll_row, "voucher_no", as_vcdocno )
ads_vchead.setitem( ll_row, "voucher_date", adtm_vcdate )
ads_vchead.setitem( ll_row, "voucher_type", as_vctype )
ads_vchead.setitem( ll_row, "voucher_desc", as_vcdesc )
ads_vchead.setitem( ll_row, "voucher_amt", adc_vcamt )
ads_vchead.setitem( ll_row, "entry_id", ls_userid )
ads_vchead.setitem( ll_row, "entry_date", ldtm_entry )
ads_vchead.setitem( ll_row, "system_code", as_system_code )
ads_vchead.setitem( ll_row, "cash_type", li_cash_type )

li_vcdocmax	= upperbound( is_vcdocno[] )

if isnull( li_vcdocmax ) then
	li_vcdocmax	= 0
end if

li_vcdocmax ++
is_vcdocno[ li_vcdocmax ]	= as_vcdocno

return 1
end function

private function integer of_vccashlnpay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
 Version 2.0
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการจ่ายเงินกู้ เงินสด  ยอดหักกลบลงรายการฝั่งรับ(RV)
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
	Version 2.0 (Initial version) Modified Date 19/02/2015 by Sakuraii
</usage> 
***********************************************************/
string		ls_slipno, ls_accid, ls_accintid, ls_accintarrid  ,ls_slipno_bf, ls_desc, ls_voucher_type
string		ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp, ls_itemtypeshr, ls_accshr, ls_desc_rv
string		ls_shrlontype, ls_sliptype, ls_itemtype, ls_tofromaccid, ls_slipitemtype_code
string		ls_slipclr, ls_accid_clc, ls_shrloncode, ls_memgroup, ls_coopid, ls_accid_bf, ls_itemdesc
integer	li_shrlonstatus, li_slipflag
long		ll_index, ll_count, ll_sortacc, ll_index2
dec{2}	ldc_prinpay, ldc_intpay, ldc_intarrpay, ldc_itempay, ldc_int, ldc_shrpay


datastore	lds_slipdata

// ds สำหรับดึงข้อมูลการจ่ายเงินกู้
lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cashlnpay"
lds_slipdata.settransobject( itr_sqlca )

ll_count			= lds_slipdata.retrieve( adtm_vcdate , as_coopid   )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if
ls_tmpsystem		= "LON"
ls_tmpvcgrp			= "PAY"
ll_index2 			= 1

	 //สร้างเลขที่ Voucher
 if  is_vcrcvdocno = ""    then
		ls_voucher_type	= "RV"
		ls_desc_rv		= "เงินสดรับประจำวัน"		
		is_vcrcvdocno	= this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvdocno , as_coopid  )
		this.of_addvoucher( is_vcrcvdocno , adtm_vcdate , ls_voucher_type ,  ls_desc, 0 , ids_vcrcv , 'CSH'  , as_coopid  , as_userid )		
	else
		ids_vcrcv.retrieve( is_vcrcvdocno )
		ids_vcrcvdet.retrieve( is_vcrcvdocno )
 end if 	
	 
	 if  is_vcpaydocno    =  ""  then
			ls_voucher_type	= "PV"
			ls_desc  				= "เงินสดจ่ายประจำวัน"		
			is_vcpaydocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcpaydocno , as_coopid  )
			this.of_addvoucher( is_vcpaydocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcpay , 'CSH'  , as_coopid  , as_userid )		
		else
			ids_vcpay.retrieve( is_vcpaydocno )
			ids_vcpaydet.retrieve( is_vcpaydocno )
			ids_vcrcv.retrieve( is_vcrcvdocno )
			ids_vcrcvdet.retrieve( is_vcrcvdocno )
	 end if 	
	 
//ทำรายการ Voucher	 
for ll_index = 1 to ll_count 
	
	ls_coopid				= lds_slipdata.object.coop_id[ ll_index ]
	ls_slipno				= lds_slipdata.object.payoutslip_no[ ll_index ]
	ls_shrlontype			= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_tofromaccid			= lds_slipdata.object.tofrom_accid[ ll_index ]
	li_shrlonstatus			= 1
	li_slipflag				= lds_slipdata.object.sliptypesign_flag[ ll_index ]
	ldc_itempay				= lds_slipdata.object.payout_amt[ ll_index ]
	ls_sliptype				= lds_slipdata.object.sliptype_code [ ll_index ]
	ldc_int					= lds_slipdata.object.interest_payamt [ ll_index ]
	ldc_prinpay				= lds_slipdata.object.principal_payamt [ ll_index ]
	ls_shrloncode			= lds_slipdata.object.slslippayindet_shrlontype_code [ ll_index ]
	ls_slipclr				= lds_slipdata.object.slipclear_no[ ll_index ]
	ls_memgroup				= lds_slipdata.object.membgroup_code[ ll_index ]
	ls_slipitemtype_code	= lds_slipdata.object.slipitemtype_code[ ll_index ]
	ldc_shrpay				= lds_slipdata.object.item_payamt [ ll_index ]
	
	if isnull(ls_itemtype) or ls_itemtype = "" then ls_itemtype = 'LON'
	if isnull(ldc_prinpay) then ldc_prinpay = 0
	if isnull(ldc_itempay) then ldc_itempay = 0
	if isnull(ldc_int) then ldc_int = 0
	if isnull(ls_shrloncode) then ls_shrloncode = '00'
	
		choose case ls_sliptype
		case  'LWD'	
			ls_itemtype		= 'LON'
		case  'SWD'	,'SWT','SWP'
			ls_itemtype		= 'SHR'
	end choose		

	
	ls_accid			= string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype , ls_shrlontype, li_shrlonstatus, "account_id" ) )
	ls_accintid		= string	( of_getattribmapaccid(as_coopid, "LON", ls_itemtype , ls_shrloncode, li_shrlonstatus, "accint_id" ) )
	ls_accintarrid	= string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype , ls_shrloncode, li_shrlonstatus, "accintarr_id"  ) )
	ll_sortacc		= long	( of_getattribmapaccid(as_coopid,"LON", ls_itemtype , ls_shrlontype, li_shrlonstatus, "sortacc_order"   ) )
	ls_accid_clc		= string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype , ls_shrloncode, li_shrlonstatus, "account_id" ) )
	
	if ( li_slipflag > 0 ) then
		ls_accside		= "CR"
		ls_accrevside	= "DR"
	else
		ls_accside		= "DR"
		ls_accrevside	= "CR"
	end if

	
	if  isnull (ls_tofromaccid ) or ls_tofromaccid <>  is_acccash then
		ls_tofromaccid		= 	is_acccash
	end if
	
		if trim(ls_slipitemtype_code) = 'LON' then 
				
	else
		choose case ls_slipitemtype_code
				
			case  'SHR' //ค่าหุ้น
				ls_itemtypeshr		= 'SHR'
				ls_shrlontype	= '01'
				ls_accshr = string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtypeshr , ls_shrlontype, li_shrlonstatus, "account_id" ) )
			case  'INF' //ค่าดอกเบี้ยล่วงหน้า
				ls_itemtypeshr		= trim(ls_slipitemtype_code)
				ls_accshr = string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtypeshr , ls_shrlontype, li_shrlonstatus, "account_id" ))
			case else
				ls_itemtypeshr		= trim(ls_slipitemtype_code)
				ls_shrlontype	= '00'
				ls_accshr = string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtypeshr , ls_shrlontype, li_shrlonstatus, "account_id" ) )
			
		end choose
	end if
	
		// hare_code เพื่อแยกประเภทหุ้นของสมาชิกปกติ กับ สมทบ by Mike 04/09/2013 สำหรับระยอง
	if(left(ls_memgroup,1) = 'S' ) and ls_itemtype = 'SHR' then
		ls_accid = string( of_getattribmapaccid( as_coopid, "LON", "SHR" , "S1", 1, "account_id" ) )  
	end if


if isnull (ls_slipclr) or ls_slipclr = "" then //เช็คว่ามีหักกลบรึป่าว
	// รายการจ่ายเงิน
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid , is_vcpaydocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid  , ls_accside, ldc_itempay, "เงินสดจ่ายประจำวัน", ll_sortacc, ids_vcpaydet)
	end if
	
	// รายการฝั่งตรงข้าม
	if 	( ldc_itempay > 0 ) then		
		this.of_additemdesc( as_coopid , is_vcpaydocno, "CSH", "CSH", ls_tofromaccid, ls_accrevside, ldc_itempay, "เงินสดจ่ายประจำวัน", 1, ids_vcpaydet)
	end if
	
else
	///////////////////////////////////ท่อนนี้ยิงลง PV/////////////////////////////////////////////////////
			// รายการจ่ายเงิน
	if(ls_slipno_bf <> ls_slipno) then
		if ( ldc_itempay > 0 ) then
			this.of_additemdesc( as_coopid ,  is_vcpaydocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid  , ls_accside, ldc_itempay, "เงินสดจ่ายประจำวัน", ll_sortacc, ids_vcpaydet)
		end if

		if (ldc_itempay > 0) then
			this.of_additemdesc( as_coopid , is_vcpaydocno, "CSH", "CSH", ls_tofromaccid, ls_accrevside, ldc_itempay, "เงินสดจ่ายประจำวัน", 1, ids_vcpaydet)
		end if
	end if
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////ท่อนนี้ยิงลง RV////////////////////////////////////////////////////
	choose case ls_slipitemtype_code
		case 'LON'
	if 	( ldc_prinpay > 0 ) then	
		this.of_additemdesc( as_coopid , is_vcrcvdocno ,ls_tmpsystem, ls_tmpvcgrp, ls_accid_clc , ls_accrevside, ldc_prinpay  , "เงินสดรับประจำวัน", ll_sortacc, ids_vcrcvdet)
		this.of_additemdesc( as_coopid , is_vcrcvdocno ,"CSH", "CSH", ls_tofromaccid , ls_accside, ldc_prinpay  , "เงินสดรับประจำวัน", 1 , ids_vcrcvdet)
	end if

	if ( ldc_int > 0 ) then
		this.of_additemdesc( as_coopid ,  is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accintid , ls_accrevside, ldc_int, "เงินสดรับประจำวัน", ll_sortacc, ids_vcrcvdet)
		this.of_additemdesc( as_coopid , is_vcrcvdocno ,"CSH", "CSH", ls_tofromaccid , ls_accside, ldc_int   , "เงินสดรับประจำวัน", 1 , ids_vcrcvdet)
	end if
case else
		if 	( ldc_shrpay > 0 ) then	
		this.of_additemdesc( as_coopid , is_vcrcvdocno ,ls_tmpsystem, ls_tmpvcgrp, ls_accshr , ls_accrevside, ldc_shrpay , "เงินสดรับประจำวัน", ll_sortacc, ids_vcrcvdet)
		this.of_additemdesc( as_coopid , is_vcrcvdocno ,"CSH", "CSH", ls_tofromaccid , ls_accside, ldc_shrpay   , "เงินสดรับประจำวัน", 1 , ids_vcrcvdet)
	end if 
		
end choose
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
end if
	
	// Update สถานะการผ่าน Voucher
	if	ls_slipno	<> ls_slipno_bf		then
		update		slslippayout
		set				posttovc_flag		= 1,	
						voucher_no			= :is_vcpaydocno
		where		( payoutslip_no		= :ls_slipno ) and
						(memcoop_id		= :as_coopid) and
						(coop_id				= :ls_coopid)

		using     itr_sqlca   ;							
	end if
	
	ls_slipno_bf		= ls_slipno
	ls_accid_bf		= ls_accid
	
next

destroy (lds_slipdata)

//update
if ids_vcpay.update() <> 1 then	
	return -1
end if
	
if ids_vcpaydet.update() <> 1 then
	return -1
end if

if ids_vcrcv.update() <> 1 then
	return -1
end if

if ids_vcrcvdet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

return 1
end function

private function integer of_vccashlnrcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
 Version 2.0
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการชำระ เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
	Version 2.0 (Initial version) Modified Date 19/02/2015 by Sakuraii
</usage> 
***********************************************************/

string		ls_slipno, ls_accid, ls_accintid, ls_accintarrid, ls_slipno_bf, ls_desc
string		ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp, ls_voucher_type
string		ls_shrlontype, ls_itemtype, ls_tofromaccid, ls_memgroup, ls_coopid
integer	li_shrlonstatus, li_slipflag
long		ll_index, ll_count, ll_sortacc, ll_sortint
dec{2}	ldc_prinpay, ldc_intpay, ldc_itempay, ldc_intarrpay, ldc_int

datastore	lds_slipdata 

// ds สำหรับเก็บการชำระหนี้
lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cashlnrcv"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate, as_coopid  )


// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if
	
ls_tmpsystem	= "LON" 
ls_tmpvcgrp		= "PAY"

//สร้างเลขที่ Voucher
 if  is_vcrcvdocno = ""    then
		ls_voucher_type	= "RV"
		ls_desc  				= "เงินสดรับประจำวัน"		
		is_vcrcvdocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvdocno , as_coopid  )
		this.of_addvoucher( is_vcrcvdocno , adtm_vcdate , ls_voucher_type ,  ls_desc, 0 , ids_vcrcv , 'CSH'  , as_coopid  , as_userid )		
	else
		ids_vcrcv.retrieve( is_vcrcvdocno )
		ids_vcrcvdet.retrieve( is_vcrcvdocno )
 end if 	

// ชุดการรับชำระหนี้
for ll_index = 1 to ll_count

	ls_coopid				= lds_slipdata.object.coop_id[ ll_index ]
	ls_slipno				= lds_slipdata.object.payinslip_no[ ll_index ]
	ls_shrlontype		= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_itemtype			= lds_slipdata.object.slipitemtype_code[ ll_index ]
	ls_tofromaccid		= lds_slipdata.object.tofrom_accid[ ll_index ]
	li_shrlonstatus		= lds_slipdata.object.bfcontlaw_status[ ll_index ]
	li_slipflag				= lds_slipdata.object.sliptypesign_flag[ ll_index ]
	ldc_itempay			= lds_slipdata.object.item_payamt[ ll_index ]
	ldc_prinpay			= lds_slipdata.object.principal_payamt[ ll_index ]
	ldc_int				= lds_slipdata.object.interest_payamt[ ll_index ]
	ldc_intarrpay		= lds_slipdata.object.intarrear_payamt[ ll_index ]
	ls_memgroup		= lds_slipdata.object.membgroup_code[ ll_index ]
							
		
	if isnull( ldc_intpay ) then ldc_intpay = 0
	if isnull( ldc_prinpay ) then ldc_prinpay = 0
	if isnull( ldc_intarrpay ) then ldc_intarrpay = 0
	if isnull( li_shrlonstatus) then li_shrlonstatus = 1
	
	if ( ldc_intarrpay > 0 ) then
		ldc_intpay	= ldc_intpay - ldc_intarrpay
	end if
		
	ls_accid			= string	( of_getattribmapaccid(as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "account_id" ) )
	ls_accintid		= string	( of_getattribmapaccid(as_coopid, "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "accint_id" ) )
	ls_accintarrid	= string	( of_getattribmapaccid( as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "accintarr_id"  ) )
	ll_sortacc		= long	( of_getattribmapaccid( as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortacc_order"   ) )
	ll_sortint			= long	( of_getattribmapaccid( as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortint_order"  ) )
		
	if ( li_slipflag > 0 ) then
		ls_accside		= "CR"
		ls_accrevside	= "DR"
	else
		ls_accside		= "DR"
		ls_accrevside	= "CR"
	end if
	
	
	if  isnull (ls_tofromaccid ) or ls_tofromaccid <>  is_acccash then
		ls_tofromaccid		= 	is_acccash
	end if
	
		// hare_code เพื่อแยกประเภทหุ้นของสมาชิกปกติ กับ สมทบ by Mike 04/09/2013 สำหรับระยอง
//	if(left(ls_memgroup,1) = 'S' ) and ls_itemtype = 'SHR' then
//		ls_accid = "311101"  
//	end if
//
	
// เงินต้น
		if ( ldc_prinpay > 0 ) then				
			this.of_additemdesc( as_coopid ,is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_prinpay, "รับชำระตามรายงานใบเสร็จ", ll_sortacc, ids_vcrcvdet)
			this.of_additem( as_coopid , is_vcrcvdocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_prinpay  , 1, ids_vcrcvdet  , as_userid )
		end if
		
		// ดอกเบี้ย	
		if ( ldc_int > 0 ) then
			this.of_additemdesc( as_coopid ,is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accintid, ls_accside, ldc_int, "รับชำระตามรายงานใบเสร็จ", ll_sortacc, ids_vcrcvdet)
			this.of_additem( as_coopid , is_vcrcvdocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_int  , 1, ids_vcrcvdet  , as_userid )
		end if
		
		// ดอกเบี้ยค้าง
		if ( ldc_intarrpay > 0 ) then
			this.of_additemdesc( as_coopid ,is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accintarrid, ls_accside, ldc_intarrpay, "รับชำระตามรายงานใบเสร็จ", ll_sortacc, ids_vcrcvdet)
			this.of_additem( as_coopid , is_vcrcvdocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_intarrpay  , 1, ids_vcrcvdet  , as_userid )
		end if	
		
				//รายการชำระหักอื่น ๆ
		if ( ldc_itempay > 0 and  ldc_prinpay = 0 and ldc_int = 0 and ldc_intarrpay = 0) then
			this.of_additem( as_coopid , is_vcrcvdocno, ls_tmpsystem , ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay ,ll_sortint, ids_vcrcvdet  , as_userid )
			this.of_additem( as_coopid , is_vcrcvdocno , "CSH" , "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcrcvdet  , as_userid )
		end if
		
	// Update สถานะการผ่าน Voucher
	if	ls_slipno	<> ls_slipno_bf		then
		update		slslippayin
		set				posttovc_flag		= 1,	
						voucher_no			= :is_vcrcvdocno
		where		payinslip_no			= :ls_slipno   and 
						memcoop_id		= :as_coopid and
						coop_id				= :ls_coopid
		using    		 itr_sqlca   ;							
	end if				
		
	ls_slipno_bf		= ls_slipno	
				
next

destroy (lds_slipdata)

//update
if ids_vcrcv.update() <> 1 then
	return -1
end if
	
if ids_vcrcvdet.update() <> 1 then
	return -1
end if


if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if


return 1
end function

private function integer of_vccashdprcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception;/***********************************************************
Version 2.0
<description>
	ประมวลผลดึงรายการบัญชี   ==> ฝาก + เปิดบัญชี เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
	Version 2.0 (Initial version) Modified Date 19/02/2015 by Sakuraii
</usage> 
***********************************************************/

string			ls_slipno, ls_accid, ls_accintarrid, ls_depttype, ls_tofromaccid, ls_desc
string			ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp, ls_depttype_group, ls_voucher_type
long			ll_index, ll_count, ll_sortacc, ll_index2
dec{2}			ldc_itempay
string			ls_coopid , ls_deptcoopid, ls_acccash, ls_itemdesc, ls_accid_bf

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cashdprcv"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpsystem		= "DEP"
ls_tmpvcgrp			= "RCV"
ll_index2			=	1

	 
	 if  is_vcrcvdocno    =  ""  then
			ls_voucher_type	= "RV"
			ls_desc  		= "เงินสดรับประจำวัน"		
			is_vcrcvdocno	= this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvdocno , as_coopid  )
			this.of_addvoucher( is_vcrcvdocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcv , 'CSH'  , as_coopid,   as_userid )		
		else
			ids_vcrcv.retrieve( is_vcrcvdocno )
			ids_vcrcvdet.retrieve( is_vcrcvdocno )
	 end if 	



for ll_index = 1 to ll_count
	
	ls_coopid				= lds_slipdata.object.coop_id[ ll_index ]
	ls_deptcoopid			= lds_slipdata.object.deptcoop_id[ ll_index ]
	ls_slipno				= lds_slipdata.object.deptslip_no[ ll_index ]
	ls_depttype				= lds_slipdata.object.depttype_code[ ll_index ]
	ls_tofromaccid			= lds_slipdata.object.tofrom_accid[ ll_index ]
	ldc_itempay				= lds_slipdata.object.deptslip_netamt[ ll_index ]
	
	ls_accid				= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, "account_id"  ) )
	
	ls_accside			= "CR"
	ls_accrevside		= "DR"	
	
	if  isnull (ls_tofromaccid ) or ls_tofromaccid <>  is_acccash then
		ls_tofromaccid		= 	is_acccash
	end if
	

		
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid ,is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, "เงินสดรับประจำวัน", ll_sortacc, ids_vcrcvdet)
		this.of_additemdesc( as_coopid ,is_vcrcvdocno, "CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay, "เงินสดรับประจำวัน", 1, ids_vcrcvdet)
	end if
	
	//update สถานะการดึงข้อมูล
	if	not isnull(is_vcrcvdocno)    	then
		update	dpdeptslip
		set		posttovc_flag	= 1,	
				voucher_no		= :is_vcrcvdocno
		where	( deptslip_no	= :ls_slipno ) and
				( deptcoop_id 	= :as_coopid) and
				( coop_id 		= :ls_coopid)
		using itr_sqlca;
	end if
	
	ls_accid_bf	= ls_accid
	

next

//update
if ids_vcrcv.update() <> 1 then	
	return -1
end if
	
if ids_vcrcvdet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if
	
destroy( lds_slipdata )	
return 1
end function

private function integer of_vccashfinpay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
 Version 2.0
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการจ่ายการเงิน เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
	Version 2.0 (Initial version) Modified Date 19/02/2015 by Sakuraii
</usage> 
***********************************************************/
string			ls_slipno, ls_slipprior, ls_accid, ls_tofromaccid, ls_desc
string			ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp ,ls_slipitem_desc
long			ll_index, ll_count
dec{2}		ldc_itempay
string			ls_itemdesc , ls_coopid, ls_voucher_type

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cashfnpay"
lds_slipdata.settransobject( itr_sqlca )
 
ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

//ls_desc	= "จ่ายเงิน"
ls_tmpsystem		= "FIN"
ls_tmpvcgrp			= "DAY"

// สร้างเลข Voucher

	 if  is_vcpaydocno    =  ""  then
			ls_voucher_type	= "PV"
			ls_desc  				= "เงินสดจ่ายประจำวัน"		
			is_vcpaydocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcpaydocno , as_coopid  )
			this.of_addvoucher( is_vcpaydocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcpay , 'CSH'  , as_coopid  , as_userid )		
		else
			ids_vcpay.retrieve( is_vcpaydocno )
			ids_vcpaydet.retrieve( is_vcpaydocno )
	 end if 	

for ll_index = 1 to ll_count
	ls_slipno					= lds_slipdata.object.slip_no[ ll_index ]
	ldc_itempay				= lds_slipdata.object.itempay_amt[ ll_index ] //เปลี่ยนจาก 	itempayamt_net เป็น itempay_amt เนื่องจากเคสภาษี
	ls_accid					= lds_slipdata.object.account_id[ ll_index ]
	ls_slipitem_desc		= trim( lds_slipdata.object.slipitem_desc[ ll_index ] )
	ls_tofromaccid			= trim( lds_slipdata.object.tofrom_accid[ ll_index ] )
	ls_coopid					= lds_slipdata.object.coop_id[ ll_index ]
	
	if isnull( ldc_itempay ) then ldc_itempay = 0
			
	ls_accside		= "DR"
	ls_accrevside	= "CR"	
	
	if  isnull (ls_tofromaccid ) or ls_tofromaccid <>  is_acccash then
		ls_tofromaccid		= 	is_acccash
	end if
	
	//รายการการเงิน
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid , is_vcpaydocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, ls_slipitem_desc, 1, ids_vcpaydet)
		this.of_additemdesc( as_coopid , is_vcpaydocno, "CSH", "CSH", ls_tofromaccid, ls_accrevside, ldc_itempay, "เงินสดจ่ายประจำวัน", 1, ids_vcpaydet)
	end if	
		
	//update สถานะการดึงข้อมูล
	if ls_slipno <> ls_slipprior then
		update	finslipdet
		set			posttovc_flag	= 1,	
					voucher_no		= :is_vcpaydocno
		where	( slip_no			= :ls_slipno ) and
					( coop_id 		= :ls_coopid)
		
		using    	itr_sqlca   ;	
		
		ls_slipprior	= ls_slipno
		
	end if

next

destroy (lds_slipdata)
// update Vc
if ids_vcpay.update() <> 1 then	
	return -1
end if
	
if ids_vcpaydet.update() <> 1 then
	return -1
end if


if ids_voucher.update() <> 1 then	
	return -1
end if
	
if ids_voucherdet.update() <> 1 then	
	return -1
end if


return 1
end function

private function integer of_vccashfinrcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
 Version 2.0
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการรับการเงิน เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
	Version 2.0 (Initial version) Modified Date 19/02/2015 by Sakuraii
</usage> 
***********************************************************/
string		ls_slipno, ls_slipprior, ls_accid, ls_tofromaccid, ls_slipitem_desc
string		ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp
long		ll_index, ll_count
dec{2}	ldc_itempay
string		ls_desc, ls_voucher_type , ls_coopid

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cashfnrcv"
lds_slipdata.settransobject( itr_sqlca )

// reset เงินสดรับ
ll_count	= lds_slipdata.retrieve( adtm_vcdate,as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if


ls_tmpsystem		= "FIN"
ls_tmpvcgrp			= "DAY"

// สร้างเลข Voucher

	 if  is_vcrcvdocno    =  ""  then
			ls_voucher_type	= "RV"
			ls_desc  				= "เงินสดรับประจำวัน"		
			is_vcrcvdocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvdocno , as_coopid  )
			this.of_addvoucher( is_vcrcvdocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcv , 'CSH'  , as_coopid  , as_userid )		
		else
			ids_vcrcv.retrieve( is_vcrcvdocno )
			ids_vcrcvdet.retrieve( is_vcrcvdocno )
	 end if 	

for ll_index = 1 to ll_count
	ls_slipno					= trim( lds_slipdata.object.slip_no[ ll_index ] )
	ldc_itempay				= lds_slipdata.object.itempay_amt[ ll_index ]	
	ls_accid					= lds_slipdata.object.account_id[ ll_index ]
	ls_slipitem_desc		= trim( lds_slipdata.object.slipitem_desc[ ll_index ] )
	ls_tofromaccid			= trim( lds_slipdata.object.tofrom_accid[ ll_index ] )
	ls_coopid					= lds_slipdata.object.coop_id[ ll_index ]	
	
	ls_accside			= "CR"
	ls_accrevside		= "DR"
	
	if  isnull (ls_tofromaccid ) or ls_tofromaccid <>  is_acccash then
		ls_tofromaccid		= 	is_acccash
	end if
	
		// รายการการเงิน
	if ( ldc_itempay > 0 ) then		
		this.of_additemdesc( as_coopid , is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, ls_slipitem_desc, 0, ids_vcrcvdet)
		this.of_additemdesc( as_coopid ,is_vcrcvdocno, "CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay, "เงินสดรับประจำวัน", 1, ids_vcrcvdet)
	end if

	// Update สถานะการผ่าน Voucher
		update	finslipdet
		set			posttovc_flag	= 1,	
					voucher_no		= :is_vcrcvdocno
		where	( slip_no			= :ls_slipno )  and
					( coop_id 		= :ls_coopid)
		using     itr_sqlca   ;	
next

//update
if ids_vcrcv.update() <> 1 then	
	return -1
end if
	
if ids_vcrcvdet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

destroy (lds_slipdata)
return 1
end function

private function integer of_additem (string as_coopid, string as_voucherno, string as_syscode, string as_vcgrpno, string as_accid, string as_accside, decimal adc_itemamt, long al_sortorder, ref n_ds ads_voucherdet, string as_userid) throws Exception;/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   เพิ่มรายการด้านเงินสด 
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/

string		ls_colname , ls_coopcontrol
long		ll_find, ll_seqno
dec{2}	ldc_itembal

if as_accside = "DR" then
	ls_colname	= "dr_amt"
else
	ls_colname	= "cr_amt"
end if


ll_find	= ads_voucherdet.find( "coop_id = '"+as_coopid+  "'  and account_id = '"+as_accid+  "'  and voucher_no = '"+  as_voucherno + "' and system_code = '"+as_syscode+"'" + &
									" and vcgrp_no = '"+as_vcgrpno+"' and account_side = '"+as_accside+"'", 1, ads_voucherdet.rowcount() )	
			
if ll_find <= 0 then
	ll_find		= ads_voucherdet.insertrow( 0 )
	
	ll_seqno	= long( ads_voucherdet.describe( "evaluate( 'max( seq_no for all )', "+string( ll_find )+") " ) )
	
	if isnull( ll_seqno ) then ll_seqno = 0
	
	ll_seqno ++
	
	ads_voucherdet.setitem( ll_find, "coop_id", as_coopid ) 
	ads_voucherdet.setitem( ll_find, "voucher_no", as_voucherno )
	ads_voucherdet.setitem( ll_find, "seq_no", ll_seqno )
	ads_voucherdet.setitem( ll_find, "system_code", as_syscode )
	ads_voucherdet.setitem( ll_find, "vcgrp_no", as_vcgrpno )
	ads_voucherdet.setitem( ll_find, "account_id", as_accid )
	ads_voucherdet.setitem( ll_find, "account_side", as_accside )
	ads_voucherdet.setitem( ll_find, "sort_order", al_sortorder )
	ads_voucherdet.setitem( ll_find, "POSTTOGL_ALLFLAG", 1 )
	
end if
			
ldc_itembal		= ads_voucherdet.getitemdecimal( ll_find, ls_colname )
ldc_itembal		= ldc_itembal + adc_itemamt
			
ads_voucherdet.setitem( ll_find, ls_colname, ldc_itembal )

if ii_set_vcdetail = 0 then
	ads_voucherdet.setitem( ll_find, "POSTTOGL_FLAG", 0 )
else
	ads_voucherdet.setitem( ll_find, "POSTTOGL_FLAG", 1 )
end if

ads_voucherdet.accepttext( )

return 1
end function

private function integer of_additemdesc (string as_coopid, string as_voucherno, string as_syscode, string as_vcgrpno, string as_accid, string as_accside, decimal adc_itemamt, string as_desc, long al_sortorder, ref n_ds ads_voucherdet) throws Exception;/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี  
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/

string		ls_colname, ls_itemdesc, ls_min, ls_max, ls_desc, ls_coopcontrol
long		ll_find, ll_seqno, ll_pos
dec{2}	ldc_itembal

ls_itemdesc	= ''
ls_min		= ''
ls_max		= ''
ls_desc		= ''

if as_accside = "DR" then
	ls_colname	= "dr_amt"
else
	ls_colname	= "cr_amt"
end if					

ll_find	= ads_voucherdet.find( "coop_id = '"+as_coopid+  "'  and account_id = '"+as_accid+  "'  and voucher_no = '"+  as_voucherno + "' and system_code = '"+as_syscode+"'" + &
									" and vcgrp_no = '"+as_vcgrpno+"' and account_side = '"+as_accside+"'", 1, ads_voucherdet.rowcount() )	


if ll_find <= 0 then
	ll_find		= ads_voucherdet.insertrow( 0 )
	
	ll_seqno	= long( ads_voucherdet.describe( "evaluate( 'max( seq_no for all )', "+string( ll_find )+") " ) )
	
	if isnull( ll_seqno ) then ll_seqno = 0
	
	ll_seqno ++
	ads_voucherdet.setitem( ll_find, "coop_id", as_coopid ) 
	ads_voucherdet.setitem( ll_find, "voucher_no", as_voucherno )
	ads_voucherdet.setitem( ll_find, "seq_no", ll_seqno )
	ads_voucherdet.setitem( ll_find, "system_code", as_syscode )
	ads_voucherdet.setitem( ll_find, "vcgrp_no", as_vcgrpno )
	ads_voucherdet.setitem( ll_find, "account_id", as_accid )
	ads_voucherdet.setitem( ll_find, "account_side", as_accside )
	ads_voucherdet.setitem( ll_find, "sort_order", al_sortorder )
	ads_voucherdet.setitem( ll_find, "POSTTOGL_ALLFLAG", 1 )
	ads_voucherdet.setitem( ll_find, "POSTTOGL_FLAG", 1 )
	

end if					
			
ldc_itembal		= ads_voucherdet.getitemdecimal( ll_find, ls_colname )
ldc_itembal		= ldc_itembal + adc_itemamt
			
ads_voucherdet.setitem( ll_find, ls_colname, ldc_itembal )
ads_voucherdet.setitem( ll_find, "item_desc", as_desc )

if ii_set_vcdetail = 0 then
	ads_voucherdet.setitem( ll_find, "POSTTOGL_FLAG", 0 )
else
	ads_voucherdet.setitem( ll_find, "POSTTOGL_FLAG", 1 )
end if
	
ads_voucherdet.accepttext( )

return 1
end function

private function integer of_vccashshrcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
 Version 2.0
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการรับซื้อหุ้น เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
	Version 2.0 (Initial version) Modified Date 19/02/2015 by Sakuraii
</usage> 
***********************************************************/

string		ls_slipno, ls_accid , ls_slipno_bf, ls_desc
string		ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp
string		ls_shrlontype, ls_itemtype, ls_tofromaccid
integer	li_shrlonstatus, li_slipflag
long		ll_index, ll_count, ll_sortacc, ll_index2
dec{2}	ldc_itempay
string		ls_loangroup_code, ls_accid_bf, ls_vcrcvdocno_prnc ,ls_coopcontrol , ls_coopid
string		ls_voucher_type, ls_memgroup, ls_itemdesc

datastore	lds_slipdata 

// ds สำหรับเก็บการซื้อหุ้น
lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cashshrcv"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate, as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

// สร้างเลข Voucher
	 if  is_vcrcvdocno    =  ""  then
			ls_voucher_type	= "RV"
			ls_desc  				= "เงินสดรับประจำวัน"		
			is_vcrcvdocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvdocno , as_coopid  )
			this.of_addvoucher( is_vcrcvdocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcv , 'CSH'  , as_coopid  , as_userid )		
		else
			ids_vcrcv.retrieve( is_vcrcvdocno )
			ids_vcrcvdet.retrieve( is_vcrcvdocno )
	 end if 	


ls_tmpsystem	= "SHR" 
ls_tmpvcgrp		= "PAY"
ls_accid_bf		= ''
ll_index2			=	1
// ชุดการรับชำระหนี้
for ll_index = 1 to ll_count

	ls_coopid				= lds_slipdata.object.coop_id[ ll_index ]
	ls_slipno				= lds_slipdata.object.payinslip_no[ ll_index ]
	ls_shrlontype		= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_itemtype			= lds_slipdata.object.slipitemtype_code[ ll_index ]
	ls_tofromaccid		= lds_slipdata.object.tofrom_accid[ ll_index ]
	li_shrlonstatus		= 1
	li_slipflag				= lds_slipdata.object.sliptypesign_flag[ ll_index ]
	ldc_itempay			= lds_slipdata.object.item_payamt[ ll_index ]
	ls_memgroup		= lds_slipdata.object.membgroup_code[ ll_index ]
		
	if isnull( ldc_itempay ) then ldc_itempay = 0

		
	ls_accid			= string	( of_getattribmapaccid(as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "account_id" ) )
	ll_sortacc		= long	( of_getattribmapaccid( as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortacc_order"   ) )
		
	if ( li_slipflag > 0 ) then
		ls_accside		= "CR"
		ls_accrevside	= "DR"
	else
		ls_accside		= "DR"
		ls_accrevside	= "CR"
	end if


	if  isnull (ls_tofromaccid ) or ls_tofromaccid <>  is_acccash then
		ls_tofromaccid		= 	is_acccash
	end if
	
	// hare_code เพื่อแยกประเภทหุ้นของสมาชิกปกติ กับ สมทบ by Mike 04/09/2013 สำหรับระยอง
	if(left(ls_memgroup,1) = 'S' ) and ls_itemtype = 'SHR' then
		ls_accid = string( of_getattribmapaccid( as_coopid, "LON", "SHR" , "S1", 1, "account_id" ) )  
	end if

		
	// ยอดทำรายการ
	if ( ldc_itempay > 0 ) then				
		this.of_additemdesc( as_coopid ,is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, ls_desc, ll_sortacc, ids_vcrcvdet)
	end if
	
	// รายการเงินสดฝั่งตรงข้าม
	if	( ldc_itempay > 0  ) then
		this.of_additemdesc( as_coopid , is_vcrcvdocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay ,ls_desc , 1, ids_vcrcvdet )
	end if		
	
	// Update สถานะการผ่าน Voucher
	if	ls_slipno	<> ls_slipno_bf		then
		update		slslippayin
		set				posttovc_flag		= 1,	
						voucher_no			= :is_vcrcvdocno
		where		payinslip_no			= :ls_slipno   and 
						memcoop_id		= :as_coopid and
						coop_id 				= :ls_coopid
		using    		 itr_sqlca   ;							
	end if				
		
	ls_accid_bf		= ls_accid
	ls_slipno_bf		= ls_slipno	
				
next

destroy (lds_slipdata)

if ids_vcrcv.update() <> 1 then
	return -1
end if
	
if ids_vcrcvdet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if


return 1
end function

private function integer of_vccashshpay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; ///***********************************************************
 //Version 2.0
//<description>
	//ประมวลผลดึงรายการบัญชี   ==> รายการจ่าย เงินสด
//</description>
//
//<arguments>
//
//</arguments> 
//
//<return> 
	//Integer	1 = success,  throwable = failure
//</return> 
//
//<usage> 
	//
	//Revision History:
	//Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
	//Version 2.0 (Initial version) Modified Date 19/02/2015 by Sakuraii
//</usage> 
//***********************************************************/
string	ls_slipno, ls_accid, ls_accintid, ls_accintarrid , ls_slipno_bf, ls_desc
string	ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp, ls_acccash, ls_desc_rv
string	ls_moneygrp, ls_shrlontype, ls_sliptype, ls_itemtype, ls_tofromaccid
integer	li_slipflag, li_shrlonclc_status, li_shareclc_status
long	ll_index, ll_count, ll_sortacc, ll_index2, ll_row
dec{2}	ldc_prinpay, ldc_intpay, ldc_intarrpay, ldc_itempay
dec{2}	ldc_int, ldc_total
string	ls_tofromaccid_bf,  ls_shrloncode, ls_slipclr, ls_accid_clc
string	ls_voucher_type,ls_coopid, ls_itemdesc, ls_memgroup

datastore	lds_slipdata

// ds สำหรับดึงข้อมูลการถอนหุ้นลาออก
lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cashshpay"
lds_slipdata.settransobject( itr_sqlca )

ll_count			= lds_slipdata.retrieve( adtm_vcdate , as_coopid   )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpsystem		= "SHR"
ls_tmpvcgrp			= "PAY"
ls_tofromaccid_bf	= ""
ll_index2				=	1
	 //สร้างเลขที่ Voucher
 if  is_vcrcvdocno = ""    then
		ls_voucher_type	= "RV"
		ls_desc_rv		= "เงินสดรับประจำวัน"		
		is_vcrcvdocno	= this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvdocno , as_coopid  )
		this.of_addvoucher( is_vcrcvdocno , adtm_vcdate , ls_voucher_type ,  ls_desc, 0 , ids_vcrcv , 'CSH'  , as_coopid  , as_userid )		
	else
		ids_vcrcv.retrieve( is_vcrcvdocno )
		ids_vcrcvdet.retrieve( is_vcrcvdocno )
 end if 	
	 
	 if  is_vcpaydocno    =  ""  then
			ls_voucher_type	= "PV"
			ls_desc  		= "เงินสดจ่ายประจำวัน"		
			is_vcpaydocno	= this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcpaydocno , as_coopid  )
			this.of_addvoucher( is_vcpaydocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcpay , 'CSH'  , as_coopid  , as_userid )		
		else
			ids_vcpay.retrieve( is_vcpaydocno )
			ids_vcpaydet.retrieve( is_vcpaydocno )
			ids_vcrcv.retrieve( is_vcrcvdocno )
			ids_vcrcvdet.retrieve( is_vcrcvdocno )
	 end if 	
//
for ll_index = 1 to ll_count 
		
	ls_slipno			= lds_slipdata.object.payoutslip_no[ ll_index ]
	ls_moneygrp			= lds_slipdata.object.moneytype_group[ ll_index ]
	ls_shrlontype		= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_tofromaccid		= lds_slipdata.object.tofrom_accid[ ll_index ]
	li_slipflag			= lds_slipdata.object.sliptypesign_flag[ ll_index ]
	ldc_itempay			= lds_slipdata.object.payout_amt[ ll_index ]
	ls_sliptype			= lds_slipdata.object.sliptype_code [ ll_index ]
	ldc_int				= lds_slipdata.object.interest_payamt [ ll_index ]
	ldc_prinpay			= lds_slipdata.object.principal_payamt [ ll_index ]
	ls_shrloncode		= lds_slipdata.object.slslippayindet_shrlontype_code [ ll_index ]
	ldc_total			= lds_slipdata.object.payoutnet_amt [ ll_index ]
	ls_coopid			= lds_slipdata.object.coop_id [ ll_index ]
	ls_slipclr			= lds_slipdata.object.slipclear_no[ ll_index ]
	li_shrlonclc_status	= lds_slipdata.object.bfcontlaw_status[ ll_index ]
	li_shareclc_status	= lds_slipdata.object.bfshare_status[ ll_index ]
	ls_memgroup			= lds_slipdata.object.membgroup_code[ ll_index ]
	
	if isnull(li_shareclc_status) then li_shareclc_status = 1
	if isnull(li_shrlonclc_status) then li_shrlonclc_status = 1
	
	if isnull(ldc_total) then ldc_total = 0
	if isnull(ldc_int) then ldc_int = 0
	if isnull(ldc_prinpay) then ldc_prinpay = 0
	if isnull(ldc_itempay) then ldc_itempay = 0
	
	ls_accid			= string	( of_getattribmapaccid( as_coopid, "LON", "SHR" , ls_shrlontype, li_shrlonclc_status, "account_id" ) )
	ls_accintid		= string	( of_getattribmapaccid(as_coopid, "LON", "LON" , ls_shrloncode, li_shrlonclc_status, "accint_id" ) )
	ls_accintarrid	= string	( of_getattribmapaccid( as_coopid, "LON", "LON" , ls_shrloncode, li_shrlonclc_status, "accintarr_id"  ) )
	ll_sortacc		= long	( of_getattribmapaccid(as_coopid,"LON", "SHR" , ls_shrlontype, li_shrlonclc_status, "sortacc_order"   ) )
	ls_accid_clc		= string	( of_getattribmapaccid( as_coopid, "LON", "LON" , ls_shrloncode, li_shrlonclc_status, "account_id" ) )
	
	if ( li_slipflag > 0 ) then
		ls_accside		= "CR"
		ls_accrevside	= "DR"
	else
		ls_accside		= "DR"
		ls_accrevside	= "CR"
	end if
	
	//หาบัญชีเงินสด
	select  	cash_account_code
	into		:ls_acccash 
	from		accconstant 
	where 	coop_id = :as_coopid
	using    	 itr_sqlca   ;	
	
	//
	if  isnull (ls_tofromaccid ) or ls_tofromaccid <>  ls_acccash then
		ls_tofromaccid		= 	ls_acccash
	end if
	
	
	
		// hare_code เพื่อแยกประเภทหุ้นของสมาชิกปกติ กับ สมทบ by Mike 04/09/2013 สำหรับระยอง
	if(left(ls_memgroup,1) = 'S' ) and ls_itemtype = 'SHR' then
		ls_accid = string( of_getattribmapaccid( as_coopid, "LON", "SHR" , "S1", 1, "account_id" ) )  
	end if


if isnull (ls_slipclr) or ls_slipclr = "" then //เช็คว่ามีหักกลบรึป่าว
	// รายการจ่ายเงิน
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid , is_vcpaydocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid  , ls_accside, ldc_itempay, "เงินสดจ่ายประจำวัน", ll_sortacc, ids_vcpaydet)
	end if
	
	// รายการฝั่งตรงข้าม
	if 	( ldc_itempay > 0 ) then		
		this.of_additemdesc( as_coopid , is_vcpaydocno ,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay  ,"เงินสดจ่ายประจำวัน", 1, ids_vcpaydet  )
	end if
	
else
	///////////////////////////////////ท่อนนี้ยิงลง PV/////////////////////////////////////////////////////
			// รายการจ่ายเงิน
	if(ls_slipno_bf <> ls_slipno) then
		if ( ldc_itempay > 0 ) then
			this.of_additemdesc( as_coopid ,  is_vcpaydocno, ls_itemtype, ls_tmpvcgrp, ls_accid  , ls_accside, ldc_itempay, "เงินสดจ่ายประจำวัน", ll_sortacc, ids_vcpaydet)
		end if
		// รายการฝั่งตรงข้าม
		if (ldc_total > 0) then
			this.of_additemdesc( as_coopid , is_vcpaydocno ,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_total  , "เงินสดจ่ายประจำวัน", 1, ids_vcpaydet )
		end if
	end if
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////ท่อนนี้ยิงลง RV////////////////////////////////////////////////////
	if 	( ldc_prinpay > 0 ) then	
		this.of_additemdesc( as_coopid , is_vcpaydocno ,ls_itemtype, ls_tmpvcgrp, ls_accid_clc , ls_accrevside, ldc_prinpay , "เงินสดรับประจำวัน", 1, ids_vcpaydet )
	end if

	if ( ldc_int > 0 ) then
		this.of_additemdesc( as_coopid ,  is_vcpaydocno, ls_itemtype, ls_tmpvcgrp, ls_accintid , ls_accrevside, ldc_int, "เงินสดรับประจำวัน", ll_sortacc, ids_vcpaydet)
	end if
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
end if
	
	// Update สถานะการผ่าน Voucher
	if	ls_slipno	<> ls_slipno_bf		then
		update		slslippayout
		set				posttovc_flag		= 1,	
						voucher_no			= :is_vcpaydocno
		where		( payoutslip_no		= :ls_slipno ) and
						(memcoop_id		= :as_coopid) and
						(coop_id				= :ls_coopid)

		using     itr_sqlca   ;							
	end if
	
	ls_slipno_bf		= ls_slipno
	
next

destroy (lds_slipdata)

//update
if ids_vcpay.update() <> 1 then	
	return -1
end if
	
if ids_vcpaydet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

return 1
end function

private function integer of_vctrnpayin (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการชำระหนี้  เงินโอน
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/

string		ls_slipno, ls_refopeno, ls_accid, ls_accintid, ls_accintarrid, ls_vc_type , ls_cash , ls_slipno_bf
string		ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp
string		ls_moneygrp, ls_shrlontype, ls_itemtype, ls_tofromaccid
string		ls_branchid,ls_mbbranch_id,ls_acccr_id,ls_accdr_id,ls_desc,ls_year,ls_vcdocno,ls_docno,ls_mbbranch_idold
integer	li_shrlonstatus, li_slipflag, li_seqno,li_flag
long		ll_index, ll_count, ll_sortacc, ll_sortint, ll_sortintarr, ll_index2
dec{2}	ldc_prinpay, ldc_intpay, ldc_itempay, ldc_intarrpay,ldc_fineamt, ldc_intarrear
string		ls_shrlontypeold,ls_document_no,ls_itemdesc,ls_maxdoc,ls_mindoc, ls_date, ls_month, ls_slipitem_desc
datetime	ldtm_operate
string		ls_vc_desc, ls_loangroup_code, ls_accid_bf, ls_vcrcvdocno_prnc, ls_accintid_bf
string		ls_vcrcvdocno_int , ls_vcrcvdocno_etc , ls_voucher_type , as_vcdocno , ls_coopid, ls_memgroup

datastore	lds_slipdata ,lds_countitem

// ds สำหรับเก็บการชำระหนี้
lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_trnlnrcv"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate, as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

// สร้างเลข Voucher
is_vcrcvtrndocno = ""

	 if  is_vcrcvtrndocno    =  ""  then
			ls_voucher_type	= "JV"
			ls_desc  				= "รับค่าหุ้น + รับชำระหนี้จากสมาชิก"		
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
		else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	



ls_tmpvcgrp		= "PAY"
ls_accid_bf		= ''
ll_index2			=	1
// ชุดการรับชำระหนี้
for ll_index = 1 to ll_count
	
	ls_slipno			= lds_slipdata.object.payinslip_no[ ll_index ]
	ls_document_no		= lds_slipdata.object.document_no[ ll_index ]
	ls_moneygrp			= lds_slipdata.object.moneytype_group[ ll_index ]
	ls_shrlontype		= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_itemtype			= lds_slipdata.object.slipitemtype_code[ ll_index ]
	ls_tofromaccid		= lds_slipdata.object.tofrom_accid[ ll_index ]
	li_shrlonstatus		= lds_slipdata.object.bfcontlaw_status[ ll_index ]
	li_slipflag			= lds_slipdata.object.sliptypesign_flag[ ll_index ]
	ldc_prinpay			= lds_slipdata.object.principal_payamt[ ll_index ]
	ldc_intpay			= lds_slipdata.object.interest_payamt[ ll_index ]
	ldc_itempay			= lds_slipdata.object.item_payamt[ ll_index ]
	ls_slipitem_desc	= trim(lds_slipdata.object.slipitem_desc[ ll_index ])
	ls_coopid			= lds_slipdata.object.coop_id[ ll_index ]
	ls_memgroup			= lds_slipdata.object.membgroup_code[ ll_index ]
	ldc_intarrear		= lds_slipdata.object.intarrear_payamt[ ll_index ]
		
	if isnull( ldc_intpay ) then ldc_intpay = 0
	if isnull( ldc_prinpay ) then ldc_prinpay = 0
	if isnull( li_shrlonstatus) then li_shrlonstatus = 1
	if isnull( ldc_intarrear ) then ldc_intarrear = 0
	
	// ด/บ จ่าย - ดอกเบี้ยคืน
	ldc_intpay = ldc_intpay - ldc_intarrear
	
	ls_accid			= string	( of_getattribmapaccid(as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "account_id" ) )
	ls_accintid		= string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "accint_id" ) )
	ls_accintarrid	= string	( of_getattribmapaccid(as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "accintarr_id"  ) )
	ll_sortacc		= long	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortacc_order"   ) )
	ll_sortint			= long	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortint_order"  ) )
	ll_sortintarr		= long	( of_getattribmapaccid( as_coopid ,"LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortintarr_order"  ) )
		
	if ( li_slipflag > 0 ) then
		ls_accside		= "CR"
		ls_accrevside	= "DR"
	else
		ls_accside		= "DR"
		ls_accrevside	= "CR"
	end if

					
	if  ls_accid_bf = ls_accid then
		ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
		ll_index2 = ll_index2 + 1
	else
		ll_index2	=	1
		ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
		ll_index2 = ll_index2 + 1
	end if

		
		// เงินต้น
		if ( ldc_prinpay > 0 ) then				
			this.of_additem( as_coopid ,is_vcrcvtrndocno , "LON" , "TRN", ls_accid, ls_accside , ldc_prinpay, ll_sortacc, ids_vcrcvpaydet  , as_userid )
		end if
		
		// ดอกเบี้ย	
		if ( ldc_intpay > 0 ) then
			this.of_additem( as_coopid ,is_vcrcvtrndocno, "LON"  , "TRN", ls_accintid, ls_accside, ldc_intpay,ll_sortint, ids_vcrcvpaydet  , as_userid )
		end if
		//รายการชำระหักอื่น ๆ
		if ( ldc_itempay > 0 and  ldc_prinpay = 0 and ldc_intpay = 0 ) then
			this.of_additem( as_coopid , is_vcrcvtrndocno, "LON" , "TRN", ls_accid, ls_accside, ldc_itempay ,ll_sortint, ids_vcrcvpaydet  , as_userid )
		end if
		
			//รายการ ด/บ คืน
		if ( ldc_intarrear> 0) then
			this.of_additem( as_coopid , is_vcrcvtrndocno, "LON" , "TRN", ls_accintarrid, ls_accside, ldc_intarrear ,ll_sortintarr, ids_vcrcvpaydet  , as_userid )
		end if
		
		// รายการฝั่งตรงข้าม
		if	( ldc_itempay > 0  ) then
			this.of_additem( as_coopid ,is_vcrcvtrndocno , "LON" , "TRN", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcrcvpaydet  , as_userid )
		end if
		

	
	// Update สถานะการผ่าน Voucher
	if	ls_slipno	<> ls_slipno_bf		then
		update		slslippayin
		set				posttovc_flag		= 1,	
						voucher_no			= :is_vcrcvtrndocno
		where		( payinslip_no		= :ls_slipno ) and
						( memcoop_id		= :as_coopid  )
		using     itr_sqlca   ;							
	end if			

	ls_accid_bf		= ls_accid
	ls_accintid_bf	= ls_accintid
	ls_slipno_bf		= ls_slipno			
next

destroy( lds_slipdata )

if ids_vcrcvpay.update() <> 1 then
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

return 1
end function

private function integer of_vctrnpayout (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการจ่ายเงินกู้+หักกลบ ราการโอน
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
	Version 2.0 (Initial version) Modified Date 19/04/2016 by Sakuraii
</usage> 
***********************************************************/
string		ls_slipno, ls_accid, ls_accintid, ls_accintarrid  ,ls_slipno_bf
string		ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp, ls_desc
string		ls_shrlontype, ls_sliptype, ls_itemtype, ls_tofromaccid
integer		li_shrlonstatus, li_slipflag,li_flag
long		ll_index, ll_count, ll_find, ll_sortacc, ll_index2
dec{2}		ldc_prinpay, ldc_intpay, ldc_intarrpay, ldc_itempay
string		ls_accid_bf, ls_accid_clc, ls_itemdesc
dec{2}		ldc_int, ldc_total, ldc_shrpay
string		ls_voucher_type, ls_memgroup, ls_moneycode
string		ls_slipitem_desc, ls_coopid, ls_shrloncode, ls_slipclr, ls_slipitemtype_code, ls_accshr, ls_itemtypeshr

datastore	lds_slipdata

// ds สำหรับดึงข้อมูลการจ่ายเงินกู้
lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_trnlnpay"
lds_slipdata.settransobject( itr_sqlca )

ll_count			= lds_slipdata.retrieve( adtm_vcdate , as_coopid   )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpvcgrp			= "PAY"
ls_accid_bf			= ""
ll_index2			=	1
//// สร้างเลข Voucher
is_vcrcvtrndocno = ""
	 if  is_vcrcvtrndocno   =  ""  then
			ls_voucher_type	= "JV"
			ls_desc  		= "จ่ายเงินกู้แก่สมาชิก"		
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
		else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	

//end if		

//
for ll_index = 1 to ll_count
		
	ls_slipno				= lds_slipdata.object.payoutslip_no[ ll_index ]
	ls_shrlontype			= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_tofromaccid			= lds_slipdata.object.tofrom_accid[ ll_index ]
	li_shrlonstatus			= 1
	li_slipflag				= lds_slipdata.object.sliptypesign_flag[ ll_index ]
	ldc_itempay				= lds_slipdata.object.payout_amt[ ll_index ]
	ls_sliptype				= lds_slipdata.object.sliptype_code [ ll_index ]
	ls_coopid				= lds_slipdata.object.coop_id [ ll_index ]
	ls_slipclr				= lds_slipdata.object.slipclear_no[ ll_index ]
	ls_slipitemtype_code	= lds_slipdata.object.slipitemtype_code[ ll_index ]
	ls_shrloncode			= lds_slipdata.object.slslippayindet_shrlontype_code [ ll_index ]
	ldc_int					= lds_slipdata.object.interest_payamt [ ll_index ]
	ldc_prinpay				= lds_slipdata.object.principal_payamt [ ll_index ]
	ldc_total				= lds_slipdata.object.payoutnet_amt [ ll_index ]
	ldc_shrpay				= lds_slipdata.object.item_payamt [ ll_index ]
	ls_memgroup				= lds_slipdata.object.membgroup_code[ ll_index ]
	ls_moneycode			= lds_slipdata.object.moneytype_code[ ll_index ]


//	if isnull(ls_itemtype) or ls_itemtype = "" then ls_itemtype = 'LON'
	if isnull(ldc_prinpay) then ldc_prinpay = 0
	if isnull(ldc_itempay) then ldc_itempay = 0
	if isnull(ldc_int) then ldc_int = 0
	if isnull(ldc_total) then ldc_total = 0
	if isnull(ls_shrloncode) then ls_shrloncode = '00'
	
	choose case ls_sliptype
		case  'LWD'	
			ls_itemtype		= 'LON'
		case  'SWD'	,'SWT','SWP'
			ls_itemtype		= 'SHR'
	end choose				
	
	ls_accid			= string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype , ls_shrlontype, li_shrlonstatus, "account_id" ) )
	ls_accintid			= string	( of_getattribmapaccid(as_coopid, "LON", ls_itemtype , ls_shrloncode, li_shrlonstatus, "accint_id" ) )
	ls_accintarrid		= string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype , ls_shrloncode, li_shrlonstatus, "accintarr_id"  ) )
	ll_sortacc			= long	( of_getattribmapaccid(as_coopid,"LON", ls_itemtype , ls_shrlontype, li_shrlonstatus, "sortacc_order"   ) )
	ls_accid_clc		= string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype , ls_shrloncode, li_shrlonstatus, "account_id" ) )
	
	if trim(ls_slipitemtype_code) = 'LON' then 
				
	else
		choose case ls_slipitemtype_code
				
			case  'SHR' //ค่าหุ้น
				ls_itemtypeshr		= 'SHR'
				ls_shrlontype	= '01'
				ls_accshr = string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtypeshr , ls_shrlontype, li_shrlonstatus, "account_id" ))
			case  'INF' //ค่าดอกเบี้ยล่วงหน้า
				ls_itemtypeshr		= trim(ls_slipitemtype_code)
				ls_accshr = string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtypeshr , ls_shrlontype, li_shrlonstatus, "account_id" ) )
			case else
				ls_itemtypeshr		= trim(ls_slipitemtype_code)
				ls_shrlontype	= '00'
				ls_accshr = string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtypeshr , ls_shrlontype, li_shrlonstatus, "account_id" ) )
			
		end choose
	end if
	
	if ( li_slipflag > 0 ) then
		ls_accside		= "CR"
		ls_accrevside	= "DR"
	else
		ls_accside		= "DR"
		ls_accrevside	= "CR"
	end if			
	
	// hare_code เพื่อแยกประเภทหุ้นของสมาชิกปกติ กับ สมทบ by Mike 04/09/2013
	if(left(ls_memgroup,1) = 'S' ) and ls_itemtype = 'SHR' then
		ls_accid = string( of_getattribmapaccid( as_coopid, "LON", "SHR" , "S1", 1, "account_id" ) )  
	end if
	
	//hard code เนื่องจากคู่บัญชีเลือกมาผิด ต้องการให้ default ให้
	choose case ls_moneycode
	case 'CBT'
		ls_tofromaccid = '111302'
	case 'TRN'
		ls_tofromaccid = '214500'
	case 'CHQ'
		ls_tofromaccid = '211111'
	end choose
	
	
	if isnull (ls_slipclr) or ls_slipclr = "" then //เช็คว่ามีหักกลบรึป่าว
	// รายการจ่ายเงิน
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid ,  is_vcrcvtrndocno, ls_itemtype, ls_tmpvcgrp, ls_accid  , ls_accside, ldc_itempay, ls_desc, ll_sortacc, ids_vcrcvpaydet)
	end if
	
	// รายการฝั่งตรงข้าม
	if 	( ldc_itempay > 0 ) then		
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno ,"TRN", "TRN", ls_tofromaccid , ls_accrevside, ldc_itempay ,ls_desc , 1, ids_vcrcvpaydet   )
	end if
	
	else
	
	// รายการจ่ายเงิน
	if(ls_slipno_bf <> ls_slipno) then
		if ( ldc_itempay > 0 ) then
			this.of_additemdesc( as_coopid ,  is_vcrcvtrndocno, ls_itemtype, ls_tmpvcgrp, ls_accid  , ls_accside, ldc_itempay, ls_desc, ll_sortacc, ids_vcrcvpaydet)
		end if
		if (ldc_total > 0) then
			this.of_additemdesc( as_coopid , is_vcrcvtrndocno ,"TRN", "TRN", ls_tofromaccid , ls_accrevside, ldc_total ,ls_desc , 1, ids_vcrcvpaydet  )
		end if
	end if
		choose case ls_slipitemtype_code
			case 'SHR'
		if (ldc_shrpay > 0) then //ยอดซื้อหุ้น
			this.of_additemdesc( as_coopid ,  is_vcrcvtrndocno, ls_itemtype, ls_tmpvcgrp, ls_accshr , ls_accrevside, ldc_shrpay, ls_desc, ll_sortacc, ids_vcrcvpaydet)
		end if

			case 'LON'
		// รายการฝั่งตรงข้าม
		if 	( ldc_itempay > 0 ) then	
			this.of_additemdesc( as_coopid , is_vcrcvtrndocno ,"TRN", "TRN", ls_accid_clc , ls_accrevside, ldc_prinpay ,ls_desc , 1, ids_vcrcvpaydet  )
		end if
	
		if ( ldc_int > 0 ) then
			this.of_additemdesc( as_coopid ,  is_vcrcvtrndocno, ls_itemtype, ls_tmpvcgrp, ls_accintid , ls_accrevside, ldc_int, ls_desc, ll_sortacc, ids_vcrcvpaydet)
		end if
	
			case else
		if (ldc_shrpay > 0) then //ยอดค่าธรรมเนียม
			this.of_additemdesc( as_coopid ,  is_vcrcvtrndocno, ls_itemtype, ls_tmpvcgrp, ls_accshr , ls_accrevside, ldc_shrpay, ls_desc, ll_sortacc, ids_vcrcvpaydet)
		end if		
			end choose
//end if
end if
	
			
	// Update สถานะการผ่าน Voucher
	if	ls_slipno	<> ls_slipno_bf		then
		update		slslippayout
		set				posttovc_flag		= 1,	
						voucher_no			= :is_vcrcvtrndocno
		where		( payoutslip_no		= :ls_slipno ) and
						( memcoop_id		= :as_coopid )
		using     itr_sqlca   ;							
	end if
	
	ls_accid_bf		= ls_accid
	ls_slipno_bf		= ls_slipno
	
next

destroy( lds_slipdata )
//update
if ids_vcrcvpay.update() <> 1 then	
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if


if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if


return 1
end function

private function integer of_vctrnshrrcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการชำระหนี้  เงินโอน
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/

string		ls_slipno, ls_accid, ls_accintid, ls_accintarrid, ls_slipno_bf
string		ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp, ls_desc
string		ls_shrlontype, ls_itemtype, ls_tofromaccid
integer		li_shrlonstatus, li_slipflag, li_flag
long		ll_index, ll_count, ll_sortacc, ll_index2
dec{2}		ldc_prinpay, ldc_intpay, ldc_itempay, ldc_intarrpay
string		ls_itemdesc,  ls_slipitem_desc
string		ls_vc_desc, ls_loangroup_code, ls_accid_bf, ls_accintid_bf
string		ls_voucher_type  , ls_coopid, ls_memgroup

datastore	lds_slipdata ,lds_countitem

// ds สำหรับเก็บการชำระหนี้
lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_trnshrrcv"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate, as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

// สร้างเลข Voucher
is_vcrcvtrndocno = ""

 
	 if  is_vcrcvtrndocno    =  ""  then
			ls_voucher_type	= "JV"
			ls_desc  				= "โอนภายในซื้อหุ้น"		
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
		else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	



ls_tmpvcgrp		= "PAY"
ls_accid_bf		= ''
ll_index2			=	1
// ชุดการรับชำระหนี้
for ll_index = 1 to ll_count
	
	ls_slipno			= lds_slipdata.object.payinslip_no[ ll_index ]
	ls_shrlontype		= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_itemtype			= lds_slipdata.object.slipitemtype_code[ ll_index ]
	ls_tofromaccid		= lds_slipdata.object.tofrom_accid[ ll_index ]
	li_shrlonstatus		= 1
	li_slipflag			= lds_slipdata.object.sliptypesign_flag[ ll_index ]
	ldc_prinpay			= lds_slipdata.object.principal_payamt[ ll_index ]
	ldc_intpay			= lds_slipdata.object.interest_payamt[ ll_index ]
	ldc_itempay			= lds_slipdata.object.item_payamt[ ll_index ]
	ls_slipitem_desc	= trim(lds_slipdata.object.slipitem_desc[ ll_index ])
	ls_coopid			= lds_slipdata.object.coop_id[ ll_index ]
	ls_memgroup			= lds_slipdata.object.membgroup_code[ ll_index ]
		
	if isnull( ldc_prinpay ) then ldc_prinpay = 0
	if isnull( ldc_intpay ) then ldc_intpay = 0
	if isnull( ldc_itempay ) then ldc_itempay = 0

	
	ls_accid		= string	( of_getattribmapaccid(as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "account_id" ) )
	ls_accintid		= string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "accint_id" ) )
	ls_accintarrid	= string	( of_getattribmapaccid(as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "accintarr_id"  ) )
	ll_sortacc		= long	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortacc_order"   ) )

		
	if ( li_slipflag > 0 ) then
		ls_accside		= "CR"
		ls_accrevside	= "DR"
	else
		ls_accside		= "DR"
		ls_accrevside	= "CR"
	end if

	// hare_code เพื่อแยกประเภทหุ้นของสมาชิกปกติ กับ สมทบ by Mike 04/09/2013
	if(left(ls_memgroup,1) = 'S' ) and ls_itemtype = 'SHR' then
		ls_accid = string( of_getattribmapaccid( as_coopid, "LON", "SHR" , "S1", 1, "account_id" ) )  
	end if
		
		//รายการชำระหักอื่น ๆ
		if	( ldc_itempay > 0  ) then
			this.of_additemdesc( as_coopid , is_vcrcvtrndocno, "LON" , "TRN", ls_accid, ls_accside, ldc_itempay, ls_desc ,1, ids_vcrcvpaydet )
		end if
		
		// รายการฝั่งตรงข้าม
		if	( ldc_itempay > 0  ) then
			this.of_additemdesc( as_coopid ,is_vcrcvtrndocno , "LON" , "TRN", ls_tofromaccid , ls_accrevside, ldc_itempay , ls_desc  , 1, ids_vcrcvpaydet )
		end if
		

	
	// Update สถานะการผ่าน Voucher
	if	ls_slipno	<> ls_slipno_bf		then
		update		slslippayin
		set			posttovc_flag		= 1,	
					voucher_no			= :is_vcrcvtrndocno
		where		( payinslip_no		= :ls_slipno ) and
					( memcoop_id		= :as_coopid  )
		using		itr_sqlca   ;							
	end if			

	ls_accid_bf		= ls_accid
	ls_accintid_bf	= ls_accintid
	ls_slipno_bf	= ls_slipno			
next

destroy( lds_slipdata )

if ids_vcrcvpay.update() <> 1 then
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

return 1
end function

private function integer of_vctrnshrpay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการถอนหุ้นลาออก เงินโอน
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
	Version 2.0 (Initial version) Modified Date 19/04/2016 by Sakuraii
</usage> 
***********************************************************/
string		ls_slipno, ls_accid, ls_accintid, ls_accintarrid  ,ls_slipno_bf
string		ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp, ls_desc
string		ls_shrlontype, ls_sliptype, ls_itemtype, ls_tofromaccid
integer		li_shrlonstatus, li_slipflag
long		ll_index, ll_count, ll_sortacc
dec{2}		ldc_prinpay, ldc_intpay, ldc_intarrpay, ldc_itempay
string		ls_vc_desc, ls_itemdesc, ls_voucher_type
dec{2}		ldc_total, ldc_int
string		ls_coopid, ls_slipclr, ls_accid_clc, ls_shrloncode, ls_memgroup

datastore	lds_slipdata

// ds สำหรับดึงข้อมูลการจ่ายเงินกู้
lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_trnshrpay"
lds_slipdata.settransobject( itr_sqlca )

ll_count			= lds_slipdata.retrieve( adtm_vcdate , as_coopid   )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if
ls_tmpsystem		= "SHR"
ls_tmpvcgrp			= "PAY"
is_vcrcvtrndocno	= ""

	//สร้าง voucher
		 if is_vcrcvtrndocno = ""  then
			ls_voucher_type	= "JV"
			ls_desc  				= "จ่ายหุ้นคืนสมาชิก"		
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcvpay , 'TRN'  , as_coopid , as_userid )		
		else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	
	 
for ll_index = 1 to ll_count 
		
	ls_slipno			= lds_slipdata.object.payoutslip_no[ ll_index ]
	ls_shrlontype		= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_tofromaccid		= lds_slipdata.object.tofrom_accid[ ll_index ]
	li_shrlonstatus		= 1
	li_slipflag			= lds_slipdata.object.sliptypesign_flag[ ll_index ]
	ldc_itempay			= lds_slipdata.object.payout_amt[ ll_index ]
	ls_sliptype			= lds_slipdata.object.sliptype_code [ ll_index ]
	ldc_int				= lds_slipdata.object.interest_payamt [ ll_index ]
	ldc_prinpay			= lds_slipdata.object.principal_payamt [ ll_index ]
	ls_shrloncode		= lds_slipdata.object.slslippayindet_shrlontype_code [ ll_index ]
	ldc_total			= lds_slipdata.object.payoutnet_amt [ ll_index ]
	ls_coopid			= lds_slipdata.object.coop_id [ ll_index ]
	ls_slipclr			= lds_slipdata.object.slipclear_no[ ll_index ]
	ls_memgroup			= lds_slipdata.object.membgroup_code[ ll_index ] 
	
	if isnull(ldc_total) then ldc_total = 0
	if isnull(ldc_int) then ldc_int = 0
	if isnull(ldc_prinpay) then ldc_prinpay = 0
	if isnull(ldc_itempay) then ldc_itempay = 0
	if isnull(ls_tofromaccid) or trim(ls_tofromaccid) = '1' then ls_tofromaccid = '211111'
	
	ls_accid			= string	( of_getattribmapaccid( as_coopid, "LON", "SHR" , ls_shrlontype, li_shrlonstatus, "account_id" ) )
     ls_accintid		= string	( of_getattribmapaccid(as_coopid, "LON", "LON" , ls_shrloncode, li_shrlonstatus, "accint_id" ) )
	ls_accintarrid		= string	( of_getattribmapaccid( as_coopid, "LON", "LON" , ls_shrloncode, li_shrlonstatus, "accintarr_id"  ) )
	ll_sortacc			= long	( of_getattribmapaccid(as_coopid,"LON", "SHR" , ls_shrlontype, li_shrlonstatus, "sortacc_order"   ) )
	ls_accid_clc		= string	( of_getattribmapaccid( as_coopid, "LON", "LON" , ls_shrloncode, li_shrlonstatus, "account_id" ) )
	

	if ( li_slipflag > 0 ) then
		ls_accside		= "CR"
		ls_accrevside	= "DR"
	else
		ls_accside		= "DR"
		ls_accrevside	= "CR"
	end if
	
	// hare_code เพื่อแยกประเภทหุ้นของสมาชิกปกติ กับ สมทบ by Mike 04/09/2013
	if(left(ls_memgroup,1) = 'S' ) and ls_itemtype = 'SHR' then
		ls_accid = string( of_getattribmapaccid( as_coopid, "LON", "SHR" , "S1", 1, "account_id" ) )  
	end if


if isnull (ls_slipclr) or ls_slipclr = "" then //เช็คว่ามีหักกลบรึป่าว
	// รายการจ่ายเงิน
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid  , ls_accside, ldc_itempay, ls_desc, ll_sortacc, ids_vcrcvpaydet)
	end if
	
	// รายการฝั่งตรงข้าม
	if 	( ldc_itempay > 0 ) then		
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno ,"TRN", "TRN", ls_tofromaccid , ls_accrevside, ldc_itempay ,ls_desc , 1, ids_vcrcvpaydet  )
	end if
	
else
	
			// รายการจ่ายเงิน
	if(ls_slipno_bf <> ls_slipno) then
		if ( ldc_itempay > 0 ) then
			this.of_additemdesc( as_coopid ,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid  , ls_accside, ldc_itempay, ls_desc, ll_sortacc, ids_vcrcvpaydet)
		end if
		// รายการฝั่งตรงข้าม
		if (ldc_total > 0) then
			this.of_additemdesc( as_coopid , is_vcrcvtrndocno ,"TRN", "TRN", ls_tofromaccid , ls_accrevside, ldc_total ,ls_desc , 1, ids_vcrcvpaydet )
		end if
	end if
	if 	( ldc_itempay > 0 ) then	
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno ,"TRN", "TRN", ls_accid_clc , ls_accrevside, ldc_prinpay ,ls_desc , 1, ids_vcrcvpaydet  )
	end if

	if ( ldc_int > 0 ) then
		this.of_additemdesc( as_coopid ,  is_vcrcvtrndocno, ls_itemtype, ls_tmpvcgrp, ls_accintid , ls_accrevside, ldc_int, ls_desc, ll_sortacc, ids_vcrcvpaydet)
	end if
	
end if
	
	// Update สถานะการผ่าน Voucher
	if	ls_slipno	<> ls_slipno_bf		then
		update		slslippayout
		set			posttovc_flag		= 1,	
					voucher_no			= :is_vcrcvtrndocno
		where		( payoutslip_no		= :ls_slipno ) and
					(memcoop_id			= :as_coopid) and
					(coop_id			= :ls_coopid)

		using     itr_sqlca   ;							
	end if
	
	ls_slipno_bf		= ls_slipno
	
next

destroy (lds_slipdata)

//update
if ids_vcrcvpay.update() <> 1 then	
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

return 1
end function

private function integer of_vctrnfinrcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการรับการเงิน เงินโอน
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/
string		ls_slipno, ls_slipprior, ls_mapacc, ls_accid
string		ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp
string		ls_itemtype, ls_tofromaccid, ls_itemdesc
long		ll_index, ll_count, ll_index2
dec{2}		ldc_itempay
string		ls_slipitem_desc, ls_accid_bf
string		ls_desc, ls_voucher_type , ls_cash, ls_coopid

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_trnfnrcv"
lds_slipdata.settransobject( itr_sqlca )

// retrieve 
ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if


ls_tmpsystem		= "FIN"
ls_tmpvcgrp			= "DAY"
ls_accid_bf			= ""
ll_index2			=	1
is_vcrcvtrndocno	= ""
// สร้างเลข Voucher
	 if  is_vcrcvtrndocno    =  ""  then
			ls_voucher_type		= "JV"
			ls_desc  			= "รายการโอน(การเงินรับ)"		
			is_vcrcvtrndocno	= this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
		else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	

//
for ll_index = 1 to ll_count
	ls_slipno				= trim( lds_slipdata.object.slip_no[ ll_index ] )
	ldc_itempay				= lds_slipdata.object.itempay_amt[ ll_index ]	
	ls_accid				= lds_slipdata.object.account_id[ ll_index ]
	ls_itemdesc				= trim( lds_slipdata.object.slipitem_desc[ ll_index ] )
	ls_tofromaccid			= trim( lds_slipdata.object.tofrom_accid[ ll_index ] )
	ls_coopid				= lds_slipdata.object.coop_id[ ll_index ]
	
	ls_accside			= "CR"
	ls_accrevside		= "DR"
	
	// รายการการเงิน
	if ( ldc_itempay > 0 ) then		
		this.of_additemdesc(  as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay , ls_desc , 1, ids_vcrcvpaydet )
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_tofromaccid , ls_accrevside, ldc_itempay , ls_desc , 2, ids_vcrcvpaydet )
	end if

	// Update สถานะการผ่าน Voucher
	if ls_slipno <> ls_slipprior then
		update	finslipdet
		set			posttovc_flag	= 1,	
					voucher_no		= :is_vcrcvtrndocno
		where	( slip_no			= :ls_slipno ) and
					( coop_id			= :ls_coopid ) 
		using     itr_sqlca   ;
		
		ls_slipprior	= ls_slipno
	end if
	
	ls_accid_bf	= ls_accid
	
next

destroy( lds_slipdata )
//update
if ids_vcrcvpay.update() <> 1 then	
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

return 1
end function

private function integer of_vctrnfinpay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการจ่ายการเงิน เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/
string			ls_slipno, ls_slipprior, ls_accid, ls_accintarrid, ls_mapacc, ls_colname, ls_vc_type,ls_taxid
string			ls_accside, ls_accrevside, ls_vcdocno, ls_tmpsystem, ls_tmpvcgrp ,ls_slipitem_desc
string			ls_moneygrp, ls_depttype, ls_itemtype, ls_tofromaccid, ls_docno, ls_year
string			ls_desc
integer			li_slipflag,ll_seqno
long			ll_index, ll_count,ll_find, ll_index2
dec{2}			ldc_itempay,ldc_tax_amt,ldc_itembal, ldc_itemamtnet
string			ls_slipitemtype_code,ls_vcrcvno,ls_acctaxid,ls_cashcode ,ls_account_id 
string			ls_accid_bf,  ls_itemdesc , ls_cash, ls_coopid , ls_detail
string			ls_finno, ls_tofromaccid_bf, ls_voucher_type 

n_ds			lds_vcpay, lds_vcpaydet, lds_vcpaydetail
datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_trnfnpay"
lds_slipdata.settransobject( itr_sqlca )
 
ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

//ls_desc	= "จ่ายเงิน"
ls_tmpsystem		= "FIN"
ls_tmpvcgrp			= "DAY"
ls_accid_bf			= ""
ll_index2			=	1
// สร้างเลข Voucher
is_vcrcvtrndocno = ""

	 if  is_vcrcvtrndocno    =  ""  then
			ls_voucher_type	= "JV"
			ls_desc  				= "รายการโอน(การเงินจ่าย)"		
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
		else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	



for ll_index = 1 to ll_count
	ls_slipno				= lds_slipdata.object.slip_no[ ll_index ]
	ldc_itempay				= lds_slipdata.object.itempay_amt[ ll_index ]	
	ls_accid				= lds_slipdata.object.account_id[ ll_index ]
	ls_slipitem_desc		= trim( lds_slipdata.object.slipitem_desc[ ll_index ] )
	ls_tofromaccid			= trim( lds_slipdata.object.tofrom_accid[ ll_index ] )
	ls_finno				= trim( ls_slipno )	
	ldc_tax_amt				= lds_slipdata.object.tax_amt[ ll_index ]
	ldc_itemamtnet			= lds_slipdata.object.item_amtnet[ ll_index ]
	ls_coopid				= lds_slipdata.object.coop_id[ ll_index ]
	ls_detail				= lds_slipdata.object.nonmember_detail[ ll_index ]
	
	if isnull( ldc_tax_amt ) then ldc_tax_amt = 0
	ls_taxid	= string( of_getattribmapaccid( as_coopid ,"FIN", "TAX", "01", 1, "account_id"  ) )
	
	ls_accside		= "DR"
	ls_accrevside	= "CR"			

	
	//รายการการเงิน
if (ldc_tax_amt > 0) then
	if ( ldc_itempay > 0 ) then
		ldc_itempay = ldc_itemamtnet + ldc_tax_amt
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, ls_desc, 1, ids_vcrcvpaydet )
		this.of_additemdesc( as_coopid ,is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_tofromaccid, ls_accrevside, ldc_itemamtnet, ls_desc, 2, ids_vcrcvpaydet)
		this.of_additemdesc( as_coopid ,is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_taxid, ls_accrevside, ldc_tax_amt, ls_desc, 3, ids_vcrcvpaydet)
	end if
else
	if ( ldc_itemamtnet > 0 ) then
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, ls_desc, 1, ids_vcrcvpaydet )
		this.of_additemdesc( as_coopid ,is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_tofromaccid, ls_accrevside, ldc_itempay, ls_desc, 2, ids_vcrcvpaydet)
	end if
end if
		
	//update สถานะการดึงข้อมูล
	if ls_slipno <> ls_slipprior then
		update	finslipdet
		set			posttovc_flag	= 1,	
					voucher_no		= :is_vcrcvtrndocno
		where	( slip_no			= :ls_slipno ) and
					( coop_id			= :ls_coopid )
		using    	 itr_sqlca   ;	
		
		ls_slipprior	= ls_slipno
	end if
	
	ls_accid_bf	= ls_accid
	ls_tofromaccid_bf	= ls_tofromaccid
next

destroy( lds_slipdata )
// update Vc
if ids_vcrcvpay.update() <> 1 then	
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if


if ids_voucher.update() <> 1 then	
	return -1
end if
	
if ids_voucherdet.update() <> 1 then	
	return -1
end if

return 1
end function

private function integer of_vctrnpayout_atm (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการจ่าย เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/
string		ls_slipno, ls_refopeno, ls_accid, ls_accintid, ls_accintarrid , ls_cash ,ls_slipno_bf,ls_taxid
string		ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp
string		ls_moneygrp, ls_shrlontype, ls_sliptype, ls_itemtype, ls_tofromaccid
string		ls_shrcvno[]
string		ls_branchid,ls_mbbranch_id,ls_acccr_id,ls_accdr_id,ls_desc,ls_year,ls_vcdocno,ls_docno,ls_mbbranch_idold
integer	li_shrlonstatus, li_slipflag, li_seqno,li_flag, li_addflag, li_clear_flag
long		ll_index, ll_count, ll_sindex, ll_scount, ll_find, ll_sortacc, ll_sortint, ll_sortintarr, ll_index2
dec{2}	ldc_prinpay, ldc_intpay, ldc_intarrpay, ldc_itempay, ldc_loanrcv, ldc_loanfine
dec{2}	ldc_loanrcvnet, ldc_clcfee, ldc_sharebuy, ldc_wrtfund_amt
datetime	ldtm_operate
string		ls_month, ls_date, ls_tofromaccid_bf, ls_accid_bf, ls_accintid_bf, ls_loangroup_code, ls_accid_clc
string		ls_vc_desc, ls_vcdocno_prnc, ls_itemdesc, ls_vcdocno_int, ls_vcdocno_etc, ls_payoutno
string		ls_loantype_pay, ls_loantype_rcv, ls_sliplwd_no, ls_slipclc_no
string		ls_vccash_tran_01, ls_vccash_tran_02, ls_vccash_tran_03, ls_vccash_01, ls_vccash_02, ls_vccash_03
string		ls_laonrcv_temp, ls_laonrcv_current, ls_receiptno , ls_document_no  ,  as_vcdocno
dec{2}	ldc_clcprnc, ldc_clcint, ldc_fineall, ldc_feeall,  ldc_int, ldc_total, ldc_shrpay
string		ls_tran01, ls_tran02, ls_tran03, ls_tran2, ls_tran3, ls_tran4, ls_vccash_tran2, ls_vccash_tran3, ls_vc_type , ls_voucher_type
string		ls_slipitem_desc, ls_coopid, ls_shrloncode, ls_loangroup, ls_slipclr, ls_memgroup, ls_slipitemtype_code, ls_accshr, ls_itemtypeshr

datastore	lds_slipdata

// ds สำหรับดึงข้อมูลการจ่ายเงินกู้
lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_trnlnpay_atm"
lds_slipdata.settransobject( itr_sqlca )

ll_count			= lds_slipdata.retrieve( adtm_vcdate , as_coopid   )
is_vcrcvtrndocno = ""
// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpvcgrp			= "PAY"
ls_tofromaccid_bf	= ""
ls_accid_bf			= ""
ls_accintid_bf		= ""
ls_laonrcv_temp	= ""
ll_index2				=	1
//// สร้างเลข Voucher
is_vcrcvtrndocno = ""
	 if  is_vcrcvtrndocno    =  ""  then
			ls_voucher_type	= "JV"
			ls_desc  				= "จ่ายเงินกู้แก่สมาชิก(ตู้ ATM)"		
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
		else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	

//end if		

//
for ll_index = 1 to ll_count
		
	ls_slipno			= lds_slipdata.object.payoutslip_no[ ll_index ]
	ls_document_no		= lds_slipdata.object.document_no[ ll_index ]
	ls_moneygrp			= lds_slipdata.object.moneytype_group[ ll_index ]
	ls_shrlontype		= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_tofromaccid		= lds_slipdata.object.tofrom_accid[ ll_index ]
	li_shrlonstatus		= 1
	li_slipflag			= lds_slipdata.object.sliptypesign_flag[ ll_index ]
	ldc_itempay			= lds_slipdata.object.payout_amt[ ll_index ]
	ls_sliptype			= lds_slipdata.object.sliptype_code [ ll_index ]
	ls_coopid				= lds_slipdata.object.coop_id [ ll_index ]
	ls_loangroup		= lds_slipdata.object.loangroup_code[ ll_index ]
	ls_slipclr			= lds_slipdata.object.slipclear_no[ ll_index ]
	ls_memgroup			= lds_slipdata.object.membgroup_code[ ll_index ]
	ls_slipitemtype_code	= lds_slipdata.object.slipitemtype_code[ ll_index ]
	ls_shrloncode		= lds_slipdata.object.slslippayindet_shrlontype_code [ ll_index ]
	ldc_int				= lds_slipdata.object.interest_payamt [ ll_index ]
	ldc_prinpay			= lds_slipdata.object.principal_payamt [ ll_index ]
	ldc_total			= lds_slipdata.object.payoutnet_amt [ ll_index ]
	ldc_shrpay			= lds_slipdata.object.item_payamt [ ll_index ]


//	if isnull(ls_itemtype) or ls_itemtype = "" then ls_itemtype = 'LON'
	if isnull(ldc_prinpay) then ldc_prinpay = 0
	if isnull(ldc_itempay) then ldc_itempay = 0
	if isnull(ldc_int) then ldc_int = 0
	if isnull(ldc_total) then ldc_total = 0
	if isnull(ls_shrloncode) or  ls_shrloncode = '' then ls_shrloncode = '88'

	
	choose case ls_sliptype
		case  'LWD'	
			ls_itemtype		= 'LON'
		case  'SWD'	,'SWT','SWP'
			ls_itemtype		= 'SHR'
	end choose				
	
	ls_accid		= string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype , ls_shrlontype, li_shrlonstatus, "account_id" ) )
	ls_accintid		= string	( of_getattribmapaccid(as_coopid, "LON", ls_itemtype , ls_shrlontype, li_shrlonstatus, "accint_id" ) )
	ls_accintarrid	= string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype , ls_shrlontype, li_shrlonstatus, "accintarr_id"  ) )
	ll_sortacc		= long	( of_getattribmapaccid(as_coopid,"LON", ls_itemtype , ls_shrlontype, li_shrlonstatus, "sortacc_order"   ) )
	ll_sortint		= long	( of_getattribmapaccid(as_coopid, "LON", ls_itemtype , ls_shrlontype, li_shrlonstatus, "sortint_order"  ) )
	ll_sortintarr	= long	( of_getattribmapaccid( as_coopid,"LON", ls_itemtype , ls_shrlontype, li_shrlonstatus, "sortintarr_order"  ) )
	ls_accid_clc	= string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype , ls_shrloncode, li_shrlonstatus, "account_id" ) )
	ls_taxid		= string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype , ls_shrlontype, li_shrlonstatus, "acctax_id" ) )
	
	//if trim(ls_tofromaccid) = '12345678' then  ls_tofromaccid = ls_taxid
	
	
	if trim(ls_slipitemtype_code) = 'LON' then 
				
	else
		choose case ls_slipitemtype_code
				
			case  'SHR' //ค่าหุ้น
				ls_itemtypeshr		= 'SHR'
				ls_shrlontype	= '01'
				ls_accshr = string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtypeshr , ls_shrlontype, li_shrlonstatus, "account_id" ) )
			case else
				ls_itemtypeshr		= trim(ls_slipitemtype_code)
				ls_shrlontype	= '00'
				ls_accshr = string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtypeshr , ls_shrlontype, li_shrlonstatus, "account_id" ) )
			
		end choose
	end if
	
	if ( li_slipflag > 0 ) then
		ls_accside		= "CR"
		ls_accrevside	= "DR"
	else
		ls_accside		= "DR"
		ls_accrevside	= "CR"
	end if			
	
			// hare_code เพื่อแยกประเภทหุ้นของสมาชิกปกติ กับ สมทบ by Mike 04/09/2013
	if(left(ls_memgroup,1) = 'S' ) and ls_itemtype = 'SHR' then
		ls_accid = string( of_getattribmapaccid( as_coopid, "LON", "SHR" , "S1", 1, "account_id" ) )   
	end if
		
	if isnull (ls_slipclr) or ls_slipclr = "" then //เช็คว่ามีหักกลบรึป่าว
	// รายการจ่ายเงิน
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid ,  is_vcrcvtrndocno, ls_itemtype, ls_tmpvcgrp, ls_accid  , ls_accside, ldc_itempay, ls_desc, ll_sortacc, ids_vcrcvpaydet)
	end if
	
	// รายการฝั่งตรงข้าม
	if 	( ldc_itempay > 0 ) then		
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno ,"TRN", "TRN", ls_tofromaccid , ls_accrevside, ldc_itempay , ls_desc , 1, ids_vcrcvpaydet  )
	end if
	
	else
	
	// รายการจ่ายเงิน
	if(ls_slipno_bf <> ls_slipno) then
		if ( ldc_itempay > 0 ) then
			this.of_additemdesc( as_coopid ,  is_vcrcvtrndocno, ls_itemtype, ls_tmpvcgrp, ls_accid  , ls_accside, ldc_itempay, ls_desc, ll_sortacc, ids_vcrcvpaydet)
		end if
		if (ldc_total > 0) then
			this.of_additemdesc( as_coopid , is_vcrcvtrndocno ,"TRN", "TRN", ls_tofromaccid , ls_accrevside, ldc_total ,ls_desc , 1, ids_vcrcvpaydet  )
		end if
	end if
		choose case ls_slipitemtype_code
			case 'SHR'
		if (ldc_shrpay > 0) then //ยอดซื้อหุ้น
			this.of_additemdesc( as_coopid ,  is_vcrcvtrndocno, ls_itemtype, ls_tmpvcgrp, ls_accshr , ls_accrevside, ldc_shrpay, ls_desc, ll_sortacc, ids_vcrcvpaydet)
		end if

			case 'LON'
		// รายการฝั่งตรงข้าม
		if 	( ldc_itempay > 0 ) then	
			this.of_additemdesc( as_coopid , is_vcrcvtrndocno ,"TRN", "TRN", ls_accid_clc , ls_accrevside, ldc_prinpay,ls_desc  , 1, ids_vcrcvpaydet  )
		end if
	
		if ( ldc_int > 0 ) then
			this.of_additemdesc( as_coopid ,  is_vcrcvtrndocno, ls_itemtype, ls_tmpvcgrp, ls_accintid , ls_accrevside, ldc_int, ls_desc, ll_sortacc, ids_vcrcvpaydet)
		end if
	
			case else
		if (ldc_shrpay > 0) then //ยอดค่าธรรมเนียม
			this.of_additemdesc( as_coopid ,  is_vcrcvtrndocno, ls_itemtype, ls_tmpvcgrp, ls_accshr , ls_accrevside, ldc_shrpay, ls_desc, ll_sortacc, ids_vcrcvpaydet)
		end if		
			end choose
//end if
end if
	
			
	// Update สถานะการผ่าน Voucher
	if	ls_slipno	<> ls_slipno_bf		then
		update		slslippayout
		set			posttovc_flag		= 1,	
					voucher_no			= :is_vcrcvtrndocno
		where		( payoutslip_no		= :ls_slipno ) and
					( memcoop_id		= :as_coopid )
		using     itr_sqlca   ;							
	end if
	
	ls_accid_bf		= ls_accid
	ls_accintid_bf	= ls_accintid
	ls_slipno_bf		= ls_slipno
	
next

destroy( lds_slipdata )
//update
if ids_vcrcvpay.update() <> 1 then	
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if


if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if


return 1
end function

private function integer of_vctrn_kpmonth (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการเรียกเก็บประจำเดือน
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/
string			ls_slipno, ls_slipprior, ls_accid, ls_accintarrid, ls_mapacc, ls_colname
string			ls_accside, ls_accrevside, ls_vcdocno, ls_tmpsystem, ls_tmpvcgrp ,ls_slipitem_desc
string			ls_moneygrp, ls_depttype, ls_itemtype, ls_tofromaccid, ls_itemtypecode
string			ls_branchid,ls_accmaster_branch_id,ls_acccr_id,ls_accdr_id,ls_oldbranchid,ls_desc,ls_vcbrdocno
integer			li_slipflag,ll_seqno, li_shrlonstatus
long			ll_index, ll_count,ll_find
dec{2}			ldc_itempay,ldc_tax_amt,ldc_itembal, ldc_itemamtnet, ldc_principal, ldc_int, ldc_deptamt, ldc_total, ldc_intarrear
string			ls_slipitemtype_code,ls_vcrcvno,ls_acctaxid,ls_cashcode ,ls_account_id 
string			ls_itemdesc ,  ls_shrlontype, ls_membno
string			ls_finno, ls_finno_temp, ls_tofromaccid_bf, ls_voucher_type 
string			ls_system_code, ls_accintid, ls_recv_period, ls_kpaccid

n_ds			lds_vcpay, lds_vcpaydet
datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_kp_month_all"
lds_slipdata.settransobject( itr_sqlca )
 
ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

//ls_desc	= "จ่ายเงิน"
ls_tmpsystem		= "KEP"
ls_tmpvcgrp			= "MTH"
is_vcrcvtrndocno	= ""
// สร้างเลข Voucher

	 if  is_vcrcvtrndocno    =  ""  then
			ls_voucher_type	= "JV"
			ls_desc  				= "รายการเรียกเก็บรายเดือน"		
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
		else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	


for ll_index = 1 to ll_count
	ldc_itempay				= lds_slipdata.object.item_payment[ ll_index ]	
	ldc_principal			= lds_slipdata.object.principal_payment[ ll_index ]
	ldc_int					= lds_slipdata.object.interest_payment[ ll_index ]
	ls_itemtype				= lds_slipdata.object.keepitemtype_code[ ll_index ]
	ls_shrlontype			= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_system_code			= trim(lds_slipdata.object.system_code[ ll_index ])
	li_shrlonstatus			= lds_slipdata.object.bfcontlaw_status[ ll_index ] 
	ldc_intarrear			= lds_slipdata.object.intarrear_payment[ ll_index ] 
	ls_recv_period			= lds_slipdata.object.recv_period[ ll_index ]  

	if isnull( ldc_principal ) then ldc_principal = 0
	if isnull( ldc_int ) then ldc_int = 0
	ldc_intarrear = 0    // ตียอดดอกเบี้ยค้าง = 0  เพราะที่ยกมาจากยอดก่อน+ ยอดประจำงวด จะเท่ากับยอด intarrear_payment อยู่แล้ว edit by Apple 30/09/2558
	if isnull(ls_shrlontype)	 then ls_shrlontype	= '00'
	if isnull(li_shrlonstatus) or li_shrlonstatus = 0 then li_shrlonstatus = 1
	
	
	choose case ls_itemtype
		case  'L01','L02','L03'	
			ls_itemtypecode		= 'LON'
		case 'S01'
			ls_itemtypecode		= 'SHR'
		case 'D00','D01','D02'
			ls_itemtypecode		= 'DEP' 
		case 'IAR'
			ls_itemtypecode		= 'IAR'
		case else
			ls_itemtypecode		= ls_itemtype
			ls_shrlontype	= '00'
		end choose		
	
	ls_accid		= string	( of_getattribmapaccid( as_coopid, ls_system_code, ls_itemtypecode , ls_shrlontype, li_shrlonstatus, "account_id" ) )
	ls_accintid		= string	( of_getattribmapaccid(as_coopid, ls_system_code, ls_itemtypecode , ls_shrlontype, li_shrlonstatus, "accint_id" ) )
	ls_accintarrid	= string	( of_getattribmapaccid(as_coopid, ls_system_code, ls_itemtypecode , ls_shrlontype, li_shrlonstatus, "accintarr_id"  ) )
	ls_kpaccid		= string	( of_getattribmapaccid( as_coopid, "KEP", "KEP" , "01", 1, "account_id" ) ) //รหัสลูกหนี้ตัวแทน
	
	
		
	ls_accside		= "DR"
	ls_accrevside	= "CR"			
	
	if(ldc_itempay > 0) then  //ลูกหนี้ตัวแทน ฝั่ง DR
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_kpaccid, ls_accside, ldc_itempay, ls_desc, 1, ids_vcrcvpaydet )
	end if
	
	choose case ls_itemtype
		case 'L01','L02','L03'
			
	if(ldc_principal > 0) then //ฝั่ง CR
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accrevside, ldc_principal, ls_desc, 2, ids_vcrcvpaydet )
	end if
	if(ldc_int > 0) then //ดอกเบี้ยฝั่ง CR
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accintid, ls_accrevside, ldc_int, ls_desc, 3, ids_vcrcvpaydet )
	end if
	if(ldc_intarrear > 0) then //ฝั่ง CR
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accintarrid, ls_accrevside, ldc_intarrear, ls_desc, 4, ids_vcrcvpaydet )
	end if

	case else
	if(ldc_itempay > 0) then  //
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accrevside, ldc_itempay, ls_desc, 5, ids_vcrcvpaydet )
	end if

end choose

next

	//update สถานะการดึงข้อมูล
		update	kpmastreceivedet
		set			posttovc_flag	= 1,	
					voucher_no		= :is_vcrcvtrndocno
		where		( recv_period	= :ls_recv_period ) and
					( coop_id			= :as_coopid ) //and 
//					(keepitemtype_code	not like '%D%') and
//					(keepitem_status = 1)
		using    	 itr_sqlca   ;

destroy (lds_slipdata)
// update Vc
if ids_vcrcvpay.update() <> 1 then	
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if


if ids_voucher.update() <> 1 then	
	return -1
end if
	
if ids_voucherdet.update() <> 1 then	
	return -1
end if

return 1
end function

private function integer of_vctrn_cancel_kp_month (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการเรียกเก็บประจำเดือน
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/
string			ls_slipno, ls_slipprior, ls_accid, ls_accintarrid, ls_mapacc, ls_colname, ls_vc_type
string			ls_accside, ls_accrevside, ls_vcdocno, ls_tmpsystem, ls_tmpvcgrp ,ls_slipitem_desc
string			ls_moneygrp, ls_depttype, ls_itemtype, ls_tofromaccid, ls_docno, ls_year
string			ls_branchid,ls_accmaster_branch_id,ls_acccr_id,ls_accdr_id,ls_oldbranchid,ls_desc,ls_vcbrdocno
integer		li_slipflag,ll_seqno, li_shrlonstatus
long			ll_index, ll_count,ll_find, ll_index2, ll_sortacc, ll_sortint, ll_sortintarr
dec{2}		ldc_itempay,ldc_tax_amt,ldc_itembal, ldc_itemamtnet, ldc_principal, ldc_int, ldc_deptamt, ldc_total, ldc_intarrear
int				ll_num_D00, ll_num_D01, ll_num_S01, ll_num_WF, ll_num_OTH, ll_num_FFE, ll_num_L01, ll_num_L02, ll_num_L03
string			ls_slipitemtype_code,ls_vcrcvno,ls_acctaxid,ls_cashcode ,ls_account_id 
string			ls_accid_bf, ls_vcrcvdocno_tax , ls_itemdesc , ls_cash, ls_shrlontype, ls_membno, ls_membno_last
string			ls_finno, ls_finno_temp, ls_tofromaccid_bf, ls_voucher_type , as_vcdocno, ls_deptaccount
string			ls_itemdesc_D00, ls_itemdesc_D01, ls_itemdesc_S01, ls_itemdesc_WF, ls_itemdesc_OTH, ls_itemdesc_FFE
string			ls_itemdesc_L01, ls_itemdesc_L02, ls_itemdesc_L03, ls_system_code, ls_accintid, ls_recv_period,ls_kpaccintid,ls_kpaccid

n_ds			lds_vcpay, lds_vcpaydet
datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cancel_kp_month"
lds_slipdata.settransobject( itr_sqlca )
 
ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

//ls_desc	= "จ่ายเงิน"
ls_tmpsystem		= "KEP"
ls_tmpvcgrp			= "MTH"
ls_accid_bf			= ""
ls_vcrcvdocno_tax	= ""
ls_finno_temp		= ""
ll_index2				=	1
ls_membno_last	=	""
ll_num_D00			=	1
ll_num_D01			=	1
ll_num_S01			=	1
ll_num_WF			=	1
ll_num_OTH			=	1
ll_num_FFE			=	1
ll_num_L01			=	1
ll_num_L02			=	1
ll_num_L03			=	1
is_vcrcvtrndocno	= ""
// สร้างเลข Voucher

	 if  is_vcrcvtrndocno    =  ""  then
			ls_voucher_type	= "JV"
			ls_desc  				= "รายการยกเลิกกระดาษทำการ"		
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
		else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	


for ll_index = 1 to ll_count
//	ls_slipno					= lds_slipdata.object.kpslip_no[ ll_index ]
	ldc_itempay				= lds_slipdata.object.item_payment[ ll_index ]	
	ldc_principal				= lds_slipdata.object.principal_payment[ ll_index ]
	ldc_int					= lds_slipdata.object.interest_payment[ ll_index ]
	ls_itemtype				= lds_slipdata.object.keepitemtype_code[ ll_index ]
	ls_shrlontype			= lds_slipdata.object.shrlontype_code[ ll_index ]
//	ls_deptaccount			= trim(lds_slipdata.object.description[ ll_index ])
//	ls_membno				= trim(lds_slipdata.object.member_no[ ll_index ])
	ls_system_code		= trim(lds_slipdata.object.system_code[ ll_index ])
	li_shrlonstatus			= lds_slipdata.object.bfcontlaw_status[ ll_index ]     
	ldc_intarrear			= lds_slipdata.object.intarrear_payment[ ll_index ] 
	ls_recv_period			= lds_slipdata.object.recv_period[ ll_index ]  
	
	if isnull(li_shrlonstatus) or li_shrlonstatus = 0 then li_shrlonstatus = 1
	if isnull( ldc_principal ) then ldc_principal = 0
	if isnull( ldc_int ) then ldc_int = 0
	ldc_intarrear = 0    // ตียอดดอกเบี้ยค้าง = 0  เพราะที่ยกมาจากยอดก่อน+ ยอดประจำงวด จะเท่ากับยอด intarrear_payment อยู่แล้ว edit by Apple 30/09/2558
	if isnull(ls_shrlontype)	then ls_shrlontype	= '00'
	if ( ls_itemtype = 'FFE' ) then
		ls_shrlontype	= '00'
	end if
	choose case ls_itemtype
		case  'S01'	
			ls_system_code		= 'SHR'
		case 'FFE'
			ls_system_code		= 'FFE'
		case 'FEE'
			ls_system_code		= 'FEE'
		case 'ISF'  //ลูกหนี้ค่าเบี้ยประกันภัย
			ls_system_code		= 'ISF'
		end choose		
	
	ls_accid			= string	( of_getattribmapaccid( as_coopid, "LON", ls_system_code , ls_shrlontype, li_shrlonstatus, "account_id" ) )
	ls_accintid		= string	( of_getattribmapaccid(as_coopid, "LON", ls_system_code , ls_shrlontype, li_shrlonstatus, "accint_id" ) )
	ls_accintarrid	= string	( of_getattribmapaccid(as_coopid, "LON", ls_system_code , ls_shrlontype, li_shrlonstatus, "accintarr_id"  ) )
	ll_sortacc		= long	( of_getattribmapaccid( as_coopid,"LON", ls_system_code, ls_shrlontype, li_shrlonstatus, "sortacc_order"   ) )
	ll_sortint			= long	( of_getattribmapaccid(as_coopid, "LON", ls_system_code , ls_shrlontype, li_shrlonstatus, "sortint_order"  ) )
	ll_sortintarr		= long	( of_getattribmapaccid(as_coopid, "LON", ls_system_code, ls_shrlontype, li_shrlonstatus, "sortintarr_order"  ) )
	ls_vc_type		= string	( of_getattribmapaccid(as_coopid, "LON", ls_system_code, ls_shrlontype, li_shrlonstatus, "prefix_recv"  ) )
//	ls_kpaccid		= string	( of_getattribmapaccid( as_coopid, "KEP", "KEP" , "01", 1, "account_id" ) ) //รหัสลูกหนี้ตัวแทน
 	ls_kpaccintid	= string	( of_getattribmapaccid(as_coopid, "KEP", "KEP" , "01", 1, "accint_id" ) )
		
	ls_accside		= "CR"
	ls_accrevside	= "DR"			
	
	if(ldc_itempay > 0) then  //ลูกหนี้ตัวแทน ฝั่ง DR
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_kpaccintid, ls_accside, ldc_itempay, ls_desc, 1, ids_vcrcvpaydet )
	end if
	
	choose case ls_itemtype
		case 'L01','L02','L03'
	if(ldc_principal > 0) then //ฝั่ง CR
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accrevside, ldc_principal, ls_desc, 2, ids_vcrcvpaydet )
	end if
	if(ldc_int > 0) then //ดอกเบี้ยฝั่ง CR
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accintid, ls_accrevside, ldc_int, ls_desc, 3, ids_vcrcvpaydet )
	end if
	if(ldc_intarrear > 0) then //ฝั่ง CR
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accintarrid, ls_accrevside, ldc_intarrear, ls_desc, 4, ids_vcrcvpaydet )
	end if

		case else
	
	if(ldc_itempay > 0) then  //
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accrevside, ldc_itempay, ls_desc, 5, ids_vcrcvpaydet )
	end if

end choose


	ls_accid_bf	= ls_accid
	ls_finno_temp	= ls_finno
	ls_tofromaccid_bf	= ls_tofromaccid
	ls_membno_last = ls_membno
next

	//update สถานะการดึงข้อมูล
		update	kpmastreceivedet
		set			canceltovc_flag	= 1,	
					cancelvc_no			= :is_vcrcvtrndocno
		where	( recv_period	= :ls_recv_period ) and
					( coop_id			= :as_coopid ) and 
//					(keepitemtype_code	not like '%D%') and
					( keepitem_status	= -9)
		using    	 itr_sqlca   ;

destroy (lds_slipdata)
// update Vc
if ids_vcrcvpay.update() <> 1 then	
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if


if ids_voucher.update() <> 1 then	
	return -1
end if
	
if ids_voucherdet.update() <> 1 then	
	return -1
end if

return 1
end function

private function integer of_vctrn_cancel_kp_month_slip (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการเรียกเก็บประจำเดือน
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/
string			ls_slipno, ls_slipprior, ls_accid, ls_accintarrid, ls_mapacc, ls_colname, ls_vc_type
string			ls_accside, ls_accrevside, ls_vcdocno, ls_tmpsystem, ls_tmpvcgrp ,ls_slipitem_desc
string			ls_moneygrp, ls_depttype, ls_itemtype, ls_tofromaccid
string			ls_desc
integer			li_slipflag,ll_seqno, li_shrlonstatus
long			ll_index, ll_count,ll_find, ll_index2, ll_sortacc, ll_sortint, ll_sortintarr
dec{2}			ldc_itempay,ldc_tax_amt,ldc_itembal, ldc_itemamtnet, ldc_principal, ldc_int, ldc_deptamt, ldc_total, ldc_intarrear
string			ls_slipitemtype_code,ls_acctaxid,ls_account_id 
string			ls_accid_bf, ls_itemdesc ,  ls_shrlontype
string			ls_voucher_type
string			ls_system_code, ls_accintid, ls_recv_period

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cancel_mth_slip2"
lds_slipdata.settransobject( itr_sqlca )
 
ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

//ls_desc	= "จ่ายเงิน"
ls_tmpsystem		= "KEP"
ls_tmpvcgrp			= "MTH"
is_vcrcvtrndocno	= ""
// สร้างเลข Voucher

	 if  is_vcrcvtrndocno    =  ""  then
			ls_voucher_type	= "JV"
			ls_desc  				= "ยกเลิกใบเสร็จประจำเดือน"		
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
		else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	


for ll_index = 1 to ll_count
	ldc_itempay				= lds_slipdata.object.item_adjamt[ ll_index ]	
	ldc_principal			= lds_slipdata.object.principal_adjamt[ ll_index ]
	ldc_int					= lds_slipdata.object.interest_adjamt[ ll_index ]
	ls_itemtype				= lds_slipdata.object.bfmthpay_kpitemtyp[ ll_index ]
	ls_shrlontype			= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_system_code			= trim(lds_slipdata.object.system_code[ ll_index ])
	li_shrlonstatus			= lds_slipdata.object.bfcontlaw_status[ ll_index ]
	ldc_intarrear			= lds_slipdata.object.intarrear_adjamt[ ll_index ] 
	ls_recv_period			= lds_slipdata.object.ref_recvperiod[ ll_index ]  
	ls_tofromaccid			= trim(lds_slipdata.object.tofrom_accid[ ll_index ] )

	if isnull( ldc_principal ) then ldc_principal = 0
	if isnull( ldc_int ) then ldc_int = 0
	if isnull( ldc_intarrear ) then ldc_intarrear = 0
	if isnull(li_shrlonstatus) or li_shrlonstatus = 0 then li_shrlonstatus = 1
	if isnull(ls_shrlontype)	then ls_shrlontype	= '00'
	if ( ls_itemtype = 'FFE' ) then
		ls_shrlontype	= '00'
	end if
	choose case ls_itemtype
		case  'S01'	
			ls_system_code		= 'SHR'
		case 'FFE'
			ls_system_code		= 'FFE'
		case 'FEE'
			ls_system_code		= 'FEE'
		case 'ISF'
			ls_system_code		= 'ISF'
		end choose		
	
	ls_accid		= string	( of_getattribmapaccid( as_coopid, "LON", ls_system_code , ls_shrlontype, li_shrlonstatus, "account_id" ) )
	ls_accintid		= string	( of_getattribmapaccid(as_coopid, "LON", ls_system_code , ls_shrlontype, li_shrlonstatus, "accint_id" ) )
	ls_accintarrid	= string	( of_getattribmapaccid(as_coopid, "LON", ls_system_code , ls_shrlontype, li_shrlonstatus, "accintarr_id"  ) )
	ll_sortacc		= long	( of_getattribmapaccid( as_coopid,"LON", ls_system_code, ls_shrlontype, li_shrlonstatus, "sortacc_order"   ) )
	ll_sortint		= long	( of_getattribmapaccid(as_coopid, "LON", ls_system_code , ls_shrlontype, li_shrlonstatus, "sortint_order"  ) )
	ll_sortintarr	= long	( of_getattribmapaccid(as_coopid, "LON", ls_system_code, ls_shrlontype, li_shrlonstatus, "sortintarr_order"  ) )
	ls_vc_type		= string	( of_getattribmapaccid(as_coopid, "LON", ls_system_code, ls_shrlontype, li_shrlonstatus, "prefix_recv"  ) )
		
	ls_accside		= "CR"
	ls_accrevside	= "DR"			
	
	if(ldc_itempay > 0) then  //ลูกหนี้ตัวแทน ฝั่ง CR
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_tofromaccid, ls_accside, ldc_itempay, ls_desc, 1, ids_vcrcvpaydet )
	end if
	
	choose case ls_itemtype
		case 'L01','L02','L03'

	if(ldc_principal > 0) then //ฝั่ง DR
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accrevside, ldc_principal, ls_desc, 2, ids_vcrcvpaydet )
	end if
	if(ldc_int > 0) then //ดอกเบี้ยฝั่ง DR
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accintid, ls_accrevside, ldc_int, ls_desc, 3, ids_vcrcvpaydet )
	end if
	if(ldc_intarrear > 0) then //ฝั่ง DR
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accintarrid, ls_accrevside, ldc_intarrear, ls_desc, 4, ids_vcrcvpaydet )
	end if
	
		case else
	
	if(ldc_itempay > 0) then  //
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accrevside, ldc_itempay, ls_desc, 5, ids_vcrcvpaydet )
	end if
end choose

next

	//update สถานะการดึงข้อมูล
		update	slslipadjust
		set		posttovc_flag	= 1,	
				voucher_no			= :is_vcrcvtrndocno
		where	( ref_recvperiod	= :ls_recv_period ) and
				( coop_id			= :as_coopid ) and 
				( adjslip_date		= :adtm_vcdate )
					
		using    	 itr_sqlca   ;

destroy (lds_slipdata)
// update Vc
if ids_vcrcvpay.update() <> 1 then	
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if


if ids_voucher.update() <> 1 then	
	return -1
end if
	
if ids_voucherdet.update() <> 1 then	
	return -1
end if

return 1
end function

private function integer of_vctrnpayin_shr (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการชำระหนี้ + ซื้อหุ้น เงินโอน
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
	Version 2.0 (Initial version) Modified Date 09/11/2016 by Sakuraii	
</usage> 
***********************************************************/

string		ls_slipno,  ls_accid, ls_accintid, ls_accintarrid, ls_vc_type ,  ls_slipno_bf
string		ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp
string		ls_moneygrp, ls_shrlontype, ls_itemtype, ls_tofromaccid,ls_moneytype_code
integer	    li_shrlonstatus, li_slipflag, li_seqno,li_flag,li_group,li_group_bf
long		ll_index, ll_count, ll_sortacc, ll_sortint, ll_sortintarr
dec{2}		ldc_prinpay, ldc_intpay, ldc_itempay, ldc_intarrpay, ldc_intarrear
string		ls_loangroup_code,  ls_accintid_bf, ls_desc
string		ls_voucher_type ,  ls_coopid, ls_memgroup

datastore	lds_slipdata 

// ds สำหรับเก็บการชำระหนี้
lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_trnlnrcv_shr_exat"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate, as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

	 //สร้างเลข Voucher
is_vcrcvtrndocno = ""

	 if  is_vcrcvtrndocno    =  ""  then
			ls_voucher_type	= "JV"
			ls_desc  		= "รับค่าหุ้น + รับชำระหนี้จากสมาชิก"		
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
		else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 




ls_tmpvcgrp		= "PAY"
// ชุดการรับชำระหนี้
for ll_index = 1 to ll_count
	
	ls_slipno				= lds_slipdata.object.payinslip_no[ ll_index ]
	ls_moneygrp		= lds_slipdata.object.moneytype_group[ ll_index ]
	ls_shrlontype		= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_itemtype			= lds_slipdata.object.slipitemtype_code[ ll_index ]
	ls_tofromaccid		= lds_slipdata.object.tofrom_accid[ ll_index ]
	li_shrlonstatus		= lds_slipdata.object.bfcontlaw_status[ ll_index ]
	li_slipflag				= lds_slipdata.object.sliptypesign_flag[ ll_index ]
	ldc_prinpay			= lds_slipdata.object.principal_payamt[ ll_index ]
	ldc_intpay			= lds_slipdata.object.interest_payamt[ ll_index ]
	ldc_itempay			= lds_slipdata.object.item_payamt[ ll_index ]
	ls_coopid			= lds_slipdata.object.coop_id[ ll_index ]
	ls_memgroup		= lds_slipdata.object.membgroup_code[ ll_index ]
	li_group			= lds_slipdata.object.compute_6[ ll_index ]
	ldc_intarrear		= lds_slipdata.object.intarrear_payamt[ ll_index ]
	ls_moneytype_code	= lds_slipdata.object.moneytype_code[ ll_index ]   // ใช้แยกเคส ของขวัญ ถ้าเป็น TRN (GSB)
		
	if isnull( ldc_intpay ) then ldc_intpay = 0
	if isnull( ldc_prinpay ) then ldc_prinpay = 0
	if isnull( li_shrlonstatus) or li_shrlonstatus = 0  then li_shrlonstatus = 1
	if(ls_itemtype = 'FEE') then ls_itemtype = 'FFE'
	if isnull( ldc_intarrear ) then ldc_intarrear = 0
	if isnull( ls_shrlontype) or ls_shrlontype = ""  then ls_shrlontype = "00"
	// ด/บ จ่าย - ดอกเบี้ยคืน
	ldc_intpay = ldc_intpay - ldc_intarrear
		
	
	ls_accid			= string	( of_getattribmapaccid(as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "account_id" ) )
	ls_accintid		= string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "accint_id" ) )
	ls_accintarrid	= string	( of_getattribmapaccid(as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "accintarr_id"  ) )
	ll_sortacc		= long	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortacc_order"   ) )
	ll_sortint			= long	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortint_order"  ) )
	ll_sortintarr		= long	( of_getattribmapaccid( as_coopid ,"LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortintarr_order"  ) )
		
	if ( li_slipflag > 0 ) then
		ls_accside		= "CR"
		ls_accrevside	= "DR"
	else
		ls_accside		= "DR"
		ls_accrevside	= "CR"
	end if

		 //hare_code เพื่อแยกประเภทหุ้นของสมาชิกปกติ กับ สมทบ by Mike 04/09/2013
	if(left(ls_memgroup,1) = 'S' ) and ls_itemtype = 'SHR' then
		ls_accid = string( of_getattribmapaccid( as_coopid, "LON", "SHR" , "S1", 1, "account_id" ) )  
	end if
	
		 //hare_code เพื่อแยกประเภทค่าธรรมเนียมของสมาชิกปกติ กับ สมทบ by Mike 09/03/2017
	if(left(ls_memgroup,1) = 'S' ) and ls_itemtype = 'FFE' then
		ls_accid = string( of_getattribmapaccid( as_coopid, "LON", "FFE" , "S1", 1, "account_id" ) )  
	end if
		
		// เงินต้น
		if ( ldc_prinpay > 0 ) then				
			this.of_additemdesc( as_coopid ,is_vcrcvtrndocno , "LON" , "TRN", ls_accid, ls_accside , ldc_prinpay, ls_desc, ll_sortacc, ids_vcrcvpaydet  )
		end if
		
		// ดอกเบี้ย	
		if ( ldc_intpay > 0 ) then
			this.of_additemdesc( as_coopid ,is_vcrcvtrndocno, "LON"  , "TRN", ls_accintid, ls_accside, ldc_intpay, ls_desc ,ll_sortint, ids_vcrcvpaydet )
		end if
		//รายการชำระหักอื่น ๆ
		if ( ldc_itempay > 0 and  ldc_prinpay = 0 and ldc_intpay = 0 and ldc_intarrear = 0) then
			this.of_additemdesc( as_coopid , is_vcrcvtrndocno, "LON" , "TRN", ls_accid, ls_accside, ldc_itempay, ls_desc ,ll_sortint, ids_vcrcvpaydet )
		end if
			//รายการ ด/บ คืน
		if ( ldc_intarrear> 0) then
			this.of_additemdesc( as_coopid , is_vcrcvtrndocno, "LON" , "TRN", ls_accintarrid, ls_accside, ldc_intarrear, ls_desc ,ll_sortintarr, ids_vcrcvpaydet  )
		end if
		
		// รายการฝั่งตรงข้าม
		if	( ldc_itempay > 0  ) then
			this.of_additemdesc( as_coopid ,is_vcrcvtrndocno , "LON" , "TRN", ls_tofromaccid , ls_accrevside, ldc_itempay , ls_desc , 1, ids_vcrcvpaydet  )
		end if
		

	
	// Update สถานะการผ่าน Voucher
	if	ls_slipno	<> ls_slipno_bf		then
		update		slslippayin
		set				posttovc_flag		= 1,	
						voucher_no			= :is_vcrcvtrndocno
		where		( payinslip_no		= :ls_slipno ) and
						( memcoop_id		= :as_coopid  )
		using     itr_sqlca   ;							
	end if			

	ls_accintid_bf	= ls_accintid
	ls_slipno_bf		= ls_slipno	
	li_group_bf = li_group
next

destroy( lds_slipdata )

if ids_vcrcvpay.update() <> 1 then
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

return 1
end function

private function integer of_vccashlnrcv_shr (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
 Version 2.0
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการชำระ เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
	Version 2.0 (Initial version) Modified Date 19/02/2015 by Sakuraii
</usage> 
***********************************************************/

string		ls_slipno, ls_accid, ls_accintid, ls_accintarrid, ls_slipno_bf, ls_voucher_type
string		ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp, ls_desc
string		ls_shrlontype, ls_itemtype, ls_tofromaccid
integer	li_shrlonstatus, li_slipflag
long		ll_index, ll_count, ll_sortacc, ll_sortint
dec{2}	ldc_prinpay, ldc_intpay, ldc_itempay, ldc_intarrpay, ldc_int
string		ls_coopcontrol , ls_coopid
string		as_vcdocno , ls_loangroup, ls_memgroup

datastore	lds_slipdata ,lds_countitem

// ds สำหรับเก็บการชำระหนี้
lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cashlnrcv_shr"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate, as_coopid  )

// ds สำหรับทำสำเนาเพื่อ หาเลขที่ใบเสร็จ
lds_countitem	= lds_slipdata

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if
	
ls_tmpsystem	= "LON" 
ls_tmpvcgrp		= "PAY"

//สร้างเลขที่ Voucher
 if  is_vcrcvdocno = ""    then
		ls_voucher_type	= "RV"
		ls_desc  				= "เงินสดรับประจำวัน"		
		is_vcrcvdocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvdocno , as_coopid  )
		this.of_addvoucher( is_vcrcvdocno , adtm_vcdate , ls_voucher_type ,  ls_desc, 0 , ids_vcrcv , 'CSH'  , as_coopid  , as_userid )		
	else
		ids_vcrcv.retrieve( is_vcrcvdocno )
		ids_vcrcvdet.retrieve( is_vcrcvdocno )
 end if 	

// ชุดการรับชำระหนี้
for ll_index = 1 to ll_count

	ls_coopid			= lds_slipdata.object.coop_id[ ll_index ]
	ls_slipno			= lds_slipdata.object.payinslip_no[ ll_index ]
	ls_shrlontype		= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_itemtype			= lds_slipdata.object.slipitemtype_code[ ll_index ]
	ls_tofromaccid		= lds_slipdata.object.tofrom_accid[ ll_index ]
	li_shrlonstatus		= lds_slipdata.object.bfcontlaw_status[ ll_index ]
	li_slipflag			= lds_slipdata.object.sliptypesign_flag[ ll_index ]
	ldc_itempay			= lds_slipdata.object.item_payamt[ ll_index ]
	ldc_prinpay			= lds_slipdata.object.principal_payamt[ ll_index ]
	ldc_int				= lds_slipdata.object.interest_payamt[ ll_index ]
	ldc_intarrpay		= lds_slipdata.object.intarrear_payamt[ ll_index ]
	ls_memgroup			= lds_slipdata.object.membgroup_code[ ll_index ]
							
		
	if isnull( ldc_intpay ) then ldc_intpay = 0
	if isnull( ldc_prinpay ) then ldc_prinpay = 0
	if isnull( ldc_intarrpay ) then ldc_intarrpay = 0
	if isnull( li_shrlonstatus) then li_shrlonstatus = 1
	if isnull( ls_shrlontype) or ls_shrlontype = ""  then ls_shrlontype = "00"
	
	if(ls_itemtype = 'SHR') then li_shrlonstatus = 1
	if(ls_itemtype = 'FEE') then ls_itemtype = 'FFE'
	if ( ldc_intarrpay > 0 ) then
		ldc_intpay	= ldc_intpay - ldc_intarrpay
	end if
		
	ls_accid		= string	( of_getattribmapaccid(as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "account_id" ) )
	ls_accintid		= string	( of_getattribmapaccid(as_coopid, "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "accint_id" ) )
	ls_accintarrid	= string	( of_getattribmapaccid( as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "accintarr_id"  ) )
	ll_sortacc		= long	( of_getattribmapaccid( as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortacc_order"   ) )
	ll_sortint		= long	( of_getattribmapaccid( as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortint_order"  ) )

		
	if ( li_slipflag > 0 ) then
		ls_accside		= "CR"
		ls_accrevside	= "DR"
	else
		ls_accside		= "DR"
		ls_accrevside	= "CR"
	end if
	
	if  isnull (ls_tofromaccid ) or ls_tofromaccid <>  is_acccash then
		ls_tofromaccid		= 	is_acccash
	end if
	
				// hare_code เพื่อแยกประเภทหุ้นของสมาชิกปกติ กับ สมทบ by Mike 04/09/2013
	if(left(ls_memgroup,1) = 'S' ) and ls_itemtype = 'SHR' then
		ls_accid = string( of_getattribmapaccid( as_coopid, "LON", "SHR" , "S1", 1, "account_id" ) )  
	end if
	
			 //hare_code เพื่อแยกประเภทค่าธรรมเนียมของสมาชิกปกติ กับ สมทบ by Mike 09/03/2017
	if(left(ls_memgroup,1) = 'S' ) and ls_itemtype = 'FFE' then
		ls_accid = string( of_getattribmapaccid( as_coopid, "LON", "FFE" , "S1", 1, "account_id" ) )  
	end if

	
// เงินต้น
		if ( ldc_prinpay > 0 ) then				
			this.of_additemdesc( as_coopid ,is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_prinpay, "เงินสดรับประจำวัน", ll_sortacc, ids_vcrcvdet)
			this.of_additemdesc( as_coopid , is_vcrcvdocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_prinpay , "เงินสดรับประจำวัน", 1, ids_vcrcvdet )
		end if
		
		// ดอกเบี้ย	
		if ( ldc_int > 0 ) then
			this.of_additemdesc( as_coopid ,is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accintid, ls_accside, ldc_int, "เงินสดรับประจำวัน", ll_sortacc, ids_vcrcvdet)
			this.of_additemdesc( as_coopid , is_vcrcvdocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_int  ,"เงินสดรับประจำวัน",  1, ids_vcrcvdet )
		end if
		
		// ดอกเบี้ยค้าง
		if ( ldc_intarrpay > 0 ) then
			this.of_additemdesc( as_coopid ,is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accintarrid, ls_accside, ldc_intarrpay, "เงินสดรับประจำวัน", ll_sortacc, ids_vcrcvdet)
			this.of_additemdesc( as_coopid , is_vcrcvdocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_intarrpay  ,"เงินสดรับประจำวัน", 1, ids_vcrcvdet )
		end if	
		
				//รายการชำระหักอื่น ๆ
		if ( ldc_itempay > 0 and  ldc_prinpay = 0 and ldc_int = 0 and ldc_intarrpay = 0 ) then
			this.of_additemdesc( as_coopid , is_vcrcvdocno, ls_tmpsystem , ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay ,"เงินสดรับประจำวัน", ll_sortacc, ids_vcrcvdet)
			this.of_additemdesc( as_coopid , is_vcrcvdocno , "CSH" , "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay  ,"เงินสดรับประจำวัน", 1, ids_vcrcvdet )
		end if
		
	// Update สถานะการผ่าน Voucher
	if	ls_slipno	<> ls_slipno_bf		then
		update		slslippayin
		set				posttovc_flag		= 1,	
						voucher_no			= :is_vcrcvdocno
		where		payinslip_no			= :ls_slipno   and 
						memcoop_id			= :as_coopid and
						coop_id				= :ls_coopid
		using    		 itr_sqlca   ;							
	end if				
		
	ls_slipno_bf		= ls_slipno	
				
next

destroy (lds_slipdata)

//update
if ids_vcrcv.update() <> 1 then
	return -1
end if
	
if ids_vcrcvdet.update() <> 1 then
	return -1
end if


if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if


return 1
end function

private function integer of_vctrndppay_rcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception;/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> ถอน + ปิดบัญชี รายการโอน
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/
string			ls_slipno, ls_accid, ls_accintarrid, ls_mapacc, ls_colname, ls_colsort, ls_coopid, ls_date,ls_feeid
string			ls_accside, ls_accrevside, ls_vcdocno, ls_tmpsystem, ls_tmpvcgrp , ls_deptgroup , ls_deptgroup_bf
string			ls_moneygrp, ls_depttype, ls_itemtype, ls_tofromaccid, ls_docno, ls_tofromaccid3 ,ls_group_itemtpe
string			s_acccr_id,ls_accdr_id,ls_branchid,ls_branchorigin,ls_desc,ls_oldbranchid,ls_cash
integer			li_slipflag,ll_find,li_flag, li_dueflag, li_dueflag_bf, li_accflag, li_deptgroup_code_bf, li_deptgroup_code, li_paymeth
long			ll_index, ll_count, ll_sortacc, ll_sortintarr, ll_index2
dec{2}			ldc_itempay, ldc_intarrpay,ldc_prncbal,ldc_int_amt,ldc_accuint_amt, ldc_intreturn, ldc_slipnetamt, ldc_pay
string			ls_deptgroupcode, ls_itemgroup, ls_accid_bf, ls_depttype_code, ls_vc_desc, ls_itemdesc  
string			ls_depttype_group, ls_refsystem,  ls_voucher_type , ls_vc_type , ls_dept_refer
dec{2}			ldc_other_amt, ldc_intbfyear , ldc_itempaynet, ldc_tax_return, ldc_tax, ldc_checkint,ldc_orther, ldc_int_ref
string			ls_accid_old, ls_acccash, ls_depttype_bf, ls_itemtype_bf, ls_accint, ls_acctax, ls_refer_cashtype, ls_tofromaccid2

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	="d_vc_slip_data_trndppay_rcv_ry"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpsystem				= "DEP"
ls_tmpvcgrp					= "DAY"
ls_accid_bf 				= ""
ll_index2					=	1
li_dueflag_bf				= 2

for ll_index = 1 to ll_count

	ls_slipno				= lds_slipdata.object.deptslip_no[ ll_index ]
	ls_itemtype				= lds_slipdata.object.recppaytype_code[ ll_index ]
	ls_moneygrp				= lds_slipdata.object.moneytype_group[ ll_index ]
	ls_depttype				= lds_slipdata.object.depttype_code[ ll_index ]
	ls_tofromaccid			= lds_slipdata.object.tofrom_accid[ ll_index ]
	ls_mapacc				= lds_slipdata.object.accmap_code[ ll_index ]
	ldc_itempay				= lds_slipdata.object.deptslip_amt[ ll_index ]
	ldc_int_amt				= lds_slipdata.object.int_amt[ ll_index ]	
	ldc_accuint_amt			= lds_slipdata.object.accuint_amt[ ll_index ]
	ldc_intreturn			= lds_slipdata.object.int_return[ ll_index ]
	ls_deptgroupcode		= lds_slipdata.object.deptgroup_code[ ll_index ]
	ls_itemgroup			= lds_slipdata.object.group_itemtpe[ ll_index ]
	ldc_itempaynet			= lds_slipdata.object.deptslip_netamt[ ll_index ]
	ldc_other_amt			= lds_slipdata.object.other_amt[ ll_index ] ; 
	ldc_intbfyear			= lds_slipdata.object.int_bfyear[ ll_index ]
	ls_desc					= trim(lds_slipdata.object.compute_3[ ll_index ])
	ldc_tax_return			= lds_slipdata.object.tax_return[ ll_index ]
	ldc_tax					= lds_slipdata.object.tax2[ ll_index ]	
	ls_refer_cashtype		= lds_slipdata.object.refer_cashtype[ ll_index ]	
	ls_tofromaccid2			= lds_slipdata.object.tofrom_accid2[ ll_index ]
	li_accflag				= lds_slipdata.object.accnature_flag[ ll_index ]
	li_deptgroup_code		= lds_slipdata.object.group_flag[ ll_index ]
	ldc_checkint			= lds_slipdata.object.deptslip_amt[ ll_index ]
	ldc_orther				=  lds_slipdata.object.other_amt[ ll_index ]  //ค่าปรับเงินฝาก
	ls_group_itemtpe		= lds_slipdata.object.group_itemtpe[ ll_index ]	
	li_dueflag				= lds_slipdata.object.due_flag[ ll_index ]	
	ls_coopid				= lds_slipdata.object.coop_id[ ll_index ]	
	ls_tofromaccid3			= lds_slipdata.object.tofrom_accid3[ ll_index ]
	li_paymeth				= lds_slipdata.object.payfee_meth[ ll_index ] //วิธีการปรับ 1.ปรับเงินสด 2.ปรับจากยอดถอน 3.ปรับจากในบัญชี

	if isnull (ls_tofromaccid3) or ls_tofromaccid3 = ""  then ls_tofromaccid3 = ls_tofromaccid
	if isnull (ls_tofromaccid2) or ls_tofromaccid2 = ""  then ls_tofromaccid2 = ls_tofromaccid
	if isnull( ldc_other_amt ) then ldc_other_amt = 0
	if isnull( li_paymeth ) then li_paymeth = 0
	if IsNull( ldc_int_ref ) then ldc_int_ref = 0
	if isnull( ldc_tax ) then ldc_tax = 0
	if isnull( ldc_int_amt ) then ldc_int_amt = 0
	if isnull( ldc_accuint_amt ) then ldc_accuint_amt = 0
	if isnull( ldc_intreturn ) then ldc_intreturn = 0
	if isnull(ldc_intbfyear) then ldc_intbfyear = 0
	if isnull(ldc_checkint) then ldc_checkint = 0
	if isnull(ls_refer_cashtype) then ls_refer_cashtype = ""
	if isnull(li_dueflag) then li_dueflag = 0
	if ls_itemtype = 'WTI' then ldc_int_amt = 0      // ในแถว WTI มี int_amt จากเดิมใช้จาก INY ทำให้ดึงดอกเบี้ยจ่ายเกินมา เขียนไว้เพื่อตียอด int_amt จาก WTI เป็น 0
	if ls_itemtype = 'DTR' then ldc_int_amt = 0  //ดึงรายการ DTR จากการถอนดอกเบี้ยครบกำหนดบัญชี A มาฝากที่บัญชี B  แต่ใน DTR ฟิว int_amt มียอดทำให้ดึงเบิ้ล
	if ls_itemtype = 'WTR' then   // ในแถว WTR มี int_amt จากเดิมใช้จาก INT ทำให้ดึงดอกเบี้ยจ่ายเกินมา เขียนไว้เพื่อตียอด int_amt จาก WTR เป็น 0
	
		//หาคู่บัญชีว่าถอนไปฝากที่รหัสอะไร
		select depttype_code 
		into :ls_dept_refer
		from dpdeptslip  
		where refer_slipno = :ls_slipno and 
		recppaytype_code in ('DTR','OTR')
		using itr_sqlca;
		
		ls_tofromaccid2		= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_dept_refer, 1, "account_id"  ) )
		if isnull (ls_tofromaccid2) or ls_tofromaccid2 = ""  then ls_tofromaccid2 = ls_tofromaccid
		
		ldc_itempay = ldc_itempaynet
		ldc_int_amt = 0 
	end if
////////////////////////////////////////////////////////////////////////		  
	choose case ls_group_itemtpe
	case 'CLS','WID'    //ดึงยอดจาก ใบ INT แล้ว
		ldc_itempay = ldc_itempaynet
		ldc_intbfyear = 0
		ldc_int_amt = 0
		ldc_intreturn = 0
		ldc_tax = 0
		ldc_tax_return = 0
	end	choose
////////////////////////////////////////////////////////////////////////////	
	if ls_itemtype = 'CTR' then
				
		select depttype_code 
		into :ls_dept_refer
		from dpdeptslip  
		where refer_slipno = :ls_slipno and 
		recppaytype_code in ('OTR','DTR')
		using itr_sqlca;
		
		ls_tofromaccid2		= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_dept_refer, 1, "account_id"  ) )
		if isnull (ls_tofromaccid2) or ls_tofromaccid2 = ""  then ls_tofromaccid2 = ls_tofromaccid
	end if
	////////////สร้าง Voucher////////////////////////
	 if  li_deptgroup_code_bf <> li_deptgroup_code    then
			ls_voucher_type	= "JV"	
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			if(li_deptgroup_code = 1) then
				ls_desc  				= "รายการฝากถอนเงินกลุ่มประจำ (รายการโอน)"		
				else
				ls_desc  				= "รายการฝากถอนเงินกลุ่มออมทรัพย์ (รายการโอน)"		
			end if
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
	else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if
		
	choose case ls_mapacc
		case "AIT"
			ls_accintarrid	= string( of_getattribmapaccid( as_coopid, "DEP", "DEP", ls_depttype, 1, "accintarr_id"  ) )
			ll_sortintarr		= long( of_getattribmapaccid( as_coopid , "DEP", "DEP", ls_depttype, 1, "sortintarr_order" ) )
			ldc_itempay		= ldc_itempay 
			ls_colname		= "accint_id"
			ls_colsort		= "sortint_order"
		case "ATX"
			ls_colname		= "acctax_id"
			ls_colsort		= "sorttax_order"
			ldc_intbfyear	= 0.00
		case else
			ls_colname		= "account_id"
			ls_colsort		= "sortacc_order"
			ldc_intbfyear	= 0.00
	end choose
	
	ls_accid				= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, ls_colname  ) )
	ls_accint				= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, "accint_id"  ) )
	ls_accintarrid		= string( of_getattribmapaccid( as_coopid, "DEP", "DEP", ls_depttype, 1, "accintarr_id"  ) )
	ls_acctax				= string( of_getattribmapaccid( as_coopid, "DEP", "DEP", ls_depttype, 1, "acctax_id"  ) )
	ll_sortacc			= long( of_getattribmapaccid( as_coopid , "DEP", "DEP", ls_depttype, 1, ls_colsort  ) )		
	ls_feeid				= string( of_getattribmapaccid( as_coopid ,"DEP", "FEE", "00", 1,  "account_id"  ) ) //ค่าปรับ
	
	if(li_accflag = 1) then
		ls_accside		= "CR"
		ls_accrevside	= "DR"	
	else
		ls_accside		= "DR"
		ls_accrevside	= "CR"
	end if
	
	if ls_itemtype = 'INY'  then
		ls_accside			= "DR"
		ls_accrevside		= "CR"
		ls_tofromaccid2 	= ls_tofromaccid
		//ls_tofromaccid2 	= ls_tofromaccid3
		ldc_int_amt  		= ldc_int_amt - ldc_intbfyear
		ldc_itempaynet		= 0.00
		ldc_itempay			= ( ldc_itempay - ldc_tax ) * -1  //ทำเพื่อลบค่าออกจากยอดเต็มของฝาก ถอน
		ls_accid			= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, "account_id"  ) )
	end if
	
	if ls_itemtype = 'INT' then
		ls_accside			= "DR"
		ls_accrevside		= "CR"
		ls_tofromaccid2 	= ls_tofromaccid
		//ls_tofromaccid2 	= ls_tofromaccid3
		ldc_itempay  		= ldc_itempay - ldc_intbfyear
		if( ldc_itempay < 0 ) then ldc_itempay = 0.00   //กรณียอด ดบ.ตั้งค้าง > ดบ.จ่าย  ลงแต่ยอด ดบ.ตั้งค้าง  แล้ว cr ดอกเบี้ยเงินฝากประจำค้างจ่ายรับคืน 
		ldc_int_amt 			= 0.00
	end if
	
	choose case ls_itemtype
		case "FEE"
			ls_accid = string( of_getattribmapaccid( as_coopid ,"DEP", "FEE", "00", 1, "account_id"  ) )
			ls_accside		= "CR"
			ls_accrevside	= "DR"	
		case "WFS"
			ls_accid =  string( of_getattribmapaccid( as_coopid ,"DEP", "WFS", "00", 1, "account_id"  ) )
			ls_accside		= "CR"
			ls_accrevside	= "DR"
		case else
			ls_accid = ls_accid
	end choose
	
	//กรณีค่าปรับเงินสด ไม่ต้องลงข้อมูลที่รายการโอน
	if li_paymeth = 0 then ldc_orther = 0
	
		//ดอกเบี้ยหลังหักภาษี
		ldc_pay = ldc_int_amt - ldc_tax
		
	//case INR ที่ปิดด้วยเงินสด แต่ INR ลงรายการโอน ต้องนำมาลงที่รายการโอน Edit By Mike 15/10/2014
	//case INR ที่ปิดด้วยรายการโอน ไม่ต้องนำ INR มาลง เอายอดจาก int_return จากใบถอนมาลงรายการ
	
	//ทำกั้นไว้กรณีปิดเป็นเงินสด แล้วรายการ INR จะส่งคู่บัญชี ( tofrom_accid ) มาเป็นเงินสด ต้องส่งมาเป็นรหัสดอกเบี้ยจ่าย
	if( ls_itemtype = 'INR' and ls_refer_cashtype = 'CSH') then
		ls_tofromaccid2 = string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, "accint_id"  ) )
	end if
	
	if( ls_itemtype = 'INR' and ls_refer_cashtype <> 'CSH') then
		ls_tofromaccid2 = string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, "accint_id"  ) )
		ls_accid		= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, "account_id"  ) )
	end if
	
	//รายการถอน
	if ( ldc_itempay > 0 ) or ( ldc_itempay < 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, ls_desc, ll_sortacc, ids_vcrcvpaydet )
	end if
	if (ldc_int_amt > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accint, ls_accside, ldc_int_amt , ls_desc, ll_sortacc, ids_vcrcvpaydet )
	end if
	if (ldc_tax_return > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_acctax, ls_accside, ldc_tax_return, ls_desc, ll_sortacc, ids_vcrcvpaydet )
	end if
	//	//ดอกเบี้ยค้างรับค้างจ่าย
	if (ldc_intbfyear > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accintarrid, ls_accside, ldc_intbfyear, ls_desc, ll_sortacc, ids_vcrcvpaydet )
	end if
	//เพิ่มเติม ยิงข้อมูลเข้าแทนรายการ INR 03/10/2014 Edit By Mike
	if (ldc_intreturn > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_intreturn, ls_desc, ll_sortacc, ids_vcrcvpaydet )
	end if
	
	
	
	// รายการฝั่งตรงข้าม
	if 	( ldc_itempaynet > 0 ) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno,ls_tmpsystem, ls_tmpvcgrp, ls_tofromaccid2 , ls_accrevside, ldc_itempaynet - ldc_tax , ls_desc , 1, ids_vcrcvpaydet )
	end if
	if 	( ldc_intreturn > 0 ) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno,ls_tmpsystem, ls_tmpvcgrp, ls_accint , ls_accrevside, ldc_intreturn ,ls_desc , 1, ids_vcrcvpaydet  )
	end if
	if 	( ldc_tax > 0 ) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno,ls_tmpsystem, ls_tmpvcgrp, ls_acctax , ls_accrevside, ldc_tax ,ls_desc , 1, ids_vcrcvpaydet  )
	end if
	//กรณี ดบ.ตั้งค้าง มากกว่า ดบ.จ่าย ลงรายการ ดบ.เงินฝากประจำค้างจ่ายรับคืน 
	if( ldc_intbfyear > ldc_checkint) then 
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno,ls_tmpsystem, ls_tmpvcgrp, ls_accint , ls_accrevside, ldc_intbfyear - ldc_checkint ,ls_desc , 1, ids_vcrcvpaydet  )
	end if
		if( ldc_orther > 0 ) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp,ls_feeid , ls_accrevside, ldc_orther,ls_desc  , 1, ids_vcrcvpaydet  )
	end if

	
	
	
	
	// Update สถานะการผ่าน Voucher
	if	not isnull(is_vcrcvtrndocno)    	then
		update	dpdeptslip
		set			posttovc_flag	= 1,	
					voucher_no		= :is_vcrcvtrndocno
		where	( deptslip_no		= :ls_slipno ) and
				( deptcoop_id 		= :as_coopid) and
				( coop_id 			= :ls_coopid)
		using itr_sqlca;
	end if
	
	ls_accid_bf 			= ls_accid
	ls_depttype_bf			= ls_depttype
	ls_itemtype_bf			= ls_itemtype
	li_deptgroup_code_bf	= li_deptgroup_code
	li_dueflag_bf			= li_dueflag
		
next

destroy (lds_slipdata)
// update Vc
if ids_vcrcvpay.update() <> 1 then
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

return 1
end function

public function integer of_gen_vc_close_year (integer ai_year, integer ai_period, string as_coopid) throws Exception; /***********************************************************
<description>
	ประมวลผลสร้าง Voucher ปิดสิ้นปี
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 10/02/2015 by Sakuraii
</usage> 
***********************************************************/
string		ls_av_no, ls_vcno, ls_accid, ls_voucher_type, ls_benifit_total_acc
string		ls_accside, ls_accrevside
integer		li_vcno
long		ll_index, ll_count
datetime	adtm_date_end, ldtm_start_endperiod
dec{2}		ldc_forward_dr, ldc_forward_cr , ldc_pl_sumall

datastore	lds_slipdata, lds_slipdata2

// ds สำหรับดึงข้อมูลรายการโอนปิดบัญชี
lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_gen_close_year"
lds_slipdata.settransobject( itr_sqlca )

ll_count			= lds_slipdata.retrieve( ai_year, ai_period  , as_coopid   )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return -1
end if
//หาวันที่สุดท้ายของปีบัญชี
select		ending_of_account
into		:adtm_date_end
from		accaccountyear
where	account_year	= :ai_year and
			coop_id		= :as_coopid using itr_sqlca;

if itr_sqlca.sqlcode <> 0 then
	ithw_exception.text	= "ไม่สามารถตรวจสอบช่วงวันที่ของปีบัญชีได้ " + itr_sqlca.sqlerrtext
	throw ithw_exception
end if

// สร้างเลข Voucher
is_vcrcvtrndocno = ""

//วันเริ่มต้นงวดสุดท้าย
	ldtm_start_endperiod = datetime( date( year( date( adtm_date_end ) ), month( date( adtm_date_end ) ), 1  ) )
	
	//หา voucher_JV ล่าสุดของงวดสุดท้าย
	select substr(max(voucher_no),7,4) , substr(max(voucher_no),1,6)
	into	:ls_av_no, :ls_vcno
	from  	vcvoucher
	where voucher_date between :ldtm_start_endperiod and :adtm_date_end and
			voucher_no	like 'JV%'		and
			coop_id		= :as_coopid	
			using itr_sqlca;
			
	if isnull(ls_av_no) or ls_av_no = "" then ls_av_no = '0000'
	if isnull(ls_vcno) or ls_vcno = "" then ls_vcno = 'JV' + mid(string( ai_year + 543), 3 , 2) + string(ai_period,'00')
	
	li_vcno = integer(ls_av_no) + 1
	
	ls_vcno = ls_vcno + string(li_vcno,'0000')

	//เพิ่มใหม่ ดึง voucher ทั้งหมดจากระบบนั้นๆ แล้วแยกใบ voucher ในท่อนโค๊ดนี้ตามประเภทรายการ
	if ( is_vcrcvtrndocno = "" ) then
		ls_voucher_type	= "JV"
//		is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_date_end , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
		is_vcrcvtrndocno  = ls_vcno
		this.of_addvoucher( is_vcrcvtrndocno , adtm_date_end , ls_voucher_type , "โอนปิดรายได้-ค่าใช้จ่ายเข้ากำไรสุทธิรอจัดสรร", 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , "ACC" )		
	else
		ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
		ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	
////////ยิงรายการที่ไม่มีข้องบประมาณ///////////////////////
for ll_index = 1 to ll_count
		
	ls_accid				= lds_slipdata.object.account_id[ ll_index ]
	ldc_forward_dr		= lds_slipdata.object.forward_dr_amount[ ll_index ]
	ldc_forward_cr		= lds_slipdata.object.forward_cr_amount[ ll_index ]


		ls_accside		= "DR"
		ls_accrevside	= "CR"
		
	// รายการจ่ายเงิน DR
	if ( ldc_forward_dr > 0 ) then
		this.of_additemdesc( as_coopid ,  is_vcrcvtrndocno, "TRN", "TRN", ls_accid  , ls_accrevside, ldc_forward_dr, "", 1, ids_vcrcvpaydet)
	end if
	
	// รายการฝั่งตรงข้าม CR
	if 	( ldc_forward_cr > 0 ) then		
		this.of_additem( as_coopid , is_vcrcvtrndocno ,"TRN", "TRN", ls_accid , ls_accside, ldc_forward_cr  , 1, ids_vcrcvpaydet  , "ACC" )
	end if
			
next

//หายอดกำไรสุทธิ
//ldc_pl_sumall = inv_account_service.of_get_profit_period( ai_year, ai_period  , as_coopid )
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

dec{2}		ldc_fw_dr_rec, ldc_fw_cr_rec, ldc_fw_dr_pay, ldc_fw_cr_pay
dec{2}		 ldc_total_rec, ldc_total_pay

SELECT	sum(accsumledgerperiod.forward_dr_amount),   
			sum(accsumledgerperiod.forward_cr_amount)
INTO		:ldc_fw_dr_rec,   
			:ldc_fw_cr_rec
FROM		accmaster, accsumledgerperiod  
WHERE  	( accsumledgerperiod.account_id		= accmaster.account_id ) and  
			( ( accsumledgerperiod.account_year	= :ai_year ) AND  
			( accsumledgerperiod.period			= :ai_period ) AND  
			( accmaster.account_group_id			= '4' ) )  and
			( accsumledgerperiod.coop_id		= :as_coopid )  
			using itr_sqlca;

if isnull( ldc_fw_dr_rec ) then ldc_fw_dr_rec = 0.00
if isnull( ldc_fw_cr_rec ) then ldc_fw_cr_rec = 0.00

ldc_total_rec	= ldc_fw_cr_rec - ldc_fw_dr_rec

//ค่าใช้จ่าย
SELECT	sum(accsumledgerperiod.forward_dr_amount),   
			sum(accsumledgerperiod.forward_cr_amount)
INTO		:ldc_fw_dr_pay,   
			:ldc_fw_cr_pay
FROM		accmaster,   
			accsumledgerperiod  
WHERE		( accsumledgerperiod.account_id		= accmaster.account_id ) and  
			( ( accsumledgerperiod.account_year	= :ai_year ) AND  
			( accsumledgerperiod.period			= :ai_period ) AND  
			( accmaster.account_group_id			= '5' ) ) and
			( accsumledgerperiod.coop_id		= :as_coopid ) using itr_sqlca;

if isnull( ldc_fw_dr_pay ) then ldc_fw_dr_pay = 0.00
if isnull( ldc_fw_cr_pay ) then ldc_fw_cr_pay = 0.00

ldc_total_pay	= ldc_fw_dr_pay - ldc_fw_cr_pay

// ยอดคงเหลือจริง
ldc_pl_sumall	= ldc_total_rec - ldc_total_pay

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

select benifit_total_acco
into :ls_benifit_total_acc
from accconstant
where coop_id = :as_coopid
using itr_sqlca;

	if(ldc_pl_sumall > 0 ) then 
		this.of_additemdesc( as_coopid ,  is_vcrcvtrndocno, "TRN", "TRN", ls_benifit_total_acc  , ls_accrevside, ldc_pl_sumall, "", 1, ids_vcrcvpaydet)
	end if
	if(ldc_pl_sumall < 0 ) then 
		this.of_additem( as_coopid , is_vcrcvtrndocno ,"TRN", "TRN", ls_benifit_total_acc , ls_accside, ldc_pl_sumall  , 1, ids_vcrcvpaydet  , "ACC" )
	end if
	

destroy( lds_slipdata )
destroy( lds_slipdata2 )
//update
if ids_vcrcvpay.update() <> 1 then
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

//update ให้ผ่านรายการไปแยกประเภทเลย
update vcvoucher
set posttoacc_flag = 1
where voucher_no = :is_vcrcvtrndocno
using itr_sqlca;


return 1
end function

private function integer of_vccashfinrcv_tax (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
 Version 2.0
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการรับการเงิน เงินสด  ภาษี
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
	Version 2.0 (Initial version) Modified Date 19/02/2015 by Sakuraii
</usage> 
***********************************************************/
string		ls_slipno, ls_slipprior, ls_accid, ls_tofromaccid, ls_slipitem_desc
string		ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp, ls_desc, ls_voucher_type
long		ll_index, ll_count
dec{2}	ldc_itempay

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cashfnrcv_tax"
lds_slipdata.settransobject( itr_sqlca )

// reset เงินสดรับ
ll_count	= lds_slipdata.retrieve( adtm_vcdate,as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if


ls_tmpsystem		= "FIN"
ls_tmpvcgrp			= "DAY"


// สร้างเลข Voucher

	 if  is_vcrcvdocno    =  ""  then
			ls_voucher_type	= "RV"
			ls_desc  				= "เงินสดรับประจำวัน"		
			is_vcrcvdocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvdocno , as_coopid  )
			this.of_addvoucher( is_vcrcvdocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcv , 'CSH'  , as_coopid  , as_userid )		
		else
			ids_vcrcv.retrieve( is_vcrcvdocno )
			ids_vcrcvdet.retrieve( is_vcrcvdocno )
	 end if 	

//ทำรายการ Voucher
for ll_index = 1 to ll_count
	ls_slipno					= trim( lds_slipdata.object.slip_no[ ll_index ] )
	ldc_itempay				= lds_slipdata.object.tax_amt[ ll_index ]	
	ls_slipitem_desc		= trim( lds_slipdata.object.slipitem_desc[ ll_index ] )
	ls_tofromaccid			= trim( lds_slipdata.object.tofrom_accid[ ll_index ] )

	
	ls_accside			= "CR"
	ls_accrevside		= "DR"
	
	ls_accid				= string( of_getattribmapaccid( as_coopid ,"FIN", "TAX", "01", 1, "account_id"  ) )
	
		if  isnull (ls_tofromaccid ) or ls_tofromaccid <>  is_acccash then
		ls_tofromaccid		= 	is_acccash
	end if
	
		// รายการการเงิน
	if ( ldc_itempay > 0 ) then		
		this.of_additemdesc( as_coopid , is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, ls_slipitem_desc, 0, ids_vcrcvdet)
		this.of_additemdesc( as_coopid ,is_vcrcvdocno, "CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay, "เงินสดรับประจำวัน", 1, ids_vcrcvdet)
	end if

	// Update สถานะการผ่าน Voucher
//		update	finslipdet
//		set			posttovc_flag	= 1,	
//					voucher_no		= :is_vcrcvdocno
//		where	( slip_no			= :ls_slipno )  and
//					( coop_id 		= :as_coopid)
//		using     itr_sqlca   ;	
next

//update
if ids_vcrcv.update() <> 1 then	
	return -1
end if
	
if ids_vcrcvdet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

destroy (lds_slipdata)
return 1
end function

private function integer of_set_voucher_no (datetime adtm_date, string as_coopid, string as_type) throws Exception;integer		li_pvno, li_rvno, li_jvno, li_year, li_period, li_avno, li_tvno
string		ls_pvno, ls_rvno, ls_jvno, ls_avno, ls_tvno
datetime	ldtm_endperiod, ldtm_start_endperiod, ldtm_start_year

	select min(period_end_date)
	into	:ldtm_endperiod
	from	accperiod
	where	period_end_date >= :adtm_date and 
				coop_id		  = :as_coopid	
	using itr_sqlca;
	
	if IsNull(ldtm_endperiod) then 
		ldtm_start_endperiod	= datetime( date( year( date( adtm_date ) ) , month( date( adtm_date ) ), 1  ) )
		ldtm_endperiod			= datetime( date( year( date( adtm_date ) )  , month( date( adtm_date ) ), 30 ) )
	else
	
	//วันเริ่มต้นงวด
	if (as_type = '01') then  //ขึ้นเลขใหม่ทุกสิ้นเดือน
		ldtm_start_endperiod	= datetime( date( year( date( ldtm_endperiod ) ) , month( date( ldtm_endperiod ) ), 1  ) )
	else
		//หาวันที่เริ่มต้นปีบัญชี
		select beginning_of_accu
		into	:ldtm_start_year
		from accconstant
		where coop_id = :as_coopid
		using itr_sqlca;
		
		ldtm_start_endperiod	= datetime( date( year( date( ldtm_start_year ) ) , month( date( ldtm_start_year ) ), 1  ) )
	end if
	ldtm_endperiod			= datetime( date( year( date( ldtm_endperiod ) )  , month( date( ldtm_endperiod ) ),  day( date( ldtm_endperiod ) ) ) )
	end if
		
		
	//////////หาเลขที่เอกสารของปีเก่า//////////////////
	select substr(max(voucher_no),7,4)
	into	:ls_pvno
	from	vcvoucher
	where voucher_date between :ldtm_start_endperiod and :ldtm_endperiod   and
			voucher_no	like 'PV%'		and
			coop_id			= :as_coopid	
	using itr_sqlca;
	
	select substr(max(voucher_no),7,4)
	into	:ls_rvno
	from	vcvoucher
	where voucher_date between :ldtm_start_endperiod and :ldtm_endperiod   and
			voucher_no	like 'RV%'		and
			coop_id			= :as_coopid	
	using itr_sqlca;
	
	select substr(max(voucher_no),7,4)
	into	:ls_jvno
	from	vcvoucher
	where voucher_date between :ldtm_start_endperiod and :ldtm_endperiod   and
			voucher_no	like 'JV%'		and
			coop_id			= :as_coopid	
	using itr_sqlca;
	
	select substr(max(voucher_no),7,4)
	into	:ls_avno
	from	vcvoucher
	where voucher_date between :ldtm_start_endperiod and :ldtm_endperiod   and
			voucher_no	like 'AV%'		and
			coop_id			= :as_coopid	
	using itr_sqlca;
	
	select substr(max(voucher_no),7,4)
	into	:ls_tvno
	from	vcvoucher
	where voucher_date between :ldtm_start_endperiod and :ldtm_endperiod   and
			voucher_no	like 'TV%'		and
			coop_id			= :as_coopid	
	using itr_sqlca;
	

	
	if isnull(ls_pvno) or ls_pvno = "" then ls_pvno = '0'
	if isnull(ls_rvno) or ls_rvno = "" then ls_rvno = '0'
	if isnull(ls_jvno) or ls_jvno = "" then ls_jvno = '0'
	if isnull(ls_avno) or ls_avno = "" then ls_avno = '0'
	if isnull(ls_tvno) or ls_tvno = "" then ls_tvno = '0'

	
	li_pvno	= integer(ls_pvno)
	li_rvno	= integer(ls_rvno)
	li_jvno	= integer(ls_jvno)
	li_avno	= integer(ls_avno)
	li_tvno	= integer(ls_tvno)
	
	
	//update เลขที่เอกสาร Voucher
update 	cmdocumentcontrol
set			last_documentno	= :li_pvno
where 	( document_code = 'CMVOUCHERNO_PV' ) and
			( coop_id			= :as_coopid	  )
using itr_sqlca;

update 	cmdocumentcontrol
set			last_documentno	= :li_rvno
where 	( document_code = 'CMVOUCHERNO_RV' ) and
			( coop_id				= :as_coopid	  )
using itr_sqlca;

update 	cmdocumentcontrol
set			last_documentno	= :li_jvno
where 	( document_code = 'CMVOUCHERNO_JV' ) and
			( coop_id			= :as_coopid	 )
using itr_sqlca;

update 	cmdocumentcontrol
set			last_documentno	= :li_avno
where 	( document_code = 'CMVOUCHERNO_AV' ) and
			( coop_id			= :as_coopid	 )
using itr_sqlca;

update 	cmdocumentcontrol
set			last_documentno	= :li_tvno
where 	( document_code = 'CMVOUCHERNO_TV' ) and
			( coop_id			= :as_coopid	 )
using itr_sqlca;


if itr_sqlca.sqlcode <> 0 then
	ithw_exception.text	= "ไม่สามารถอัพเดทเลขที่เอกสาร Voucher ได้  " + itr_sqlca.sqlerrtext
	rollback using itr_sqlca ;
	throw ithw_exception
end if

return 1
	
	/////////////////////////////////////////////////////////////////////////////////////
end function

private function integer of_vctrndppay_rcv_due (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception;/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> ถอน + ปิดบัญชี รายการโอน
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/
string			ls_slipno, ls_accid, ls_accintarrid, ls_mapacc, ls_colname, ls_colsort, ls_feeid
string			ls_accside, ls_accrevside, ls_vcdocno, ls_tmpsystem, ls_tmpvcgrp , ls_deptgroup , ls_deptgroup_bf
string			ls_moneygrp, ls_depttype, ls_itemtype, ls_tofromaccid, ls_docno, ls_year,ls_group_itemtpe
string			ls_desc
integer			li_slipflag,ll_find,li_flag, li_dueflag, li_dueflag_bf, li_accflag, li_deptgroup_code_bf, li_deptgroup_code
long			ll_index, ll_count, ll_sortacc, ll_sortintarr, ll_index2
dec{2}			ldc_itempay, ldc_intarrpay,ldc_prncbal,ldc_int_amt,ldc_accuint_amt, ldc_intreturn, ldc_slipnetamt, ldc_pay
string			ls_deptgroupcode, ls_itemgroup, ls_accid_bf, ls_depttype_code, ls_vc_desc, ls_itemdesc  
string			ls_depttype_group, ls_refsystem,  ls_voucher_type , ls_vc_type , ls_coopid
dec{2}			ldc_other_amt, ldc_intbfyear , ldc_itempaynet, ldc_tax_return, ldc_tax, ldc_checkint,ldc_orther, ldc_tax_wtr
string			ls_accid_old, ls_acccash, ls_depttype_bf, ls_itemtype_bf, ls_accint, ls_acctax, ls_refer_cashtype, ls_tofromaccid2

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	="d_vc_slip_data_trndppay_rcv_due_exat"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpsystem				= "DEP"
ls_tmpvcgrp					= "DAY"
ls_accid_bf 				= ""
ll_index2					=	1
li_dueflag_bf				= 2
is_vcrcvtrndocno			= ""

////////////สร้าง Voucher////////////////////////
	 if  is_vcrcvtrndocno = ""    then
			ls_voucher_type	= "JV"	
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			ls_desc  				= "รายการถอนเงินโอนภายในครบกำหนด"		
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
	else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if

for ll_index = 1 to ll_count

	ls_slipno				= lds_slipdata.object.deptslip_no[ ll_index ]
	ls_itemtype				= lds_slipdata.object.recppaytype_code[ ll_index ]
	ls_moneygrp				= lds_slipdata.object.moneytype_group[ ll_index ]
	ls_depttype				= lds_slipdata.object.depttype_code[ ll_index ]
	ls_tofromaccid			= lds_slipdata.object.tofrom_accid[ ll_index ]
	ls_mapacc				= lds_slipdata.object.accmap_code[ ll_index ]
	ldc_itempay				= lds_slipdata.object.deptslip_amt[ ll_index ]
	ldc_int_amt				= lds_slipdata.object.int_amt[ ll_index ]	
	ldc_accuint_amt			= lds_slipdata.object.accuint_amt[ ll_index ]
	ldc_intreturn			= lds_slipdata.object.int_return[ ll_index ]
	ls_deptgroupcode		= lds_slipdata.object.deptgroup_code[ ll_index ]
	ls_itemgroup			= lds_slipdata.object.group_itemtpe[ ll_index ]
	ldc_itempaynet			= lds_slipdata.object.deptslip_netamt[ ll_index ]
	ldc_other_amt			= lds_slipdata.object.other_amt[ ll_index ] ; 
	ldc_intbfyear			= lds_slipdata.object.int_bfyear[ ll_index ]
	ls_desc					= trim(lds_slipdata.object.compute_3[ ll_index ])
	ldc_tax_return			= lds_slipdata.object.tax_return[ ll_index ]
	ldc_tax					= lds_slipdata.object.tax2[ ll_index ]	
	ls_refer_cashtype		= lds_slipdata.object.refer_cashtype[ ll_index ]	
	ls_tofromaccid2			= lds_slipdata.object.tofrom_accid2[ ll_index ]
	li_accflag				= lds_slipdata.object.accnature_flag[ ll_index ]
	li_deptgroup_code		= lds_slipdata.object.group_flag[ ll_index ]
	ldc_checkint			= lds_slipdata.object.deptslip_amt[ ll_index ]
	ldc_orther				=  lds_slipdata.object.other_amt[ ll_index ]  //ค่าปรับเงินฝาก
	ls_group_itemtpe		= lds_slipdata.object.group_itemtpe[ ll_index ]	
	li_dueflag				= lds_slipdata.object.due_flag[ ll_index ]	
	ldc_tax_wtr				= lds_slipdata.object.tax_amt[ ll_index ]
	ls_coopid				= lds_slipdata.object.coop_id[ ll_index ]	
	
	if isnull (ls_tofromaccid2) or ls_tofromaccid2 = ""  then ls_tofromaccid2 = ls_tofromaccid
	if isnull( ldc_other_amt ) then ldc_other_amt = 0
	if isnull( ldc_tax ) then ldc_tax = 0
	if isnull( ldc_int_amt ) then ldc_int_amt = 0
	if isnull( ldc_tax_wtr ) then ldc_tax_wtr = 0
	if isnull( ldc_intreturn ) then ldc_intreturn = 0
	if isnull(ldc_intbfyear) then ldc_intbfyear = 0
	if isnull(ldc_checkint) then ldc_checkint = 0
	if isnull(ls_refer_cashtype) then ls_refer_cashtype = ""
	if isnull(li_dueflag) then li_dueflag = 0
	if ls_itemtype = 'WTI' then ldc_int_amt = 0      // ในแถว WTI มี int_amt จากเดิมใช้จาก INY ทำให้ดึงดอกเบี้ยจ่ายเกินมา เขียนไว้เพื่อตียอด int_amt จาก WTI เป็น 0
	if ls_itemtype = 'DTR' then ldc_int_amt = 0  //ดึงรายการ DTR จากการถอนดอกเบี้ยครบกำหนดบัญชี A มาฝากที่บัญชี B  แต่ใน DTR ฟิว int_amt มียอดทำให้ดึงเบิ้ล
	if ls_itemtype = 'WTR' then  // ในแถว WTR มี int_amt จากเดิมใช้จาก INT ทำให้ดึงดอกเบี้ยจ่ายเกินมา เขียนไว้เพื่อตียอด int_amt จาก WTR เป็น 0
		
		ldc_itempay	= ( ldc_itempay + ldc_tax_wtr ) - ldc_int_amt   //ลบยอดถอน + ภาษี - ดอกเบี้ย เพราะ slip ยิงยอดรวมในกรณีที่ครบกำหนด
		ldc_itempaynet = ldc_itempaynet - ldc_int_amt 
		ldc_int_amt = 0     		
	end if
	
	if ls_group_itemtpe = 'CLS' then 
		ldc_itempay = ldc_itempay
		ldc_intbfyear = 0
		ldc_int_amt = 0
		ldc_intreturn = 0
		ldc_tax = 0
		ldc_tax_return = 0
		
end if 
	
		
	choose case ls_mapacc
		case "AIT"
			ls_accintarrid	= string( of_getattribmapaccid( as_coopid, "DEP", "DEP", ls_depttype, 1, "accintarr_id"  ) )
			ll_sortintarr		= long( of_getattribmapaccid( as_coopid , "DEP", "DEP", ls_depttype, 1, "sortintarr_order" ) )
			ldc_itempay		= ldc_itempay 
			ls_colname		= "accint_id"
			ls_colsort		= "sortint_order"
		case "ATX"
			ls_colname		= "acctax_id"
			ls_colsort		= "sorttax_order"
			ldc_intbfyear	= 0.00
		case else
			ls_colname		= "account_id"
			ls_colsort		= "sortacc_order"
			ldc_intbfyear	= 0.00
	end choose
	
	ls_accid				= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, ls_colname  ) )
	ls_accint				= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, "accint_id"  ) )
	ls_accintarrid		= string( of_getattribmapaccid( as_coopid, "DEP", "DEP", ls_depttype, 1, "accintarr_id"  ) )
	ls_acctax				= string( of_getattribmapaccid( as_coopid, "DEP", "DEP", ls_depttype, 1, "acctax_id"  ) )
	ll_sortacc			= long( of_getattribmapaccid( as_coopid , "DEP", "DEP", ls_depttype, 1, ls_colsort  ) )		
	ls_feeid				= string( of_getattribmapaccid( as_coopid ,"DEP", "FEE", "00", 1,  "account_id"  ) ) //ค่าปรับ
	
	if(li_accflag = 1) then
		ls_accside		= "CR"
		ls_accrevside	= "DR"	
	else
		ls_accside		= "DR"
		ls_accrevside	= "CR"
	end if
	
	if ls_itemtype = 'INY'  then
		ls_accside			= "DR"
		ls_accrevside		= "CR"
		ls_tofromaccid2 	= ls_tofromaccid
		ldc_int_amt  		= ldc_int_amt - ldc_intbfyear
		//ldc_itempaynet		= 0.00
		ldc_itempay			= ( ldc_itempay - ldc_tax ) * -1  //ทำเพื่อลบค่าออกจากยอดเต็มของฝาก ถอน
		if( ldc_itempay < 0 ) then ldc_itempay = 0.00
		ls_accid			= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, "account_id"  ) )
	end if
	
	if ls_itemtype = 'INT' then
		ls_accside			= "DR"
		ls_accrevside		= "CR"
		ls_tofromaccid2 	= ls_tofromaccid
		ldc_itempay  		= ldc_itempay - ldc_intbfyear
		if( ldc_itempay < 0 ) then ldc_itempay = 0.00   //กรณียอด ดบ.ตั้งค้าง > ดบ.จ่าย  ลงแต่ยอด ดบ.ตั้งค้าง  แล้ว cr ดอกเบี้ยเงินฝากประจำค้างจ่ายรับคืน 
		ldc_int_amt 			= 0.00
	end if
	
	choose case ls_itemtype
		case "FEE"
			ls_accid = string( of_getattribmapaccid( as_coopid ,"DEP", "FEE", "00", 1, "account_id"  ) )
			ls_accside		= "CR"
			ls_accrevside	= "DR"	
		case "WFS"
			ls_accid =  string( of_getattribmapaccid( as_coopid ,"DEP", "WFS", "00", 1, "account_id"  ) )
			ls_accside		= "CR"
			ls_accrevside	= "DR"
		case else
			ls_accid = ls_accid
	end choose
	
		//ดอกเบี้ยหลังหักภาษี
		ldc_pay = ldc_int_amt - ldc_tax
		
	//case INR ที่ปิดด้วยเงินสด แต่ INR ลงรายการโอน ต้องนำมาลงที่รายการโอน Edit By Mike 15/10/2014
	//case INR ที่ปิดด้วยรายการโอน ไม่ต้องนำ INR มาลง เอายอดจาก int_return จากใบถอนมาลงรายการ
	
	//ทำกั้นไว้กรณีปิดเป็นเงินสด แล้วรายการ INR จะส่งคู่บัญชี ( tofrom_accid ) มาเป็นเงินสด ต้องส่งมาเป็นรหัสดอกเบี้ยจ่าย
	if( ls_itemtype = 'INR' and ls_refer_cashtype = 'CSH') then
		ls_tofromaccid2 = string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, "accint_id"  ) )
	end if
	
	if( ls_itemtype = 'INR' and ls_refer_cashtype <> 'CSH') then
		ls_tofromaccid2 = string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, "accint_id"  ) )
		ls_accid		= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, "account_id"  ) )
	end if
	
	//รายการถอน
	if ( ldc_itempay > 0 ) or ( ldc_itempay < 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay , ls_desc, ll_sortacc, ids_vcrcvpaydet )
	end if
	if (ldc_int_amt > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accint, ls_accside, ldc_int_amt , ls_desc, ll_sortacc, ids_vcrcvpaydet )
	end if
	if (ldc_tax_return > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_acctax, ls_accside, ldc_tax_return, ls_desc, ll_sortacc, ids_vcrcvpaydet )
	end if
	//	//ดอกเบี้ยค้างรับค้างจ่าย
	if (ldc_intbfyear > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accintarrid, ls_accside, ldc_intbfyear, ls_desc, ll_sortacc, ids_vcrcvpaydet )
	end if
	//เพิ่มเติม ยิงข้อมูลเข้าแทนรายการ INR 03/10/2014 Edit By Mike
	if (ldc_intreturn > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_intreturn, ls_desc, ll_sortacc, ids_vcrcvpaydet )
	end if
	
	
	
	// รายการฝั่งตรงข้าม
	if 	( ldc_itempaynet > 0 ) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno,ls_tmpsystem, ls_tmpvcgrp, ls_tofromaccid2 , ls_accrevside, ldc_itempaynet ,ls_desc , 1, ids_vcrcvpaydet  )
	end if
	if 	( ldc_intreturn > 0 ) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno,ls_tmpsystem, ls_tmpvcgrp, ls_accint , ls_accrevside, ldc_intreturn, ls_desc  , 1, ids_vcrcvpaydet  )
	end if
	if 	( ldc_tax > 0 ) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno,ls_tmpsystem, ls_tmpvcgrp, ls_acctax , ls_accrevside, ldc_tax , ls_desc , 1, ids_vcrcvpaydet   )
	end if
	//กรณี ดบ.ตั้งค้าง มากกว่า ดบ.จ่าย ลงรายการ ดบ.เงินฝากประจำค้างจ่ายรับคืน 
	if( ldc_intbfyear > ldc_checkint) then 
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno,ls_tmpsystem, ls_tmpvcgrp, ls_accint , ls_accrevside, ldc_intbfyear - ldc_checkint, ls_desc  , 1, ids_vcrcvpaydet  )
	end if
		if( ldc_orther > 0 ) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp,ls_feeid , ls_accrevside, ldc_orther, ls_desc  , 1, ids_vcrcvpaydet )
	end if

	
	
	
	
	// Update สถานะการผ่าน Voucher
	if	not isnull(is_vcrcvtrndocno)    	then
		update	dpdeptslip
		set			posttovc_flag	= 1,	
					voucher_no		= :is_vcrcvtrndocno
		where	( deptslip_no		= :ls_slipno ) and
				( deptcoop_id 		= :as_coopid) and
				( coop_id 			= :ls_coopid)
		using itr_sqlca;
	end if
	
	ls_accid_bf 			= ls_accid
	ls_depttype_bf			= ls_depttype
	ls_itemtype_bf			= ls_itemtype
	li_deptgroup_code_bf	= li_deptgroup_code
	li_dueflag_bf			= li_dueflag
		
next

destroy (lds_slipdata)
// update Vc
if ids_vcrcvpay.update() <> 1 then
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

return 1
end function

private function integer of_vctrnpayin_shr_dept (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการชำระหนี้  เงินโอน
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/

string		ls_slipno,  ls_accid, ls_accintid, ls_accintarrid, ls_slipno_bf
string		ls_accside, ls_accrevside, ls_tmpvcgrp, ls_desc
string		ls_shrlontype, ls_itemtype, ls_tofromaccid
integer	    li_shrlonstatus, li_slipflag, li_seqno
long		ll_index, ll_count, ll_sortacc, ll_sortint, ll_sortintarr
dec{2}		ldc_prinpay, ldc_intpay, ldc_itempay, ldc_intarrear
string		ls_depttype
string		ls_voucher_type , ls_coopid

datastore	lds_slipdata 

// ds สำหรับเก็บการชำระหนี้
lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_trnlnrcv_shr_from_dept"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate, as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if


ls_tmpvcgrp		= "PAY"

	// สร้างเลข Voucher
//is_vcrcvtrndocno = ""

	 if  is_vcrcvtrndocno    =  ""  then
			ls_voucher_type	= "JV"
			ls_desc  		= "รับค่าหุ้น + รับชำระหนี้จากสมาชิก"		
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
	else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	
// ชุดการรับชำระหนี้
for ll_index = 1 to ll_count
	
	ls_slipno			= lds_slipdata.object.payinslip_no[ ll_index ]
	ls_shrlontype		= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_itemtype			= lds_slipdata.object.slipitemtype_code[ ll_index ]
	//ls_tofromaccid		= lds_slipdata.object.tofrom_accid[ ll_index ]
	li_shrlonstatus		= lds_slipdata.object.bfcontlaw_status[ ll_index ]
	li_slipflag			= lds_slipdata.object.sliptypesign_flag[ ll_index ]
	ldc_prinpay			= lds_slipdata.object.principal_payamt[ ll_index ]
	ldc_intpay			= lds_slipdata.object.interest_payamt[ ll_index ]
	ldc_itempay			= lds_slipdata.object.item_payamt[ ll_index ]
	ls_coopid			= lds_slipdata.object.coop_id[ ll_index ]
	ldc_intarrear		= lds_slipdata.object.intarrear_payamt[ ll_index ]
	ls_depttype			= lds_slipdata.object.depttype_code[ ll_index ]
		
	if isnull( ldc_intpay ) then ldc_intpay = 0
	if isnull( ldc_prinpay ) then ldc_prinpay = 0
	if isnull( li_shrlonstatus) or li_shrlonstatus = 0  then li_shrlonstatus = 1
	if(ls_itemtype = 'FEE') then ls_itemtype = 'FFE'
	if isnull( ldc_intarrear ) then ldc_intarrear = 0
	if isnull( ls_shrlontype) or ls_shrlontype = ""  then ls_shrlontype = "00"
	// ด/บ จ่าย - ดอกเบี้ยคืน
	ldc_intpay = ldc_intpay - ldc_intarrear
	
	
	ls_accid			= string	( of_getattribmapaccid(as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "account_id" ) )
	ls_accintid			= string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "accint_id" ) )
	ls_accintarrid		= string	( of_getattribmapaccid(as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "accintarr_id"  ) )
	ll_sortacc			= long	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortacc_order"   ) )
	ll_sortint			= long	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortint_order"  ) )
	ll_sortintarr		= long	( of_getattribmapaccid( as_coopid ,"LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortintarr_order"  ) )
	ls_tofromaccid		= string	( of_getattribmapaccid(as_coopid , "DEP", "DEP", ls_depttype, 1, "account_id" ) )
		
	if ( li_slipflag > 0 ) then
		ls_accside		= "CR"
		ls_accrevside	= "DR"
	else
		ls_accside		= "DR"
		ls_accrevside	= "CR"
	end if

		// เงินต้น
		if ( ldc_prinpay > 0 ) then				
			this.of_additemdesc( as_coopid ,is_vcrcvtrndocno , "LON" , "TRN", ls_accid, ls_accside , ldc_prinpay, ls_desc, ll_sortacc, ids_vcrcvpaydet  )
		end if
		
		// ดอกเบี้ย	
		if ( ldc_intpay > 0 ) then
			this.of_additemdesc( as_coopid ,is_vcrcvtrndocno, "LON"  , "TRN", ls_accintid, ls_accside, ldc_intpay, ls_desc,ll_sortint, ids_vcrcvpaydet  )
		end if
		//รายการชำระหักอื่น ๆ
		if ( ldc_itempay > 0 and  ldc_prinpay = 0 and ldc_intpay = 0 and ldc_intarrear = 0 ) then
			this.of_additemdesc( as_coopid , is_vcrcvtrndocno, "LON" , "TRN", ls_accid, ls_accside, ldc_itempay, ls_desc ,ll_sortint, ids_vcrcvpaydet  )
		end if
			//รายการ ด/บ คืน
		if ( ldc_intarrear > 0) then
			this.of_additemdesc( as_coopid , is_vcrcvtrndocno, "LON" , "TRN", ls_accintarrid, ls_accside, ldc_intarrear , ls_desc,ll_sortintarr, ids_vcrcvpaydet  )
		end if
		
		// รายการฝั่งตรงข้าม
		if	( ldc_itempay > 0  ) then
			this.of_additemdesc( as_coopid , is_vcrcvtrndocno, "LON" , "TRN", ls_tofromaccid, ls_accrevside, ldc_itempay, ls_desc, ll_sortacc, ids_vcrcvpaydet )
		end if
		

	
	// Update สถานะการผ่าน Voucher
	if	ls_slipno	<> ls_slipno_bf		then
		update		slslippayin
		set				posttovc_flag		= 1,	
						voucher_no			= :is_vcrcvtrndocno
		where		( payinslip_no		= :ls_slipno ) and
						( memcoop_id		= :as_coopid  )
		using     itr_sqlca   ;							
	end if			

	ls_slipno_bf		= ls_slipno	

next

destroy( lds_slipdata )

if ids_vcrcvpay.update() <> 1 then
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

return 1
end function

private function integer of_vctrndppay_atm (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception;/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> ถอนเงินฝาก ATM
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  throwable = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/
string			ls_slipno, ls_accid, ls_accintarrid, ls_mapacc, ls_colname, ls_colsort
string			ls_accside, ls_accrevside, ls_vcdocno, ls_tmpsystem, ls_tmpvcgrp
string			ls_moneygrp, ls_depttype, ls_itemtype, ls_tofromaccid
string			ls_desc
integer		li_slipflag,ll_find,li_flag, li_payfee_meth
long			ll_index, ll_count, ll_sortacc, ll_sortintarr, ll_index2
dec{2}		ldc_itempay, ldc_intarrpay,ldc_prncbal,ldc_int_amt,ldc_accuint_amt, ldc_intreturn, ldc_slipnetamt
string			ls_deptgroupcode, ls_itemgroup, ls_accid_bf, ls_depttype_code, ls_vc_desc, ls_itemdesc  
string			ls_depttype_group, ls_refsystem, ls_voucher_type , ls_vc_type , as_vcdocno
dec{2}		ldc_other_amt, ldc_intbfyear , ldc_itempaynet, ldc_tax_return, ldc_tax
string			ls_accid_old, ls_acccash, ls_depttype_bf, ls_itemtype_bf, ls_accint, ls_acctax

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	="d_vc_slip_data_trndppay_atm_ry"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpsystem					= "DEP"
ls_tmpvcgrp						= "DAY"
ls_accid_bf 					= ""
ll_index2						=	1
is_vcrcvtrndocno				= ""
//สร้างเลข Voucher
	 if  is_vcrcvtrndocno = ""   then
			ls_voucher_type	= "JV"	
			ls_desc				= "รายการถอนเงินประจำวัน(ตู้ ATM)"
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , ls_desc  , 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
	else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	

for ll_index = 1 to ll_count

	ls_slipno					= lds_slipdata.object.deptslip_no[ ll_index ]
	ls_itemtype				= lds_slipdata.object.recppaytype_code[ ll_index ]
	ls_moneygrp			= lds_slipdata.object.moneytype_group[ ll_index ]
	ls_depttype				= lds_slipdata.object.depttype_code[ ll_index ]
	ls_tofromaccid			= lds_slipdata.object.tofrom_accid[ ll_index ]
	ls_mapacc				= lds_slipdata.object.accmap_code[ ll_index ]
	ldc_itempay				= lds_slipdata.object.deptslip_amt[ ll_index ]
	ldc_int_amt				= lds_slipdata.object.int_amt[ ll_index ]	
	ldc_accuint_amt		= lds_slipdata.object.accuint_amt[ ll_index ]
	ldc_intreturn			= lds_slipdata.object.int_return[ ll_index ]
	ls_deptgroupcode		= lds_slipdata.object.deptgroup_code[ ll_index ]
	ls_itemgroup			= lds_slipdata.object.group_itemtpe[ ll_index ]
	ldc_itempaynet			= lds_slipdata.object.deptslip_netamt[ ll_index ]
	ldc_other_amt			= lds_slipdata.object.other_amt[ ll_index ] ; 
	li_payfee_meth			= lds_slipdata.object.payfee_meth[ ll_index ] ; 
	ldc_intbfyear			= lds_slipdata.object.int_bfyear[ ll_index ]
	ls_desc					= trim(lds_slipdata.object.compute_3[ ll_index ])
	ldc_tax_return			= lds_slipdata.object.tax_return[ ll_index ]
	ldc_tax					= lds_slipdata.object.tax_amt[ ll_index ]	
	
//	if isnull (ls_tofromaccid)  then ls_tofromaccid = '000000'	
	if isnull( ldc_other_amt ) then ldc_other_amt = 0
	if isnull( li_payfee_meth ) then li_payfee_meth = 0
	if isnull( ldc_int_amt ) then ldc_int_amt = 0
	if isnull( ldc_accuint_amt ) then ldc_accuint_amt = 0
	if isnull( ldc_intreturn ) then ldc_intreturn = 0
	if isnull(ldc_intbfyear) then ldc_intbfyear = 0
		
	choose case ls_mapacc
		case "AIT"
			ls_accintarrid	= string( of_getattribmapaccid( as_coopid, "DEP", "DEP", ls_depttype, 1, "accintarr_id"  ) )
			ll_sortintarr		= long( of_getattribmapaccid( as_coopid , "DEP", "DEP", ls_depttype, 1, "sortintarr_order" ) )
			ldc_itempay		= ldc_itempay 
			ls_colname		= "accint_id"
			ls_colsort		= "sortint_order"
		case "ATX"
			ls_colname		= "acctax_id"
			ls_colsort		= "sorttax_order"
			ldc_intbfyear	= 0.00
		case else
			ls_colname		= "account_id"
			ls_colsort		= "sortacc_order"
			ldc_intbfyear	= 0.00
	end choose
	
	ls_accid				= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, ls_colname  ) )
	ls_accint				= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, "accint_id"  ) )
	ls_accintarrid		= string( of_getattribmapaccid( as_coopid, "DEP", "DEP", ls_depttype, 1, "accintarr_id"  ) )
	ls_acctax				= string( of_getattribmapaccid( as_coopid, "DEP", "DEP", ls_depttype, 1, "acctax_id"  ) )
	ll_sortacc			= long( of_getattribmapaccid( as_coopid , "DEP", "DEP", ls_depttype, 1, ls_colsort  ) )		
	
	ls_accside		= "DR"
	ls_accrevside	= "CR"	
	

	//รายการถอน
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, ls_desc, ll_sortacc, ids_vcrcvpaydet )
	end if
	if (ldc_int_amt > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accint, ls_accside, ldc_int_amt, ls_desc, ll_sortacc, ids_vcrcvpaydet )
	end if
	if (ldc_tax_return > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_acctax, ls_accside, ldc_tax_return, ls_desc, ll_sortacc, ids_vcrcvpaydet )
	end if
	
	
	// รายการฝั่งตรงข้าม
	if 	( ldc_itempaynet > 0 ) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno,"TRN", "TRN", ls_tofromaccid , ls_accrevside, ldc_itempaynet , ls_desc, ll_sortacc, ids_vcrcvpaydet )
	end if
	if 	( ldc_intreturn > 0 ) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno,"TRN", "TRN", ls_accint , ls_accrevside, ldc_intreturn , ls_desc, ll_sortacc, ids_vcrcvpaydet )
	end if
	if 	( ldc_tax > 0 ) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno,"TRN", "TRN", ls_acctax , ls_accrevside, ldc_tax  , ls_desc, ll_sortacc, ids_vcrcvpaydet )
	end if
	
	// Update สถานะการผ่าน Voucher
	if	not isnull(is_vcrcvtrndocno)    	then
		update	dpdeptslip
		set			posttovc_flag	= 1,	
					voucher_no		= :is_vcrcvtrndocno
		where		( deptslip_no	= :ls_slipno ) and
					( coop_id 		= :as_coopid)
		using itr_sqlca;
	end if
	
	ls_accid_bf 				= ls_accid
	ls_depttype_bf			= ls_depttype
	ls_itemtype_bf			= ls_itemtype
		
next

destroy (lds_slipdata)
// update Vc
if ids_vcrcvpay.update() <> 1 then
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

return 1
end function

private function integer of_vccashdprcv_fee (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception;/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> ค่าปรับเงินฝาก เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 13/10/2016 by Sakuraii
</usage> 
***********************************************************/

string			ls_slipno, ls_mapacc, ls_accid, ls_desc, ls_itemdesc, ls_coopid
string			ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp, ls_voucher_type
string			ls_itemtype, ls_tofromaccid
long			ll_index, ll_count
dec{2}			ldc_itempay

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cashdprcv_fee"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpsystem		= "DEP"
ls_tmpvcgrp			= "DAY"


	 if  is_vcrcvdocno    =  ""  then
			ls_voucher_type	= "RV"
			ls_desc  		= "เงินสดรับประจำวัน"		
			is_vcrcvdocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvdocno , as_coopid  )
			this.of_addvoucher( is_vcrcvdocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcv , 'CSH'  , as_coopid,   as_userid )		
		else
			ids_vcrcv.retrieve( is_vcrcvdocno )
			ids_vcrcvdet.retrieve( is_vcrcvdocno )
	 end if 	

for ll_index = 1 to ll_count
	
	ls_coopid				= lds_slipdata.object.coop_id[ ll_index ]
	ls_slipno				= lds_slipdata.object.deptslip_no[ ll_index ]
	ls_itemtype				= lds_slipdata.object.recppaytype_code[ ll_index ]
	ls_tofromaccid			= lds_slipdata.object.tofrom_accid[ ll_index ]
	ls_mapacc				= lds_slipdata.object.accmap_code[ ll_index ]
	ldc_itempay				= lds_slipdata.object.deptslip_netamt[ ll_index ]

	//รหัสค่าปรับเงินฝาก
	ls_accid				= string( of_getattribmapaccid( as_coopid ,"DEP", "FEE", "00", 1, "account_id"  ) )
	
	ls_accside			= "CR"
	ls_accrevside		= "DR"	
		
	if  isnull (ls_tofromaccid ) or ls_tofromaccid <>  is_acccash then
		ls_tofromaccid		= 	is_acccash
	end if
	


	// รายการเงินฝาก
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid ,is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, "เงินสดรับประจำวัน", 1, ids_vcrcvdet)
	end if
	
	/// รายการฝั่งตรงข้าม
	if 	( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid ,is_vcrcvdocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay, "เงินสดรับประจำวัน"  , 2, ids_vcrcvdet  )
	end if
	

	//update สถานะการดึงข้อมูล
	if	not isnull(is_vcrcvdocno)    	then
		update	dpdeptslip
		set			posttovc_flag	= 1,	
					voucher_no		= :is_vcrcvdocno
		where	( deptslip_no	= :ls_slipno ) and
					( deptcoop_id 	= :as_coopid) and
					( coop_id 		= :ls_coopid)
		using itr_sqlca;
	end if
	
next

destroy( lds_slipdata )

//update
if ids_vcrcv.update() <> 1 then	
	return -1
end if
	
if ids_vcrcvdet.update() <> 1 then
	return -1
end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

return 1
end function

on n_cst_account_prepare_vc_service_ry.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_account_prepare_vc_service_ry.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ithw_exception		= create Exception
end event

event destructor;destroy ( ids_mapaccid )
destroy ( ids_acccont )
end event
