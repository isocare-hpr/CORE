$PBExportHeader$n_cst_account_prepare_vc_service_nan.sru
$PBExportComments$ตัวบริการ เตรียมข้อมูลระบบบัญชี
forward
global type n_cst_account_prepare_vc_service_nan from NonVisualObject
end type
end forward

/// <summary> ตัวบริการ เตรียมข้อมูลระบบบัญชี
/// </summary>
global type n_cst_account_prepare_vc_service_nan from NonVisualObject
end type
global n_cst_account_prepare_vc_service_nan n_cst_account_prepare_vc_service_nan

type variables
public:
n_cst_progresscontrol	inv_progresscontrol

protected:
exception		ithw_exception
transaction		itr_sqlca

string				is_cash_id,is_benifit_total_acc , is_benifit_account_id , is_pay[], is_rcv[] , is_vcdocno[]
string				is_account_pl_pf, is_finstatus_code, is_coop_decs
integer				ii_present_year, ii_begin_year, ii_begin_period
datetime			idtm_beginning_of_accou,idtm_ending_of_account
integer				ii_split_vcdetail  = 0 , ii_set_vcdetail  = 1
string				is_vcpaydocno, is_vcrcvdocno,is_vcrcvtrndocno, is_coop_id, is_coop_control

n_cst_datetimeservice		inv_datetime
n_cst_doccontrolservice		inv_docservice
n_cst_stringservice			inv_string
n_cst_progresscontrol		inv_progress
n_cst_account_service		inv_account_service

datastore	ids_vcproc
n_ds		ids_vcrcvpay, ids_vcrcvpaydet, ids_vcrcvpaydetail , ids_vcrcv, ids_vcrcvdet, ids_vcrcvdetail , ids_vcpay, ids_vcpaydet, ids_vcpaydetail ,ids_voucher,ids_voucherdet , ids_mapaccid, ids_voucherdetail
end variables

