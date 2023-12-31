$PBExportHeader$n_cst_fin_vcgen_manual.sru
$PBExportComments$ทำใบสำคัญจ่ายเลือกรายการเอง
forward
global type n_cst_fin_vcgen_manual from nonvisualobject
end type
end forward

global type n_cst_fin_vcgen_manual from nonvisualobject
end type
global n_cst_fin_vcgen_manual n_cst_fin_vcgen_manual

type variables
public:
n_cst_progresscontrol	inv_progresscontrol

protected:
Exception		ithw_exception
transaction		itr_sqlca

string				is_cash_id,is_benifit_total_acc , is_benifit_account_id , is_pay[], is_rcv[] , is_vcdocno[]
string				is_account_pl_pf, is_finstatus_code
integer			ii_present_year, ii_begin_year, ii_begin_period
datetime			idtm_beginning_of_accou,idtm_ending_of_account
integer			ii_split_vcdetail  = 0 , ii_set_vcdetail  = 0
string				is_vcpaydocno, is_vcrcvdocno,is_vcrcvtrndocno

n_cst_datetimeservice		inv_datetime
n_cst_doccontrolservice		inv_docservice
n_cst_stringservice			inv_string
n_cst_progresscontrol		inv_progress

datastore	ids_vcproc
n_ds			ids_vcrcv, ids_vcrcvdet , ids_vcpay, ids_vcpaydet ,ids_voucher,ids_voucherdet , ids_mapaccid
end variables

forward prototypes
public function integer of_settrans (n_cst_dbconnectservice anv_db)
public function integer of_vcproc (datetime adtm_sysdate, integer ai_sysgencode, string as_branchid, string as_userid) throws Exception
private function integer of_addvoucher (string as_vcdocno, datetime adtm_vcdate, string as_vctype, string as_vcdesc, decimal adc_vcamt, datastore ads_vchead, string as_system_code, string as_branchid, string as_userid)
private function any of_getattribmapaccid (string as_system, string as_slipitem, string as_shrlontype, integer ai_itemstatus, string as_attribmap) throws Exception
private function integer of_vccashdppay (datetime adtm_vcdate, string as_branchid, string as_userid) throws Exception
private function integer of_vccashdprcv (datetime adtm_vcdate, string as_branchid, string as_userid) throws Exception
private function integer of_vccashfinpay (datetime adtm_vcdate, string as_branchid, string as_userid) throws Exception
private function integer of_vccashfinrcv (datetime adtm_vcdate, string as_branchid, string as_userid) throws Exception
private function integer of_vccashlnpay (datetime adtm_vcdate, string as_branchid, string as_userid) throws Exception
private function integer of_vccashshrcv (datetime adtm_vcdate, string as_branchid, string as_userid) throws Exception
private function integer of_vccashshpay (datetime adtm_vcdate, string as_branchid, string as_userid) throws Exception
private function integer of_additem (string as_voucherno, string as_syscode, string as_vcgrpno, string as_accid, string as_accside, decimal adc_itemamt, long al_sortorder, ref n_ds ads_voucherdet, string as_branch, string as_userid)
private function integer of_additemdesc (string as_voucherno, string as_syscode, string as_vcgrpno, string as_accid, string as_accside, decimal adc_itemamt, string as_desc, long al_sortorder, ref n_ds ads_voucherdet)
protected function integer of_updateflag (string as_voucherno)
public function integer of_vccancel (datetime adtm_vcdate, string as_vcdocno, string as_branchid, string as_userid)
protected function integer of_vccashlnrcv (datetime adtm_vcdate, string as_branchid, string as_userid) throws Exception
public function integer of_vctrnlnrcv (datawindow xml_lnrcv, datetime adtm_vcdate, integer as_slippart, integer as_entry)
private function string of_getvoucher_no (datetime adtm_date, string as_voucher_type, ref string as_voucher_no, string as_coop_id) throws Exception
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


return 1
end function

public function integer of_vcproc (datetime adtm_sysdate, integer ai_sysgencode, string as_branchid, string as_userid) throws Exception;/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  Exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/
string			ls_shfilter, ls_lnfilter , ls_branch , ls_userid
integer		li_shpay, li_shrcv, li_lnpay, li_lnrcv, li_dpall, li_other, li_allstep,li_finall, li_count
integer		li_chk, li_row , li_syscode
datetime		ldtm_vcdate
boolean		lb_genamt


ldtm_vcdate			=  adtm_sysdate
li_syscode			=  ai_sysgencode
ls_branch			=  trim ( as_branchid )
ls_userid				=  trim ( as_userid  ) 
li_shpay				=  1
li_shrcv				=  1
li_lnpay				=  1
li_lnrcv				=  1
li_dpall				=  1
li_finall				=  1

//ลบข้อมูลก่อน ช่วงทดสอบ
delete  from vcvoucherdet where voucher_no in ( select  voucher_no  from vcvoucher where voucher_date = :adtm_sysdate  )  using itr_sqlca ; 	
delete  from vcvoucher where voucher_date = :adtm_sysdate using	itr_sqlca ;  commit using	itr_sqlca ; 	

//+++++++++++++++++++++++++++++++++++++++++++++
//รายการรับเงินสด  ===CSH
//+++++++++++++++++++++++++++++++++++++++++++++