forward prototypes
public function integer of_settrans (n_cst_dbconnectservice anv_db)
private function any of_getattribmapaccid (string as_coopid, string as_system, string as_slipitem, string as_shrlontype, integer ai_itemstatus, string as_attribmap) throws Exception
private function string of_getvoucher_no (datetime adtm_date, string as_voucher_type, ref string as_voucher_no, string as_coopid) throws Exception
private function integer of_vccashdppay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_additem (string as_coopid, string as_voucherno, string as_syscode, string as_vcgrpno, string as_accid, string as_accside, decimal adc_itemamt, long al_sortorder, ref n_ds ads_voucherdet, string as_userid)
private function integer of_addvoucher (string as_vcdocno, datetime adtm_vcdate, string as_vctype, string as_vcdesc, decimal adc_vcamt, DataStore ads_vchead, string as_system_code, string as_coopid, string as_userid) throws Exception
private function integer of_vccashshpay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vccashshrcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vccashlnpay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vccashlnrcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vccashfinpay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vccashfinrcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrnfinpay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrnpayout (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_additemdesc (string as_coopid, string as_voucherno, string as_syscode, string as_vcgrpno, string as_accid, string as_accside, decimal adc_itemamt, string as_desc, long al_sortorder, ref n_ds ads_voucherdet)
private function integer of_additemdesc_detail (string as_coopid, string as_voucherno, string as_syscode, string as_vcgrpno, string as_accid, string as_accside, decimal adc_itemamt, string as_desc, long al_sortorder, ref n_ds ads_voucherdetail)
private function integer of_additemdesc_nondetail (string as_coopid, string as_voucherno, string as_syscode, string as_vcgrpno, string as_accid, string as_accside, decimal adc_itemamt, string as_desc, long al_sortorder, ref n_ds ads_voucherdetail)
private function integer of_additemdesc_nondetail2 (string as_coopid, string as_voucherno, string as_syscode, string as_vcgrpno, string as_accid, string as_accside, decimal adc_itemamt, string as_desc, long al_sortorder, ref n_ds ads_voucherdetail)
private function integer of_vctrnpayin (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
public function string of_err_generate_import_xml (integer ai_error)
private function integer of_vctrn_cancel_kp_month (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrn_cancel_kp_month_slip (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrnshrpay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrndprcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrndppay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrn_kpmth_dprcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrn_kpmth_dppay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vccashdprcv_fee (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vccashdprcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
public function integer of_vcproc_nan (datetime adtm_sysdate, string as_sysgencode, string as_coopid, string as_userid) throws Exception
private function integer of_vccashfinrcv_tax (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vccashlnrcv_shr (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrnshrrcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrnpayin_shr (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrnfinrcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
private function integer of_vctrn_kpmonth (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
public function integer of_vccashfinrcv_fee (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception
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
inv_progresscontrol		= create n_cst_progresscontrol

inv_docservice.of_settrans( anv_db )

is_coop_id =  anv_db.is_coopid
is_coop_control =  anv_db.is_coopcontrol

ids_vcrcv	= create n_ds
ids_vcrcv.dataobject	= "d_vc_gnrate_voucher"
ids_vcrcv.settransobject( itr_sqlca )

ids_vcrcvdet	= create n_ds
ids_vcrcvdet.dataobject	= "d_vc_gnrate_voucherdet"
ids_vcrcvdet.settransobject( itr_sqlca )

//ids_vcrcvdetail	= create n_ds
//ids_vcrcvdetail.dataobject	= "d_vc_gnrate_voucherdetdetail"
//ids_vcrcvdetail.settransobject( itr_sqlca )

ids_vcpay	= create n_ds
ids_vcpay.dataobject	= "d_vc_gnrate_voucher"
ids_vcpay.settransobject( itr_sqlca )

ids_vcpaydet	= create n_ds
ids_vcpaydet.dataobject	= "d_vc_gnrate_voucherdet"
ids_vcpaydet.settransobject( itr_sqlca )

//ids_vcpaydetail	= create n_ds
//ids_vcpaydetail.dataobject	= "d_vc_gnrate_voucherdetdetail"
//ids_vcpaydetail.settransobject( itr_sqlca )

ids_vcrcvpay	= create n_ds
ids_vcrcvpay.dataobject	= "d_vc_gnrate_voucher"
ids_vcrcvpay.settransobject( itr_sqlca )

ids_vcrcvpaydet	= create n_ds
ids_vcrcvpaydet.dataobject	= "d_vc_gnrate_voucherdet"
ids_vcrcvpaydet.settransobject( itr_sqlca )

//ids_vcrcvpaydetail	= create n_ds
//ids_vcrcvpaydetail.dataobject	= "d_vc_gnrate_voucherdetdetail"
//ids_vcrcvpaydetail.settransobject( itr_sqlca )

ids_voucher	= create n_ds
ids_voucher.dataobject	= "d_vc_gnrate_voucher"
ids_voucher.settransobject( itr_sqlca )

ids_voucherdet	= create n_ds
ids_voucherdet.dataobject	= "d_vc_gnrate_voucherdet"
ids_voucherdet.settransobject( itr_sqlca )

//ids_voucherdetail	= create n_ds
//ids_voucherdetail.dataobject	= "d_vc_gnrate_voucherdetdetail"
//ids_voucherdetail.settransobject( itr_sqlca )

ids_mapaccid	= create n_ds
ids_mapaccid.dataobject	= "d_vc_mapaccid"
ids_mapaccid.settransobject( itr_sqlca )
ids_mapaccid.retrieve( )

//detali สาขาปัว ใช้บันทึกให้รายละเอียดที่เป็นข้อมูลของสาขาปัว
is_coop_decs = "(สาขาปัว)"


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

private function string of_getvoucher_no (datetime adtm_date, string as_voucher_type, ref string as_voucher_no, string as_coopid) throws Exception;/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี  สร้างเลขที่เอกสาร
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/

string				ls_column, ls_year, ls_date, ls_month, ls_docno
integer			li_year, li_fount
datetime			ldtm_operate

ls_column		= "CMVOUCHERNO_" + trim (as_voucher_type)
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
<description>
	ประมวลผลดึงรายการบัญชี   ==> ถอน + ปิดบัญชี แยกดอกเบี้ย เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
	Version 2.0 (Initial version) Modified Date 29/03/2016 by Sakuraii	
</usage> 
***********************************************************/
string			ls_slipno, ls_accid, ls_accintarrid, ls_mapacc, ls_colname, ls_colsort
string			ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp
string			ls_depttype, ls_itemtype, ls_tofromaccid, ls_depttype_code
long			ll_index, ll_count, ll_sortacc
dec{2}			ldc_itempay, ldc_intarrpay,ldc_int_amt, ldc_intreturn, ldc_taxreturn	  
string			ls_depttype_group, ls_voucher_type, ls_desc
dec{2}			ldc_other_amt, ldc_intbfyear, ldc_itempaynet, ldc_tax
string			ls_acccash, ls_coopid, ls_accint, ls_acctax

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	="d_vc_slip_data_cashdppay_tks"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpsystem					= "DEP"
ls_tmpvcgrp						= "DAY"
is_vcpaydocno					= ""

 if  is_vcpaydocno = ""  then
		ls_voucher_type	= "PV"
		is_vcpaydocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcpaydocno , as_coopid  )
		this.of_addvoucher( is_vcpaydocno , adtm_vcdate , ls_voucher_type , "จ่ายเงินสด ถอนเงินฝาก", 0 , ids_vcpay , 'CSH'  , as_coopid  , as_userid )		
else
		ids_vcpay.retrieve( is_vcpaydocno )
		ids_vcpaydet.retrieve( is_vcpaydocno )
 end if 

for ll_index = 1 to ll_count

	ls_slipno				= lds_slipdata.object.deptslip_no[ ll_index ]
	ls_itemtype				= lds_slipdata.object.recppaytype_code[ ll_index ]
	ls_depttype				= lds_slipdata.object.depttype_code[ ll_index ]
	ls_tofromaccid			= lds_slipdata.object.tofrom_accid[ ll_index ]
	ls_mapacc				= lds_slipdata.object.accmap_code[ ll_index ]
	ldc_itempay				= lds_slipdata.object.deptslip_amt[ ll_index ]
	ldc_int_amt				= lds_slipdata.object.int_amt[ ll_index ]	
	ldc_intreturn			= lds_slipdata.object.int_return[ ll_index ]
	ldc_other_amt			= lds_slipdata.object.other_amt[ ll_index ] 
	ldc_intbfyear			= lds_slipdata.object.int_bfyear[ ll_index ]
	ldc_taxreturn			= lds_slipdata.object.tax_return[ ll_index ]
	ldc_itempaynet			= lds_slipdata.object.deptslip_netamt[ ll_index ]
	ls_coopid				= lds_slipdata.object.coop_id[ ll_index ]
	ldc_tax					= lds_slipdata.object.tax_amt[ ll_index ]
	ls_desc					= ""
	
	if isnull( ldc_other_amt ) then ldc_other_amt = 0
	if isnull( ldc_int_amt ) then ldc_int_amt = 0
	if isnull( ldc_intreturn ) then ldc_intreturn = 0
	if isnull(ldc_taxreturn) then ldc_taxreturn = 0
	if isnull(ldc_tax) then ldc_tax = 0
	if IsNull(ls_coopid) or ls_coopid = "" then ls_coopid = as_coopid
		
	choose case ls_mapacc
		case "AIT"
			ls_accintarrid	= string( of_getattribmapaccid( as_coopid, "DEP", "DEP", ls_depttype, 1, "accintarr_id"  ) )
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
	ls_accintarrid			= string( of_getattribmapaccid( as_coopid, "DEP", "DEP", ls_depttype, 1, "accintarr_id"  ) )
	ls_acctax				= string( of_getattribmapaccid( as_coopid, "DEP", "DEP", ls_depttype, 1, "acctax_id"  ) )
	ll_sortacc				= long( of_getattribmapaccid( as_coopid , "DEP", "DEP", ls_depttype, 1, ls_colsort  ) )	
	
	ls_accside		= "DR"
	ls_accrevside	= "CR"	
	
	choose case ls_itemtype
		case "FEE"
			ls_accid		= string( of_getattribmapaccid( as_coopid ,"DEP", "FEE", "00", 1, "account_id"  ) )
			ls_accside		= "CR"
			ls_accrevside	= "DR"	
		case "WFS" //ถอนเพื่อจ่ายเป็นค่าหุ้น/ชำระหนี้ 
			ls_accid		= string( of_getattribmapaccid( as_coopid ,"LON", "SHR", "01", 1, "account_id"  ) )
			ls_accside		= "CR"
			ls_accrevside	= "DR"
		case else
			ls_accid = ls_accid
	end choose
			

	
		//หาบัญชีเงินสด
	select  	cash_account_code
	into		:ls_acccash 
	from		accconstant 
	where 		coop_id = :as_coopid
	using    	 itr_sqlca   ;	
	
	if  isnull (ls_tofromaccid ) or ls_tofromaccid <>  ls_acccash then
		ls_tofromaccid		= 	ls_acccash
	end if
	
	////หาจำนวนราย
	//if  ls_depttype_bf = ls_depttype then
		//ls_desc  = string ( ll_index2 )  + '  รายการ'
		//ll_index2 = ll_index2 + 1
	//else
		//ll_index2	=	1
		//ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
		//ll_index2 = ll_index2 + 1
	//end if
	
	//ตรวจสอบสาขา
	choose case ls_coopid
	case '018002' //สาขาปัว
		ls_desc = ls_desc + is_coop_decs
	case else
		ls_desc = ls_desc
	end choose
	
	//รายการ DR
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid , is_vcpaydocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, ls_desc, ll_sortacc, ids_vcpaydet )
	end if
	if (ldc_int_amt > 0) then
		this.of_additemdesc( as_coopid , is_vcpaydocno, ls_tmpsystem, ls_tmpvcgrp, ls_accint, ls_accside, ldc_int_amt, ls_desc, ll_sortacc, ids_vcpaydet )
	end if

		// รายการฝั่งตรงข้าม CR
	if 	( ldc_itempaynet > 0 ) then
		this.of_additem( as_coopid , is_vcpaydocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_itempaynet  , 1, ids_vcpaydet  , as_userid )
	end if

	
	// Update สถานะการผ่าน Voucher
	if	not isnull(is_vcpaydocno)    	then
		update		dpdeptslip
		set			posttovc_flag	= 1,	
					voucher_no		= :is_vcpaydocno
		where	( deptslip_no		= :ls_slipno ) and
					( deptcoop_id 	= :as_coopid) and
					( coop_id 		= :ls_coopid)
		using itr_sqlca;
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

private function integer of_additem (string as_coopid, string as_voucherno, string as_syscode, string as_vcgrpno, string as_accid, string as_accside, decimal adc_itemamt, long al_sortorder, ref n_ds ads_voucherdet, string as_userid);/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   เพิ่มรายการด้านเงินสด 
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  exception = failure
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

private function integer of_addvoucher (string as_vcdocno, datetime adtm_vcdate, string as_vctype, string as_vcdesc, decimal adc_vcamt, DataStore ads_vchead, string as_system_code, string as_coopid, string as_userid) throws Exception;/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี  บันทึก รายการหลัก
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  exception = failure
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
	case  'RV'	
	   li_cash_type			= 1	
	case  'JV'	
	  li_cash_type			= 2		
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

private function integer of_vccashshpay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการจ่าย เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/
string		ls_slipno, ls_refopeno, ls_accid, ls_accintid, ls_accintarrid , ls_cash ,ls_slipno_bf
string		ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp, ls_acccash
string		ls_moneygrp, ls_shrlontype, ls_sliptype, ls_itemtype, ls_tofromaccid
string		ls_shrpay[], ls_slippart[]
string		ls_branchid,ls_mbbranch_id,ls_acccr_id,ls_accdr_id,ls_desc,ls_year,ls_vcdocno,ls_docno,ls_mbbranch_idold
integer	li_shrlonstatus, li_slipflag, li_seqno,li_flag, li_addflag, li_clear_flag, li_shrlonclc_status, li_shareclc_status
long		ll_index, ll_count, ll_sindex, ll_scount, ll_find, ll_sortacc, ll_sortint, ll_sortintarr, ll_index2, ll_row
dec{2}	ldc_prinpay, ldc_intpay, ldc_intarrpay, ldc_itempay, ldc_loanrcv, ldc_loanfine
dec{2}	ldc_loanrcvnet, ldc_clcfee, ldc_sharebuy, ldc_wrtfund_amt, ldc_int, ldc_total
datetime	ldtm_operate
string		ls_month, ls_date, ls_tofromaccid_bf, ls_accid_bf, ls_accintid_bf, ls_loangroup_code, ls_shrloncode, ls_slipclr, ls_accid_clc, ls_loangroup_bf, ls_loangroup
string		ls_vc_desc, ls_vcdocno_prnc, ls_itemdesc, ls_vcdocno_int, ls_vcdocno_etc, ls_payoutno
string		ls_slipclc_no, ls_voucher_type
string		ls_laonrcv_temp, ls_laonrcv_current, ls_receiptno , ls_document_no  ,  as_vcdocno
string		ls_slipitem_desc, ls_coopid

datastore	lds_slipdata

// ds สำหรับดึงข้อมูลการถอนหุ้นลาออก
lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cashshpay_tks"
lds_slipdata.settransobject( itr_sqlca )

ll_count			= lds_slipdata.retrieve( adtm_vcdate , as_coopid   )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpsystem		= "SHR"
ls_tmpvcgrp			= "PAY"
ls_tofromaccid_bf	= ""
ls_accid_bf			= ""
ls_accintid_bf		= ""
ls_laonrcv_temp	= ""
ll_index2				=	1
// สร้างเลข Voucher
is_vcpaydocno = ""

	 if  is_vcpaydocno    =  ""  then
			ls_voucher_type	= "PV"
			ls_desc  				= "จ่ายหุ้นคืนสมาชิก"		
			is_vcpaydocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcpaydocno , as_coopid  )
			this.of_addvoucher( is_vcpaydocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcpay , 'CSH'  , as_coopid , as_userid )		
		else
			ids_vcpay.retrieve( is_vcpaydocno )
			ids_vcpaydet.retrieve( is_vcpaydocno )
	 end if 	

for ll_index = 1 to ll_count 
		
	ls_slipno				= lds_slipdata.object.payoutslip_no[ ll_index ]
	ls_document_no	= lds_slipdata.object.document_no[ ll_index ]
	ls_moneygrp		= lds_slipdata.object.moneytype_group[ ll_index ]
	ls_shrlontype		= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_tofromaccid		= lds_slipdata.object.tofrom_accid[ ll_index ]
	li_shrlonstatus		= 1
	li_slipflag				= lds_slipdata.object.sliptypesign_flag[ ll_index ]
	ldc_itempay			= lds_slipdata.object.payout_amt[ ll_index ]
	ls_sliptype			= lds_slipdata.object.sliptype_code [ ll_index ]
	ldc_int				= lds_slipdata.object.interest_payamt [ ll_index ]
	ldc_prinpay			= lds_slipdata.object.principal_payamt [ ll_index ]
	ls_shrloncode		= lds_slipdata.object.slslippayindet_shrlontype_code [ ll_index ]
	ldc_total				= lds_slipdata.object.payoutnet_amt [ ll_index ]
	ls_coopid				= lds_slipdata.object.coop_id [ ll_index ]
	ls_slipclr				= lds_slipdata.object.slipclear_no[ ll_index ]
	li_shrlonclc_status	= lds_slipdata.object.bfcontlaw_status[ ll_index ]
	li_shareclc_status	= lds_slipdata.object.bfshare_status[ ll_index ]
	
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
	ll_sortint			= long	( of_getattribmapaccid(as_coopid, "LON", "SHR" , ls_shrlontype, li_shrlonclc_status, "sortint_order"  ) )
	ll_sortintarr		= long	( of_getattribmapaccid( as_coopid,"LON", "SHR" , ls_shrlontype, li_shrlonclc_status, "sortintarr_order"  ) )
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


	
	if ls_slipno_bf <> ls_slipno then
		ls_itemdesc  = string( ll_index2 ) + '  รายการ'
		ll_index2 = ll_index2 + 1
	else
		ll_index2	=	1
		ls_itemdesc  =  string ( ll_index2 ) + '  รายการ'
		ll_index2 = ll_index2 + 1
	end if


if isnull (ls_slipclr) or ls_slipclr = "" then //เช็คว่ามีหักกลบรึป่าว
	// รายการจ่ายเงิน
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid , is_vcpaydocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid  , ls_accside, ldc_itempay, ls_itemdesc, ll_sortacc, ids_vcpaydet)
	end if
	
	// รายการฝั่งตรงข้าม
	if 	( ldc_itempay > 0 ) then		
		this.of_additem( as_coopid , is_vcpaydocno ,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcpaydet  , as_userid )
	end if
	
else
	
			// รายการจ่ายเงิน
	if(ls_slipno_bf <> ls_slipno) then
		if ( ldc_itempay > 0 ) then
			this.of_additemdesc( as_coopid ,  is_vcpaydocno, ls_itemtype, ls_tmpvcgrp, ls_accid  , ls_accside, ldc_itempay, ls_itemdesc, ll_sortacc, ids_vcpaydet)
		end if
		// รายการฝั่งตรงข้าม
		if (ldc_total > 0) then
			this.of_additem( as_coopid , is_vcpaydocno ,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_total  , 1, ids_vcpaydet  , as_userid )
		end if
	end if
	if 	( ldc_prinpay > 0 ) then	
		this.of_additem( as_coopid , is_vcpaydocno ,ls_itemtype, ls_tmpvcgrp, ls_accid_clc , ls_accrevside, ldc_prinpay  , 1, ids_vcpaydet  , as_userid )
	end if

	if ( ldc_int > 0 ) then
		this.of_additemdesc( as_coopid ,  is_vcpaydocno, ls_itemtype, ls_tmpvcgrp, ls_accintid , ls_accrevside, ldc_int, "", ll_sortacc, ids_vcpaydet)
	end if
	
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
	
	ls_accid_bf		= ls_accid
	ls_accintid_bf	= ls_accintid
	ls_slipno_bf		= ls_slipno
	ls_loangroup_bf	= ls_loangroup
	
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

private function integer of_vccashshrcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการซื้อหุ้น เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/

string		ls_slipno, ls_refopeno, ls_accid, ls_accintid, ls_accintarrid, ls_vc_type , ls_acccash , ls_slipno_bf
string		ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp
string		ls_moneygrp, ls_shrlontype, ls_itemtype, ls_tofromaccid
string		ls_branchid,ls_mbbranch_id,ls_acccr_id,ls_accdr_id,ls_desc,ls_year,ls_vcdocno,ls_docno,ls_mbbranch_idold
integer	li_shrlonstatus, li_slipflag, li_seqno,li_flag
long		ll_index, ll_count, ll_sortacc, ll_sortint, ll_sortintarr, ll_index2
dec{2}	ldc_prinpay, ldc_intpay, ldc_itempay, ldc_intarrpay,ldc_fineamt
string		ls_shrlontypeold,ls_document_no,ls_itemdesc,ls_maxdoc,ls_mindoc, ls_date, ls_month, ls_slipitem_desc
datetime	ldtm_operate
string		ls_vc_desc, ls_loangroup_code, ls_accid_bf, ls_vcrcvdocno_prnc, ls_accintid_bf ,ls_coopcontrol , ls_coopid
string		ls_vcrcvdocno_int , ls_vcrcvdocno_etc , ls_voucher_type , as_vcdocno 

datastore	lds_slipdata ,lds_countitem

// ds สำหรับเก็บการซื้อหุ้น
lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cashshrcv_tks"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate, as_coopid  )

// ds สำหรับทำสำเนาเพื่อ หาเลขที่ใบเสร็จ
lds_countitem	= lds_slipdata

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

// สร้างเลข Voucher
is_vcrcvdocno = ""
	 if  is_vcrcvdocno    =  ""  then
			ls_voucher_type	= "RV"
			ls_desc  				= "สมาชิกซื้อหุ้นเพิ่ม"		
			is_vcrcvdocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvdocno , as_coopid  )
			this.of_addvoucher( is_vcrcvdocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcv , 'CSH'  , as_coopid  , as_userid )		
		else
			ids_vcrcv.retrieve( is_vcrcvdocno )
			ids_vcrcvdet.retrieve( is_vcrcvdocno )
//			ids_vcrcvdetail.retrieve( is_vcrcvdocno )
	 end if 	


ls_tmpsystem	= "SHR" 
ls_tmpvcgrp		= "PAY"
ls_accid_bf		= ''
ll_index2			=	1
// ชุดการรับชำระหนี้
for ll_index = 1 to ll_count

	ls_coopid				= lds_slipdata.object.coop_id[ ll_index ]
	ls_slipno				= lds_slipdata.object.payinslip_no[ ll_index ]
	ls_document_no	= lds_slipdata.object.document_no[ ll_index ]
	ls_moneygrp		= lds_slipdata.object.moneytype_group[ ll_index ]
	ls_shrlontype		= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_itemtype			= lds_slipdata.object.slipitemtype_code[ ll_index ]
	ls_tofromaccid		= lds_slipdata.object.tofrom_accid[ ll_index ]
	li_shrlonstatus		= 1
	li_slipflag				= lds_slipdata.object.sliptypesign_flag[ ll_index ]
	ldc_itempay			= lds_slipdata.object.item_payamt[ ll_index ]
	ls_slipitem_desc	= trim(lds_slipdata.object.slipitem_desc[ ll_index ])	
		
	if isnull( ldc_intpay ) then ldc_intpay = 0
	if isnull( ldc_fineamt ) then ldc_fineamt = 0
		
	ls_accid			= string	( of_getattribmapaccid(as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "account_id" ) )
	ls_accintid		= string	( of_getattribmapaccid(as_coopid, "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "accint_id" ) )
	ls_accintarrid	= string	( of_getattribmapaccid( as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "accintarr_id"  ) )
	ll_sortacc		= long	( of_getattribmapaccid( as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortacc_order"   ) )
	ll_sortint			= long	( of_getattribmapaccid( as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortint_order"  ) )
	ll_sortintarr		= long	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortintarr_order"  ) )
		
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

	if  ls_accid_bf = ls_accid then
		ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
		ll_index2 = ll_index2 + 1
	else
		ll_index2	=	1
		ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
		ll_index2 = ll_index2 + 1
	end if
		
	// ยอดทำรายการ
	if ( ldc_itempay > 0 ) then				
		this.of_additemdesc( as_coopid ,is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, ls_itemdesc, ll_sortacc, ids_vcrcvdet)
	end if
	
	// รายการเงินสดฝั่งตรงข้าม
	if	( ldc_itempay > 0  ) then
		this.of_additem( as_coopid , is_vcrcvdocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcrcvdet  , as_userid )
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
	ls_accintid_bf	= ls_accintid
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

private function integer of_vccashlnpay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการจ่ายเงินกู้ เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/
string		ls_slipno, ls_refopeno, ls_accid, ls_accintid, ls_accintarrid , ls_cash ,ls_slipno_bf
string		ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp
string		ls_moneygrp, ls_shrlontype, ls_sliptype, ls_itemtype, ls_tofromaccid
string		ls_shrcvno[]
string		ls_branchid,ls_mbbranch_id,ls_acccr_id,ls_accdr_id,ls_desc,ls_year,ls_vcdocno,ls_docno,ls_mbbranch_idold
integer	li_shrlonstatus, li_slipflag, li_seqno,li_flag, li_addflag, li_clear_flag, li_account_id_num
long		ll_index, ll_count, ll_sindex, ll_scount, ll_find, ll_sortacc, ll_sortint, ll_sortintarr, ll_index2, ll_num
dec{2}	ldc_prinpay, ldc_intpay, ldc_intarrpay, ldc_itempay, ldc_loanrcv, ldc_loanfine
dec{2}	ldc_loanrcvnet, ldc_clcfee, ldc_sharebuy, ldc_wrtfund_amt
datetime	ldtm_operate
string		ls_month, ls_date, ls_tofromaccid_bf, ls_accid_bf, ls_accintid_bf, ls_loangroup_code
string		ls_vc_desc, ls_vcdocno_prnc, ls_itemdesc, ls_vcdocno_int, ls_vcdocno_etc, ls_payoutno
string		ls_loantype_pay, ls_loantype_rcv, ls_sliplwd_no, ls_slipclc_no
string		ls_laonrcv_temp, ls_laonrcv_current, ls_receiptno , ls_document_no  ,  as_vcdocno
dec{2}	ldc_itempaynet, ldc_payoutclr, ldc_total, ldc_int
string		ls_vc_type , ls_voucher_type
string		ls_slipitem_desc, ls_acccash, ls_coopid, ls_loangroup, ls_loangroup_bf, ls_slipclr, ls_accid_clc, ls_shrloncode

datastore	lds_slipdata
datastore	lds_slipdata1

// ds สำหรับดึงข้อมูลการจ่ายเงินกู้
lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cashlnpay_tks"
lds_slipdata.settransobject( itr_sqlca )

// ds สำหรับนับจำนวนราย
lds_slipdata1	= create datastore
lds_slipdata1.dataobject	= "d_vc_slip_data_cashlnpay_num_tks"
lds_slipdata1.settransobject( itr_sqlca )

ll_count			= lds_slipdata.retrieve( adtm_vcdate , as_coopid   )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if
ls_tmpsystem		= "LON"
ls_tmpvcgrp			= "PAY"
ls_tofromaccid_bf	= ""
ls_accid_bf			= ""
ls_accintid_bf		= ""
ls_laonrcv_temp	= ""
ll_index2				= 1
	 
for ll_index = 1 to ll_count 
		
	ls_slipno				= lds_slipdata.object.payoutslip_no[ ll_index ]
	ls_document_no	= lds_slipdata.object.document_no[ ll_index ]
	ls_moneygrp		= lds_slipdata.object.moneytype_group[ ll_index ]
	ls_shrlontype		= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_tofromaccid		= lds_slipdata.object.tofrom_accid[ ll_index ]
	li_shrlonstatus		= 1
	li_slipflag				= lds_slipdata.object.sliptypesign_flag[ ll_index ]
	ldc_itempay			= lds_slipdata.object.payout_amt[ ll_index ]
	ls_sliptype			= lds_slipdata.object.sliptype_code [ ll_index ]
	ldc_int				= lds_slipdata.object.interest_payamt [ ll_index ]
	ldc_prinpay			= lds_slipdata.object.principal_payamt [ ll_index ]
	ls_shrloncode		= lds_slipdata.object.slslippayindet_shrlontype_code [ ll_index ]
	ldc_total				= lds_slipdata.object.payoutnet_amt [ ll_index ]
	ls_coopid				= lds_slipdata.object.coop_id [ ll_index ]
	ls_loangroup		= lds_slipdata.object.loangroup_code[ ll_index ]
	ls_slipclr				= lds_slipdata.object.slipclear_no[ ll_index ]
	
	ls_accid			= string	( of_getattribmapaccid( as_coopid, "LON", "LON" , ls_shrlontype, li_shrlonstatus, "account_id" ) )
	ls_accintid		= string	( of_getattribmapaccid(as_coopid, "LON", "LON" , ls_shrlontype, li_shrlonstatus, "accint_id" ) )
	ls_accintarrid	= string	( of_getattribmapaccid( as_coopid, "LON", "LON" , ls_shrlontype, li_shrlonstatus, "accintarr_id"  ) )
	ll_sortacc		= long	( of_getattribmapaccid(as_coopid,"LON", "LON" , ls_shrlontype, li_shrlonstatus, "sortacc_order"   ) )
	ll_sortint			= long	( of_getattribmapaccid(as_coopid, "LON", "LON" , ls_shrlontype, li_shrlonstatus, "sortint_order"  ) )
	ll_sortintarr		= long	( of_getattribmapaccid( as_coopid,"LON", "LON" , ls_shrlontype, li_shrlonstatus, "sortintarr_order"  ) )
	ls_accid_clc		= string	( of_getattribmapaccid( as_coopid, "LON", "LON" , ls_shrloncode, li_shrlonstatus, "account_id" ) )
	
	if ( li_slipflag > 0 ) then
		ls_accside		= "CR"
		ls_accrevside	= "DR"
	else
		ls_accside		= "DR"
		ls_accrevside	= "CR"
	end if
	
	choose case ls_loangroup
		case '01'
			ls_desc = "เงินสดจ่ายเงินกู้ฉุกเฉินให้แก่สมาชิก"
		case '02'
			ls_desc = "เงินสดจ่ายเงินกู้สามัญให้แก่สมาชิก"
		case '03'
			ls_desc = "เงินสดจ่ายเงินกู้พิเศษให้แก่สมาชิก"
	end choose
	//สร้าง voucher
		 if ( ls_loangroup    <>  ls_loangroup_bf)  then
			ls_voucher_type	= "PV"
//			ls_desc  				= "เงินสดจ่ายประจำวัน"		
			is_vcpaydocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcpaydocno , as_coopid  )
			this.of_addvoucher( is_vcpaydocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcpay , 'CSH'  , as_coopid , as_userid )		
		else
			ids_vcpay.retrieve( is_vcpaydocno )
			ids_vcpaydet.retrieve( is_vcpaydocno )
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
	
if(ls_accid <> ls_accid_bf) then
	ll_num		 = lds_slipdata1.retrieve( adtm_vcdate , as_coopid , ls_accid  )
	li_account_id_num	= lds_slipdata1.object.count_group [ 1 ]  // ใช้นับจำนวนรายเงินกู้
	ls_itemdesc  =  string ( li_account_id_num ) + '  ราย'
else
	ls_itemdesc	= ls_itemdesc
end if

//		if  ls_accid_bf = ls_accid then
//		ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
//		ll_index2 = ll_index2 + 1
//	else
//		ll_index2	=	1
//		ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
//		ll_index2 = ll_index2 + 1
//	end if
//


//if isnull (ls_slipclr) or ls_slipclr = "" then //เช็คว่ามีหักกลบรึป่าว
	// รายการจ่ายเงิน
	if(ls_slipno_bf <> ls_slipno) then
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid , is_vcpaydocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid  , ls_accside, ldc_itempay, ls_itemdesc, ll_sortacc, ids_vcpaydet)
	end if
	
	// รายการฝั่งตรงข้าม
	if 	( ldc_itempay > 0 ) then		
		this.of_additem( as_coopid , is_vcpaydocno ,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcpaydet  , as_userid )
	end if
end if
	
//else
//	
//			// รายการจ่ายเงิน
//	if(ls_slipno_bf <> ls_slipno) then
//		if ( ldc_itempay > 0 ) then
//			this.of_additemdesc( as_coopid ,  is_vcpaydocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid  , ls_accside, ldc_itempay, ls_itemdesc, ll_sortacc, ids_vcpaydet)
//		end if
//		// รายการฝั่งตรงข้าม
//		if (ldc_total > 0) then
//			this.of_additem( as_coopid , is_vcpaydocno ,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_total  , 1, ids_vcpaydet  , as_userid )
//		end if
//	end if
//	if 	( ldc_itempay > 0 ) then	
//		this.of_additem( as_coopid , is_vcpaydocno ,"CSH", "CSH", ls_accid_clc , ls_accrevside, ldc_prinpay  , 1, ids_vcpaydet  , as_userid )
//	end if
//
//	if ( ldc_int > 0 ) then
//		this.of_additemdesc( as_coopid ,  is_vcpaydocno, ls_tmpsystem, ls_tmpvcgrp, ls_accintid , ls_accrevside, ldc_int, "", ll_sortacc, ids_vcpaydet)
//	end if
//	
//end if
	
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
	
	ls_accid_bf		= ls_accid
	ls_accintid_bf	= ls_accintid
	ls_slipno_bf		= ls_slipno
	ls_loangroup_bf	= ls_loangroup
	
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

private function integer of_vccashlnrcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการชำระ เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
	Version 2.0 (Initial version) Modified Date 30/03/2016 by Sakuraii
</usage> 
***********************************************************/

string		ls_slipno, ls_accid, ls_accintid, ls_accintarrid , ls_acccash , ls_slipno_bf
string		ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp, ls_entry_coopid
string		ls_moneygrp, ls_shrlontype, ls_itemtype, ls_tofromaccid
string		ls_desc, ls_voucher_type, ls_coopid
integer		li_shrlonstatus, li_slipflag
long		ll_index, ll_count, ll_sortacc, ll_sortint, ll_sortintarr
dec{2}		ldc_prinpay, ldc_intpay, ldc_itempay, ldc_intarrpay, ldc_int

datastore	lds_slipdata 

// ds สำหรับเก็บการชำระหนี้
lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cashlnrcv_tks"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate, as_coopid  )

// ds สำหรับทำสำเนาเพื่อ หาเลขที่ใบเสร็จ
//lds_countitem	= lds_slipdata

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if


//end if		
ls_tmpsystem	= "LON" 
ls_tmpvcgrp		= "PAY"
is_vcrcvdocno	= ""

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
	ls_moneygrp			= lds_slipdata.object.moneytype_group[ ll_index ]
	ls_shrlontype		= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_itemtype			= lds_slipdata.object.slipitemtype_code[ ll_index ]
	ls_tofromaccid		= lds_slipdata.object.tofrom_accid[ ll_index ]
	li_shrlonstatus		= lds_slipdata.object.bfcontlaw_status[ ll_index ]
	li_slipflag			= lds_slipdata.object.sliptypesign_flag[ ll_index ]
	ldc_itempay			= lds_slipdata.object.item_payamt[ ll_index ]
	ldc_prinpay			= lds_slipdata.object.principal_payamt[ ll_index ]
	ldc_int				= lds_slipdata.object.interest_payamt[ ll_index ]
	ldc_intarrpay		= lds_slipdata.object.intarrear_payamt[ ll_index ]
	ls_entry_coopid		= lds_slipdata.object.entry_bycoopid[ ll_index ] //ใช้แยกยอดของสาขา
	ls_desc				= ""
							
		
	if isnull( ldc_intpay ) then ldc_intpay = 0
	if isnull( ldc_intarrpay ) then ldc_intarrpay = 0
	if IsNull( li_shrlonstatus ) then li_shrlonstatus = 1
	
	if ( ldc_intarrpay > 0 ) then
		ldc_intpay	= ldc_intpay - ldc_intarrpay
	end if
		
	ls_accid			= string	( of_getattribmapaccid(as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "account_id" ) )
	ls_accintid			= string	( of_getattribmapaccid(as_coopid, "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "accint_id" ) )
	ls_accintarrid		= string	( of_getattribmapaccid( as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "accintarr_id"  ) )
	ll_sortacc			= long	( of_getattribmapaccid( as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortacc_order"   ) )
	ll_sortint			= long	( of_getattribmapaccid( as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortint_order"  ) )
	ll_sortintarr		= long	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortintarr_order"  ) )
		
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
	where 		coop_id = :as_coopid
	using    	 itr_sqlca   ;	
	
	//ตรวจสอบสาขา
	choose case ls_entry_coopid
	case '018002' //สาขาปัว
		ls_desc = ls_desc + is_coop_decs
	case else
		ls_desc = ls_desc
	end choose
	
//	select		loangroup_code
//	into		:ls_loangroup_code
//	from		lnloantype
//	where	loantype_code		= :ls_shrlontype
//	using     	itr_sqlca;
			
//	choose case ls_loangroup
//		case '01'
//			ls_desc	= 'เงินกู้ฉุกเฉิน'
//		case '02'
//			ls_desc	= 'เงินกู้สามัญ'
//		case '03'
//			ls_desc	= 'เงินกู้พิเศษ'
//	end choose
	
	if  isnull (ls_tofromaccid ) or ls_tofromaccid <>  ls_acccash then
		ls_tofromaccid		= 	ls_acccash
	end if
	
	

	//นับจำนวนรายการ
//	if  ls_accid_bf = ls_accid then
//		ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
//		ll_index2 = ll_index2 + 1
//	else
//		ll_index2	=	1
//		ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
//		ll_index2 = ll_index2 + 1
//	end if
	
	// เงินต้น
		if ( ldc_prinpay > 0 ) then				
			this.of_additemdesc( as_coopid ,is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_prinpay, ls_desc, ll_sortacc, ids_vcrcvdet)
			this.of_additem( as_coopid , is_vcrcvdocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_prinpay  , 1, ids_vcrcvdet  , as_userid )
		end if
			
		// ดอกเบี้ย	
		if ( ldc_int > 0 ) then
			this.of_additemdesc( as_coopid ,is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accintid, ls_accside, ldc_int, ls_desc, ll_sortacc, ids_vcrcvdet)
			this.of_additem( as_coopid , is_vcrcvdocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_int  , 1, ids_vcrcvdet  , as_userid )
		end if
			
		// ดอกเบี้ยค้าง
		if ( ldc_intarrpay > 0 ) then
			this.of_additemdesc( as_coopid ,is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accintarrid, ls_accside, ldc_intarrpay, ls_desc, ll_sortacc, ids_vcrcvdet)
			this.of_additem( as_coopid , is_vcrcvdocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_intarrpay  , 1, ids_vcrcvdet  , as_userid )
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

private function integer of_vccashfinpay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการจ่ายการเงิน เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  exception = failure
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
integer		li_slipflag,ll_seqno
long			ll_index, ll_count,ll_find, ll_index2
dec{2}		ldc_itempay,ldc_tax_amt,ldc_itembal
string			ls_slipitemtype_code,ls_vcrcvno,ls_acctaxid,ls_cashcode,ls_account_id 
string			ls_accid_bf, ls_vcrcvdocno_tax , ls_itemdesc , ls_cash, ls_coopid, ls_detail
string			ls_finno, ls_finno_temp, ls_tofromaccid_bf, ls_voucher_type , as_vcdocno, ls_acccash

n_ds			lds_vcpay, lds_vcpaydet
datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cashfnpay_tks"
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
ls_vcrcvdocno_tax	= ""
ls_finno_temp		= ""
ll_index2				= 1

// สร้างเลข Voucher
is_vcpaydocno = ""

 if  is_vcpaydocno    =  ""  then
		ls_voucher_type	= "PV"
		ls_desc  				= "เงินสดจ่ายประจำวัน(การเงิน)"		
		is_vcpaydocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcpaydocno , as_coopid  )
		this.of_addvoucher( is_vcpaydocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcpay , 'CSH'  , as_coopid  , as_userid )		
	else
		ids_vcpay.retrieve( is_vcpaydocno )
		ids_vcpaydet.retrieve( is_vcpaydocno )
 end if 	

for ll_index = 1 to ll_count
	ls_slipno					= lds_slipdata.object.slip_no[ ll_index ]
	ldc_itempay				= lds_slipdata.object.itempay_amt[ ll_index ]	
	ls_accid					= lds_slipdata.object.account_id[ ll_index ]
	ls_slipitem_desc		= trim( lds_slipdata.object.slipitem_desc[ ll_index ] )
	ls_tofromaccid			= trim( lds_slipdata.object.tofrom_accid[ ll_index ] )
	ls_finno					= trim( ls_slipno )	
	ls_coopid					= lds_slipdata.object.coop_id[ ll_index ]
	ls_detail					= lds_slipdata.object.nonmember_detail[ ll_index ]
	
	if isnull( ldc_tax_amt ) then ldc_tax_amt = 0
		
//	if ( li_slipflag > 0 ) then
//		ls_accside		= "CR"
//		ls_accrevside	= "DR"
//	else
//		ls_accside		= "DR"
//		ls_accrevside	= "CR"
//	end if
	
	ls_accside		= "DR"
	ls_accrevside	= "CR"	
			
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
		

	if  ls_accid_bf = ls_accid then
		ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
		ll_index2 = ll_index2 + 1
	else
		ll_index2	=	1
		ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
		ll_index2 = ll_index2 + 1
	end if
	
	//รายการการเงิน
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid , is_vcpaydocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, "", 1, ids_vcpaydet)
	end if
	
	// รายการฝั่งตรงข้าม
	if 	( ldc_itempay > 0 ) then
		this.of_additem( as_coopid ,is_vcpaydocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcpaydet  , as_userid )
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
	
	ls_accid_bf			= ls_accid
	ls_finno_temp		= ls_finno
	ls_tofromaccid_bf	= ls_tofromaccid
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
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการรับการเงิน เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/
string		ls_slipno, ls_slipprior, ls_mapacc, ls_accid, ls_accintarrid, ls_colname
string		ls_accside, ls_accrevside, ls_vcdocno, ls_tmpsystem, ls_tmpvcgrp
string		ls_moneygrp, ls_depttype, ls_itemtype, ls_tofromaccid, ls_docno, ls_year
integer	li_slipflag
long		ll_index, ll_count, ll_index2
dec{2}	ldc_itempay
string		ls_slipitem_desc, ls_accid_bf, ls_detail
string		ls_maxdoc, ls_mindoc,  ls_desc, ls_voucher_type , ls_cash, ls_slipitemtype, ls_coopid
string		ls_finno_temp,  ls_finno, ls_tofromaccid_bf , as_vcdocno , ls_itemdesc, ls_acccash

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cashfnrcv_tks"
lds_slipdata.settransobject( itr_sqlca )

// reset เงินสดรับ
ll_count	= lds_slipdata.retrieve( adtm_vcdate,as_coopid  )

// สร้างเลข Voucher
 is_vcrcvdocno = ""

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if


ls_tmpsystem		= "FIN"
ls_tmpvcgrp			= "DAY"
ls_accid_bf			= ""
ll_index2				= 1

// สร้างเลข Voucher
 is_vcrcvdocno = ""

	 if  is_vcrcvdocno    =  ""  then
			ls_voucher_type	= "RV"
			ls_desc  				= "เงินสดรับประจำวัน(การเงิน)"		
			is_vcrcvdocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvdocno , as_coopid  )
			this.of_addvoucher( is_vcrcvdocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcv , 'CSH'  , as_coopid  , as_userid )		
		else
			ids_vcrcv.retrieve( is_vcrcvdocno )
			ids_vcrcvdet.retrieve( is_vcrcvdocno )
	 end if 	



//
for ll_index = 1 to ll_count
	ls_slipno					= trim( lds_slipdata.object.slip_no[ ll_index ] )
	ldc_itempay					= lds_slipdata.object.itempay_amt[ ll_index ]	
	ls_accid					= lds_slipdata.object.account_id[ ll_index ]
	ls_slipitem_desc			= trim( lds_slipdata.object.slipitem_desc[ ll_index ] )
	ls_tofromaccid				= trim( lds_slipdata.object.tofrom_accid[ ll_index ] )
	ls_finno					= ls_slipno
	ls_slipitemtype				= lds_slipdata.object.slipitemtype_code[ ll_index ]
	ls_coopid					= lds_slipdata.object.coop_id[ ll_index ]	
	ls_detail					= lds_slipdata.object.nonmember_detail[ ll_index ]	
	
	ls_accside			= "CR"
	ls_accrevside		= "DR"

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

	if  ls_accid_bf = ls_accid then
		ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
		ll_index2 = ll_index2 + 1
	else
		ll_index2	=	1
		ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
		ll_index2 = ll_index2 + 1
	end if
	
		// รายการการเงิน
	if ( ldc_itempay > 0 ) then		
		this.of_additemdesc( as_coopid , is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, ls_slipitem_desc, 0, ids_vcrcvdet)
	end if
	// รายการฝั่งตรงข้าม
	if 	( ldc_itempay > 0 ) then		
		this.of_additem( as_coopid ,is_vcrcvdocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcrcvdet  , as_userid )
	end if
	
		// Update สถานะการผ่าน Voucher
	if ls_slipno <> ls_slipprior then
		update	finslipdet
		set			posttovc_flag	= 1,	
					voucher_no		= :is_vcrcvdocno
		where	( slip_no			= :ls_slipno )  and
					( coop_id 		= :ls_coopid)
		using     itr_sqlca   ;
		
		ls_slipprior	= ls_slipno
	end if
	
	ls_accid_bf				= ls_accid
	ls_finno_temp			= ls_finno
	ls_tofromaccid_bf		= ls_tofromaccid
	
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
string			ls_slipno, ls_slipprior, ls_accid, ls_accintarrid, ls_mapacc, ls_colname, ls_vc_type
string			ls_accside, ls_accrevside, ls_vcdocno, ls_tmpsystem, ls_tmpvcgrp ,ls_slipitem_desc
string			ls_moneygrp, ls_depttype, ls_itemtype, ls_tofromaccid, ls_docno, ls_year
string			ls_branchid,ls_accmaster_branch_id,ls_acccr_id,ls_accdr_id,ls_oldbranchid,ls_desc,ls_vcbrdocno
integer		li_slipflag,ll_seqno
long			ll_index, ll_count,ll_find, ll_index2
dec{2}		ldc_itempay,ldc_tax_amt,ldc_itembal, ldc_itemamtnet
string			ls_slipitemtype_code,ls_vcrcvno,ls_acctaxid,ls_cashcode ,ls_account_id 
string			ls_accid_bf, ls_vcrcvdocno_tax , ls_itemdesc , ls_cash, ls_coopid , ls_detail
string			ls_finno, ls_finno_temp, ls_tofromaccid_bf, ls_voucher_type , as_vcdocno

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
ls_vcrcvdocno_tax	= ""
ls_finno_temp		= ""
ll_index2				=	1
// สร้างเลข Voucher
//is_vcrcvtrndocno = ""

	 if  is_vcrcvtrndocno    =  ""  then
			ls_voucher_type	= "JV"
			ls_desc  				= "รายการโอน"		
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
		else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	



for ll_index = 1 to ll_count
	ls_slipno					= lds_slipdata.object.slip_no[ ll_index ]
	ldc_itempay				= lds_slipdata.object.itempay_amt[ ll_index ]	
	ls_accid					= lds_slipdata.object.account_id[ ll_index ]
	ls_slipitem_desc		= trim( lds_slipdata.object.slipitem_desc[ ll_index ] )
	ls_tofromaccid			= trim( lds_slipdata.object.tofrom_accid[ ll_index ] )
	ls_finno					= trim( ls_slipno )	
	ldc_tax_amt				= lds_slipdata.object.tax_amt[ ll_index ]
	ldc_itemamtnet			= lds_slipdata.object.item_amtnet[ ll_index ]
	ls_coopid					= lds_slipdata.object.coop_id[ ll_index ]
	ls_detail					= lds_slipdata.object.nonmember_detail[ ll_index ]
	
	if isnull( ldc_tax_amt ) then ldc_tax_amt = 0
		
	ls_accside		= "DR"
	ls_accrevside	= "CR"			
	

	if  ls_accid_bf = ls_accid then
		ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
		ll_index2 = ll_index2 + 1
	else
		ll_index2	=	1
		ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
		ll_index2 = ll_index2 + 1
	end if
	
	//รายการการเงิน
if (ldc_tax_amt > 0) then
	if ( ldc_itempay > 0 ) then
		ldc_itempay = ldc_itemamtnet + ldc_tax_amt
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, ls_itemdesc, 77777, ids_vcrcvpaydet )
		this.of_additemdesc( as_coopid ,is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_tofromaccid, ls_accrevside, ldc_itemamtnet, ls_itemdesc, 77777, ids_vcrcvpaydet)
		this.of_additemdesc( as_coopid ,is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, "219100", ls_accrevside, ldc_tax_amt, ls_itemdesc, 77777, ids_vcrcvpaydet)
	end if
else
	if ( ldc_itemamtnet > 0 ) then
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, ls_itemdesc, 77777, ids_vcrcvpaydet )
		this.of_additemdesc( as_coopid ,is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_tofromaccid, ls_accrevside, ldc_itempay, ls_itemdesc, 77777, ids_vcrcvpaydet)
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
	ls_finno_temp	= ls_finno
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

private function integer of_vctrnpayout (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
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
string		ls_slipno, ls_refopeno, ls_accid, ls_accintid, ls_accintarrid , ls_cash ,ls_slipno_bf
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
lds_slipdata.dataobject	= "d_vc_slip_data_trnlnpay"
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
//is_vcrcvtrndocno = ""
	 if  is_vcrcvtrndocno    =  ""  then
			ls_voucher_type	= "JV"
			ls_desc  				= "รายการโอน"		
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
	ls_document_no	= lds_slipdata.object.document_no[ ll_index ]
	ls_moneygrp		= lds_slipdata.object.moneytype_group[ ll_index ]
	ls_shrlontype		= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_tofromaccid		= lds_slipdata.object.tofrom_accid[ ll_index ]
	li_shrlonstatus		= 1
	li_slipflag				= lds_slipdata.object.sliptypesign_flag[ ll_index ]
	ldc_itempay			= lds_slipdata.object.payout_amt[ ll_index ]
	ls_sliptype			= lds_slipdata.object.sliptype_code [ ll_index ]
	ls_coopid				= lds_slipdata.object.coop_id [ ll_index ]
	ls_loangroup		= lds_slipdata.object.loangroup_code[ ll_index ]
	ls_slipclr				= lds_slipdata.object.slipclear_no[ ll_index ]
	ls_memgroup		= lds_slipdata.object.membgroup_code[ ll_index ]
	ls_slipitemtype_code			= lds_slipdata.object.slipitemtype_code[ ll_index ]
	ls_shrloncode		= lds_slipdata.object.slslippayindet_shrlontype_code [ ll_index ]
	ldc_int				= lds_slipdata.object.interest_payamt [ ll_index ]
	ldc_prinpay			= lds_slipdata.object.principal_payamt [ ll_index ]
	ldc_total				= lds_slipdata.object.payoutnet_amt [ ll_index ]
	ldc_shrpay			= lds_slipdata.object.item_payamt [ ll_index ]


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
	ls_accintid		= string	( of_getattribmapaccid(as_coopid, "LON", ls_itemtype , ls_shrloncode, li_shrlonstatus, "accint_id" ) )
	ls_accintarrid	= string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype , ls_shrloncode, li_shrlonstatus, "accintarr_id"  ) )
	ll_sortacc		= long	( of_getattribmapaccid(as_coopid,"LON", ls_itemtype , ls_shrlontype, li_shrlonstatus, "sortacc_order"   ) )
	ll_sortint			= long	( of_getattribmapaccid(as_coopid, "LON", ls_itemtype , ls_shrlontype, li_shrlonstatus, "sortint_order"  ) )
	ll_sortintarr		= long	( of_getattribmapaccid( as_coopid,"LON", ls_itemtype , ls_shrlontype, li_shrlonstatus, "sortintarr_order"  ) )
	ls_accid_clc		= string	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype , ls_shrloncode, li_shrlonstatus, "account_id" ) )
	
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
//	if(left(ls_memgroup,1) = 'S' ) and ls_itemtype = 'SHR' then
//		ls_accid = "311101"  
//	end if
		
	if  ls_accid_bf = ls_accid then
		ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
		ll_index2 = ll_index2 + 1
	else
		ll_index2	=	1
		ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
		ll_index2 = ll_index2 + 1
	end if
	
	if isnull (ls_slipclr) or ls_slipclr = "" then //เช็คว่ามีหักกลบรึป่าว
	// รายการจ่ายเงิน
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid ,  is_vcrcvtrndocno, ls_itemtype, ls_tmpvcgrp, ls_accid  , ls_accside, ldc_itempay, ls_itemdesc, ll_sortacc, ids_vcrcvpaydet)
	end if
	
	// รายการฝั่งตรงข้าม
	if 	( ldc_itempay > 0 ) then		
		this.of_additem( as_coopid , is_vcrcvtrndocno ,"TRN", "TRN", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcrcvpaydet  , as_userid )
	end if
	
	else
	
	// รายการจ่ายเงิน
	if(ls_slipno_bf <> ls_slipno) then
		if ( ldc_itempay > 0 ) then
			this.of_additemdesc( as_coopid ,  is_vcrcvtrndocno, ls_itemtype, ls_tmpvcgrp, ls_accid  , ls_accside, ldc_itempay, ls_itemdesc, ll_sortacc, ids_vcrcvpaydet)
		end if
		if (ldc_total > 0) then
			this.of_additem( as_coopid , is_vcrcvtrndocno ,"TRN", "TRN", ls_tofromaccid , ls_accrevside, ldc_total  , 1, ids_vcrcvpaydet  , as_userid )
		end if
	end if
		choose case ls_slipitemtype_code
			case 'SHR'
		if (ldc_shrpay > 0) then //ยอดซื้อหุ้น
			this.of_additemdesc( as_coopid ,  is_vcrcvtrndocno, ls_itemtype, ls_tmpvcgrp, ls_accshr , ls_accrevside, ldc_shrpay, "", ll_sortacc, ids_vcrcvpaydet)
		end if

			case 'LON'
		// รายการฝั่งตรงข้าม
		if 	( ldc_itempay > 0 ) then	
			this.of_additem( as_coopid , is_vcrcvtrndocno ,"TRN", "TRN", ls_accid_clc , ls_accrevside, ldc_prinpay  , 1, ids_vcrcvpaydet  , as_userid )
		end if
	
		if ( ldc_int > 0 ) then
			this.of_additemdesc( as_coopid ,  is_vcrcvtrndocno, ls_itemtype, ls_tmpvcgrp, ls_accintid , ls_accrevside, ldc_int, "", ll_sortacc, ids_vcrcvpaydet)
		end if
	
			case else
		if (ldc_shrpay > 0) then //ยอดค่าธรรมเนียม
			this.of_additemdesc( as_coopid ,  is_vcrcvtrndocno, ls_itemtype, ls_tmpvcgrp, ls_accshr , ls_accrevside, ldc_shrpay, "", ll_sortacc, ids_vcrcvpaydet)
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

private function integer of_additemdesc (string as_coopid, string as_voucherno, string as_syscode, string as_vcgrpno, string as_accid, string as_accside, decimal adc_itemamt, string as_desc, long al_sortorder, ref n_ds ads_voucherdet);/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี  
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  exception = failure
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
									" and vcgrp_no = '"+as_vcgrpno+"' and account_side = '"+as_accside+"' and item_desc = '"+ as_desc +"'", 1, ads_voucherdet.rowcount() )	


if ll_find <= 0 then
	ll_find		= ads_voucherdet.insertrow( 0 )
	
	ll_seqno	= long( ads_voucherdet.describe( "evaluate( 'max( seq_no for all )', "+string( ll_find )+") " ) )
	
	if isnull( ll_seqno ) then ll_seqno = 0
	
	ll_seqno ++
	ads_voucherdet.setitem( ll_find, "coop_id", is_coop_control ) 
	ads_voucherdet.setitem( ll_find, "voucher_no", as_voucherno )
	ads_voucherdet.setitem( ll_find, "seq_no", ll_seqno )
	ads_voucherdet.setitem( ll_find, "system_code", as_syscode )
	ads_voucherdet.setitem( ll_find, "vcgrp_no", as_vcgrpno )
	ads_voucherdet.setitem( ll_find, "account_id", as_accid )
	ads_voucherdet.setitem( ll_find, "account_side", as_accside )
//	ads_voucherdet.setitem( ll_find, "Item_desc", as_desc )
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

private function integer of_additemdesc_detail (string as_coopid, string as_voucherno, string as_syscode, string as_vcgrpno, string as_accid, string as_accside, decimal adc_itemamt, string as_desc, long al_sortorder, ref n_ds ads_voucherdetail);/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี  
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  exception = failure
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

ll_find	= ads_voucherdetail.find( "coop_id = '"+as_coopid+  "'  and account_id = '"+as_accid+  "'  and voucher_no = '"+  as_voucherno + "' and system_code = '"+as_syscode+"'" + &
									" and vcgrp_no = '"+as_vcgrpno+"' and account_side = '"+as_accside+"'", 1, ads_voucherdetail.rowcount() )	


//if ll_find <= 0 then
	ll_find		= ads_voucherdetail.insertrow( 0 )
	
	ll_seqno	= long( ads_voucherdetail.describe( "evaluate( 'max( order_no for all )', "+string( ll_find )+") " ) )
	
	if isnull( ll_seqno ) then ll_seqno = 0
	
	ll_seqno ++
	ads_voucherdetail.setitem( ll_find, "coop_id", as_coopid ) 
	ads_voucherdetail.setitem( ll_find, "voucher_no", as_voucherno )
	ads_voucherdetail.setitem( ll_find, "order_no", ll_seqno )
	ads_voucherdetail.setitem( ll_find, "system_code", as_syscode )
	ads_voucherdetail.setitem( ll_find, "vcgrp_no", as_vcgrpno )
	ads_voucherdetail.setitem( ll_find, "account_id", as_accid )
	ads_voucherdetail.setitem( ll_find, "account_side", as_accside )
//	ads_voucherdetail.setitem( ll_find, "Item_desc", as_desc )
	ads_voucherdetail.setitem( ll_find, ls_colname, adc_itemamt )
	ads_voucherdetail.setitem( ll_find, "sort_order", al_sortorder )
	ads_voucherdetail.setitem( ll_find, "POSTTOGL_ALLFLAG", 1 )
	ads_voucherdetail.setitem( ll_find, "POSTTOGL_FLAG", 1 )
	

//end if
			
				
			
//ldc_itembal		= ads_voucherdetail.getitemdecimal( ll_find, ls_colname )
//ldc_itembal		= ldc_itembal + adc_itemamt
			
//ads_voucherdetail.setitem( ll_find, ls_colname, ldc_itembal )
ads_voucherdetail.setitem( ll_find, "item_desc", as_desc )

if ii_set_vcdetail = 0 then
	ads_voucherdetail.setitem( ll_find, "POSTTOGL_FLAG", 0 )
else
	ads_voucherdetail.setitem( ll_find, "POSTTOGL_FLAG", 1 )
end if

ads_voucherdetail.accepttext( )

return 1
end function

private function integer of_additemdesc_nondetail (string as_coopid, string as_voucherno, string as_syscode, string as_vcgrpno, string as_accid, string as_accside, decimal adc_itemamt, string as_desc, long al_sortorder, ref n_ds ads_voucherdetail);/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี  
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  exception = failure
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

ll_find	= ads_voucherdetail.find( "coop_id = '"+as_coopid+  "'  and account_id = '"+as_accid+  "'  and voucher_no = '"+  as_voucherno + "' and system_code = '"+as_syscode+"'" + &
									" and vcgrp_no = '"+as_vcgrpno+"' and account_side = '"+as_accside+"'", 1, ads_voucherdetail.rowcount() )	


if ll_find <= 0 then
	ll_find		= ads_voucherdetail.insertrow( 0 )
	
	ll_seqno	= long( ads_voucherdetail.describe( "evaluate( 'max( order_no for all )', "+string( ll_find )+") " ) )
	
	if isnull( ll_seqno ) then ll_seqno = 0
	
	ll_seqno ++
	ads_voucherdetail.setitem( ll_find, "coop_id", as_coopid ) 
	ads_voucherdetail.setitem( ll_find, "voucher_no", as_voucherno )
	ads_voucherdetail.setitem( ll_find, "order_no", ll_seqno )
	ads_voucherdetail.setitem( ll_find, "system_code", as_syscode )
	ads_voucherdetail.setitem( ll_find, "vcgrp_no", as_vcgrpno )
	ads_voucherdetail.setitem( ll_find, "account_id", as_accid )
	ads_voucherdetail.setitem( ll_find, "account_side", as_accside )
//	ads_voucherdetail.setitem( ll_find, "Item_desc", as_desc )
//	ads_voucherdetail.setitem( ll_find, ls_colname, adc_itemamt )
	ads_voucherdetail.setitem( ll_find, "sort_order", al_sortorder )
	ads_voucherdetail.setitem( ll_find, "POSTTOGL_ALLFLAG", 1 )
	ads_voucherdetail.setitem( ll_find, "POSTTOGL_FLAG", 1 )
	

end if
			
				
			
ldc_itembal		= ads_voucherdetail.getitemdecimal( ll_find, ls_colname )
ldc_itembal		= ldc_itembal + adc_itemamt
			
ads_voucherdetail.setitem( ll_find, ls_colname, ldc_itembal )
ads_voucherdetail.setitem( ll_find, "item_desc", as_desc )

if ii_set_vcdetail = 0 then
	ads_voucherdetail.setitem( ll_find, "POSTTOGL_FLAG", 0 )
else
	ads_voucherdetail.setitem( ll_find, "POSTTOGL_FLAG", 1 )
end if


ads_voucherdetail.accepttext( )

return 1
end function

private function integer of_additemdesc_nondetail2 (string as_coopid, string as_voucherno, string as_syscode, string as_vcgrpno, string as_accid, string as_accside, decimal adc_itemamt, string as_desc, long al_sortorder, ref n_ds ads_voucherdetail);/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี  
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  exception = failure
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

ll_find	= ads_voucherdetail.find( "coop_id = '"+as_coopid+  "'  and account_id = '"+as_accid+  "'  and voucher_no = '"+  as_voucherno + "' and system_code = '"+as_syscode+"'" + &
									" and vcgrp_no = '"+as_vcgrpno+"' and account_side = '"+as_accside+"' and item_desc = '"+ as_desc+"'", 1, ads_voucherdetail.rowcount() )	


if ll_find <= 0 then
	ll_find		= ads_voucherdetail.insertrow( 0 )
	
	ll_seqno	= long( ads_voucherdetail.describe( "evaluate( 'max( order_no for all )', "+string( ll_find )+") " ) )
	
	if isnull( ll_seqno ) then ll_seqno = 0
	
	ll_seqno ++
	ads_voucherdetail.setitem( ll_find, "coop_id", as_coopid ) 
	ads_voucherdetail.setitem( ll_find, "voucher_no", as_voucherno )
	ads_voucherdetail.setitem( ll_find, "order_no", ll_seqno )
	ads_voucherdetail.setitem( ll_find, "system_code", as_syscode )
	ads_voucherdetail.setitem( ll_find, "vcgrp_no", as_vcgrpno )
	ads_voucherdetail.setitem( ll_find, "account_id", as_accid )
	ads_voucherdetail.setitem( ll_find, "account_side", as_accside )
//	ads_voucherdetail.setitem( ll_find, "Item_desc", as_desc )
//	ads_voucherdetail.setitem( ll_find, ls_colname, adc_itemamt )
	ads_voucherdetail.setitem( ll_find, "sort_order", al_sortorder )
	ads_voucherdetail.setitem( ll_find, "POSTTOGL_ALLFLAG", 1 )
	ads_voucherdetail.setitem( ll_find, "POSTTOGL_FLAG", 1 )
	

end if
			
				
			
ldc_itembal		= ads_voucherdetail.getitemdecimal( ll_find, ls_colname )
ldc_itembal		= ldc_itembal + adc_itemamt
			
ads_voucherdetail.setitem( ll_find, ls_colname, ldc_itembal )
ads_voucherdetail.setitem( ll_find, "item_desc", as_desc )

if ii_set_vcdetail = 0 then
	ads_voucherdetail.setitem( ll_find, "POSTTOGL_FLAG", 0 )
else
	ads_voucherdetail.setitem( ll_find, "POSTTOGL_FLAG", 1 )
end if


ads_voucherdetail.accepttext( )

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
//is_vcrcvtrndocno = ""

	 if  is_vcrcvtrndocno    =  ""  then
			ls_voucher_type	= "JV"
			ls_desc  				= "รายการโอน"		
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
	
	ls_slipno				= lds_slipdata.object.payinslip_no[ ll_index ]
	ls_document_no	= lds_slipdata.object.document_no[ ll_index ]
	ls_moneygrp		= lds_slipdata.object.moneytype_group[ ll_index ]
	ls_shrlontype		= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_itemtype			= lds_slipdata.object.slipitemtype_code[ ll_index ]
	ls_tofromaccid		= lds_slipdata.object.tofrom_accid[ ll_index ]
	li_shrlonstatus		= lds_slipdata.object.bfcontlaw_status[ ll_index ]
	li_slipflag				= lds_slipdata.object.sliptypesign_flag[ ll_index ]
	ldc_prinpay			= lds_slipdata.object.principal_payamt[ ll_index ]
	ldc_intpay			= lds_slipdata.object.interest_payamt[ ll_index ]
	ldc_itempay			= lds_slipdata.object.item_payamt[ ll_index ]
	ls_slipitem_desc	= trim(lds_slipdata.object.slipitem_desc[ ll_index ])
	ls_coopid				= lds_slipdata.object.coop_id[ ll_index ]
	ls_memgroup		= lds_slipdata.object.membgroup_code[ ll_index ]
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
	
		// hare_code เพื่อแยกประเภทหุ้นของสมาชิกปกติ กับ สมทบ by Mike 04/09/2013
	if(left(ls_memgroup,1) = 'S' ) and ls_itemtype = 'SHR' then
		ls_accid = "311101"  
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

public function string of_err_generate_import_xml (integer ai_error);choose case ai_error
	case	-1   
		return "No rows or startrow value supplied is greater than the number of rows in the string"
	case	-3
		return "Invalid argument"
	case	-4
		return "Invalid input"
	case	-11
		return "XML Parsing Error; XML parser libraries not found or XML not well formed"
	case	-12
		return "XML Template does not exist or does not match the DataWindow"
	case	-13
		return "Unsupported DataWindow style for import"
	case	-14
		return "Error resolving DataWindow nesting"
	case else
		return "No Error Message"
end choose
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
string			ls_slipno, ls_slipprior, ls_accid, ls_accintarrid, ls_mapacc, ls_colname
string			ls_accside, ls_accrevside, ls_vcdocno, ls_tmpsystem, ls_tmpvcgrp ,ls_slipitem_desc
string			ls_moneygrp, ls_depttype, ls_itemtype, ls_tofromaccid,  ls_desc
integer		li_slipflag,ll_seqno, li_shrlonstatus
long			ll_index, ll_count
dec{2}		ldc_itempay,ldc_tax_amt,ldc_itembal, ldc_itemamtnet, ldc_principal, ldc_int, ldc_deptamt, ldc_total, ldc_intarrear
string			ls_slipitemtype_code,ls_vcrcvno,ls_acctaxid,ls_cashcode ,ls_account_id 
string			ls_itemdesc , ls_shrlontype, ls_membno, ls_membno_last
string			ls_finno, ls_finno_temp, ls_tofromaccid_bf, ls_voucher_type , as_vcdocno, ls_deptaccount
string			ls_system_code, ls_accintid, ls_recv_period,ls_kpaccintid,ls_kpaccid

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

	if isnull( ldc_principal ) then ldc_principal = 0
	if isnull( ldc_int ) then ldc_int = 0
	
	//เคลียร์ยอด ldc_intarrear ให้เป็น 0 เนื่องจากยอดได้ไปรวมใน int_amt แล้ว
	ldc_intarrear  = 0
	
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
//	ls_kpaccid		= string	( of_getattribmapaccid( as_coopid, "KEP", "KEP" , "01", 1, "account_id" ) ) //รหัสลูกหนี้ตัวแทน
 	ls_kpaccintid	= string	( of_getattribmapaccid(as_coopid, "KEP", "KEP" , "01", 1, "accint_id" ) )
		
	ls_accside		= "CR"
	ls_accrevside	= "DR"			
	
	if(ldc_itempay > 0) then  //ลูกหนี้ตัวแทน ฝั่ง DR
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_kpaccintid, ls_accside, ldc_itempay, "ยกเลิกกระดาษทำการ", 77777, ids_vcrcvpaydet )
	end if
	
	choose case ls_itemtype
		case 'L01','L02','L03'
	if(ldc_principal > 0) then //ฝั่ง CR
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accrevside, ldc_principal, "ยกเลิก", 77777, ids_vcrcvpaydet )
	end if
	if(ldc_int > 0) then //ดอกเบี้ยฝั่ง CR
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accintid, ls_accrevside, ldc_int, "ยกเลิก", 77777, ids_vcrcvpaydet )
	end if
	if(ldc_intarrear > 0) then //ฝั่ง CR
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accintarrid, ls_accrevside, ldc_intarrear, "ยกเลิก", 77777, ids_vcrcvpaydet )
	end if

		case else
	
	if(ldc_itempay > 0) then  //
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accrevside, ldc_itempay, "ยกเลิก", 77777, ids_vcrcvpaydet )
	end if

end choose

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
string			ls_slipno,  ls_accid, ls_accintarrid, ls_mapacc, ls_colname, ls_vc_type
string			ls_accside, ls_accrevside, ls_vcdocno, ls_tmpsystem, ls_tmpvcgrp ,ls_slipitem_desc
string			ls_moneygrp, ls_depttype, ls_itemtype, ls_tofromaccid, ls_docno, ls_year
string			ls_branchid,ls_accmaster_branch_id,ls_acccr_id,ls_accdr_id,ls_oldbranchid,ls_desc,ls_vcbrdocno
integer		li_slipflag,ll_seqno, li_shrlonstatus
long			ll_index, ll_count,  ll_sortacc, ll_sortint, ll_sortintarr
dec{2}		ldc_itempay,ldc_tax_amt,ldc_itembal, ldc_itemamtnet, ldc_principal, ldc_int, ldc_deptamt, ldc_total, ldc_intarrear
string			ls_slipitemtype_code,ls_vcrcvno,ls_acctaxid,ls_cashcode ,ls_account_id 
string			ls_itemdesc , ls_cash, ls_shrlontype, ls_membno, ls_membno_last
string			ls_voucher_type , as_vcdocno, ls_deptaccount
string			ls_system_code, ls_accintid, ls_recv_period, ls_slipno_bf