//ซื้อหุ้น ***
if li_shpay = 1 then	
	li_chk = this.of_vccashshpay( ldtm_vcdate , ls_branch , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if
	
end if

//รับชำระหนี้
if li_lnpay = 1 then
	// รับชำระหนี้จากสมาชิก ***
	li_chk = this.of_vccashlnpay( ldtm_vcdate , ls_branch , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if

end if

//รายการเงินฝาก
if li_dpall = 1 then
	//	ฝากเงิน ***
	li_chk = this.of_vccashdprcv( ldtm_vcdate , ls_branch , ls_userid ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if
end if

//การเงินรับ
if li_finall = 1 then
	//สหกรณ์รับเงิน ***
	li_chk = this.of_vccashfinrcv( ldtm_vcdate , ls_branch , ls_userid ) 
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

//ถอนหุ้น
if li_shrcv = 1 then
	li_chk = this.of_vccashshrcv( ldtm_vcdate  , ls_branch , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if
end if

//จ่ายเงินกู้
if li_lnrcv = 1 then
	// จ่ายเงินกู้ให้สมาชิก  ***
	li_chk = this.of_vccashlnrcv( ldtm_vcdate , ls_branch , ls_userid  ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if
end if

//รายการเงินฝาก
if li_dpall = 1 then
	//ถอนเงินรวมปิดบัญชี ***
	li_chk = this.of_vccashdppay( ldtm_vcdate , ls_branch , ls_userid ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if	
end if

//การเงินจ่ายของสหกรณ์
if li_finall = 1 then
	//สหกรณ์จ่ายเงิน ***
	li_chk = this.of_vccashfinpay( ldtm_vcdate , ls_branch , ls_userid ) 
	if li_chk = 1 then
		lb_genamt = true
	else
		rollback using itr_sqlca ;
		throw ithw_exception
	end if
end if

//+++++++++++++++++++++++++++++++++++++++++++++
//รายการเงินโอน  ====TRN
//+++++++++++++++++++++++++++++++++++++++++++++



//update
if ids_vcrcvdet.update() <> 1 then
	rollback using	itr_sqlca ; 
end if


if ids_vcpaydet.update() <> 1 then
	rollback using	itr_sqlca ; 
end if

commit  	using	itr_sqlca ; 


return 1
end function

private function integer of_addvoucher (string as_vcdocno, datetime adtm_vcdate, string as_vctype, string as_vcdesc, decimal adc_vcamt, datastore ads_vchead, string as_system_code, string as_branchid, string as_userid);/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี  บันทึก รายการหลัก
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  Exception = failure
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
li_cash_type			= 1

ll_row	= ads_vchead.insertrow( 0 )

ads_vchead.setitem( ll_row, "voucher_no", as_vcdocno )
ads_vchead.setitem( ll_row, "voucher_date", adtm_vcdate )
ads_vchead.setitem( ll_row, "voucher_type", as_vctype )
ads_vchead.setitem( ll_row, "voucher_desc", as_vcdesc )
ads_vchead.setitem( ll_row, "voucher_amt", adc_vcamt )
ads_vchead.setitem( ll_row, "entry_id", ls_userid )
ads_vchead.setitem( ll_row, "entry_date", ldtm_entry )
ads_vchead.setitem( ll_row, "system_code", as_system_code )
ads_vchead.setitem( ll_row, "branch_id", as_branchid )
ads_vchead.setitem( ll_row, "cash_type", li_cash_type )

li_vcdocmax	= upperbound( is_vcdocno[] )

if isnull( li_vcdocmax ) then
	li_vcdocmax	= 0
end if

li_vcdocmax ++
is_vcdocno[ li_vcdocmax ]	= as_vcdocno

return 1
end function

private function any of_getattribmapaccid (string as_system, string as_slipitem, string as_shrlontype, integer ai_itemstatus, string as_attribmap) throws Exception;/***********************************************************
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
li_row	= ids_mapaccid.find( "system_code = '"+as_system+"' and slipitemtype_code = '"+as_slipitem+"' and shrlontype_code = '"+as_shrlontype+&
							   "' and shrlontype_status = "+string( ai_itemstatus )  , 0 , ids_mapaccid.rowcount() )
if li_row > 0 then	
	la_attrib	= ids_mapaccid.GetitemString( li_row,as_attribmap  )	
end if

return la_attrib
end function

private function integer of_vccashdppay (datetime adtm_vcdate, string as_branchid, string as_userid) throws Exception;/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> ถอน + ปิดบัญชี แยกดอกเบี้ย เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  Exception = failure
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
long			ll_index, ll_count, ll_sortacc, ll_sortintarr
dec{2}		ldc_itempay, ldc_intarrpay,ldc_prncbal,ldc_int_amt,ldc_accuint_amt, ldc_intreturn, ldc_slipnetamt
string			ls_deptgroupcode, ls_itemgroup, ls_accid_bf, ls_depttype_code, ls_vc_desc, ls_itemdesc  
string			ls_depttype_group, ls_refsystem, ls_depttype_group_temp, ls_voucher_type , ls_vc_type , as_vcdocno
dec{2}		ldc_other_amt, ldc_intbfyear
datetime		ldtm_operate
string			ls_accid_old

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	="d_vc_slip_data_cashdppay"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_branchid)

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpsystem					= "DEP"
ls_tmpvcgrp						= "DAY"
ls_depttype_group_temp		= ""
ls_accid_bf 						= ""

//// สร้างเลข Voucher
if trim ( is_vcpaydocno ) = "" then
	//
	ids_vcpay.reset()
	ids_vcpaydet.reset()
	
	//
	select		voucher_no
	into		:as_vcdocno
	from		vcvoucher
	where	( voucher_date		= :adtm_vcdate ) and
				( voucher_type		=  '2' ) and
				( system_code		= 'CSH' ) and
				( branch_id			= :as_branchid ) and
				( voucher_status	= 1 )
	using     itr_sqlca   ;			
				
	 if  isnull ( as_vcdocno )  then as_vcdocno = ""
	 is_vcpaydocno		=  trim ( as_vcdocno )
	 
	 //
	 if  is_vcpaydocno    =  ""  then
			ls_voucher_type	= "PV"
			ls_desc  				= "รายการจ่ายเงินสดรับประจำวัน"		
			is_vcpaydocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcpaydocno , as_branchid )
			this.of_addvoucher( is_vcpaydocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcpay , 'CSH'  , as_branchid , as_userid )		
		else
			ids_vcpay.retrieve( is_vcpaydocno )
			ids_vcpaydet.retrieve( is_vcpaydocno )
	 end if 	

end if		

//
for ll_index = 1 to ll_count

	ls_slipno					= lds_slipdata.object.deptslip_no[ ll_index ]
	ls_itemtype				= lds_slipdata.object.recppaytype_code[ ll_index ]
	ls_moneygrp			= lds_slipdata.object.moneytype_group[ ll_index ]
	ls_depttype				= lds_slipdata.object.depttype_code[ ll_index ]
	ls_tofromaccid			= lds_slipdata.object.tofrom_accid[ ll_index ]
	ls_mapacc				= lds_slipdata.object.accmap_code[ ll_index ]
	ldc_itempay				= lds_slipdata.object.deptslip_amt[ ll_index ]
	ldc_int_amt				= lds_slipdata.object.int_amt[ ll_index ]	
	ls_branchid				= lds_slipdata.object.branch_id[ ll_index ]
	ls_branchorigin			= lds_slipdata.object.branch_origin[ ll_index ]
	ldc_accuint_amt		= lds_slipdata.object.accuint_amt[ ll_index ]
	ldc_intreturn			= lds_slipdata.object.int_return[ ll_index ]
	ls_deptgroupcode		= lds_slipdata.object.deptgroup_code[ ll_index ]
	ls_itemgroup			= lds_slipdata.object.group_itemtpe[ ll_index ]
	ldc_slipnetamt			= lds_slipdata.object.deptslip_netamt[ ll_index ]
	ldc_other_amt			= lds_slipdata.object.other_amt[ ll_index ] ; if isnull( ldc_other_amt ) then ldc_other_amt = 0
	li_payfee_meth			= lds_slipdata.object.payfee_meth[ ll_index ] ; if isnull( li_payfee_meth ) then li_payfee_meth = 0
	ls_refsystem			= lds_slipdata.object.refer_app[ ll_index ]
	ldc_intbfyear			= lds_slipdata.object.int_bfyear[ ll_index ]
	
	if isnull( ldc_int_amt ) then ldc_int_amt = 0
	if isnull( ldc_accuint_amt ) then ldc_accuint_amt = 0
	if isnull( ldc_intreturn ) then ldc_intreturn = 0
	if isnull(ldc_intbfyear) then ldc_intbfyear = 0
		
	choose case ls_mapacc
		case "AIT"
			ls_accintarrid	= string( of_getattribmapaccid( "DEP", "DEP", ls_depttype, 1, "accintarr_id"  ) )
			ll_sortintarr		= long( of_getattribmapaccid( "DEP", "DEP", ls_depttype, 1, "sortintarr_order" ) )
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
	
	ls_accid				= string( of_getattribmapaccid( "DEP", "DEP", ls_depttype, 1, ls_colname  ) )
	ll_sortacc			= long( of_getattribmapaccid( "DEP", "DEP", ls_depttype, 1, ls_colsort  ) )		
			
	if li_slipflag > 0 then
		ls_accside		= "CR"
		ls_accrevside	= "DR"
	else
		ls_accside		= "DR"
		ls_accrevside	= "CR"
	end if
	
	
		// รายการเงินสด
		select 	cash_account_code
		into		:ls_cash
		from		accconstant 
	    using		itr_sqlca ;
		
		if	ls_tofromaccid <> ls_cash then
			ls_tofromaccid = ls_cash
		end if	

	if  ls_accid_bf <> ls_accid then
		ls_itemdesc  = 'จำนวน '  + string (ll_index ) + '  รายการ'
	end if	

	//รายการถอน
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( is_vcpaydocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, ls_itemdesc, ll_sortacc, ids_vcpaydet )
	end if
	
	// รายการฝั่งตรงข้าม
	if 	( ldc_itempay > 0 ) then
		this.of_additem( is_vcpaydocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcpaydet , as_branchid , as_userid )
	end if
	
	// Update สถานะการผ่าน Voucher
//	if	not isnull(ls_vcpaydocno)	then
////		update	dpdeptslip
////		set		posttovc_flag	= 1,	
////				voucher_no	= :ls_vcpaydocno
////		where	( deptslip_no	= :ls_slipno ) ;
//	end if
	
	ls_accid_bf 				= ls_accid
		
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

return 1
end function

private function integer of_vccashdprcv (datetime adtm_vcdate, string as_branchid, string as_userid) throws Exception;/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> ฝาก + เปิดบัญชี เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  Exception = failure
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

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cashdprcv"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_branchid )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

ls_tmpsystem		= "DEP"
ls_tmpvcgrp			= "DAY"
ls_accid_bf 			= ""

// สร้างเลข Voucher
if trim ( is_vcrcvdocno ) = "" then
	//
	ids_vcrcv.reset()
	ids_vcrcvdet.reset()
	
	//
	select		voucher_no
	into		:as_vcdocno
	from		vcvoucher
	where	( voucher_date		= :adtm_vcdate ) and
				( voucher_type		=  '1' ) and
				( system_code		= 'CSH' ) and
				( branch_id			= :as_branchid ) and
				( voucher_status	= 1 )
	using     itr_sqlca   ;			
				
	 if  isnull ( as_vcdocno )  then as_vcdocno = ""
	 is_vcrcvdocno		=  trim ( as_vcdocno )
	 
	 //
	 if  is_vcrcvdocno    =  ""  then
			ls_voucher_type	= "RV"
			ls_desc  				= "รายการเงินสดรับประจำวัน"		
			is_vcrcvdocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvdocno , as_branchid )
			this.of_addvoucher( is_vcrcvdocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcv , 'CSH'  , as_branchid , as_userid )		
		else
			ids_vcrcv.retrieve( is_vcrcvdocno )
			ids_vcrcvdet.retrieve( is_vcrcvdocno )
	 end if 	

end if		

//
for ll_index = 1 to ll_count
	
	ls_slipno					= lds_slipdata.object.deptslip_no[ ll_index ]
	ls_itemtype				= lds_slipdata.object.recppaytype_code[ ll_index ]
	ls_moneygrp			= lds_slipdata.object.moneytype_group[ ll_index ]
	ls_depttype				= lds_slipdata.object.depttype_code[ ll_index ]
	ls_tofromaccid			= lds_slipdata.object.tofrom_accid[ ll_index ]
	ls_mapacc				= lds_slipdata.object.accmap_code[ ll_index ]
	ldc_itempay				= lds_slipdata.object.deptslip_amt[ ll_index ]
	ls_branchid				= lds_slipdata.object.branch_id[ ll_index ]
	ls_branchorigin			= lds_slipdata.object.branch_origin[ ll_index ]
	ls_refsystem 			= lds_slipdata.object.refer_app[ ll_index ]

	// ตรวจว่าเป็นรายการเกี่ยวกับอะไร
choose case ls_mapacc
		case "AIT"
			ls_accintarrid	= string( of_getattribmapaccid( "DEP", "DEP", ls_depttype, 1, "accintarr_id"  ) )
			ll_sortintarr		= long( of_getattribmapaccid( "DEP", "DEP", ls_depttype, 1, "sortintarr_order" ) )
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
	
	ls_accid				= string( of_getattribmapaccid( "DEP", "DEP", ls_depttype, 1, ls_colname  ) )
	ll_sortacc			= long( of_getattribmapaccid( "DEP", "DEP", ls_depttype, 1, ls_colsort  ) )	
	
		ls_accside			= "CR"
		ls_accrevside		= "DR"
		
		// รายการเงินสด
		select 	cash_account_code
		into		:ls_cash
		from		accconstant 
	    using		itr_sqlca ;
		
		if	ls_tofromaccid <> ls_cash then
			ls_tofromaccid = ls_cash
		end if
			
	if  ls_accid_bf <> ls_accid then
		ls_itemdesc  = 'จำนวน '  + string (ll_index ) + '  รายการ'
	end if			
			
	// รายการเงินฝาก
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, ls_itemdesc, ll_sortacc, ids_vcrcvdet)
	end if
	
	/// รายการฝั่งตรงข้าม
	if 	( ldc_itempay > 0 ) then
		this.of_additem( is_vcrcvdocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcrcvdet , as_branchid , as_userid )
	end if
	
	//update สถานะการดึงข้อมูล
	
	ls_accid_bf 						= ls_accid
	ls_depttype_group_temp		= ls_depttype_group
	
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

private function integer of_vccashfinpay (datetime adtm_vcdate, string as_branchid, string as_userid) throws Exception; /***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการจ่ายการเงิน เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  Exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/
string			ls_slipno, ls_slipprior, ls_accid, ls_accintarrid, ls_mapacc, ls_colname, ls_vc_type
string			ls_accside, ls_accrevside, ls_vcdocno, ls_tmpsystem, ls_tmpvcgrp
string			ls_moneygrp, ls_depttype, ls_itemtype, ls_tofromaccid, ls_docno, ls_year
string			ls_branchid,ls_accmaster_branch_id,ls_acccr_id,ls_accdr_id,ls_oldbranchid,ls_desc,ls_vcbrdocno
integer		li_slipflag,ll_seqno
long			ll_index, ll_count,ll_find
dec{2}		ldc_itempay,ldc_tax_amt,ldc_itembal
string			ls_slipitemtype_code,ls_vcrcvno,ls_acctaxid,ls_cashcode,ls_account_id 
string			ls_accid_bf, ls_vcrcvdocno_tax , ls_itemdesc , ls_cash
string			ls_finno, ls_finno_temp, ls_tofromaccid_bf, ls_voucher_type , as_vcdocno

n_ds			lds_vcpay, lds_vcpaydet
datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_fnpay_all"
lds_slipdata.settransobject( itr_sqlca )

// รายการเงินสด
select 	cash_account_code
into		:ls_cash
from		accconstant 
using		itr_sqlca ;
 
ll_count	= lds_slipdata.retrieve( adtm_vcdate,as_branchid , ls_cash )

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

// สร้างเลข Voucher
if trim ( is_vcpaydocno ) = "" then
	//
	ids_vcpay.reset()
	ids_vcpaydet.reset()
	
	//
	select		voucher_no
	into		:as_vcdocno
	from		vcvoucher
	where	( voucher_date		= :adtm_vcdate ) and
				( voucher_type		=  '2' ) and
				( system_code		= 'CSH' ) and
				( branch_id			= :as_branchid ) and
				( voucher_status	= 1 )
	using     itr_sqlca   ;			
				
	 if  isnull ( as_vcdocno )  then as_vcdocno = ""
	 is_vcpaydocno		=  trim ( as_vcdocno )
	 
	 //
	 if  is_vcpaydocno    =  ""  then
			ls_voucher_type	= "PV"
			ls_desc  				= "รายการจ่ายเงินสดรับประจำวัน"		
			is_vcpaydocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcpaydocno , as_branchid )
			this.of_addvoucher( is_vcpaydocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcpay , 'CSH'  , as_branchid , as_userid )		
		else
			ids_vcpay.retrieve( is_vcpaydocno )
			ids_vcpaydet.retrieve( is_vcpaydocno )
	 end if 	

end if	

for ll_index = 1 to ll_count
	ls_slipno					= lds_slipdata.object.slip_no[ ll_index ]
	ldc_itempay				= lds_slipdata.object.slip_netamt[ ll_index ]	
	ls_accid					= lds_slipdata.object.account_id[ ll_index ]
	ls_finno					= trim( ls_slipno )	
	
	if isnull( ldc_tax_amt ) then ldc_tax_amt = 0
		
	if ( li_slipflag > 0 ) then
		ls_accside		= "CR"
		ls_accrevside	= "DR"
	else
		ls_accside		= "DR"
		ls_accrevside	= "CR"
	end if
			
		if	ls_tofromaccid <> ls_cash then
			ls_tofromaccid = ls_cash
		end if	
	
	if  ls_accid_bf <> ls_accid then
			ls_itemdesc  = 'จำนวน '  + string (ll_index ) + '  รายการ'
	end if	
	
	//รายการการเงิน
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( is_vcpaydocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, ls_itemdesc, 77777, ids_vcpaydet)
	end if
	
	// รายการฝั่งตรงข้าม
	if 	( ldc_itempay > 0 ) then
		this.of_additem( is_vcpaydocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcpaydet , as_branchid , as_userid )
	end if
	
	ls_accid_bf	= ls_accid
	ls_finno_temp	= ls_finno
	ls_tofromaccid_bf	= ls_tofromaccid
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

return 1
end function

private function integer of_vccashfinrcv (datetime adtm_vcdate, string as_branchid, string as_userid) throws Exception; /***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการรับการเงิน เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  Exception = failure
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
long		ll_index, ll_count
dec{2}	ldc_itempay
string		ls_slipitem_desc, ls_accid_bf
string		ls_maxdoc, ls_mindoc,  ls_desc, ls_voucher_type , ls_cash
string		ls_finno_temp,  ls_finno, ls_tofromaccid_bf , as_vcdocno , ls_itemdesc

datastore	lds_slipdata

lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_fnrecv_all"
lds_slipdata.settransobject( itr_sqlca )

// รายการเงินสด
select 	cash_account_code
into		:ls_cash
from		accconstant 
using		itr_sqlca ;

// reset เงินสดรับ
ll_count	= lds_slipdata.retrieve( adtm_vcdate,as_branchid , ls_cash )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if


ls_tmpsystem		= "FIN"
ls_tmpvcgrp			= "DAY"
ls_accid_bf			= ""

// สร้างเลข Voucher
if trim ( is_vcrcvdocno ) = "" then
	//
	ids_vcrcv.reset()
	ids_vcrcvdet.reset()
	
	//
	select		voucher_no
	into		:as_vcdocno
	from		vcvoucher
	where	( voucher_date		= :adtm_vcdate ) and
				( voucher_type		=  '1' ) and
				( system_code		= 'CSH' ) and
				( branch_id			= :as_branchid ) and
				( voucher_status	= 1 )
	using     itr_sqlca   ;			
				
	 if  isnull ( as_vcdocno )  then as_vcdocno = ""
	 is_vcrcvdocno		=  trim ( as_vcdocno )
	 
	 //
	 if  is_vcrcvdocno    =  ""  then
			ls_voucher_type	= "RV"
			ls_desc  				= "รายการเงินสดรับประจำวัน"		
			is_vcrcvdocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvdocno , as_branchid )
			this.of_addvoucher( is_vcrcvdocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcv , 'CSH'  , as_branchid , as_userid )		
		else
			ids_vcrcv.retrieve( is_vcrcvdocno )
			ids_vcrcvdet.retrieve( is_vcrcvdocno )
	 end if 	

end if	

//
for ll_index = 1 to ll_count
	ls_slipno					= trim( lds_slipdata.object.slip_no[ ll_index ] )
	ldc_itempay				= lds_slipdata.object.slip_netamt[ ll_index ]	
	ls_accid					= lds_slipdata.object.account_id[ ll_index ]
	ls_slipitem_desc		= trim( lds_slipdata.object.payment_desc[ ll_index ] )
	ls_finno					= ls_slipno
	
	ls_accside			= "CR"
	ls_accrevside		= "DR"
			
		if	ls_tofromaccid <> ls_cash then
			ls_tofromaccid = ls_cash
		end if	
	
	if  ls_accid_bf <> ls_accid then
			ls_itemdesc  = 'จำนวน '  + string (ll_index ) + '  รายการ'
	end if	
	
		// รายการการเงิน
	if ( ldc_itempay > 0 ) then		
		this.of_additemdesc( is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, ls_itemdesc, 55555, ids_vcrcvdet)
	end if
	// รายการฝั่งตรงข้าม
	if 	( ldc_itempay > 0 ) then		
		this.of_additem( is_vcrcvdocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcrcvdet , as_branchid , as_userid )
	end if
	
	//	
	ls_accid_bf	= ls_accid
	ls_finno_temp	= ls_finno
	ls_tofromaccid_bf	= ls_tofromaccid
	
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


return 1
end function

private function integer of_vccashlnpay (datetime adtm_vcdate, string as_branchid, string as_userid) throws Exception; /***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการชำระหนี้  เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  Exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/

string		ls_slipno, ls_refopeno, ls_accid, ls_accintid, ls_accintarrid, ls_vc_type , ls_cash
string		ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp
string		ls_moneygrp, ls_shrlontype, ls_itemtype, ls_tofromaccid
string		ls_branchid,ls_mbbranch_id,ls_acccr_id,ls_accdr_id,ls_desc,ls_year,ls_vcdocno,ls_docno,ls_mbbranch_idold
integer	li_shrlonstatus, li_slipflag, li_seqno,li_flag
long		ll_index, ll_count, ll_sortacc, ll_sortint, ll_sortintarr
dec{2}	ldc_prinpay, ldc_intpay, ldc_itempay, ldc_intarrpay,ldc_fineamt
string		ls_shrlontypeold,ls_document_no,ls_itemdesc,ls_maxdoc,ls_mindoc, ls_date, ls_month, ls_slipitem_desc
datetime	ldtm_operate
string		ls_vc_desc, ls_loangroup_code, ls_accid_bf, ls_vcrcvdocno_prnc, ls_accintid_bf
string		ls_vcrcvdocno_int , ls_vcrcvdocno_etc , ls_voucher_type , as_vcdocno 

datastore	lds_slipdata ,lds_countitem

// ds สำหรับเก็บการชำระหนี้
lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cashlnpay"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate,as_branchid )

// ds สำหรับทำสำเนาเพื่อ หาเลขที่ใบเสร็จ
lds_countitem	= lds_slipdata

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return 1
end if

// สร้างเลข Voucher
if trim ( is_vcrcvdocno ) = "" then
	//
	ids_vcrcv.reset()
	ids_vcrcvdet.reset()
	
	//
	select		voucher_no
	into		:as_vcdocno
	from		vcvoucher
	where	( voucher_date		= :adtm_vcdate ) and
				( voucher_type		=  '1' ) and
				( system_code		= 'CSH' ) and
				( branch_id			= :as_branchid ) and
				( voucher_status	= 1 )
	using     itr_sqlca   ;			
				
 if  isnull ( as_vcdocno )  then as_vcdocno = ""
 is_vcrcvdocno		=  trim ( as_vcdocno )
	 if  is_vcrcvdocno    =  ""  then
			ls_voucher_type	= "RV"
			ls_desc  				= "รายการเงินสดรับประจำวัน"		
			is_vcrcvdocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvdocno , as_branchid )
			this.of_addvoucher( is_vcrcvdocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcv , 'CSH'  , as_branchid , as_userid )		
		else
			ids_vcrcv.retrieve( is_vcrcvdocno )
			ids_vcrcvdet.retrieve( is_vcrcvdocno )
	 end if 	

end if		

ls_tmpsystem	= "LON"
ls_tmpvcgrp		= "PAY"
ls_accid_bf		= ''

// ชุดการรับชำระหนี้
for ll_index = 1 to ll_count
	
	ls_slipno				= lds_slipdata.object.payinslip_no[ ll_index ]
	ls_document_no	= lds_slipdata.object.document_no[ ll_index ]
	ls_moneygrp		= lds_slipdata.object.moneytype_group[ ll_index ]
	ls_shrlontype		= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_itemtype			= lds_slipdata.object.slipitemtype_code[ ll_index ]
	ls_tofromaccid		= lds_slipdata.object.tofrom_accid[ ll_index ]
	li_shrlonstatus		= 1
	li_slipflag				= lds_slipdata.object.sliptype_flag[ ll_index ]
	ldc_prinpay			= lds_slipdata.object.principal_payamt[ ll_index ]
	ldc_intpay			= lds_slipdata.object.interest_payamt[ ll_index ]
	ldc_itempay			= lds_slipdata.object.item_payamt[ ll_index ]
	ls_slipitem_desc	= trim(lds_slipdata.object.slipitem_desc[ ll_index ])
		
	if  ( ls_itemtype = 'FEE' ) then
		ls_shrlontype	= '00'
		ls_vc_desc	= ls_slipitem_desc
	end if
	
	if isnull( ldc_intpay ) then ldc_intpay = 0
	if isnull( ldc_fineamt ) then ldc_fineamt = 0
	
	ls_accid			= string	( of_getattribmapaccid( "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "account_id" ) )
	ls_accintid		= string	( of_getattribmapaccid( "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "accint_id" ) )
	ls_accintarrid	= string	( of_getattribmapaccid( "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "accintarr_id"  ) )
	ll_sortacc		= long	( of_getattribmapaccid( "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortacc_order"   ) )
	ll_sortint			= long	( of_getattribmapaccid( "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortint_order"  ) )
	ll_sortintarr		= long	( of_getattribmapaccid( "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortintarr_order"  ) )
	ls_vc_type		= string	( of_getattribmapaccid( "LON", "LON", ls_shrlontype, li_shrlonstatus, "prefix_recv"  ) )
	
	if ( li_slipflag > 0 ) then
		ls_accside		= "CR"
		ls_accrevside	= "DR"
	else
		ls_accside		= "DR"
		ls_accrevside	= "CR"
	end if
		
		if  ls_accid_bf <> ls_accid then
			ls_itemdesc  = 'จำนวน '  + string (ll_index ) + '  รายการ'
		end if	
		
		// รายการเงินสด
		select 	cash_account_code
		into		:ls_cash
		from		accconstant 
	    using		itr_sqlca ;
		
		if	ls_tofromaccid <> ls_cash then
			ls_tofromaccid = ls_cash
		end if	
		
		// เงินต้น
		if ( ldc_prinpay > 0 ) then				
			this.of_additem( is_vcrcvdocno , "CSH", "CSH", ls_accid, ls_accside , ldc_prinpay, ll_sortacc, ids_vcrcvdet , as_branchid , as_userid )
		end if
		
		// ดอกเบี้ย	
		if ( ldc_intpay > 0 ) then
			this.of_additem( is_vcrcvdocno,"CSH", "CSH", ls_accintid, ls_accside, ldc_intpay,ll_sortint, ids_vcrcvdet , as_branchid , as_userid )
		end if
		
		// รายการฝั่งตรงข้าม
		if	( ldc_itempay > 0 ) then
			this.of_additem( is_vcrcvdocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcrcvdet , as_branchid , as_userid )
		end if
		
	
	// Update สถานะการผ่าน Voucher

	ls_accid_bf		= ls_accid
	ls_accintid_bf	= ls_accintid
				
next

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

private function integer of_vccashshrcv (datetime adtm_vcdate, string as_branchid, string as_userid) throws Exception; /***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการถอนหุ้น  เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  Exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/
string			ls_slipno, ls_refopeno, ls_accid, ls_accid_bf
string			ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp, ls_month
string			ls_moneygrp, ls_shrlontype, ls_sliptype, ls_itemtype, ls_tofromaccid
string			ls_branchid,ls_mbbranch_id,ls_acccr_id,ls_accdr_id,ls_desc,ls_year,ls_vcdocno,ls_docno,ls_mbbranch_idold
string			ls_shrcvno[], ls_vcpaydocno
string			ls_shrcvno_temp, ls_shrcvno_current
integer		li_shrlonstatus, li_slipflag, li_seqno, li_bfshare_status
integer		li_gratuityshare, li_clear_flag
long			ll_index, ll_count, ll_sindex, ll_scount, ll_find, ll_sortacc
dec{2}		ldc_itempay, ldc_payshare, ldc_prncrcv, ldc_intrcv, ldc_gratuityshare, ldc_sharearr
dec{2}		ldc_clearlnfine_amt, ldc_return
string			ls_vctran_1,ls_vctran_2, ls_vctran_3, ls_vccash_1, ls_vccash_2, ls_branch  ,  ls_itemdesc , ls_cash
string			ls_slipswt_no, ls_sliptsl_no, ls_slipswd_no, ls_sliptsa_no,ls_payoutno, ls_receiptno, as_vcdocno , ls_voucher_type
datetime		ldtm_operate

datastore	lds_slipdata 

lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cashshrcv"
lds_slipdata.settransobject( itr_sqlca )

ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_branchid )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return  1
end if

// สร้างเลข Voucher
if trim ( is_vcpaydocno ) = "" then
	//
	ids_vcpay.reset()
	ids_vcpaydet.reset()
	
	//
	select		voucher_no
	into		:as_vcdocno
	from		vcvoucher
	where	( voucher_date		= :adtm_vcdate ) and
				( voucher_type		=  '2' ) and
				( system_code		= 'CSH' ) and
				( branch_id			= :as_branchid ) and
				( voucher_status	= 1 )
	using     itr_sqlca   ;			
				
	 if  isnull ( as_vcdocno )  then as_vcdocno = ""
	 is_vcpaydocno		=  trim ( as_vcdocno )
	 
	 //
	 if  is_vcpaydocno    =  ""  then
			ls_voucher_type	= "PV"
			ls_desc  				= "รายการจ่ายเงินสดรับประจำวัน"		
			is_vcpaydocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcpaydocno , as_branchid )
			this.of_addvoucher( is_vcpaydocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcpay , 'CSH'  , as_branchid , as_userid )		
		else
			ids_vcpay.retrieve( is_vcpaydocno )
			ids_vcpaydet.retrieve( is_vcpaydocno )
	 end if 	

end if		
ls_tmpsystem	= "SHR"
ls_tmpvcgrp		= "PAY"


// ชุดการรับถอนหุ้น
for ll_index = 1 to ll_count
	
	ls_itemdesc			= lds_slipdata.object.document_no[ ll_index ]
	ls_slipno				= lds_slipdata.object.payoutslip_no[ ll_index ]
	ls_shrlontype		= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_tofromaccid		= lds_slipdata.object.tofrom_accid[ ll_index ]
	ls_itemtype			= lds_slipdata.object.sliptype_code[ ll_index ]
	li_shrlonstatus		= 1
	li_slipflag				= 0
	ldc_itempay			= lds_slipdata.object.payoutnet_amt[ ll_index ]
		
	ls_accid			= string( of_getattribmapaccid( "LON", "SHR", ls_shrlontype, li_shrlonstatus, "account_id"  ) )
	ll_sortacc		= long( of_getattribmapaccid( "LON",  "SHR", ls_shrlontype, li_shrlonstatus, "sortacc_order" ) )

	if li_slipflag > 0 then
		ls_accside		= "CR"
		ls_accrevside	= "DR"
	else
		ls_accside		= "DR"
		ls_accrevside	= "CR"
	end if
	
	// รายการเงินสด
		select 	cash_account_code
		into		:ls_cash
		from		accconstant 
	    using		itr_sqlca ;
		
		if	ls_tofromaccid <> ls_cash then
			ls_tofromaccid = ls_cash
		end if	
	
	if  ll_index = ll_count then
		ls_itemdesc  = 'จำนวน '  + string (ll_index ) + '  รายการ'
	end if
	
	// รายการหุ้น
	if ( ldc_itempay > 0 ) then		
		this.of_additemdesc( is_vcpaydocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, ls_itemdesc, ll_sortacc, ids_vcpaydet)
	end if
	// รายการฝั่งตรงข้าม
	if 	( ldc_itempay > 0 ) then
		this.of_additem( is_vcpaydocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcpaydet , as_branchid , as_userid )
	end if
	
	// Update สถานะการผ่าน Voucher

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

return 1

end function

private function integer of_vccashshpay (datetime adtm_vcdate, string as_branchid, string as_userid) throws Exception; /***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการซื้อหุ้น  เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  Exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/
string			ls_slipno,  ls_accid
string			ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp , ls_cash
string			ls_moneygrp, ls_shrlontype, ls_itemtype, ls_tofromaccid
string			ls_branchid,ls_mbbranch_id,ls_acccr_id,ls_accdr_id,ls_desc,ls_year,ls_vcdocno,ls_docno,ls_mbbranch_idold
integer		li_shrlonstatus, li_slipflag, li_seqno
long			ll_index, ll_count, ll_sortacc,ll_find
dec{2}		ldc_itempay
STRING		ls_mindoc, ls_maxdoc, ls_itemdesc, ls_date, ls_month, ls_vcrcvdocno, ls_voucher_type , as_vcdocno 
datetime		ldtm_operate

datastore	lds_slipdata , lds_countitem

lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cashshpay"
lds_slipdata.settransobject( itr_sqlca )

// ds สำหรับเก็บค่าการนับจำนวนราย
lds_countitem	= create datastore
lds_countitem.dataobject	= "d_vc_gnrate_item_count"

ll_count	= lds_slipdata.retrieve( adtm_vcdate , as_branchid )

// ถ้าไม่มีรายการออกไป
if ll_count <= 0 then
	return  1
end if

// สร้างเลข Voucher
if trim ( is_vcrcvdocno ) = "" then
	//รีเซต
	ids_vcrcv.reset()
	ids_vcrcvdet.reset()
	
	//
	select		voucher_no
	into		:as_vcdocno
	from		vcvoucher
	where	( voucher_date		= :adtm_vcdate ) and
				( voucher_type		=  '1' ) and
				( system_code		= 'CSH' ) and
				( branch_id			= :as_branchid ) and
				( voucher_status	= 1 )
	using     itr_sqlca   ;			
				
	 if  isnull ( as_vcdocno )  then as_vcdocno = ""
	 is_vcrcvdocno		=  trim ( as_vcdocno )
	 
	 //
	 if  is_vcrcvdocno    =  ""  then
			ls_voucher_type	= "RV"
			ls_desc  				= "รายการเงินสดรับประจำวัน"		
			is_vcrcvdocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcrcvdocno , as_branchid )
			this.of_addvoucher( is_vcrcvdocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcrcv , 'CSH'  , as_branchid , as_userid )		
		else
			ids_vcrcv.retrieve( is_vcrcvdocno )
			ids_vcrcvdet.retrieve( is_vcrcvdocno )
	 end if 	

end if		

ls_tmpsystem	= "SHR"
ls_tmpvcgrp		= "PAY"

// ชุดการรับซื้อหุ้น
for ll_index = 1 to ll_count
	
	ls_itemdesc			= lds_slipdata.object.document_no[ ll_index ]
	ls_slipno				= lds_slipdata.object.payinslip_no[ ll_index ]
	ls_moneygrp		= lds_slipdata.object.moneytype_group[ ll_index ]
	ls_shrlontype		= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_tofromaccid		= lds_slipdata.object.tofrom_accid[ ll_index ]
	ls_itemtype			= lds_slipdata.object.slipitemtype_code[ ll_index ]
	li_seqno				= lds_slipdata.object.seq_no[ ll_index ]
	li_shrlonstatus		= 1
	li_slipflag				= lds_slipdata.object.sliptype_flag[ ll_index ]
	ldc_itempay			= lds_slipdata.object.item_payamt[ ll_index ]
	ls_branchid			= lds_slipdata.object.branch_id[ ll_index ] 
	
	if	isnull(ls_mbbranch_id) 	then ls_mbbranch_id ='000' 
	if   isnull(ls_shrlontype) 		then ls_shrlontype = '00'
	
	ls_accid			= string( of_getattribmapaccid( "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "account_id"  ) )
	ll_sortacc		= long( of_getattribmapaccid( "LON", ls_itemtype, ls_shrlontype, li_shrlonstatus, "sortacc_order" ) )

	if li_slipflag > 0 then
		ls_accside		= "CR"
		ls_accrevside	= "DR"
	else
		ls_accside		= "DR"
		ls_accrevside	= "CR"
	end if
	
	
	// รายการเงินสด
		select 	cash_account_code
		into		:ls_cash
		from		accconstant 
	    using		itr_sqlca ;
		
		if	ls_tofromaccid <> ls_cash then
			ls_tofromaccid = ls_cash
		end if	
	
	if  ll_index = ll_count then
		ls_itemdesc  = 'จำนวน '  + string (ll_index ) + '  รายการ'
	end if  	
			
	// รายการหุ้น		
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( is_vcrcvdocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, ls_itemdesc, ll_sortacc, ids_vcrcvdet)
	end if
	
	// รายการฝั่งตรงข้าม
	if 	( ldc_itempay > 0 ) then		
		this.of_additem( is_vcrcvdocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcrcvdet , as_branchid , as_userid )
	end if
	
	// Update สถานะการผ่าน Voucher
	
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

private function integer of_additem (string as_voucherno, string as_syscode, string as_vcgrpno, string as_accid, string as_accside, decimal adc_itemamt, long al_sortorder, ref n_ds ads_voucherdet, string as_branch, string as_userid);/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   เพิ่มรายการด้านเงินสด 
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  Exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/

string		ls_colname 
long		ll_find, ll_seqno
dec{2}	ldc_itembal

if as_accside = "DR" then
	ls_colname	= "dr_amt"
else
	ls_colname	= "cr_amt"
end if

ll_find	= ads_voucherdet.find( "account_id = '"+as_accid +"'  and voucher_no = '"+  as_voucherno + "' and system_code = '"+as_syscode+"'" + &
								" and vcgrp_no = '"+as_vcgrpno+"' and account_side = '"+as_accside+"'", 1, ads_voucherdet.rowcount() )
			
if ll_find <= 0 then
	ll_find		= ads_voucherdet.insertrow( 0 )
	
	ll_seqno	= long( ads_voucherdet.describe( "evaluate( 'max( seq_no for all )', "+string( ll_find )+") " ) )
	
	if isnull( ll_seqno ) then ll_seqno = 0
	
	ll_seqno ++
	
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

private function integer of_additemdesc (string as_voucherno, string as_syscode, string as_vcgrpno, string as_accid, string as_accside, decimal adc_itemamt, string as_desc, long al_sortorder, ref n_ds ads_voucherdet);/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี  
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  Exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/

string		ls_colname, ls_itemdesc, ls_min, ls_max, ls_desc
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

ll_find	= ads_voucherdet.find( "account_id = '"+as_accid+  "'  and voucher_no = '"+  as_voucherno + "' and system_code = '"+as_syscode+"'" + &
									" and vcgrp_no = '"+as_vcgrpno+"' and account_side = '"+as_accside+"'", 1, ads_voucherdet.rowcount() )	
				
if ll_find <= 0 then
	ll_find		= ads_voucherdet.insertrow( 0 )
	
	ll_seqno	= long( ads_voucherdet.describe( "evaluate( 'max( seq_no for all )', "+string( ll_find )+") " ) )
	
	if isnull( ll_seqno ) then ll_seqno = 0
	
	ll_seqno ++
	
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
ads_voucherdet.setitem( ll_find, "item_desc", as_desc )

if ii_set_vcdetail = 0 then
	ads_voucherdet.setitem( ll_find, "POSTTOGL_FLAG", 0 )
else
	ads_voucherdet.setitem( ll_find, "POSTTOGL_FLAG", 1 )
end if
	
ads_voucherdet.accepttext( )

return 1
end function

protected function integer of_updateflag (string as_voucherno);
/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี  อัพเดตสถานะ ข้อมูลที่ดึงรายการแล้ว
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  Exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/

as_voucherno	= trim( as_voucherno )

// การจ่ายเงินกู้
update		cmloanreceive
set				posttovc_flag = 0
where		( voucher_no	= :as_voucherno ) ;
if sqlca.sqlcode = -1 then
	messagebox( "ยกเลิกรายการ Voucher", "ปรับปรุงรายการจ่ายเงินกู้ไม่ได้ "+sqlca.sqlerrtext )
	return -1
end if

update	cmloanreceive
set			canceltovc_flag = 0
where	( cancelvc_no	= :as_voucherno ) ;
if sqlca.sqlcode = -1 then
	messagebox( "ยกเลิกรายการ Voucher", "ปรับปรุงรายการยกเลิกการจ่ายเงินกู้ไม่ได้ "+sqlca.sqlerrtext )
	return -1
end if

// การถอนหุ้น
update	cmshrwithdraw
set		posttovc_flag = 0
where	( voucher_no	= :as_voucherno ) ;
if sqlca.sqlcode = -1 then
	messagebox( "ยกเลิกรายการ Voucher", "ปรับปรุงรายการการถอนหุ้นไม่ได้ "+sqlca.sqlerrtext )
	return -1
end if

update	cmshrwithdraw
set		canceltovc_flag = 0
where	( cancelvc_no	= :as_voucherno ) ;
if sqlca.sqlcode = -1 then
	messagebox( "ยกเลิกรายการ Voucher", "ปรับปรุงรายการยกเลิกการถอนหุ้นไม่ได้ "+sqlca.sqlerrtext )
	return -1
end if

// slip หุ้นหนี้
update	cmshrlonslipdet
set		posttovc_flag	= 0
where		( voucher_no	= :as_voucherno ) ;
if sqlca.sqlcode = -1 then
	messagebox( "ยกเลิกรายการ Voucher", "ปรับปรุงรายการ Slip ไม่ได้ "+sqlca.sqlerrtext )
	return -1
end if

update	cmshrlonslipdet
set		canceltovc_flag	= 0
where		( cancelvc_no		= :as_voucherno ) ;
if sqlca.sqlcode = -1 then
	messagebox( "ยกเลิกรายการ Voucher", "ปรับปรุงรายการ Slip ยกเลิกไม่ได้ "+sqlca.sqlerrtext )
	return -1
end if

update	kpmastreceivedet
set		canceltovc_flag = 0
where		( cancelvc_no	= :as_voucherno ) ;
if sqlca.sqlcode = -1 then
	messagebox( "ยกเลิกรายการ Voucher", "ปรับปรุงรายการยกเลิกกระดาษทำการไม่ได้ "+sqlca.sqlerrtext )
	return -1
end if

update	kpmastreceivedet
set		returntovc_flag = 0
where	( returnvc_no	= :as_voucherno ) ;
if sqlca.sqlcode = -1 then
	messagebox( "ยกเลิกรายการ Voucher", "ปรับปรุงรายการคืนใบเสร็จไม่ได้ "+sqlca.sqlerrtext )
	return -1
end if

// รายการเงินฝาก
update	dpdeptslip
set		posttovc_flag = 0
where		( voucher_no	= :as_voucherno ) ;
if sqlca.sqlcode = -1 then
	messagebox( "ยกเลิกรายการ Voucher", "ปรับปรุงรายการเงินฝากไม่ได้ "+sqlca.sqlerrtext )
	return -1
end if

//รายการการเงิน
update	finslip
set		posttovc_flag = 0
where		( voucher_no	= :as_voucherno ) ;
if sqlca.sqlcode = -1 then
	messagebox( "ยกเลิกรายการ Voucher", "ปรับปรุงรายการการเงินไม่ได้ "+sqlca.sqlerrtext )
	return -1
end if

update	finslipdet
set			posttovc_flag = 0
where		( voucher_no	= :as_voucherno ) ;
if sqlca.sqlcode = -1 then
	messagebox( "ยกเลิกรายการ Voucher", "ปรับปรุงรายการการเงินไม่ได้ "+sqlca.sqlerrtext )
	return -1
end if


return 1
end function

public function integer of_vccancel (datetime adtm_vcdate, string as_vcdocno, string as_branchid, string as_userid);/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี  ยกเลิกรายการประจำวัน
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  Exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/

datetime		ldtm_vcdate
string			ls_vcdocno , ls_branchid , ls_userid
integer		li_chk ,li_find,li_rowcount,li_row

n_ds		lds_vccancel

// สร้าง DataStore สำหรับใช้งาน
lds_vccancel	= create n_ds
lds_vccancel.dataobject	= "d_vc_vcedit_vclist_cancel"
lds_vccancel.settransobject( itr_sqlca )

li_chk	= messagebox( "", "ยืนยันการลบ Voucher ", exclamation!, yesno! )
if li_chk = 2 then
	return 1
end if

ldtm_vcdate		=		adtm_vcdate
ls_vcdocno		=		trim ( as_vcdocno )
ls_branchid		=		trim ( as_branchid )
ls_userid			=		trim  ( as_userid )


li_rowcount	= lds_vccancel.retrieve( adtm_vcdate , as_branchid )
		
		do while li_find > 0 and li_find <= li_rowcount
			
//			ls_vcdocno	= dw_list.getitemstring( li_find, "voucher_no" )
			this.of_updateflag(ls_vcdocno)
			
			delete from vcvoucherdet
			where	voucher_no = :ls_vcdocno ;
//			if sqlca.sqlcode = FAILURE then
//				messagebox('vcvoucherdet',sqlca.sqlerrtext)
//				rollback;
//				return -1
//			end if
			
			delete from vcvoucher
			where	voucher_no = :ls_vcdocno ;
//			if sqlca.sqlcode = FAILURE then
//				messagebox('vcvoucher',sqlca.sqlerrtext)
//				rollback;
//				return -1
//			end if
			li_row = li_find
			li_row ++
			if li_row > li_rowcount then exit
		
	loop	
//		commit ;
		messagebox('','ยกเลิก Voucher เรียบร้อยแล้ว')

return 1
end function

protected function integer of_vccashlnrcv (datetime adtm_vcdate, string as_branchid, string as_userid) throws Exception; /***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี   ==> รายการจ่ายเงินกู้ เงินสด
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  Exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/
string		ls_slipno, ls_refopeno, ls_accid, ls_accintid, ls_accintarrid , ls_cash
string		ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp
string		ls_moneygrp, ls_shrlontype, ls_sliptype, ls_itemtype, ls_tofromaccid
string		ls_shrcvno[]
string		ls_branchid,ls_mbbranch_id,ls_acccr_id,ls_accdr_id,ls_desc,ls_year,ls_vcdocno,ls_docno,ls_mbbranch_idold
integer	li_shrlonstatus, li_slipflag, li_seqno,li_flag, li_addflag, li_clear_flag
long		ll_index, ll_count, ll_sindex, ll_scount, ll_find, ll_sortacc, ll_sortint, ll_sortintarr
dec{2}	ldc_prinpay, ldc_intpay, ldc_intarrpay, ldc_itempay, ldc_loanrcv, ldc_loanfine
dec{2}	ldc_loanrcvnet, ldc_clcfee, ldc_sharebuy, ldc_wrtfund_amt
datetime	ldtm_operate
string		ls_month, ls_date, ls_tofromaccid_bf, ls_accid_bf, ls_accintid_bf, ls_loangroup_code
string		ls_vc_desc, ls_vcdocno_prnc, ls_itemdesc, ls_vcdocno_int, ls_vcdocno_etc, ls_payoutno
string		ls_loantype_pay, ls_loantype_rcv, ls_sliplwd_no, ls_slipclc_no
string		ls_vccash_tran_01, ls_vccash_tran_02, ls_vccash_tran_03, ls_vccash_01, ls_vccash_02, ls_vccash_03
string		ls_laonrcv_temp, ls_laonrcv_current, ls_receiptno , ls_document_no  ,  as_vcdocno
dec{2}	ldc_clcprnc, ldc_clcint, ldc_fineall, ldc_feeall
string		ls_tran01, ls_tran02, ls_tran03, ls_tran2, ls_tran3, ls_tran4, ls_vccash_tran2, ls_vccash_tran3, ls_vc_type , ls_voucher_type
string		ls_slipitem_desc

datastore	lds_slipdata

// ds สำหรับดึงข้อมูลการจ่ายเงินกู้
lds_slipdata	= create datastore
lds_slipdata.dataobject	= "d_vc_slip_data_cashlnrcv"
lds_slipdata.settransobject( itr_sqlca )

ll_count			= lds_slipdata.retrieve( adtm_vcdate ,as_branchid  )

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

// สร้างเลข Voucher
if trim ( is_vcpaydocno ) = "" then
	//
	ids_vcpay.reset()
	ids_vcpaydet.reset()
	
	//
	select		voucher_no
	into		:as_vcdocno
	from		vcvoucher
	where	( voucher_date		= :adtm_vcdate ) and
				( voucher_type		=  '2' ) and
				( system_code		= 'CSH' ) and
				( branch_id			= :as_branchid ) and
				( voucher_status	= 1 )
	using     itr_sqlca   ;			
				
	 if  isnull ( as_vcdocno )  then as_vcdocno = ""
	 is_vcpaydocno		=  trim ( as_vcdocno )
	 
	 //
	 if  is_vcpaydocno    =  ""  then
			ls_voucher_type	= "PV"
			ls_desc  				= "รายการจ่ายเงินสดรับประจำวัน"		
			is_vcpaydocno  = this.of_getvoucher_no ( adtm_vcdate , ls_voucher_type , is_vcpaydocno , as_branchid )
			this.of_addvoucher( is_vcpaydocno , adtm_vcdate , ls_voucher_type , ls_desc, 0 , ids_vcpay , 'CSH'  , as_branchid , as_userid )		
		else
			ids_vcpay.retrieve( is_vcpaydocno )
			ids_vcpaydet.retrieve( is_vcpaydocno )
	 end if 	

end if		

//
for ll_index = 1 to ll_count
		
	ls_slipno				= lds_slipdata.object.payoutslip_no[ ll_index ]
	ls_document_no	= lds_slipdata.object.document_no[ ll_index ]
	ls_moneygrp		= lds_slipdata.object.moneytype_group[ ll_index ]
	ls_shrlontype		= lds_slipdata.object.shrlontype_code[ ll_index ]
	ls_tofromaccid		= lds_slipdata.object.tofrom_accid[ ll_index ]
	li_shrlonstatus		= 1
	li_slipflag				= lds_slipdata.object.sliptype_flag[ ll_index ]
	ldc_itempay			= lds_slipdata.object.payout_amt[ ll_index ]
	
	ls_accid			= string	( of_getattribmapaccid( "LON", "LON", ls_shrlontype, li_shrlonstatus, "account_id" ) )
	ls_accintid		= string	( of_getattribmapaccid( "LON", "LON", ls_shrlontype, li_shrlonstatus, "accint_id" ) )
	ls_accintarrid	= string	( of_getattribmapaccid( "LON", "LON", ls_shrlontype, li_shrlonstatus, "accintarr_id"  ) )
	ll_sortacc		= long	( of_getattribmapaccid( "LON", "LON", ls_shrlontype, li_shrlonstatus, "sortacc_order"   ) )
	ll_sortint			= long	( of_getattribmapaccid( "LON", "LON", ls_shrlontype, li_shrlonstatus, "sortint_order"  ) )
	ll_sortintarr		= long	( of_getattribmapaccid( "LON", "LON", ls_shrlontype, li_shrlonstatus, "sortintarr_order"  ) )
	ls_vc_type		= string	( of_getattribmapaccid( "LON", "LON", ls_shrlontype, li_shrlonstatus, "prefix_recv"  ) )
	
	if ( li_slipflag > 0 ) then
		ls_accside		= "CR"
		ls_accrevside	= "DR"
	else
		ls_accside		= "DR"
		ls_accrevside	= "CR"
	end if
				
		// รายการเงินสด
		select 	cash_account_code
		into		:ls_cash
		from		accconstant 
	    using		itr_sqlca ;
		
		if	ls_tofromaccid <> ls_cash then
			ls_tofromaccid = ls_cash
		end if				
				
	if  ls_accid_bf <> ls_accid then
		ls_itemdesc  = 'จำนวน '  + string (ll_index ) + '  รายการ'
	end if			
		
	// รายการเงินกู้	
	if ( ldc_itempay > 0 ) then
		this.of_additemdesc( is_vcpaydocno, ls_tmpsystem, ls_tmpvcgrp, ls_accid, ls_accside, ldc_itempay, ls_itemdesc, ll_sortacc, ids_vcpaydet)
	end if
	
	// รายการฝั่งตรงข้าม
	if 	( ldc_itempay > 0 ) then		
		this.of_additem( is_vcpaydocno,"CSH", "CSH", ls_tofromaccid , ls_accrevside, ldc_itempay  , 1, ids_vcpaydet , as_branchid , as_userid )
	end if
			
	// Update สถานะการผ่าน Voucher
	
	ls_accid_bf		= ls_accid
	ls_accintid_bf	= ls_accintid
	
next
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

public function integer of_vctrnlnrcv (datawindow xml_lnrcv, datetime adtm_vcdate, integer as_slippart, integer as_entry);// // ======================  จ่ายเงินกู้  ====================
//
//string	ls_slipno, ls_refopeno, ls_accid, ls_accintid, ls_accintarrid
//string	ls_accside, ls_accrevside, ls_tmpsystem, ls_tmpvcgrp
//string	ls_moneygrp, ls_shrlontype, ls_sliptype, ls_itemtype, ls_tofromaccid
//string	ls_shrcvno[]
//string	ls_branchid,ls_mbbranch_id,ls_acccr_id,ls_accdr_id,ls_desc,ls_year,ls_vcdocno,ls_docno,ls_mbbranch_idold
//integer	li_shrlonstatus, li_slipflag, li_seqno,li_flag, li_addflag, li_clear_flag
//long		ll_index, ll_count, ll_sindex, ll_scount, ll_find, ll_sortacc, ll_sortint, ll_sortintarr
//dec{2}	ldc_prinpay, ldc_intpay, ldc_intarrpay, ldc_itempay, ldc_loanrcv, ldc_loanfine
//dec{2}	ldc_loanrcvnet, ldc_clcfee, ldc_sharebuy, ldc_wrtfund_amt, ldc_principal_net, ldc_int_net
//datetime	ldtm_operate
//string	ls_month, ls_date, ls_tofromaccid_bf, ls_accid_bf, ls_accintid_bf, ls_loangroup_code
//string	ls_vc_desc, ls_vcdocno_prnc, ls_itemdesc, ls_vcdocno_int, ls_vcdocno_etc, ls_payoutno
//string	ls_loantype_pay, ls_loantype_rcv, ls_sliplwd_no, ls_slipclc_no
//string	ls_vccash_tran_01, ls_vccash_tran_02, ls_vccash_tran_03, ls_vc_type
//string	ls_laonrcv_temp, ls_laonrcv_current, ls_receiptno
//dec{2}	ldc_clcprnc, ldc_clcint, ldc_fineall, ldc_feeall, ldc_lnrcvamt[]
//string	ls_tran01, ls_tran02, ls_tran03, ls_tran2, ls_tran3, ls_tran4, ls_vccash_tran2, ls_vccash_tran3, ls_refsystem
//dec{2}	ldc_principal, ldc_int, ldc_helplncoll_amt
//string	ls_accid_clc, ls_accint_clc, ls_lontype_clc, ls_slipitem
//integer	li_row_clc, li_index_clc, li_shrlon_type
//
//datastore	lds_slipdata, lds_slipclc
//
//n_ds		lds_vcpay, lds_vcpaydet
//n_cst_cm_doccontrol_service		lnv_docsrv
//
//
//ll_count	= this.of_getlnrcvdocno( adtm_vcdate, as_slippart, ls_shrcvno , ldc_lnrcvamt)
//
//// ถ้าไม่มีรายการออกไป
//if ll_count <= 0 then
//	return 1
//end if
//
//// VC Master
//lds_vcpay	= create n_ds
//lds_vcpay.dataobject	= "d_vc_gnrate_voucher"
//lds_vcpay.settransobject( sqlca )
//
//// VC Detail
//lds_vcpaydet	= create n_ds
//lds_vcpaydet.dataobject	= "d_vc_gnrate_voucherdet"
//lds_vcpaydet.settransobject( sqlca )
//
//// reset
//ids_voucher.reset()
//ids_voucherdet.reset()
//
//// ds สำหรับดึงข้อมูลการจ่ายเงินกู้
//lds_slipdata	= create datastore
//lds_slipdata.dataobject	= "d_vc_slip_data_loan_pay"//"d_vc_slip_data_cashlnrcv_array"
//lds_slipdata.settransobject( sqlca )
//
//lds_slipclc= create datastore
//lds_slipclc.dataobject	= "d_vc_trnloan_clc"// datastore สำหรับหาค่ารายการหักกลบที่เป็นรายการ TRN
//lds_slipclc.settransobject( sqlca )
//
//
//ls_tmpsystem	= "LON"
//ls_tmpvcgrp		= "PAY"
//
//ls_tofromaccid_bf	= ""
//ls_accid_bf		= ""
//ls_accintid_bf		= ""
//ls_laonrcv_temp	= ""
//
//ll_scount			= lds_slipdata.retrieve( ls_shrcvno ,gs_branch_id, adtm_vcdate )
//
//// progress bar
//hpb_item.maxposition	= ll_scount
//
//if ( ii_split_vcdetail = 0 ) then 
//	this.of_initdsvctran( adtm_vcdate,lds_vcpay, ls_vcdocno , 'จ่ายเงินกู้แก่สมาชิก'  , "JV"  )
//end if
//
//
//for ll_sindex = 1 to ll_scount
//	hpb_item.position	= ll_sindex
//	
//	// เลขที่ใบจ่ายเงินกู้
//	ls_laonrcv_current	= trim( lds_slipdata.object.loanreceive_no[ ll_sindex ] )
//	ls_payoutno		= trim( lds_slipdata.object.payout_no[ ll_sindex ] )
//	ls_receiptno		= trim( lds_slipdata.object.receipt_no[ ll_sindex ] )
//	li_shrlon_type	= lds_slipdata.object.bfcontract_type[ll_sindex]
//	
//	if isnull( ls_payoutno ) then ls_payoutno = ""
//	if isnull( ls_receiptno ) then ls_receiptno = ""
//	
//	// เงินกู้ยอดรับเต็ม
//	ldc_loanrcv		= lds_slipdata.object.loanreceive_amt[ ll_sindex ]
//	if isnull( ldc_loanrcv ) then ldc_loanrcv = 0.00
//	
//	// ยอดเงินกู้รัสุทธิ
//	ldc_loanrcvnet	= lds_slipdata.object.loanreceivenet_amt[ ll_sindex ]
//	if isnull( ldc_loanrcvnet ) then ldc_loanrcvnet = 0.00
//	
//	// ประเภทเงินกู้ที่จ่าย
//	ls_loantype_pay	= trim( lds_slipdata.object.loantype_code_pay[ ll_sindex ] )
//	
//	// ประเภทเงินกู้ที่หักกลบ
//	ls_loantype_rcv	= trim( lds_slipdata.object.loantype_code_rcv[ ll_sindex ] )
//	
//	// เงินกู้ยอดหักกลบต้น
//	ldc_prinpay		= lds_slipdata.object.principal_payment[ ll_sindex ]
//	if isnull( ldc_prinpay ) then ldc_prinpay = 0.00
//	
//	// เงินกู้ยอดหักกลบดอกเบี้ย
//	ldc_intpay		= lds_slipdata.object.interest_payment[ ll_sindex ]
//	if isnull( ldc_intpay ) then ldc_intpay = 0.00
//	
//	// ยอดเงินหักกลบรวม ต้นและดอกเบี้ย ค่าธรรมเนียม ค่าปรับ
//	ldc_clcprnc		= lds_slipdata.object.clearprin_amt[ ll_sindex ]
//	ldc_clcint		= lds_slipdata.object.clearint_amt[ ll_sindex ]
////	ldc_feeall		= lds_slipdata.object.clcfee_amt[ ll_sindex ]
////	ldc_fineall		= lds_slipdata.object.clearfine_amt[ ll_sindex ]
//	if isnull( ldc_clcprnc ) then ldc_clcprnc = 0.00
//	if isnull( ldc_clcint ) then ldc_clcint = 0.00
//	if isnull( ldc_feeall ) then ldc_feeall = 0.00
//	if isnull( ldc_fineall ) then ldc_fineall = 0.00
//	
//	// ยอดเงินหักค่าปรับ
////	ldc_loanfine	= lds_slipdata.object.lnfine_amt[ ll_sindex ]
//	if isnull( ldc_loanfine ) then ldc_loanfine = 0.00
//	
//	// ยอดเงินหักค่าธรรมเนียมการกู้เงิน
////	ldc_clcfee		= lds_slipdata.object.clcfee_amt_rcv[ ll_sindex ]
//	if isnull( ldc_clcfee ) then ldc_clcfee = 0.00
//	
//	// ยอดเงินหักซื้อหุ้น
//	ldc_sharebuy	= lds_slipdata.object.buyshare_amt[ ll_sindex ]
//	if isnull( ldc_sharebuy ) then ldc_sharebuy = 0.00
//	
//	// ยอดเงินหัก กสส ใหม่
////	ldc_wrtfund_amt	= lds_slipdata.object.wrtfund_amt[ ll_sindex ]
//	if isnull( ldc_wrtfund_amt ) then ldc_wrtfund_amt = 0.00
//	
//	// ประเภทเงินที่ทำรายการ
//	ls_moneygrp			= lds_slipdata.object.moneytype_group[ ll_sindex ]
//	
//	// สถานะการเคลียร์หนี้
//	li_clear_flag			= lds_slipdata.object.clear_flag[ ll_sindex ]
//	if isnull( li_clear_flag ) then li_clear_flag = 0
//	
//	// คู่บัญชีทำรายการ
//	ls_tofromaccid		= trim( lds_slipdata.object.tofrom_accid[ ll_sindex ] )
//	
//	// เลขที่ฝบรายการต่างๆ
//	ls_sliplwd_no	= trim( lds_slipdata.object.sliplwd_no[ ll_sindex ] )
//	ls_slipclc_no	= trim( lds_slipdata.object.slipclc_no[ ll_sindex ] )
//	if isnull( ls_sliplwd_no ) then ls_sliplwd_no = ""
//	if isnull( ls_slipclc_no ) then ls_slipclc_no = ""
//	
//	// กลุ่มเงินกู้ ที่จ่าย
//	ls_loangroup_code	= trim( lds_slipdata.object.loangroup_code_pay[ ll_sindex ] )
//	
//	//ทุนช่วยเหลือผู้ค้ำประกัน
//	ldc_helplncoll_amt	=  lds_slipdata.object.helplncoll_amt[ ll_sindex ] 
//	
//	choose case ls_loangroup_code
//		case '01'
//			ls_vc_desc	= 'จ่ายเงินกู้ฉุกเฉินให้แก่สมาชิก'
//		case '02'
//			ls_vc_desc	= 'จ่ายเงินกู้สามัญให้แก่สมาชิก'
//		case '03'
//			ls_vc_desc	= 'จ่ายเงินกู้พิเศษให้แก่สมาชิก'
//	end choose
//			
//	// หากรับเต็มจำนวน
//	// ls_vccash_tran1 รอบเดียว
//	// ls_vccash_tran_01
//	// ls_vccash_tran_02
//	// ls_vccash_tran_03
//	// DR เงินกู้ที่จ่าย
//	//		CR เงินสด/เงินโอนธนาคาร/ธนาคาร
//	
//	if ( ls_laonrcv_current <> ls_laonrcv_temp ) then
//		
////		if ( ldc_loanrcv <> ldc_loanrcvnet ) then
////			ls_moneygrp	= "CBT"
////			ls_tofromaccid	= "1107010"
////		end if
//		
//		ls_vc_type	= string( inv_vcsrv.of_getattribmapaccid( "LON", "LON", ls_loantype_pay, 1, "prefix_pay" , "00" ) )
//		
//		choose case ls_loangroup_code
//			case '01'
//				if ( ls_vccash_tran_01 = "") then
//					if ( ii_split_vcdetail = 0 )  then
//						ls_vccash_tran_01	= ls_vcdocno
//					else
//						this.of_initdsvctran( adtm_vcdate,lds_vcpay, ls_vccash_tran_01 , ls_vc_desc, ls_vc_type  )
//					end if					
//				end if
//				ls_vcdocno_prnc	= ls_vccash_tran_01
//				
//			case '02'
//				if ( ls_vccash_tran_02 = "") then
//					if ( ii_split_vcdetail = 0 )  then
//						ls_vccash_tran_02	= ls_vcdocno
//					else
//						this.of_initdsvctran( adtm_vcdate,lds_vcpay, ls_vccash_tran_02 , ls_vc_desc, ls_vc_type  )
//					end if							
//				end if
//				ls_vcdocno_prnc	= ls_vccash_tran_02
//				
//			case '03'
//				if ( ls_vccash_tran_03 = "") then
//					if ( ii_split_vcdetail = 0 )  then
//						ls_vccash_tran_03	= ls_vcdocno
//					else
//						this.of_initdsvctran( adtm_vcdate,lds_vcpay, ls_vccash_tran_03 , ls_vc_desc, ls_vc_type  )
//					end if							
//				end if
//				ls_vcdocno_prnc	= ls_vccash_tran_03
//				
//		end choose
//		
//		
//		// DR เงินกู้ที่จ่าย
//		ls_accid			= string( inv_vcsrv.of_getattribmapaccid( "LON", "LON", ls_loantype_pay, 1, "account_id" , "00" ) )
//		ll_sortacc		= long( inv_vcsrv.of_getattribmapaccid( "LON", "LON", ls_loantype_pay , 1, "sortacc_order" , "00" ) )
//		
//		this.of_additemdesc( ls_vcdocno_prnc, ls_tmpsystem, ls_tmpvcgrp, ls_accid, "DR",  ls_payoutno , ldc_loanrcv , ll_sortacc, lds_vcpaydet , '' )
//		
//		//		CR เงินสด/เงินโอนธนาคาร/ธนาคาร
//		choose case ls_moneygrp
//			case "CSH"
//				this.of_additem( ls_vcdocno_prnc , "CSH", "CSH", ls_tofromaccid, "CR",   ldc_loanrcvnet , 1, lds_vcpaydet  )
//				
//			case "TRN" //รายการ TRN คือรายการหักกลบ
//				//ใช้สำหรับหาค่าหักกลบมากกว่า 1 สัญญา
//				
//
//			case else
//				
//		end choose
//		
//		li_row_clc	= lds_slipclc.retrieve( ls_sliplwd_no)
//		for li_index_clc	= 1 to li_row_clc
//			
//				ldc_principal		= lds_slipclc.object.principal_payamt[li_index_clc]
//				ldc_int			= lds_slipclc.object.interest_payamt[li_index_clc]
//				ldc_intarrpay	= lds_slipclc.object.intarrear_payamt[li_index_clc]
//				ldc_itempay		= lds_slipclc.object.item_payamt[li_index_clc]
//				ls_lontype_clc	= lds_slipclc.object.shrlontype_code[li_index_clc]
//				ls_slipitem		= lds_slipclc.object.slipitemtype_code[li_index_clc]
//				li_shrlon_type		= lds_slipclc.object.shrlon_type[li_index_clc]
//				
//				if isnull(ldc_principal) then ldc_principal	= 0.00
//				if isnull(ldc_int) then ldc_int	= 0.00
//				if isnull(ldc_intarrpay) then ldc_intarrpay	= 0.00
//				if isnull(ldc_itempay) then ldc_itempay	= 0.00
//				
//				
//				if ls_slipitem = 'LON' then 
//					if ldc_principal > 0 then 
//						ls_accid_clc		= string( inv_vcsrv.of_getattribmapaccid( "LON", "LON" , ls_lontype_clc , li_shrlon_type , "account_id"  , "00") )
//						this.of_additem( ls_vcdocno_prnc , ls_tmpsystem, ls_tmpvcgrp, ls_accid_clc, "CR", ldc_principal , 1, lds_vcpaydet  )
//					end if
//					
//					if ldc_intarrpay > 0 then
//						ls_accid_clc		= string( inv_vcsrv.of_getattribmapaccid( "LON", "LON" , ls_lontype_clc , li_shrlon_type , "accintarr_id" , "00" ) )
//						this.of_additem( ls_vcdocno_prnc , ls_tmpsystem, ls_tmpvcgrp, ls_accid_clc, "CR", ldc_intarrpay , 1, lds_vcpaydet  )
//					end if
//					
//					ldc_int	= ldc_int - ldc_intarrpay
//					if ldc_int < 0 then
//						ldc_int = 0
//					end if
//					if ldc_int > 0 then
//						ls_accid_clc		= string( inv_vcsrv.of_getattribmapaccid( "LON", "LON" , ls_lontype_clc , li_shrlon_type , "accint_id"  , "00") )
//						this.of_additem( ls_vcdocno_prnc , ls_tmpsystem, ls_tmpvcgrp, ls_accid_clc, "CR", ldc_int , 1, lds_vcpaydet  )
//					end if
//				else
//					
//					if ldc_itempay > 0 then 
//						ls_accid_clc		= string( inv_vcsrv.of_getattribmapaccid( "LON", ls_slipitem , ls_lontype_clc , li_shrlon_type , "account_id"  , "00" ) )
//						this.of_additem( ls_vcdocno_prnc , ls_tmpsystem, ls_tmpvcgrp, ls_accid_clc, "CR", ldc_itempay , 1, lds_vcpaydet  )
//					end if
//				end if
//				
//
//		next					
//				
//		// update ใบรายการ ต่างๆที่มีเลขที่ การทำรายการในใบนี้
//		// Update สถานะการผ่าน Voucher
//		update	cmshrlonslipdet
//		set			posttovc_flag	= 1,	
//					voucher_no		= :ls_vcdocno_prnc
//		where		( slip_no			in ( :ls_sliplwd_no, :ls_slipclc_no ) )  ;
//		
//		update	cmloanreceive
//		set			posttovc_flag		= 1,
//					voucher_no			= :ls_vcdocno_prnc
//		where		( loanreceive_no	= :ls_laonrcv_current ) ;
//		
//		// หากรับเต็มจำนวน
//		if ( ldc_loanrcv = ldc_loanrcvnet ) then	
////			continue;
////			this.of_additem( ls_vcdocno_prnc , ls_tmpsystem, ls_tmpvcgrp , ls_tofromaccid, "CR", ldc_loanrcv , 1, lds_vcpaydet  )
//		end if
//		
//	end if
//			
//	// ls_tran2		
//	// ค่าปรับ / ค่าธรรมเนียมการกู้เงิน
//	if ( ( ldc_loanfine > 0 ) or ( ldc_clcfee > 0 ) ) then
//		
//		ls_accid		= ""
//		ls_accid		= string( inv_vcsrv.of_getattribmapaccid( "LON", "LFE" , "00" , 1 , "account_id"  , "00") )
//		ll_sortacc	= long( inv_vcsrv.of_getattribmapaccid( "LON", "LFE" , "00" , 1 , "sortacc_order"  , "00") )
//		
//		//		CR ค่าปรับ
//		if ( ldc_loanfine > 0 ) then				
//			this.of_additemdesc( ls_vcdocno_prnc, ls_tmpsystem, ls_tmpvcgrp, ls_accid, "CR", ls_receiptno , ldc_loanfine  ,  ll_sortacc , lds_vcpaydet , ''  )
//		end if
//		//		CR ค่าธรรมเนียมการกู้เงิน
//		if ( ldc_clcfee > 0 ) then				
//			this.of_additemdesc( ls_vcdocno_prnc, ls_tmpsystem, ls_tmpvcgrp, ls_accid, "CR", ls_receiptno , ldc_clcfee  ,  ll_sortacc , lds_vcpaydet , '' )
//		end if
//		
//	end if
//
//	if ( ls_laonrcv_current <> ls_laonrcv_temp ) then
//		// ls_tran3 รอบเดียว
//		// ซื้อหุ้น
//		ls_vc_type	= string( inv_vcsrv.of_getattribmapaccid( "LON", "SHR", ls_loantype_pay, 1, "prefix_pay"  , "00") )
//		if ( ldc_sharebuy > 0 ) then	
//			//		CR ทุนเรือนหุ้น
//			ls_accid		= ""
//			ls_accid		= string( inv_vcsrv.of_getattribmapaccid( "LON", "SHR" , "01" , 1 , "account_id" , "00" ) )
//			ll_sortacc	= long( inv_vcsrv.of_getattribmapaccid( "LON", "SHR" , "01" , 1 , "sortacc_order" , "00" ) )
//			this.of_additemdesc( ls_vcdocno_prnc, ls_tmpsystem, ls_tmpvcgrp, ls_accid, "CR", ls_receiptno  , ldc_sharebuy ,  1, lds_vcpaydet , '' )
//		end if
//		
//		//		CR ธนาคาร
//		if ( ls_moneygrp <> "TRN" ) then
//			ls_accid		= ls_tofromaccid
//			if ldc_loanrcvnet > 0 then 
//				this.of_additemdesc( ls_vcdocno_prnc, ls_tmpsystem, ls_tmpvcgrp, ls_accid, "CR", ls_payoutno , ldc_loanrcvnet ,  1, lds_vcpaydet , ''  )
//			end if
//		end if
//		
//				//ทุนช่วยเหลือผู้ค้ำประกัน
//		if (  ldc_helplncoll_amt > 0 ) then
//			
//			ls_accid		= ""
//			ls_accid		= string( inv_vcsrv.of_getattribmapaccid( "LON", "HGR" , ls_loantype_pay , 1 , "account_id"  , "00") )
//			ll_sortacc	= long( inv_vcsrv.of_getattribmapaccid( "LON", "HGR" , ls_loantype_pay , 1 , "sortacc_order"  , "00") )
//			
//			//		CR ทุนช่วยเหลือผู้ค้ำประกัน
//			if ( ldc_helplncoll_amt > 0 ) then				
//				this.of_additemdesc( ls_vcdocno_prnc, ls_tmpsystem, ls_tmpvcgrp, ls_accid, "CR", ls_receiptno , ldc_helplncoll_amt  ,  ll_sortacc , lds_vcpaydet, ''   )
//			end if
//
//			
//		end if	
//	end if
//
//	ls_accid_bf			= ls_accid
//	ls_accintid_bf		= ls_accintid
//	ls_laonrcv_temp	= ls_laonrcv_current
//next
//
//// update Vc
//if lds_vcpay.update() <> 1 then
//	return -1
//end if
//
//if lds_vcpaydet.update() <> 1 then
//	return -1
//end if


return 1
end function

private function string of_getvoucher_no (datetime adtm_date, string as_voucher_type, ref string as_voucher_no, string as_coop_id) throws Exception;/***********************************************************
<description>
	ประมวลผลดึงรายการบัญชี  สร้างเลขที่เอกสาร
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success,  Exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 18/06/2011 by Runja
</usage> 
***********************************************************/

string				ls_column, ls_year, ls_date, ls_month, ls_docno
integer			li_year, li_fount
datetime			ldtm_operate

ls_column	= "CMVOUCHERNO_" + trim (as_voucher_type)
ls_docno		= inv_docservice.of_getnewdocno( as_coop_id,ls_column )

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
where	voucher_no		= :as_voucher_no and
			coop_id		= :as_coop_id  using itr_sqlca ;

if isnull( li_fount ) then li_fount = 0

if ( li_fount > 0 ) then
	this.of_getvoucher_no( adtm_date , as_voucher_type , as_voucher_no , as_coop_id  )
end if

return  as_voucher_no

end function

event constructor;ithw_exception		= create Exception	
end event

on n_cst_fin_vcgen_manual.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_fin_vcgen_manual.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;destroy ( ids_mapaccid )


end event