n_ds			lds_vcpay, lds_vcpaydet
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
	ls_slipno					= lds_slipdata.object.adjslip_no[ ll_index ]
	ldc_itempay				= lds_slipdata.object.item_adjamt[ ll_index ]	
	ldc_principal				= lds_slipdata.object.principal_adjamt[ ll_index ]
	ldc_int					= lds_slipdata.object.interest_adjamt[ ll_index ]
	ls_itemtype				= lds_slipdata.object.bfmthpay_kpitemtyp[ ll_index ]
	ls_shrlontype			= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_system_code		= trim(lds_slipdata.object.system_code[ ll_index ])
	li_shrlonstatus			= lds_slipdata.object.bfcontlaw_status[ ll_index ]
	ldc_intarrear			= lds_slipdata.object.intarrear_adjamt[ ll_index ] 
	ls_recv_period			= lds_slipdata.object.ref_recvperiod[ ll_index ]  
	ls_tofromaccid			= trim(lds_slipdata.object.tofrom_accid[ ll_index ] )

	if isnull( ldc_principal ) then ldc_principal = 0
	if isnull( ldc_int ) then ldc_int = 0
	if isnull( ldc_intarrear ) then ldc_intarrear = 0
	
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
	
	ls_accid			= string	( of_getattribmapaccid( as_coopid, "LON", ls_system_code , ls_shrlontype, li_shrlonstatus, "account_id" ) )
	ls_accintid		= string	( of_getattribmapaccid(as_coopid, "LON", ls_system_code , ls_shrlontype, li_shrlonstatus, "accint_id" ) )
	ls_accintarrid	= string	( of_getattribmapaccid(as_coopid, "LON", ls_system_code , ls_shrlontype, li_shrlonstatus, "accintarr_id"  ) )
	ll_sortacc		= long	( of_getattribmapaccid( as_coopid,"LON", ls_system_code, ls_shrlontype, li_shrlonstatus, "sortacc_order"   ) )
	ll_sortint			= long	( of_getattribmapaccid(as_coopid, "LON", ls_system_code , ls_shrlontype, li_shrlonstatus, "sortint_order"  ) )
	ll_sortintarr		= long	( of_getattribmapaccid(as_coopid, "LON", ls_system_code, ls_shrlontype, li_shrlonstatus, "sortintarr_order"  ) )
	ls_vc_type		= string	( of_getattribmapaccid(as_coopid, "LON", ls_system_code, ls_shrlontype, li_shrlonstatus, "prefix_recv"  ) )
		
	ls_accside		= "CR"
	ls_accrevside	= "DR"			
	
	if(ldc_itempay > 0) then  //ลูกหนี้ตัวแทน ฝั่ง CR
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_tofromaccid, ls_accside, ldc_itempay, "ยกเลิก", 77777, ids_vcrcvpaydet )
	end if
	
	choose case ls_itemtype
		case 'S01','FFE','FEE','ISF'
	if(ldc_itempay > 0) then  //
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accrevside, ldc_itempay, "ยกเลิก", 77777, ids_vcrcvpaydet )
	end if
			
		case else
	
	if(ldc_principal > 0) then //ฝั่ง DR
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accrevside, ldc_principal, "ยกเลิก", 77777, ids_vcrcvpaydet )
	end if
	if(ldc_int > 0) then //ดอกเบี้ยฝั่ง DR
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accintid, ls_accrevside, ldc_int, "ยกเลิก", 77777, ids_vcrcvpaydet )
	end if
	if(ldc_intarrear > 0) then //ฝั่ง DR
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accintarrid, ls_accrevside, ldc_intarrear, "ยกเลิก", 77777, ids_vcrcvpaydet )
	end if
end choose


//update สถานะการดึงข้อมูล
	if ls_slipno_bf <> ls_slipno then
		update	slslipadjust
		set			posttovc_flag	= 1,	
					voucher_no		= :is_vcrcvtrndocno
		where	( adjslip_no		= :ls_slipno ) and
					( coop_id			= :as_coopid ) 
					
		using    	 itr_sqlca   ;
	end if

	ls_slipno_bf			= ls_slipno
	
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

private function integer of_vctrnshrpay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการจ่ายเงินกู้ เงินสด
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
string		ls_slipno, ls_refopeno, ls_accid, ls_accintid, ls_accintarrid , ls_cash ,ls_slipno_bf
string		ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp
string		ls_moneygrp, ls_shrlontype, ls_sliptype, ls_itemtype, ls_tofromaccid
string		ls_shrcvno[], ls_slippart[], ls_loanpay[]
string		ls_branchid,ls_mbbranch_id,ls_acccr_id,ls_accdr_id,ls_desc,ls_year,ls_vcdocno,ls_docno,ls_mbbranch_idold
integer	li_shrlonstatus, li_slipflag, li_seqno,li_flag, li_addflag, li_clear_flag
long		ll_index, ll_count, ll_sindex, ll_scount, ll_find, ll_sortacc, ll_sortint, ll_sortintarr, ll_index2, ll_row
dec{2}	ldc_prinpay, ldc_intpay, ldc_intarrpay, ldc_itempay, ldc_loanrcv, ldc_loanfine
dec{2}	ldc_loanrcvnet, ldc_clcfee, ldc_sharebuy, ldc_wrtfund_amt
datetime	ldtm_operate
string		ls_month, ls_date, ls_tofromaccid_bf, ls_accid_bf, ls_accintid_bf, ls_loangroup_code
string		ls_vc_desc, ls_vcdocno_prnc, ls_itemdesc, ls_vcdocno_int, ls_vcdocno_etc, ls_payoutno
string		ls_loantype_pay, ls_loantype_rcv, ls_sliplwd_no, ls_slipclc_no
string		ls_vccash_tran_01, ls_vccash_tran_02, ls_vccash_tran_03, ls_vccash_01, ls_vccash_02, ls_vccash_03
string		ls_laonrcv_temp, ls_laonrcv_current, ls_receiptno , ls_document_no  ,  as_vcdocno
dec{2}	ldc_clcprnc, ldc_clcint, ldc_fineall, ldc_feeall , ldc_itempaynet, ldc_payoutclr, ldc_total, ldc_int
string		ls_tran01, ls_tran02, ls_tran03, ls_tran2, ls_tran3, ls_tran4, ls_vccash_tran2, ls_vccash_tran3, ls_vc_type , ls_voucher_type
string		ls_slipitem_desc, ls_acccash, ls_coopid, ls_loangroup, ls_loangroup_bf, ls_slipclr, ls_accid_clc, ls_shrloncode

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
ls_tofromaccid_bf	= ""
ls_accid_bf			= ""
ls_accintid_bf		= ""
ls_laonrcv_temp	= ""
ll_index2				= 1
//is_vcrcvtrndocno	= ""

	//สร้าง voucher
		 if is_vcrcvtrndocno = ""  then
			ls_voucher_type	= "JV"
			ls_desc  				= "รายการโอน"		
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcvpay , 'TRN'  , as_coopid , as_userid )		
		else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	
	 
for ll_index = 1 to ll_count 
		
	ls_slipno				= lds_slipdata.object.payoutslip_no[ ll_index ]
	ls_document_no	= lds_slipdata.object.document_no[ ll_index ]
	ls_moneygrp		= lds_slipdata.object.moneytype_group[ ll_index ]
	ls_shrlontype		= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_tofromaccid		= lds_slipdata.object.tofrom_accid[ ll_index ]
	li_shrlonstatus		= 1
	li_slipflag				= lds_slipdata.object.sliptypesign_flag[ ll_index ]
	ldc_itempay			= lds_slipdata.object.payout_amt[ ll_index ]
	ls_sliptype			= lds_slipdata.object.sliptype_code [ ll_index ]
	ldc_int				= lds_slipdata.object.interest_payamt [ ll_index ]
	ldc_prinpay			= lds_slipdata.object.principal_payamt [ ll_index ]
	ls_shrloncode		= lds_slipdata.object.slslippayindet_shrlontype_code [ ll_index ]
	ldc_total				= lds_slipdata.object.payoutnet_amt [ ll_index ]
	ls_coopid				= lds_slipdata.object.coop_id [ ll_index ]
	ls_slipclr				= lds_slipdata.object.slipclear_no[ ll_index ]
	
	if isnull(ldc_total) then ldc_total = 0
	if isnull(ldc_int) then ldc_int = 0
	if isnull(ldc_prinpay) then ldc_prinpay = 0
	if isnull(ldc_itempay) then ldc_itempay = 0
	
	ls_accid			= string	( of_getattribmapaccid( as_coopid, "LON", "SHR" , ls_shrlontype, li_shrlonstatus, "account_id" ) )
     ls_accintid		= string	( of_getattribmapaccid(as_coopid, "LON", "LON" , ls_shrloncode, li_shrlonstatus, "accint_id" ) )
	ls_accintarrid	= string	( of_getattribmapaccid( as_coopid, "LON", "LON" , ls_shrloncode, li_shrlonstatus, "accintarr_id"  ) )
	ll_sortacc		= long	( of_getattribmapaccid(as_coopid,"LON", "SHR" , ls_shrlontype, li_shrlonstatus, "sortacc_order"   ) )
	ll_sortint			= long	( of_getattribmapaccid(as_coopid, "LON", "SHR" , ls_shrlontype, li_shrlonstatus, "sortint_order"  ) )
	ll_sortintarr		= long	( of_getattribmapaccid( as_coopid,"LON", "SHR" , ls_shrlontype, li_shrlonstatus, "sortintarr_order"  ) )
	ls_accid_clc		= string	( of_getattribmapaccid( as_coopid, "LON", "LON" , ls_shrloncode, li_shrlonstatus, "account_id" ) )
	

	if ( li_slipflag > 0 ) then
		ls_accside		= "CR"
		ls_accrevside	= "DR"
	else
		ls_accside		= "DR"
		ls_accrevside	= "CR"
	end if


if isnull (ls_slipclr) or ls_slipclr = "" then //เช็คว่ามีหักกลบรึป่าว
	// รายการจ่ายเงิน
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid  , ls_accside, ldc_itempay, "", ll_sortacc, ids_vcrcvpaydet)
	end if
	
	// รายการฝั่งตรงข้าม
	if 	( ldc_itempay > 0 ) then		
		this.of_additem( as_coopid , is_vcrcvtrndocno ,"TRN", "TRN", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcrcvpaydet  , as_userid )
	end if
	
else
	
			// รายการจ่ายเงิน
	if(ls_slipno_bf <> ls_slipno) then
		if ( ldc_itempay > 0 ) then
			this.of_additemdesc( as_coopid ,  is_vcrcvtrndocno, ls_itemtype, ls_tmpvcgrp, ls_accid  , ls_accside, ldc_itempay, "", ll_sortacc, ids_vcrcvpaydet)
		end if
		// รายการฝั่งตรงข้าม
		if (ldc_total > 0) then
			this.of_additem( as_coopid , is_vcrcvtrndocno ,"TRN", "TRN", ls_tofromaccid , ls_accrevside, ldc_total  , 1, ids_vcrcvpaydet  , as_userid )
		end if
	end if
	if 	( ldc_itempay > 0 ) then	
		this.of_additem( as_coopid , is_vcrcvtrndocno ,"TRN", "TRN", ls_accid_clc , ls_accrevside, ldc_prinpay  , 1, ids_vcrcvpaydet  , as_userid )
	end if

	if ( ldc_int > 0 ) then
		this.of_additemdesc( as_coopid ,  is_vcrcvtrndocno, ls_itemtype, ls_tmpvcgrp, ls_accintid , ls_accrevside, ldc_int, "", ll_sortacc, ids_vcrcvpaydet)
	end if
	
end if
	
	// Update สถานะการผ่าน Voucher
	if	ls_slipno	<> ls_slipno_bf		then
		update		slslippayout
		set				posttovc_flag		= 1,	
						voucher_no			= :is_vcrcvtrndocno
		where		( payoutslip_no		= :ls_slipno ) and
						(memcoop_id		= :as_coopid) and
						(coop_id				= :ls_coopid)

		using     itr_sqlca   ;							
	end if
	
	ls_accid_bf		= ls_accid
	ls_accintid_bf	= ls_accintid
	ls_slipno_bf		= ls_slipno
	ls_loangroup_bf	= ls_loangroup
	
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

private function integer of_vctrndprcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception;/***********************************************************
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
</usage> 
***********************************************************/

string			ls_slipno, ls_mapacc, ls_accid, ls_accintarrid, ls_colname, ls_colsort, ls_date, ls_month
string			ls_accside, ls_accrevside, ls_vcdocno, ls_tmpsystem, ls_tmpvcgrp
string			ls_moneygrp, ls_depttype, ls_itemtype, ls_tofromaccid, ls_docno, ls_year
string			ls_branchid,ls_branchorigin,ls_acccr_id,ls_accdr_id,ls_desc,ls_oldbranchid
integer		li_slipflag,ll_seqno,ll_find,li_flag
long			ll_index, ll_count, ll_sortacc, ll_sortintarr
dec{2}		ldc_itempay, ldc_intarrpay
datetime		ldtm_operate
string			ls_depttype_group, ls_vcrcvdocno, ls_cash, ls_depttype_code, ls_vc_desc, ls_voucher_type
string			ls_accid_bf, ls_refsystem, ls_depttype_group_temp , as_vcdocno , ls_itemdesc
string			ls_coopid , ls_deptcoopid, ls_acccash, ls_depttype_bf, ls_itemtype_bf, ls_recppay

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_trndprcv"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpsystem		= "DEP"
ls_tmpvcgrp			= "DAY"
ls_accid_bf 			= ""
//is_vcrcvtrndocno	= ""

	 if  is_vcrcvtrndocno = ""  then
			ls_voucher_type	= "JV"	
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , "รายการโอน", 0 , ids_vcrcvpay , 'TRN'  , as_coopid,   as_userid )		
		else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 


for ll_index = 1 to ll_count
	
	ls_coopid					= lds_slipdata.object.coop_id[ ll_index ]
	ls_deptcoopid			= lds_slipdata.object.deptcoop_id[ ll_index ]
	ls_slipno					= lds_slipdata.object.deptslip_no[ ll_index ]
	ls_itemtype				= lds_slipdata.object.recppaytype_code[ ll_index ]
	ls_moneygrp			= lds_slipdata.object.moneytype_group[ ll_index ]
	ls_depttype				= lds_slipdata.object.depttype_code[ ll_index ]
	ls_tofromaccid			= lds_slipdata.object.tofrom_accid[ ll_index ]
	ls_mapacc				= lds_slipdata.object.accmap_code[ ll_index ]
	ldc_itempay				= lds_slipdata.object.deptslip_netamt[ ll_index ]
	ls_desc					= trim(lds_slipdata.object.compute_3[ ll_index ])
	ls_recppay				= lds_slipdata.object.recppaytype_code[ ll_index ]  
		
//	if isnull (ls_tofromaccid)  then ls_tofromaccid = '000000'	

	// ตรวจว่าเป็นรายการเกี่ยวกับอะไร
choose case ls_mapacc
		case "AIT"
			ls_accintarrid	= string( of_getattribmapaccid( as_coopid , "DEP", "DEP", ls_depttype, 1, "accintarr_id"  ) )
			ll_sortintarr		= long( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, "sortintarr_order" ) )
			ldc_itempay		= ldc_itempay 
			ls_colname		= "accint_id"
			ls_colsort		= "sortint_order"
		case "ATX"
			ls_colname		= "acctax_id"
			ls_colsort		= "sorttax_order"
		case else
			ls_colname		= "account_id"
			ls_colsort		= "sortacc_order"			
	end choose
	
	ls_accid				= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, ls_colname  ) )
	ll_sortacc			= long( of_getattribmapaccid( as_coopid , "DEP", "DEP", ls_depttype, 1, ls_colsort  ) )	
	
	if( trim(ls_recppay) = 'INT' ) then  //ทำเงื่อนไขเพื่อให้รายการพวกที่เป็นรายการถอนดอกเบี้ยมาเข้าเงินฝากลงให้ถูกฝั่ง DR CR  //Edit by Mike 03/04/2014
		ls_accside			= "DR"
		ls_accrevside		= "CR"
	else
		ls_accside			= "CR"
		ls_accrevside		= "DR"	
	end if
	
					
	// รายการเงินฝาก
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid ,is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, "", ll_sortacc, ids_vcrcvpaydet)
	end if
	
	/// รายการฝั่งตรงข้าม
	if 	( ldc_itempay > 0 ) then
		this.of_additem( as_coopid ,is_vcrcvtrndocno,"TRN", "TRN", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcrcvpaydet  , as_userid )
	end if
	
	//update สถานะการดึงข้อมูล
	if	not isnull(is_vcrcvtrndocno)    	then
		update	dpdeptslip
		set			posttovc_flag	= 1,	
					voucher_no		= :is_vcrcvtrndocno
		where	( deptslip_no	= :ls_slipno ) and
					( coop_id 		= :as_coopid)
		using itr_sqlca;
	end if
	
	ls_accid_bf 						= ls_accid
	ls_depttype_group_temp		= ls_depttype_group
	ls_depttype_bf					= ls_depttype
	ls_itemtype_bf					= ls_itemtype
	
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

private function integer of_vctrndppay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception;/***********************************************************
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
</usage> 
***********************************************************/
string			ls_slipno, ls_accid, ls_accintarrid, ls_mapacc, ls_colname, ls_colsort, ls_month, ls_date
string			ls_accside, ls_accrevside, ls_vcdocno, ls_tmpsystem, ls_tmpvcgrp, ls_feeid
string			ls_moneygrp, ls_depttype, ls_itemtype, ls_tofromaccid, ls_docno, ls_year
string			s_acccr_id,ls_accdr_id,ls_branchid,ls_branchorigin,ls_desc,ls_oldbranchid,ls_cash
integer		li_slipflag,ll_find,li_flag, li_payfee_meth
long			ll_index, ll_count, ll_sortacc, ll_sortintarr, ll_index2
dec{2}		ldc_itempay, ldc_intarrpay,ldc_prncbal,ldc_int_amt,ldc_accuint_amt, ldc_intreturn, ldc_slipnetamt
string			ls_deptgroupcode, ls_itemgroup, ls_accid_bf, ls_depttype_code, ls_vc_desc, ls_itemdesc  
string			ls_depttype_group, ls_refsystem, ls_depttype_group_temp, ls_voucher_type , ls_vc_type , as_vcdocno
dec{2}		ldc_other_amt, ldc_intbfyear , ldc_itempaynet, ldc_tax_return, ldc_tax, ldc_orther
datetime		ldtm_operate
string			ls_accid_old, ls_acccash, ls_depttype_bf, ls_itemtype_bf, ls_accint, ls_acctax

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	="d_vc_slip_data_trndppay"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpsystem					= "DEP"
ls_tmpvcgrp						= "DAY"
ls_depttype_group_temp		= ""
ls_accid_bf 						= ""
ll_index2							=	1
//is_vcrcvtrndocno				= ""
//สร้างเลข Voucher
	 if  is_vcrcvtrndocno = ""   then
			ls_voucher_type	= "JV"	
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , "รายการโอน", 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
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
	ldc_orther				=  lds_slipdata.object.other_amt[ ll_index ]  //ค่าปรับเงินฝาก
	
//	if isnull (ls_tofromaccid)  then ls_tofromaccid = '000000'	
	if isnull( ldc_orther ) then ldc_orther = 0
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
	ls_feeid				= string( of_getattribmapaccid( as_coopid ,"DEP", "FEE", "00", 1,  "account_id"  ) ) //ค่าปรับ
	
	ls_accside		= "DR"
	ls_accrevside	= "CR"	
	
//	choose case ls_itemtype
//		case "FEE"
//			ls_accid = '4200300'
//			ls_accside		= "CR"
//			ls_accrevside	= "DR"	
//		case "WFS"
//			ls_accid = '3100100'
//			ls_accside		= "CR"
//			ls_accrevside	= "DR"
//		case else
//			ls_accid = ls_accid
//	end choose
		

	//รายการถอน
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, "", ll_sortacc, ids_vcrcvpaydet )
	end if
	if (ldc_int_amt > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accint, ls_accside, ldc_int_amt, "", ll_sortacc, ids_vcrcvpaydet )
	end if
	if (ldc_tax_return > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_acctax, ls_accside, ldc_tax_return, "", ll_sortacc, ids_vcrcvpaydet )
	end if
	
	
	// รายการฝั่งตรงข้าม
	if 	( ldc_itempaynet > 0 ) then
		this.of_additem( as_coopid , is_vcrcvtrndocno,"TRN", "TRN", ls_tofromaccid , ls_accrevside, ldc_itempaynet  , 1, ids_vcrcvpaydet  , as_userid )
	end if
	if 	( ldc_intreturn > 0 ) then
		this.of_additem( as_coopid , is_vcrcvtrndocno,"TRN", "TRN", ls_accintarrid , ls_accrevside, ldc_intreturn  , 1, ids_vcrcvpaydet  , as_userid )
	end if
	if 	( ldc_tax > 0 ) then
		this.of_additem( as_coopid , is_vcrcvtrndocno,"TRN", "TRN", ls_acctax , ls_accrevside, ldc_tax  , 1, ids_vcrcvpaydet  , as_userid )
	end if
	if( ldc_orther > 0 ) then
		this.of_additem( as_coopid , is_vcrcvtrndocno,"TRN", "TRN", ls_feeid , ls_accrevside, ldc_orther  , 1, ids_vcrcvpaydet  , as_userid )
	end if
	
	// Update สถานะการผ่าน Voucher
	if	not isnull(is_vcrcvtrndocno)    	then
		update	dpdeptslip
		set			posttovc_flag	= 1,	
					voucher_no		= :is_vcrcvtrndocno
		where	( deptslip_no	= :ls_slipno ) and
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

private function integer of_vctrn_kpmth_dprcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception;/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> ฝาก + เปิดบัญชี เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/

string			ls_slipno, ls_mapacc, ls_accid, ls_accintarrid, ls_colname, ls_colsort, ls_date, ls_month
string			ls_accside, ls_accrevside, ls_vcdocno, ls_tmpsystem, ls_tmpvcgrp
string			ls_moneygrp, ls_depttype, ls_itemtype, ls_tofromaccid, ls_docno, ls_year
string			ls_branchid,ls_branchorigin,ls_acccr_id,ls_accdr_id,ls_desc,ls_oldbranchid
integer		li_slipflag,ll_seqno,ll_find,li_flag
long			ll_index, ll_count, ll_sortacc, ll_sortintarr
dec{2}		ldc_itempay, ldc_intarrpay
datetime		ldtm_operate
string			ls_depttype_group, ls_vcrcvdocno, ls_cash, ls_depttype_code, ls_vc_desc, ls_voucher_type
string			ls_accid_bf, ls_refsystem, ls_depttype_group_temp , as_vcdocno , ls_itemdesc
string			ls_coopid , ls_deptcoopid, ls_acccash, ls_depttype_bf, ls_itemtype_bf

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_kp_trndprcv_tks"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpsystem		= "DEP"
ls_tmpvcgrp			= "MTH"
ls_accid_bf 			= ""
is_vcrcvtrndocno	= ""

	 if  is_vcrcvtrndocno = ""  then
			ls_voucher_type	= "JV"	
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , "รายการฝากจัดเก็บประจำเดือน", 0 , ids_vcrcvpay , 'TRN'  , as_coopid,   as_userid )		
		else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 


for ll_index = 1 to ll_count
	
	ls_coopid					= lds_slipdata.object.coop_id[ ll_index ]
	ls_deptcoopid			= lds_slipdata.object.deptcoop_id[ ll_index ]
	ls_slipno					= lds_slipdata.object.deptslip_no[ ll_index ]
	ls_itemtype				= lds_slipdata.object.recppaytype_code[ ll_index ]
	ls_moneygrp			= lds_slipdata.object.moneytype_group[ ll_index ]
	ls_depttype				= lds_slipdata.object.depttype_code[ ll_index ]
	ls_tofromaccid			= lds_slipdata.object.tofrom_accid[ ll_index ]
	ls_mapacc				= lds_slipdata.object.accmap_code[ ll_index ]
	ldc_itempay				= lds_slipdata.object.deptslip_netamt[ ll_index ]
	ls_desc					= trim(lds_slipdata.object.compute_3[ ll_index ])
		
//	if isnull (ls_tofromaccid)  then ls_tofromaccid = '000000'	

	// ตรวจว่าเป็นรายการเกี่ยวกับอะไร
choose case ls_mapacc
		case "AIT"
			ls_accintarrid	= string( of_getattribmapaccid( as_coopid , "DEP", "DEP", ls_depttype, 1, "accintarr_id"  ) )
			ll_sortintarr		= long( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, "sortintarr_order" ) )
			ldc_itempay		= ldc_itempay 
			ls_colname		= "accint_id"
			ls_colsort		= "sortint_order"
		case "ATX"
			ls_colname		= "acctax_id"
			ls_colsort		= "sorttax_order"
		case else
			ls_colname		= "account_id"
			ls_colsort		= "sortacc_order"			
	end choose
	
	ls_accid				= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, ls_colname  ) )
	ll_sortacc			= long( of_getattribmapaccid( as_coopid , "DEP", "DEP", ls_depttype, 1, ls_colsort  ) )	
	
		ls_accside			= "CR"
		ls_accrevside		= "DR"	
		
		
			
	// รายการเงินฝาก
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid ,is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, "", ll_sortacc, ids_vcrcvpaydet)
	end if
	
	/// รายการฝั่งตรงข้าม
	if 	( ldc_itempay > 0 ) then
		this.of_additem( as_coopid ,is_vcrcvtrndocno,"TRN", "TRN", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcrcvpaydet  , as_userid )
	end if
	
	//update สถานะการดึงข้อมูล
	if	not isnull(is_vcrcvtrndocno)    	then
		update	dpdeptslip
		set			posttovc_flag	= 1,	
					voucher_no		= :is_vcrcvtrndocno
		where	( deptslip_no	= :ls_slipno ) and
					( coop_id 		= :as_coopid)
		using itr_sqlca;
	end if
	
	ls_accid_bf 						= ls_accid
	ls_depttype_group_temp		= ls_depttype_group
	ls_depttype_bf					= ls_depttype
	ls_itemtype_bf					= ls_itemtype
	
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

private function integer of_vctrn_kpmth_dppay (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception;/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> ถอน + ปิดบัญชี แยกดอกเบี้ย เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/
string			ls_slipno, ls_accid, ls_accintarrid, ls_mapacc, ls_colname, ls_colsort, ls_month, ls_date
string			ls_accside, ls_accrevside, ls_vcdocno, ls_tmpsystem, ls_tmpvcgrp
string			ls_moneygrp, ls_depttype, ls_itemtype, ls_tofromaccid, ls_docno, ls_year
string			s_acccr_id,ls_accdr_id,ls_branchid,ls_branchorigin,ls_desc,ls_oldbranchid,ls_cash
integer		li_slipflag,ll_find,li_flag, li_payfee_meth
long			ll_index, ll_count, ll_sortacc, ll_sortintarr, ll_index2
dec{2}		ldc_itempay, ldc_intarrpay,ldc_prncbal,ldc_int_amt,ldc_accuint_amt, ldc_intreturn, ldc_slipnetamt
string			ls_deptgroupcode, ls_itemgroup, ls_accid_bf, ls_depttype_code, ls_vc_desc, ls_itemdesc  
string			ls_depttype_group, ls_refsystem, ls_depttype_group_temp, ls_voucher_type , ls_vc_type , as_vcdocno
dec{2}		ldc_other_amt, ldc_intbfyear , ldc_itempaynet, ldc_tax_return, ldc_tax
datetime		ldtm_operate
string			ls_accid_old, ls_acccash, ls_depttype_bf, ls_itemtype_bf, ls_accint, ls_acctax

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	="d_vc_slip_data_kp_trndppay_tks"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpsystem					= "DEP"
ls_tmpvcgrp						= "MTH"
ls_depttype_group_temp		= ""
ls_accid_bf 						= ""
ll_index2							=	1
is_vcrcvtrndocno				= ""

	 if  is_vcrcvtrndocno = ""   then
			ls_voucher_type	= "JV"	
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , "รายการถอนจัดเก็บประจำเดือน", 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
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
	
	choose case ls_itemtype
		case "FEE"
			ls_accid = '42003000'
			ls_accside		= "CR"
			ls_accrevside	= "DR"	
		case "WFS"
			ls_accid = '31001000'
			ls_accside		= "CR"
			ls_accrevside	= "DR"
		case else
			ls_accid = ls_accid
	end choose
		


	//รายการถอน
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, "", ll_sortacc, ids_vcrcvpaydet )
	end if
	if (ldc_int_amt > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accint, ls_accside, ldc_int_amt, "", ll_sortacc, ids_vcrcvpaydet )
	end if
	if (ldc_tax_return > 0) then
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_acctax, ls_accside, ldc_tax_return, "", ll_sortacc, ids_vcrcvpaydet )
	end if
	
	
	// รายการฝั่งตรงข้าม
	if 	( ldc_itempaynet > 0 ) then
		this.of_additem( as_coopid , is_vcrcvtrndocno,"TRN", "TRN", ls_tofromaccid , ls_accrevside, ldc_itempaynet  , 1, ids_vcrcvpaydet  , as_userid )
	end if
	if 	( ldc_intreturn > 0 ) then
		this.of_additem( as_coopid , is_vcrcvtrndocno,"TRN", "TRN", ls_accintarrid , ls_accrevside, ldc_intreturn  , 1, ids_vcrcvpaydet  , as_userid )
	end if
	if 	( ldc_tax > 0 ) then
		this.of_additem( as_coopid , is_vcrcvtrndocno,"TRN", "TRN", ls_acctax , ls_accrevside, ldc_tax  , 1, ids_vcrcvpaydet  , as_userid )
	end if
	
	
	
	
	// Update สถานะการผ่าน Voucher
	if	not isnull(is_vcrcvtrndocno)    	then
		update	dpdeptslip
		set			posttovc_flag	= 1,	
					voucher_no		= :is_vcrcvtrndocno
		where	( deptslip_no	= :ls_slipno ) and
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
	ประมวลผลดึงรายการบัญชี   ==> ฝาก + เปิดบัญชี เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/

string			ls_slipno, ls_mapacc, ls_accid, ls_accintarrid, ls_colname, ls_colsort, ls_date, ls_month
string			ls_accside, ls_accrevside, ls_vcdocno, ls_tmpsystem, ls_tmpvcgrp
string			ls_moneygrp, ls_depttype, ls_itemtype, ls_tofromaccid, ls_docno, ls_year
string			ls_branchid,ls_branchorigin,ls_acccr_id,ls_accdr_id,ls_desc,ls_oldbranchid
integer		li_slipflag,ll_seqno,ll_find,li_flag
long			ll_index, ll_count, ll_sortacc, ll_sortintarr, ll_index2
dec{2}		ldc_itempay, ldc_intarrpay
datetime		ldtm_operate
string			ls_depttype_group, ls_vcrcvdocno, ls_cash, ls_depttype_code, ls_vc_desc, ls_voucher_type
string			ls_accid_bf, ls_refsystem, ls_depttype_group_temp , as_vcdocno , ls_itemdesc
string			ls_coopid , ls_deptcoopid, ls_acccash, ls_depttype_bf

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cashdprcv_fee_tks"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpsystem		= "DEP"
ls_tmpvcgrp			= "DAY"
ls_accid_bf 			= ""
ll_index2				= 1	
//is_vcrcvdocno		= ""

if  is_vcrcvdocno = ""  then
			ls_voucher_type	= "RV"
			is_vcrcvdocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvdocno , as_coopid  )
			this.of_addvoucher( is_vcrcvdocno , adtm_vcdate , ls_voucher_type , "เงินสดรับประจำวัน(การเงิน)", 0 , ids_vcrcv , 'CSH'  , as_coopid,   as_userid )		
		else
			ids_vcrcv.retrieve( is_vcrcvdocno )
			ids_vcrcvdet.retrieve( is_vcrcvdocno )
	 end if 	

for ll_index = 1 to ll_count
	
	ls_coopid					= lds_slipdata.object.coop_id[ ll_index ]
	ls_deptcoopid			= lds_slipdata.object.deptcoop_id[ ll_index ]
	ls_slipno					= lds_slipdata.object.deptslip_no[ ll_index ]
	ls_itemtype				= lds_slipdata.object.recppaytype_code[ ll_index ]
	ls_moneygrp			= lds_slipdata.object.moneytype_group[ ll_index ]
	ls_depttype				= lds_slipdata.object.depttype_code[ ll_index ]
	ls_tofromaccid			= lds_slipdata.object.tofrom_accid[ ll_index ]
	ls_mapacc				= lds_slipdata.object.accmap_code[ ll_index ]
	ldc_itempay				= lds_slipdata.object.deptslip_netamt[ ll_index ]
	ls_desc					= trim(lds_slipdata.object.compute_3[ ll_index ])

	// ตรวจว่าเป็นรายการเกี่ยวกับอะไร
choose case ls_mapacc
		case "AIT"
			ls_accintarrid	= string( of_getattribmapaccid( as_coopid , "DEP", "DEP", ls_depttype, 1, "accintarr_id"  ) )
			ll_sortintarr		= long( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, "sortintarr_order" ) )
			ldc_itempay		= ldc_itempay 
			ls_colname		= "accint_id"
			ls_colsort		= "sortint_order"
		case "ATX"
			ls_colname		= "acctax_id"
			ls_colsort		= "sorttax_order"
		case else
			ls_colname		= "account_id"
			ls_colsort		= "sortacc_order"			
	end choose
	
	ls_accid				= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, ls_colname  ) )
	ll_sortacc				= long( of_getattribmapaccid( as_coopid , "DEP", "DEP", ls_depttype, 1, ls_colsort  ) )	
	
		ls_accside			= "CR"
		ls_accrevside		= "DR"	
		
		choose case ls_itemtype
		case "FEE"
			ls_accid 	= string( of_getattribmapaccid( as_coopid ,"DEP", "FEE", "00", 1, "account_id"  ) )
		//case "WFS"
			//ls_accid = '31010100'
		case else
			ls_accid = ls_accid
	end choose
		
		//หาบัญชีเงินสด
	select  	cash_account_code
	into		:ls_acccash 
	from		accconstant 
	where 	coop_id = :as_coopid
	using    	 itr_sqlca   ;	
	
	if  isnull (ls_tofromaccid ) or ls_tofromaccid <>  ls_acccash then
		ls_tofromaccid		= 	ls_acccash
	end if
	
//	if  ls_depttype_bf = ls_depttype then
		ls_itemdesc  = string ( ll_count ) + '  รายการ'
//		ll_index2 = ll_index2 + 1
//	else
//		ll_index2	=	1
//		ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
//		ll_index2 = ll_index2 + 1
//	end if

	// รายการเงินฝาก
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid ,is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, "", ll_sortacc, ids_vcrcvdet)
	end if
	
	/// รายการฝั่งตรงข้าม
	if 	( ldc_itempay > 0 ) then
		this.of_additem( as_coopid ,is_vcrcvdocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcrcvdet  , as_userid )
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
	
	ls_accid_bf 						= ls_accid
	ls_depttype_group_temp		= ls_depttype_group
	ls_depttype_bf					= ls_depttype
	
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

private function integer of_vccashdprcv (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception;/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> ฝาก + เปิดบัญชี เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
	Version 2.0 (Initial version) Modified Date 29/03/2016 by Sakuraii
</usage> 
***********************************************************/

string			ls_slipno, ls_mapacc, ls_accid, ls_accintarrid, ls_colname, ls_colsort
string			ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp
string			ls_moneygrp, ls_depttype, ls_itemtype, ls_tofromaccid
string			ls_desc, ls_cash, ls_voucher_type
long			ll_index, ll_count, ll_sortacc
dec{2}			ldc_itempay, ldc_intarrpay
string			ls_coopid , ls_deptcoopid, ls_acccash

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cashdprcv_tks"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpsystem		= "DEP"
ls_tmpvcgrp			= "DAY"
is_vcrcvdocno		= ""

if  is_vcrcvdocno = ""  then
			ls_voucher_type	= "RV"
			is_vcrcvdocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvdocno , as_coopid  )
			this.of_addvoucher( is_vcrcvdocno , adtm_vcdate , ls_voucher_type , "รับฝากเงินสดประจำวัน", 0 , ids_vcrcv , 'CSH'  , as_coopid,   as_userid )		
		else
			ids_vcrcv.retrieve( is_vcrcvdocno )
			ids_vcrcvdet.retrieve( is_vcrcvdocno )
	 end if 	

for ll_index = 1 to ll_count
	
	ls_coopid				= lds_slipdata.object.coop_id[ ll_index ]
	ls_deptcoopid			= lds_slipdata.object.deptcoop_id[ ll_index ]
	ls_slipno				= lds_slipdata.object.deptslip_no[ ll_index ]
	ls_itemtype				= lds_slipdata.object.recppaytype_code[ ll_index ]
	ls_moneygrp				= lds_slipdata.object.moneytype_group[ ll_index ]
	ls_depttype				= lds_slipdata.object.depttype_code[ ll_index ]
	ls_tofromaccid			= lds_slipdata.object.tofrom_accid[ ll_index ]
	ls_mapacc				= lds_slipdata.object.accmap_code[ ll_index ]
	ldc_itempay				= lds_slipdata.object.deptslip_netamt[ ll_index ]
	//ls_desc					= trim(lds_slipdata.object.compute_3[ ll_index ])
	ls_desc					= ""
	
	if IsNull(ldc_itempay) then ldc_itempay = 0
	if IsNull(ls_coopid) or ls_coopid = "" then ls_coopid = as_coopid

	// ตรวจว่าเป็นรายการเกี่ยวกับอะไร
choose case ls_mapacc
		case "AIT"
			ls_accintarrid	= string( of_getattribmapaccid( as_coopid , "DEP", "DEP", ls_depttype, 1, "accintarr_id"  ) )
			ldc_itempay		= ldc_itempay 
			ls_colname		= "accint_id"
			ls_colsort		= "sortint_order"
		case "ATX"
			ls_colname		= "acctax_id"
			ls_colsort		= "sorttax_order"
		case else
			ls_colname		= "account_id"
			ls_colsort		= "sortacc_order"			
	end choose
	
	ls_accid				= string( of_getattribmapaccid( as_coopid ,"DEP", "DEP", ls_depttype, 1, ls_colname  ) )
	ll_sortacc			= long( of_getattribmapaccid( as_coopid , "DEP", "DEP", ls_depttype, 1, ls_colsort  ) )	
	
		ls_accside			= "CR"
		ls_accrevside		= "DR"	
		
		//หาบัญชีเงินสด
	select  	cash_account_code
	into		:ls_acccash 
	from		accconstant 
	where 	coop_id = :as_coopid
	using    	 itr_sqlca   ;	
	
	if  isnull (ls_tofromaccid ) or ls_tofromaccid <>  ls_acccash then
		ls_tofromaccid		= 	ls_acccash
	end if
	
		//ตรวจสอบสาขา
	choose case ls_coopid
	case '018002' //สาขาปัว
		ls_desc = ls_desc + is_coop_decs
	case else
		ls_desc = ls_desc
	end choose
	
	//if  ls_depttype_bf = ls_depttype then
		//ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
		//ll_index2 = ll_index2 + 1
	//else
		//ll_index2	=	1
		//ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
		//ll_index2 = ll_index2 + 1
	//end if

	// รายการเงินฝาก
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( as_coopid ,is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, ls_desc, ll_sortacc, ids_vcrcvdet)
	end if
	
	/// รายการฝั่งตรงข้าม
	if 	( ldc_itempay > 0 ) then
		this.of_additem( as_coopid ,is_vcrcvdocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcrcvdet  , as_userid )
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

public function integer of_vcproc_nan (datetime adtm_sysdate, string as_sysgencode, string as_coopid, string as_userid) throws Exception;/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/
string			ls_coopid ,  ls_userid , ls_sysgencode 
integer		li_shrcv, li_lnrcv, li_lnrcv_clc, li_dprcv, li_finrcv, li_shpay, li_lnpay, li_dppay, li_finpay
integer		li_chk, li_row  , li_count , li_trn_shrrcv , li_trn_shrpay
datetime		ldtm_vcdate
boolean		lb_genamt
integer		li_trn_dprcv, li_trn_dppay, li_trnfinrcv, li_trnfinpay,  li_trnpayout, li_keepmonth, li_trnpayin_shr


ldtm_vcdate			=  adtm_sysdate
ls_sysgencode		=  as_sysgencode
ls_coopid				=	trim ( as_coopid )   
ls_userid				=  trim ( as_userid  ) 
choose case ls_sysgencode
	case "ALL"	// ทั้งหมด ##	
		li_shrcv	=	1
		li_shpay	=	1
		li_lnrcv	=	1
		li_lnpay	=	1
		li_finrcv	=	1
		li_finpay	=	1
		li_dprcv	=	1	
		li_dppay	=	1
		li_trn_dprcv	=	1
		li_trn_dppay	=	1
		li_trnfinrcv	=	1
		li_trnfinpay	=	1
		li_trnpayin_shr = 1
		li_trnpayout	=	1
		li_trn_shrrcv=1
		li_trn_shrpay=1

	case  "ANC" //ทั้งหมดยกเว้นเงินสด ##
		li_trn_dprcv	=	1
		li_trn_dppay	=	1
		li_trnfinrcv	=	1
		li_trnfinpay	=	1
		li_trnpayout	=	1
		li_trnpayin_shr	= 1
		li_trn_shrrcv=1
		li_trn_shrpay=1

	case "CSH"  //เงินสด ##
		li_shrcv	=	1
		li_shpay	=	1
		li_lnrcv	=	1
		li_lnrcv_clc	=	1
		li_lnpay	=	1
		li_finrcv	=	1
		li_finpay	=	1
		li_dprcv	=	1	
		li_dppay	=	1

	case "LON"
		li_lnrcv	=	1
		li_lnrcv_clc	=	1
		li_lnpay	=	1
		li_trnpayout	=	1
		
	case "SHR"
		li_shrcv	=	1
		li_shpay	=	1
		li_trnpayin_shr	= 1
		li_trn_shrrcv=1
		li_trn_shrpay=1
		
	case "DEP"
		li_dprcv	=	1	
		li_dppay	=	1
		li_trn_dprcv	=	1
		li_trn_dppay	=	1

	case "FIN"		
		li_finrcv	=	1
		li_finpay	=	1
		li_trnfinrcv	=	1
		li_trnfinpay	=	1
		
	case "KEP"
		li_keepmonth = 1
		
end choose		

//+++++++++++++++++++++++++++++++++++++++++++++
//รายการรับเงินสด  ===CSH
//+++++++++++++++++++++++++++++++++++++++++++++

if li_lnrcv = 1 then
//รับชำระเงินสด + หุ้น + ค่าธรรมเนียม
li_chk = this.of_vccashlnrcv_shr( ldtm_vcdate , ls_coopid  , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
end if
	
	if li_dprcv = 1 then
//รายการเงินฝาก
li_chk = this.of_vccashdprcv( ldtm_vcdate ,ls_coopid ,  ls_userid ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
end if 

if li_finrcv = 1 then
//การเงินรับ
li_chk = this.of_vccashfinrcv( ldtm_vcdate ,ls_coopid ,  ls_userid ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
	
	//รับค่าปรับเงินฝาก
	li_chk = this.of_vccashdprcv_fee( ldtm_vcdate ,ls_coopid ,  ls_userid ) 
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
	
		//รับค่าธรรมเนียมแรกเข้า
	//li_chk = this.of_vccashfinrcv_fee(ldtm_vcdate ,ls_coopid ,  ls_userid ) 
	//if li_chk = 1 then
		//lb_genamt = true
	//else
		//rollback using itr_sqlca ;
		//throw ithw_exception
	//end if	
	
if li_shrcv = 1 then
	//ซื้อหุ้นเงินสด 
//li_chk = this.of_vccashshrcv( ldtm_vcdate , ls_coopid  , ls_userid  ) 
	//if li_chk = 1 then
		//lb_genamt = true
	//else
		//rollback using itr_sqlca ;
		//throw ithw_exception
	//end if	
end if
	
end if

//+++++++++++++++++++++++++++++++++++++++++++++
//รายการจ่ายเงินสด  ====CSH
//+++++++++++++++++++++++++++++++++++++++++++++
if li_lnpay  = 1 then	
//จ่ายเงินกู้ เงินสด ##
	li_chk = this.of_vccashlnpay ( ldtm_vcdate , ls_coopid , ls_userid  )  
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
	end if
	
if li_dppay=1 then	
//ถอนเงินรวมปิดบัญชี  ##
	li_chk = this.of_vccashdppay( ldtm_vcdate ,ls_coopid ,  ls_userid ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
	end if	
	
if li_finpay=1 then
//การเงินจ่ายของสหกรณ์
li_chk = this.of_vccashfinpay( ldtm_vcdate ,ls_coopid ,  ls_userid ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if
		end if
		
if li_shpay =1 then		
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
if li_trnpayin_shr = 1 then	//รับชำระหนี้ ##   (กรมที่ดิน)
li_chk = this.of_vctrnpayin_shr( ldtm_vcdate , ls_coopid  , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
		end if	
	
if li_trnpayout = 1 then		//จ่ายเงินกู้ + หักกลบ##
li_chk = this.of_vctrnpayout( ldtm_vcdate , ls_coopid  , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
		end if
		
if li_trn_dprcv = 1 then		//	โอนเงินรับฝาก
li_chk = this.of_vctrndprcv( ldtm_vcdate , ls_coopid  , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
		end if	
	
if li_trn_dppay =1 then	//	ถอนเงินรับฝาก
li_chk = this.of_vctrndppay( ldtm_vcdate , ls_coopid  , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
		end if	
		
if li_trn_shrrcv =1 then //โอนเงินซื้อหุ้น
li_chk = this.of_vctrnshrrcv( ldtm_vcdate , ls_coopid  , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
end if 
	
if li_trn_shrpay =1 then
// คืนค่าหุ้น
li_chk = this.of_vctrnshrpay( ldtm_vcdate , ls_coopid  , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
	end if 
	
	if li_trnfinrcv = 1 then
	// การเงินรับ
li_chk = this.of_vctrnfinrcv( ldtm_vcdate , ls_coopid  , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
end if 

if li_trnfinpay =1 then
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

//if li_atm = 1 then
//		//จ่ายเงินกู้ ATM##
//li_chk = this.of_vctrnpayout_atm( ldtm_vcdate , ls_coopid  , ls_userid  ) 
//	if li_chk = 1 then
//		lb_genamt = true
//	else
//		rollback using itr_sqlca ;
//		throw ithw_exception
//	end if	
//end if


//+++++++++++++++++++++++++++++++++++++++++++++
//รายการเรียกเก็บประจำเดือน====TRN
//+++++++++++++++++++++++++++++++++++++++++++++

if 	li_keepmonth = 1 then
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
	
		
	//รายการถอนจัดเก็บประจำเดือน
	li_chk = this.of_vctrn_kpmth_dppay( ldtm_vcdate , ls_coopid , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if


	//รายการฝากจัดเก็บประจำเดือน
	li_chk = this.of_vctrn_kpmth_dprcv( ldtm_vcdate , ls_coopid , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if
end if

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
string		ls_slipno, ls_slipprior, ls_accid, ls_tofromaccid, ls_slipitem_desc, ls_acccash
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
	
		// รายการการเงิน
	if ( ldc_itempay > 0 ) then		
		this.of_additemdesc( as_coopid , is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, ls_slipitem_desc, 0, ids_vcrcvdet)
		this.of_additem( as_coopid ,is_vcrcvdocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcrcvdet  , as_userid )
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
	Version 2.0 (Initial version) Modified Date 30/03/2016 by Sakuraii
</usage> 
***********************************************************/

string		ls_slipno, ls_accid, ls_accintid, ls_accintarrid, ls_slipno_bf, ls_voucher_type
string		ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp, ls_desc, ls_itemtype_bf, ls_acccash
string		ls_shrlontype, ls_itemtype, ls_tofromaccid, ls_voucher_desc,ls_memberno
integer		li_shrlonstatus, li_slipflag, li_sort , li_sort_bf
long		ll_index, ll_count, ll_sortacc, ll_sortint
dec{2}		ldc_prinpay, ldc_intpay, ldc_itempay, ldc_intarrpay, ldc_int
string		ls_coopid, ls_vcrcvdocno_bf, ls_entry_coopid
string		ls_loangroup, ls_memgroup

datastore	lds_slipdata 

// ds สำหรับเก็บการชำระหนี้
lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cashlnrcv_shr_tks"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate, as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if
	
ls_tmpsystem	= "LON" 
ls_tmpvcgrp		= "PAY"

// ชุดการรับชำระหนี้
for ll_index = 1 to ll_count

	ls_coopid			= lds_slipdata.object.coop_id[ ll_index ]
	ls_slipno			= lds_slipdata.object.payinslip_no[ ll_index ]
	ls_shrlontype		= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_memberno			= lds_slipdata.object.member_no[ ll_index ] // เพิ่ม member_no ในกรองประเภทสมาชิก by eaw
	ls_itemtype			= lds_slipdata.object.slipitemtype_code[ ll_index ]
	ls_tofromaccid		= lds_slipdata.object.tofrom_accid[ ll_index ]
	li_shrlonstatus		= lds_slipdata.object.bfcontlaw_status[ ll_index ]
	li_slipflag			= lds_slipdata.object.sliptypesign_flag[ ll_index ]
	ldc_itempay			= lds_slipdata.object.item_payamt[ ll_index ]
	ldc_prinpay			= lds_slipdata.object.principal_payamt[ ll_index ]
	ldc_int				= lds_slipdata.object.interest_payamt[ ll_index ]
	ldc_intarrpay		= lds_slipdata.object.intarrear_payamt[ ll_index ]
	ls_memgroup			= lds_slipdata.object.membgroup_code[ ll_index ]
	li_sort				= lds_slipdata.object.sort_order[ ll_index ]
	ls_entry_coopid		= lds_slipdata.object.entry_bycoopid[ ll_index ] //ใช้แยกยอดของสาขา
	ls_desc				= ""
							
		
	if isnull( ldc_intpay ) then ldc_intpay = 0
	if isnull( ldc_prinpay ) then ldc_prinpay = 0
	if isnull( ldc_intarrpay ) then ldc_intarrpay = 0
	if isnull( li_shrlonstatus) then li_shrlonstatus = 1
	if IsNull(ls_shrlontype ) or ls_shrlontype = "" then ls_shrlontype = '00' 
	
	if(ls_itemtype = 'SHR') then 
		li_shrlonstatus = 1
	end if
	if(ls_itemtype = 'FEE') then ls_itemtype = 'FFE'
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
	
	//หาบัญชีเงินสด
	select  	cash_account_code
	into		:ls_acccash 
	from		accconstant 
	where 		coop_id = :as_coopid
	using    	 itr_sqlca   ;	
	
	if  isnull (ls_tofromaccid ) or ls_tofromaccid <>  ls_acccash then
		ls_tofromaccid		= 	ls_acccash
	end if
	
	//สร้างเลขที่ Voucher
 if  li_sort <> li_sort_bf  then
		
		ls_voucher_type	= "RV"
		
		choose case ls_itemtype
			case "LON","FFE"
				ls_voucher_desc  				= "เงินสดรับประจำวัน"		
			case "SHR"
				ls_voucher_desc  				= "สมาชิกซื้อหุ้นเพิ่ม"		
			case else
				ls_voucher_desc					= "รับชำระอื่นๆ"
		end choose
				
		is_vcrcvdocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvdocno , as_coopid  )
	
		this.of_addvoucher( is_vcrcvdocno , adtm_vcdate , ls_voucher_type ,  ls_voucher_desc, 0 , ids_vcrcv , 'CSH'  , as_coopid  , as_userid )		
	else
		ids_vcrcv.retrieve( is_vcrcvdocno )
		ids_vcrcvdet.retrieve( is_vcrcvdocno )
 end if 	
 
 //ตรวจสอบสาขา
	choose case ls_entry_coopid
	case '018002' //สาขาปัว
		ls_desc = ls_desc + is_coop_decs
	case else
		ls_desc = ls_desc
	end choose
	
	/////////////////////////////////////////////////////////
	/////////hard code น่าน  แยก สามัญ สมทบ ///////// by anu
		if(left(ls_memberno,3) <> '00S' ) and ls_itemtype = 'SHR' then
			ls_accid = "31110100" //สามัญ
			end if 
			if(left(ls_memberno,3) = '00S' ) and ls_itemtype = 'SHR' then
			ls_accid = "31110200" //สมทบ
			end if 
		  
				
				//////////////////////////////////////////////
// เงินต้น
		if ( ldc_prinpay > 0 ) then				
			this.of_additemdesc( as_coopid ,is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_prinpay, ls_desc, ll_sortacc, ids_vcrcvdet)
			this.of_additem( as_coopid , is_vcrcvdocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_prinpay  , 1, ids_vcrcvdet  , as_userid )
		end if
		
		// ดอกเบี้ย	o
		if ( ldc_int > 0 ) then
			this.of_additemdesc( as_coopid ,is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accintid, ls_accside, ldc_int, ls_desc, ll_sortacc, ids_vcrcvdet)
			this.of_additem( as_coopid , is_vcrcvdocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_int  , 1, ids_vcrcvdet  , as_userid )
		end if
		
		// ดอกเบี้ยค้าง
		if ( ldc_intarrpay > 0 ) then
			this.of_additemdesc( as_coopid ,is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accintarrid, ls_accside, ldc_intarrpay, ls_desc, ll_sortacc, ids_vcrcvdet)
			this.of_additem( as_coopid , is_vcrcvdocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_intarrpay  , 1, ids_vcrcvdet  , as_userid )
		end if	
		
				//รายการชำระหักอื่น ๆ
		if ( ldc_itempay > 0 and  ldc_prinpay = 0 and ldc_int = 0 ) then
			//this.of_additem( as_coopid , is_vcrcvdocno, ls_tmpsystem , ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay ,ll_sortint, ids_vcrcvdet  , as_userid )
			this.of_additemdesc( as_coopid ,is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, ls_desc, ll_sortacc, ids_vcrcvdet)
			this.of_additem( as_coopid , is_vcrcvdocno , "CSH" , "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcrcvdet  , as_userid )
		end if
		
	// Update สถานะการผ่าน Voucher
	if	ls_slipno	<> ls_slipno_bf		then
		update			slslippayin
		set				posttovc_flag		= 1,	
						voucher_no			= :is_vcrcvdocno
		where			payinslip_no		= :ls_slipno   and 
						memcoop_id			= :as_coopid and
						coop_id				= :ls_coopid
		using    		itr_sqlca   ;							
	end if				
		
	ls_slipno_bf		= ls_slipno	
	ls_itemtype_bf		= ls_itemtype
	ls_vcrcvdocno_bf	= is_vcrcvdocno
	li_sort_bf			= li_sort
				
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

string		ls_slipno, ls_refopeno, ls_accid, ls_accintid, ls_accintarrid, ls_vc_type , ls_cash , ls_slipno_bf
string		ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp
string		ls_moneygrp, ls_shrlontype, ls_itemtype, ls_tofromaccid
string		ls_branchid,ls_mbbranch_id,ls_acccr_id,ls_accdr_id,ls_desc,ls_year,ls_vcdocno,ls_docno,ls_mbbranch_idold
integer	li_shrlonstatus, li_slipflag, li_seqno,li_flag
long		ll_index, ll_count, ll_sortacc, ll_sortint, ll_sortintarr, ll_index2
dec{2}	ldc_prinpay, ldc_intpay, ldc_itempay, ldc_intarrpay,ldc_fineamt
string		ls_shrlontypeold,ls_document_no,ls_itemdesc,ls_maxdoc,ls_mindoc, ls_date, ls_month, ls_slipitem_desc
datetime	ldtm_operate
string		ls_vc_desc, ls_loangroup_code, ls_accid_bf, ls_vcrcvdocno_prnc, ls_accintid_bf
string		ls_vcrcvdocno_int , ls_vcrcvdocno_etc , ls_voucher_type , as_vcdocno , ls_coopid, ls_memgroup

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
//is_vcrcvtrndocno = ""

 
	 if  is_vcrcvtrndocno    =  ""  then
			ls_voucher_type	= "JV"
			ls_desc  				= "รายการโอน"		
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
	
	ls_slipno				= lds_slipdata.object.payinslip_no[ ll_index ]
	ls_document_no	= lds_slipdata.object.document_no[ ll_index ]
	ls_moneygrp		= lds_slipdata.object.moneytype_group[ ll_index ]
	ls_shrlontype		= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_itemtype			= lds_slipdata.object.slipitemtype_code[ ll_index ]
	ls_tofromaccid		= lds_slipdata.object.tofrom_accid[ ll_index ]
	li_shrlonstatus		= 1
	li_slipflag				= lds_slipdata.object.sliptypesign_flag[ ll_index ]
	ldc_prinpay			= lds_slipdata.object.principal_payamt[ ll_index ]
	ldc_intpay			= lds_slipdata.object.interest_payamt[ ll_index ]
	ldc_itempay			= lds_slipdata.object.item_payamt[ ll_index ]
	ls_slipitem_desc	= trim(lds_slipdata.object.slipitem_desc[ ll_index ])
	ls_coopid				= lds_slipdata.object.coop_id[ ll_index ]
	ls_memgroup		= lds_slipdata.object.membgroup_code[ ll_index ]
		
	if isnull( ldc_intpay ) then ldc_intpay = 0
	if isnull( ldc_fineamt ) then ldc_fineamt = 0
	
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
	
	// hare_code เพื่อแยกประเภทหุ้นของสมาชิกปกติ กับ สมทบ by Mike 04/09/2013
	if(left(ls_memgroup,1) = 'S' ) and ls_itemtype = 'SHR' then
		ls_accid = "311101"  
	end if
		
		//รายการชำระหักอื่น ๆ
		if	( ldc_itempay > 0  ) then
			this.of_additem( as_coopid , is_vcrcvtrndocno, "LON" , "TRN", ls_accid, ls_accside, ldc_itempay ,1, ids_vcrcvpaydet  , as_userid )
		end if
		
		// รายการฝั่งตรงข้าม
		if	( ldc_itempay > 0  ) then
			this.of_additemdesc( as_coopid ,is_vcrcvtrndocno , "LON" , "TRN", ls_tofromaccid , ls_accrevside, ldc_itempay , "ซื้อหุ้น"  , 1, ids_vcrcvpaydet )
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

private function integer of_vctrnpayin_shr (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
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

string		ls_slipno, ls_refopeno, ls_accid, ls_accintid, ls_accintarrid, ls_vc_type , ls_cash , ls_slipno_bf,ls_itemtype_bf
string		ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp
string		ls_moneygrp, ls_shrlontype, ls_itemtype, ls_tofromaccid , ls_memberno
string		ls_branchid,ls_mbbranch_id,ls_acccr_id,ls_accdr_id,ls_desc,ls_year,ls_vcdocno,ls_docno,ls_mbbranch_idold
integer	li_shrlonstatus, li_slipflag, li_seqno,li_flag,li_group,li_group_bf
long		ll_index, ll_count, ll_sortacc, ll_sortint, ll_sortintarr, ll_index2
dec{2}	ldc_prinpay, ldc_intpay, ldc_itempay, ldc_intarrpay,ldc_fineamt, ldc_intarrear
string		ls_shrlontypeold,ls_document_no,ls_itemdesc,ls_maxdoc,ls_mindoc, ls_date, ls_month, ls_slipitem_desc
datetime	ldtm_operate
string		ls_vc_desc, ls_loangroup_code, ls_accid_bf, ls_vcrcvdocno_prnc, ls_accintid_bf
string		ls_vcrcvdocno_int , ls_vcrcvdocno_etc , ls_voucher_type , as_vcdocno , ls_coopid, ls_memgroup

datastore	lds_slipdata ,lds_countitem

// ds สำหรับเก็บการชำระหนี้
lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_trnlnrcv_shr"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate, as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if




ls_tmpvcgrp		= "PAY"
ls_accid_bf		= ''
ll_index2			=	1
// ชุดการรับชำระหนี้
for ll_index = 1 to ll_count
	
	ls_slipno			= lds_slipdata.object.payinslip_no[ ll_index ]
	ls_document_no		= lds_slipdata.object.document_no[ ll_index ]
	ls_moneygrp			= lds_slipdata.object.moneytype_group[ ll_index ] 
	ls_memberno			= lds_slipdata.object.member_no[ ll_index ] // เพิ่ม member_no ในกรองประเภทสมาชิก by eaw
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
	li_group			= lds_slipdata.object.compute_6[ ll_index ]
	ldc_intarrear		= lds_slipdata.object.intarrear_payamt[ ll_index ]
		
	if isnull( ldc_intpay ) then ldc_intpay = 0
	if isnull( ldc_prinpay ) then ldc_prinpay = 0
	if isnull( li_shrlonstatus) or li_shrlonstatus = 0  then li_shrlonstatus = 1
	
	if isnull( ldc_intarrear ) then ldc_intarrear = 0
	
	// ด/บ จ่าย - ดอกเบี้ยคืน
	ldc_intpay = ldc_intpay - ldc_intarrear
	
	
	// สร้างเลข Voucher
//is_vcrcvtrndocno = ""

//	 if  is_vcrcvtrndocno    =  ""  then
if ( li_group  <>  li_group_bf  ) then
			ls_voucher_type	= "JV"
			if(trim( ls_itemtype) = 'LON') then
				ls_desc  				= "รายการโอน"		
				else
				ls_desc  				= "รายการโอน"		
			end if
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
		else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	

	
	
	
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
	ls_itemtype_bf = ls_itemtype
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
string		ls_slipno, ls_slipprior, ls_mapacc, ls_accid, ls_accintarrid, ls_colname
string		ls_accside, ls_accrevside, ls_vcdocno, ls_tmpsystem, ls_tmpvcgrp
string		ls_moneygrp, ls_depttype, ls_itemtype, ls_tofromaccid, ls_docno, ls_year
integer	li_slipflag
long		ll_index, ll_count, ll_index2
dec{2}	ldc_itempay
string		ls_slipitem_desc, ls_accid_bf
string		ls_maxdoc, ls_mindoc,  ls_desc, ls_voucher_type , ls_cash, ls_coopid
string		ls_finno_temp,  ls_finno, ls_tofromaccid_bf , as_vcdocno , ls_itemdesc, ls_detail

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_trnfnrcv"
lds_slipdata.settransobject( itr_sqlca )

// reset 
ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_coopid  )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if


ls_tmpsystem		= "FIN"
ls_tmpvcgrp			= "DAY"
ls_accid_bf			= ""
ll_index2				=	1
//is_vcrcvtrndocno	= ""
// สร้างเลข Voucher
	 if  is_vcrcvtrndocno    =  ""  then
			ls_voucher_type	= "JV"
			ls_desc  				= "รายการโอน"		
			is_vcrcvtrndocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvtrndocno , as_coopid  )
			this.of_addvoucher( is_vcrcvtrndocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcvpay , 'TRN'  , as_coopid  , as_userid )		
		else
			ids_vcrcvpay.retrieve( is_vcrcvtrndocno )
			ids_vcrcvpaydet.retrieve( is_vcrcvtrndocno )
	 end if 	

//
for ll_index = 1 to ll_count
	ls_slipno					= trim( lds_slipdata.object.slip_no[ ll_index ] )
	ldc_itempay				= lds_slipdata.object.itempay_amt[ ll_index ]	
	ls_accid					= lds_slipdata.object.account_id[ ll_index ]
	ls_itemdesc				= trim( lds_slipdata.object.slipitem_desc[ ll_index ] )
	ls_tofromaccid			= trim( lds_slipdata.object.tofrom_accid[ ll_index ] )
	ls_finno					= ls_slipno
	ls_coopid					= lds_slipdata.object.coop_id[ ll_index ]
	ls_detail					= lds_slipdata.object.nonmember_detail[ ll_index ]
	
	ls_accside			= "CR"
	ls_accrevside		= "DR"
	
	if  ls_accid_bf = ls_accid then
		ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
		ll_index2 = ll_index2 + 1
	else
		ll_index2	=	1
		ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
		ll_index2 = ll_index2 + 1
	end if
			
	// รายการการเงิน
	if ( ldc_itempay > 0 ) then		
		this.of_additemdesc(  as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay , ls_itemdesc , 55555, ids_vcrcvpaydet )
//		this.of_additemdesc_detail(  as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay , ls_detail , 55555, ids_vcrcvpaydetail )
		this.of_additemdesc( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_tofromaccid , ls_accrevside, ldc_itempay , ls_itemdesc , 55555, ids_vcrcvpaydet )
//		this.of_additemdesc_detail( as_coopid , is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_tofromaccid , ls_accrevside, ldc_itempay , ls_detail , 55555, ids_vcrcvpaydetail )
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
	ls_finno_temp	= ls_finno
	ls_tofromaccid_bf	= ls_tofromaccid
	
next

destroy( lds_slipdata )
//update
if ids_vcrcvpay.update() <> 1 then	
	return -1
end if
	
if ids_vcrcvpaydet.update() <> 1 then
	return -1
end if

//if ids_vcrcvpaydetail.update() <> 1 then
//	return -1
//end if

if ids_voucher.update() <> 1 then
	return -1
end if
	
if ids_voucherdet.update() <> 1 then
	return -1
end if

//if ids_voucherdetail.update() <> 1 then
//	return -1
//end if


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
string			ls_slipno, ls_slipprior, ls_accid, ls_accintarrid, ls_mapacc, ls_colname, ls_vc_type
string			ls_accside, ls_accrevside, ls_vcdocno, ls_tmpsystem, ls_tmpvcgrp ,ls_slipitem_desc
string			ls_moneygrp, ls_depttype, ls_itemtype, ls_tofromaccid, ls_docno, ls_year
string			ls_branchid,ls_accmaster_branch_id,ls_acccr_id,ls_accdr_id,ls_oldbranchid,ls_desc,ls_vcbrdocno
integer		li_slipflag,ll_seqno, li_shrlonstatus
long			ll_index, ll_count,ll_find, ll_index2, ll_sortacc, ll_sortint, ll_sortintarr
dec{2}		ldc_itempay,ldc_tax_amt,ldc_itembal, ldc_itemamtnet, ldc_principal, ldc_int, ldc_deptamt, ldc_total, ldc_intarrear
string			ls_slipitemtype_code,ls_vcrcvno,ls_acctaxid,ls_cashcode ,ls_account_id 
string			ls_accid_bf, ls_vcrcvdocno_tax , ls_itemdesc , ls_cash, ls_shrlontype, ls_membno, ls_membno_last
string			ls_finno, ls_finno_temp, ls_tofromaccid_bf, ls_voucher_type , as_vcdocno, ls_deptaccount
string			ls_itemdesc_D00, ls_itemdesc_D01, ls_itemdesc_S01, ls_itemdesc_WF, ls_itemdesc_OTH, ls_itemdesc_FFE
string			ls_itemdesc_L01, ls_itemdesc_L02, ls_itemdesc_L03, ls_system_code, ls_accintid, ls_recv_period, ls_kpaccid

n_ds			lds_vcpay, lds_vcpaydet
datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_kp_month"
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

	if isnull( ldc_principal ) then ldc_principal = 0
	if isnull( ldc_int ) then ldc_int = 0
	
	//เคลียร์ยอด ldc_intarrear ให้เป็น 0 เนื่องจากยอดได้ไปรวมใน int_amt แล้ว
	ldc_intarrear  = 0
	
	if isnull(ls_shrlontype)	 then ls_shrlontype	= '00'
	if ( ls_itemtype = 'FFE' ) then
		ls_shrlontype	= '00'
	end if
	
	choose case ls_itemtype
		case  'S01'	
			ls_system_code		= 'SHR'
		case 'FFE'
			ls_system_code		= 'FFE'
//		case 'FEE'
//			ls_system_code		= 'FEE'
//		case 'ISF'   //ลูกหนี้ค่าเบี้ยประกัน
//			ls_system_code		= 'ISF'
//		case 'IAR'   //ดอกเบี้ยค้างรับ
//			ls_system_code		= 'IAR'
		end choose		
	
	ls_accid			= string	( of_getattribmapaccid( as_coopid, "LON", ls_system_code , ls_shrlontype, li_shrlonstatus, "account_id" ) )
	ls_accintid		= string	( of_getattribmapaccid(as_coopid, "LON", ls_system_code , ls_shrlontype, li_shrlonstatus, "accint_id" ) )
	ls_accintarrid	= string	( of_getattribmapaccid(as_coopid, "LON", ls_system_code , ls_shrlontype, li_shrlonstatus, "accintarr_id"  ) )
	ll_sortacc		= long	( of_getattribmapaccid( as_coopid,"LON", ls_system_code, ls_shrlontype, li_shrlonstatus, "sortacc_order"   ) )
	ll_sortint			= long	( of_getattribmapaccid(as_coopid, "LON", ls_system_code , ls_shrlontype, li_shrlonstatus, "sortint_order"  ) )
	ll_sortintarr		= long	( of_getattribmapaccid(as_coopid, "LON", ls_system_code, ls_shrlontype, li_shrlonstatus, "sortintarr_order"  ) )
	ls_vc_type		= string	( of_getattribmapaccid(as_coopid, "LON", ls_system_code, ls_shrlontype, li_shrlonstatus, "prefix_recv"  ) )
	ls_kpaccid		= string	( of_getattribmapaccid( as_coopid, "KEP", "KEP" , "01", 1, "account_id" ) ) //รหัสลูกหนี้ตัวแทน
	
	
		
	ls_accside		= "DR"
	ls_accrevside	= "CR"			
	
	if(ldc_itempay > 0) then  //ลูกหนี้ตัวแทน ฝั่ง DR
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_kpaccid, ls_accside, ldc_itempay, "", 77777, ids_vcrcvpaydet )
	end if
	
	choose case ls_itemtype
		case 'L01','L02','L03'
			
	if(ldc_principal > 0) then //ฝั่ง CR
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accrevside, ldc_principal, "", 77777, ids_vcrcvpaydet )
	end if
	if(ldc_int > 0) then //ดอกเบี้ยฝั่ง CR
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accintid, ls_accrevside, ldc_int, "", 77777, ids_vcrcvpaydet )
	end if
	if(ldc_intarrear > 0) then //ฝั่ง CR
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accintarrid, ls_accrevside, ldc_intarrear, "", 77777, ids_vcrcvpaydet )
	end if

	case else
	if(ldc_itempay > 0) then  //
		this.of_additemdesc( as_coopid,  is_vcrcvtrndocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accrevside, ldc_itempay, "", 77777, ids_vcrcvpaydet )
	end if

end choose


	ls_accid_bf	= ls_accid
	ls_finno_temp	= ls_finno
	ls_tofromaccid_bf	= ls_tofromaccid
	ls_membno_last = ls_membno
next

	//update สถานะการดึงข้อมูล
		update	kpmastreceivedet
		set			posttovc_flag	= 1,	
					voucher_no		= :is_vcrcvtrndocno
		where	( recv_period	= :ls_recv_period ) and
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

public function integer of_vccashfinrcv_fee (datetime adtm_vcdate, string as_coopid, string as_userid) throws Exception; /***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการซื้อหุ้น เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/

string		ls_slipno, ls_refopeno, ls_accid, ls_accintid, ls_accintarrid, ls_vc_type , ls_acccash , ls_slipno_bf
string		ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp
string		ls_moneygrp, ls_shrlontype, ls_itemtype, ls_tofromaccid
string		ls_branchid,ls_mbbranch_id,ls_acccr_id,ls_accdr_id,ls_desc,ls_year,ls_vcdocno,ls_docno,ls_mbbranch_idold
integer	li_shrlonstatus, li_slipflag, li_seqno,li_flag
long		ll_index, ll_count, ll_sortacc, ll_sortint, ll_sortintarr, ll_index2
dec{2}	ldc_prinpay, ldc_intpay, ldc_itempay, ldc_intarrpay,ldc_fineamt
string		ls_shrlontypeold,ls_document_no,ls_itemdesc,ls_maxdoc,ls_mindoc, ls_date, ls_month, ls_slipitem_desc
datetime	ldtm_operate
string		ls_vc_desc, ls_loangroup_code, ls_accid_bf, ls_vcrcvdocno_prnc, ls_accintid_bf ,ls_coopcontrol , ls_coopid
string		ls_vcrcvdocno_int , ls_vcrcvdocno_etc , ls_voucher_type , as_vcdocno 

datastore	lds_slipdata ,lds_countitem

// ds สำหรับเก็บการซื้อหุ้น
lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cashshrcv_fee"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate, as_coopid  )

// ds สำหรับทำสำเนาเพื่อ หาเลขที่ใบเสร็จ
lds_countitem	= lds_slipdata

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

// สร้างเลข Voucher
//is_vcrcvdocno = ""
	 if  is_vcrcvdocno    =  ""  then
			ls_voucher_type	= "RV"
			ls_desc  				= "เงินสดรับประจำวัน(การเงิน)"		
			is_vcrcvdocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvdocno , as_coopid  )
			this.of_addvoucher( is_vcrcvdocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcv , 'CSH'  , as_coopid  , as_userid )		
		else
			ids_vcrcv.retrieve( is_vcrcvdocno )
			ids_vcrcvdet.retrieve( is_vcrcvdocno )
//			ids_vcrcvdetail.retrieve( is_vcrcvdocno )
	 end if 	


ls_tmpsystem	= "FIN" 
ls_tmpvcgrp		= "DAY"
ls_accid_bf		= ''
ll_index2			=	1
// ชุดการรับชำระหนี้
for ll_index = 1 to ll_count

	ls_coopid				= lds_slipdata.object.coop_id[ ll_index ]
	ls_slipno				= lds_slipdata.object.payinslip_no[ ll_index ]
	ls_document_no	= lds_slipdata.object.document_no[ ll_index ]
	ls_moneygrp		= lds_slipdata.object.moneytype_group[ ll_index ]
	ls_shrlontype		= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_itemtype			= lds_slipdata.object.slipitemtype_code[ ll_index ]
	ls_tofromaccid		= lds_slipdata.object.tofrom_accid[ ll_index ]
	li_shrlonstatus		= 1
	li_slipflag				= lds_slipdata.object.sliptypesign_flag[ ll_index ]
	ldc_itempay			= lds_slipdata.object.item_payamt[ ll_index ]
	ls_slipitem_desc	= trim(lds_slipdata.object.slipitem_desc[ ll_index ])	
		
	if isnull( ldc_intpay ) then ldc_intpay = 0
	if isnull( ldc_fineamt ) then ldc_fineamt = 0
		
	ls_accid			= string	( of_getattribmapaccid(as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "account_id" ) )
	ls_accintid		= string	( of_getattribmapaccid(as_coopid, "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "accint_id" ) )
	ls_accintarrid	= string	( of_getattribmapaccid( as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "accintarr_id"  ) )
	ll_sortacc		= long	( of_getattribmapaccid( as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortacc_order"   ) )
	ll_sortint			= long	( of_getattribmapaccid( as_coopid , "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortint_order"  ) )
	ll_sortintarr		= long	( of_getattribmapaccid( as_coopid, "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortintarr_order"  ) )
		
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

	//if  ls_accid_bf = ls_accid then
		//ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
		//ll_index2 = ll_index2 + 1
	//else
		//ll_index2	=	1
		//ls_itemdesc  = 'จำนวน '  + string ( ll_index2 ) + '  รายการ'
		//ll_index2 = ll_index2 + 1
	//end if
		
	// ยอดทำรายการ
	if ( ldc_itempay > 0 ) then				
		this.of_additemdesc( as_coopid ,is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, "", ll_sortacc, ids_vcrcvdet)
	end if
	
	// รายการเงินสดฝั่งตรงข้าม
	if	( ldc_itempay > 0  ) then
		this.of_additem( as_coopid , is_vcrcvdocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcrcvdet  , as_userid )
	end if		
	
	// Update สถานะการผ่าน Voucher
	//if	ls_slipno	<> ls_slipno_bf		then
		//update		slslippayin
		//set				posttovc_flag		= 1,	
						//voucher_no			= :is_vcrcvdocno
		//where		payinslip_no			= :ls_slipno   and 
						//memcoop_id		= :as_coopid and
						//coop_id 				= :ls_coopid
		//using    		 itr_sqlca   ;							
	//end if				
		
	ls_accid_bf		= ls_accid
	ls_accintid_bf	= ls_accintid
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

on n_cst_account_prepare_vc_service_nan.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_account_prepare_vc_service_nan.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ithw_exception		= create exception
end event

event destructor;destroy ( ids_mapaccid )
end event
