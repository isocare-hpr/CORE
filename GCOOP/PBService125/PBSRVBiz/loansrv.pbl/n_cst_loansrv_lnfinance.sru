$PBExportHeader$n_cst_loansrv_lnfinance.sru
forward
global type n_cst_loansrv_lnfinance from nonvisualobject
end type
type stri_lnstatement from structure within n_cst_loansrv_lnfinance
end type
end forward

type stri_lnstatement from structure
	string		loancontract_no
	datetime		slip_date
	datetime		operate_date
	datetime		account_date
	string		ref_slipno
	string		ref_docno
	string		loanitemtype_code
	integer		period
	decimal		principal_payment
	decimal		interest_payment
	decimal		principal_balance
	decimal		prncalint_amt
	datetime		calint_from
	datetime		calint_to
	decimal		bfinterest_arrear
	decimal		bfinterest_return
	decimal		interest_period
	decimal		interest_arrear
	decimal		interest_return
	string		moneytype_code
	string		remark
	integer		item_status
	string		entry_id
end type

global type n_cst_loansrv_lnfinance from nonvisualobject
end type
global n_cst_loansrv_lnfinance n_cst_loansrv_lnfinance

type variables
transaction		itr_sqlca
Exception		ithw_exception

n_cst_dbconnectservice		inv_transection
n_cst_loansrv_lnoperate		inv_lnoperatesrv
n_cst_dwxmlieservice			inv_dwxmliesrv

constant string	DWO_PAYOUTSLIP	= "d_loansrv_lnpayout_slip"
constant string	DWO_PAYINSLIP 		= "d_loansrv_lnpayin_slip"
constant string	DWO_PAYINSLIPDET	= "d_loansrv_lnpayin_slipdet"
end variables

forward prototypes
public function integer of_initlnrcv (ref str_slippayout astr_initpayout) throws Exception
public function integer of_initservice (n_cst_dbconnectservice anv_dbtrans) throws Exception
private function integer of_setsrvdwxmlie (boolean ab_switch)
private function integer of_setsrvlnoperate (boolean ab_switch) throws Exception
public function integer of_initslippayin (ref str_slippayin astr_initpayin) throws Exception
public function integer of_saveslip_payin (ref str_slippayin astr_lnslip) throws Exception
public function integer of_getmembslippayin (string as_memno, ref string as_ordno, ref string as_xmlordlist) throws Exception
public function integer of_initshrwtd (ref str_slippayout astr_initpayout) throws Exception
public function integer of_saveslip_shrwtd (ref str_slippayout astr_lnslip) throws Exception
public function integer of_getmembshrwtd (string as_memno, string as_sliptype, ref string as_ordno, ref string as_xmlordlist) throws Exception
private function integer of_setpayinbyorder (ref n_ds ads_slippayindet, ref n_ds ads_ordpayindet) throws Exception
public function string of_initlist_lnrcv (string as_moneytype, datetime adtm_paydate, string as_coopid)
public function integer of_getmemblnrcv (string as_coopid, string as_memno, ref string as_ordcoopid, ref string as_ordno, ref string as_xmlordlist) throws Exception
public function integer of_saveslip_lnrcv (string as_slipcoopid, string as_slipno, string as_concoopid) throws Exception
end prototypes

public function integer of_initlnrcv (ref str_slippayout astr_initpayout) throws Exception;/***********************************************************
<description>
	สำหรับ Init ค่ารายละเอียดของสัญญาหรือใบคำขอกุ้ที่อนุมัติแล้ว เพื่อเตรียมสำหรับการจ่ายเงินกู้
</description>

<arguments>  
	str_slippayout		Structure รายการ Slip จ่าย
		Attrib ภายใน Structure ที่ต้องใช้คือ
		- initfrom_type			String			แหล่งที่มาการจ่ายเงินกู้(REQ/CONT)
		- member_no			String			ทะเบียนสมาชิก
		- loancontract_no		String			เลขที่สัญญา
		- slip_date				datetime		วันที่ Slip
		- operate_date			String			วันที่จ่ายเงินกู้
</arguments> 

<return> 
	1						Integer	ถ้าไม่มีข้อผิดพลาด
</return> 

<usage> 
	เรียกใช้โดยส่งข้อมูลผ่าน Structure เข้ามาฟังก์ชั่นจะ Generate XML สัญญาเงินกู้ที่จะจ่าย
	XML สัญญาเงินกู้ที่จะหักกลบ, XML รายการหักอื่นๆ ให้
	
	str_slippayout		lstr_slippayout
	
	lstr_slippayout.initfrom_type		= dw_list.getitemstring( ll_row, "lnrcvfrom_code" )
	lstr_slippayout.member_no		= dw_list.getitemstring( ll_row, "member_no" )
	lstr_slippayout.loancontract_no	= dw_list.getitemstring( ll_row, "loancontract_no" )
	lstr_slippayout.slip_date			= system_date
	lstr_slippayout.operate_date	= system_date
	
	lnv_lnoperate.of_initlnrcv( lstr_slippayout )
	
	dw_lnrcv.reset()
	dw_lnrcv.importstring( XML!, lstr_slippayout.xml_sliphead )
	
	dw_clrloan.reset()
	dw_clrloan.importstring( XML!, lstr_slippayout.xml_slipcutlon )
	
	dw_clrother.reset()
	dw_clrother.importstring( XML!, lstr_slippayout.xml_slipcutetc )
	----------------------------------------------------------------------
	Revision History:
	Version 1.0 (Initial version) Modified Date 20/9/2010 by OhhO

</usage> 
***********************************************************/
string		ls_orderno, ls_slipitemtype, ls_contno, ls_coopid
string		ls_dwopayout, ls_dwoclear
long		ll_row, ll_index, ll_count
integer	li_return
datetime	ldtm_slipdate, ldtm_orderdate
n_ds		lds_ordpayout, lds_ordpayoutclr
n_ds		lds_slippayout, lds_slipclear

ls_coopid			= astr_initpayout.coop_id
ls_orderno		= astr_initpayout.payoutslip_no
ldtm_slipdate	= astr_initpayout.slip_date

lds_ordpayout	= create n_ds
lds_ordpayout.dataobject	= DWO_PAYOUTSLIP
lds_ordpayout.settransobject( itr_sqlca )

lds_ordpayoutclr	= create n_ds
lds_ordpayoutclr.dataobject	= DWO_PAYINSLIPDET
lds_ordpayoutclr.settransobject( itr_sqlca )

ll_row		= lds_ordpayout.retrieve( ls_coopid, ls_orderno )

// ถ้าหาเลขที่ Order ไม่เจอ
if ll_row <= 0 then
	ithw_exception.text	= "ไม่พบเลขที่ใบสั่งจ่ายเงินกู้ "+ls_orderno+" ที่ระบุ กรุณาตรวจสอบ"
	throw ithw_exception
end if

ldtm_orderdate		= lds_ordpayout.getitemdatetime( ll_row, "slip_date" )

// ตรวจสอบวันที่ในใบสั่งจ่ายกับวันที่จ่ายต้องตรงกัน
if ldtm_slipdate <> ldtm_orderdate then
	ithw_exception.text	= "ไม่สามารถจ่ายเงินกู้ได้ เพราะวันที่สั่งจ่าย ("+string( ldtm_orderdate, "dd/mm/" )+string( year( date( ldtm_orderdate ) )+543 )+") ไม่ตรงกับวันจ่าย กรุณาตรวจสอบ"
	throw ithw_exception
end if

// ดึงข้อมูลใบสั่งว่ามีเคลียร์อะไร
lds_ordpayoutclr.retrieve( ls_coopid, ls_orderno )

// Export ข้อมูลอีกครั้งเพื่อให้ได้ค่าสุดท้าย
astr_initpayout.xml_sliphead	= string( lds_ordpayout.describe( "Datawindow.data.XML" ) )
astr_initpayout.xml_slipcutlon	= ""
astr_initpayout.xml_slipcutetc	= ""

// รายการหัวใบจ่าย

// รายการหักกลบหนี้
lds_ordpayoutclr.setfilter( "slipitemtype_code = 'LON'" )
lds_ordpayoutclr.filter()
if lds_ordpayoutclr.rowcount() > 0 then
	astr_initpayout.xml_slipcutlon	= string( lds_ordpayoutclr.describe( "Datawindow.data.XML" ) )
end if

// รายการหักอื่นๆ
lds_ordpayoutclr.setfilter( "slipitemtype_code <> 'LON'" )
lds_ordpayoutclr.filter()
if lds_ordpayoutclr.rowcount() > 0 then
	astr_initpayout.xml_slipcutetc	= string( lds_ordpayoutclr.describe( "Datawindow.data.XML" ) )
end if

return li_return
end function

public function integer of_initservice (n_cst_dbconnectservice anv_dbtrans) throws Exception;// Service Transection
if isnull( inv_transection ) or not isvalid( inv_transection ) then
	inv_transection	= create n_cst_dbconnectservice
	inv_transection	= anv_dbtrans
end if

itr_sqlca 		= inv_transection.itr_dbconnection

this.of_setsrvdwxmlie( true )

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

private function integer of_setsrvlnoperate (boolean ab_switch) throws Exception;// Check argument
if isnull( ab_switch ) then
	return -1
end if

if ab_switch then
	if isnull( inv_lnoperatesrv ) or not isvalid( inv_lnoperatesrv ) then
		inv_lnoperatesrv	= create n_cst_loansrv_lnoperate
		inv_lnoperatesrv.of_initservice( inv_transection )
		return 1
	end if
else
	if isvalid( inv_lnoperatesrv ) then
		destroy inv_lnoperatesrv
		return 1
	end if
end if

return 0
end function

public function integer of_initslippayin (ref str_slippayin astr_initpayin) throws Exception;/***********************************************************
<description>
	สำหรับ Init ค่ารายละเอียดของสัญญาหรือใบคำขอกุ้ที่อนุมัติแล้ว เพื่อเตรียมสำหรับการจ่ายเงินกู้
</description>

<arguments>  
	str_slippayout		Structure รายการ Slip จ่าย
		Attrib ภายใน Structure ที่ต้องใช้คือ
		- initfrom_type			String			แหล่งที่มาการจ่ายเงินกู้(REQ/CONT)
		- member_no			String			ทะเบียนสมาชิก
		- loancontract_no		String			เลขที่สัญญา
		- slip_date				datetime		วันที่ Slip
		- operate_date			String			วันที่จ่ายเงินกู้
</arguments> 

<return> 
	1						Integer	ถ้าไม่มีข้อผิดพลาด
</return> 

<usage> 
	เรียกใช้โดยส่งข้อมูลผ่าน Structure เข้ามาฟังก์ชั่นจะ Generate XML สัญญาเงินกู้ที่จะจ่าย
	XML สัญญาเงินกู้ที่จะหักกลบ, XML รายการหักอื่นๆ ให้
	
	str_slippayout		lstr_slippayout
	
	lstr_slippayout.initfrom_type		= dw_list.getitemstring( ll_row, "lnrcvfrom_code" )
	lstr_slippayout.member_no		= dw_list.getitemstring( ll_row, "member_no" )
	lstr_slippayout.loancontract_no	= dw_list.getitemstring( ll_row, "loancontract_no" )
	lstr_slippayout.slip_date			= system_date
	lstr_slippayout.operate_date	= system_date
	
	lnv_lnoperate.of_initlnrcv( lstr_slippayout )
	
	dw_lnrcv.reset()
	dw_lnrcv.importstring( XML!, lstr_slippayout.xml_sliphead )
	
	dw_clrloan.reset()
	dw_clrloan.importstring( XML!, lstr_slippayout.xml_slipcutlon )
	
	dw_clrother.reset()
	dw_clrother.importstring( XML!, lstr_slippayout.xml_slipcutetc )
	----------------------------------------------------------------------
	Revision History:
	Version 1.0 (Initial version) Modified Date 20/9/2010 by OhhO

</usage> 
***********************************************************/
string		ls_orderno, ls_slipitemtype, ls_contno
string		ls_dwopayin, ls_dwopayindet
long		ll_row, ll_index, ll_count, ll_findmethod, ll_ordlncount
integer	li_return, li_payspecmethod
datetime	ldtm_slipdate, ldtm_orderdate
n_ds		lds_ordpayin, lds_ordpayindet
n_ds		lds_slippayin, lds_slippayindet

ls_orderno		= astr_initpayin.payinorder_no
ldtm_slipdate	= astr_initpayin.slip_date

lds_ordpayin	= create n_ds
lds_ordpayin.dataobject	= "d_loansrv_order_payin"
lds_ordpayin.settransobject( itr_sqlca )

lds_ordpayindet	= create n_ds
lds_ordpayindet.dataobject	= "d_loansrv_order_payindet"
lds_ordpayindet.settransobject( itr_sqlca )

ll_row		= lds_ordpayin.retrieve( ls_orderno )

// ถ้าหาเลขที่ Order ไม่เจอ
if ll_row <= 0 then
	ithw_exception.text	= "ไม่พบเลขที่ใบสั่งรับชำระเงินที่ระบุ ("+ls_orderno+") กรุณาตรวจสอบ"
	throw ithw_exception
end if

// ตรวจสอบดูว่าในใบสั่งมีการชำระอะไรบ้าง
ll_count	= lds_ordpayindet.retrieve( ls_orderno )
if ll_count <= 0 then
	ithw_exception.text	= "ใบสั่งรับชำระไม่มีรายละเอียดรายการ กรุณาตรวจสอบ เลขที่ใบสั่งรับชำระ ("+ls_orderno+")"
	throw ithw_exception
end if

// ตรวจสอบวันที่ในใบสั่งจ่ายกับวันที่ชำระต้องตรงกัน
ldtm_orderdate		= lds_ordpayin.getitemdatetime( ll_row, "slip_date" )

if ldtm_slipdate <> ldtm_orderdate then
	ithw_exception.text	= "ไม่สามารถรับชำระเงินได้ เพราะวันที่สั่งรับชำระ ("+string( ldtm_orderdate, "dd/mm/" )+string( year( date( ldtm_orderdate ) )+543 )+") ไม่ตรงกับวันปัจจุบัน ("+string( ldtm_slipdate, "dd/mm/" )+string( year( date( ldtm_slipdate ) )+543 )+") กรุณาตรวจสอบ"
	throw ithw_exception
end if

// ดึงข้อมูล
astr_initpayin.member_no		= trim( lds_ordpayin.getitemstring( ll_row, "member_no" ) )
astr_initpayin.sliptype_code		= trim( lds_ordpayin.getitemstring( ll_row, "sliptype_code" ) )
astr_initpayin.slip_date			= lds_ordpayin.getitemdatetime( ll_row, "slip_date" )
astr_initpayin.operate_date		= lds_ordpayin.getitemdatetime( ll_row, "operate_date" )

// เรียกการ Init ค่าจาก lnoperate ก่อน
this.of_setsrvlnoperate( true )
li_return		= inv_lnoperatesrv.of_initslippayin( astr_initpayin )

// ดึงค่า DWObject ออกมาจาก XML จะไม่กำหนดเอง
ls_dwopayin		= inv_dwxmliesrv.of_getdataobject( astr_initpayin.xml_sliphead )

// สร้าง Slip สำหรับกำหนดค่าให้เป็นไปตาม Order
lds_slippayin	= create n_ds
lds_slippayin.dataobject	= ls_dwopayin
lds_slippayin.importstring( XML!, astr_initpayin.xml_sliphead )

// เก็บเลขที่ใบสั่งชำระเอาไว้ด้วย
lds_slippayin.setitem( 1, "payinorder_no", ls_orderno )

// ตรวจสอบว่าตัว Order สั่งให้ชำระแบบไหนยังไง
lds_slippayin.object.slip_amt[ 1 ]				= lds_ordpayin.object.slip_amt[ 1 ]
lds_slippayin.object.moneytype_code[ 1 ]	= lds_ordpayin.object.moneytype_code[ 1 ]
lds_slippayin.object.expense_bank[ 1 ]		= lds_ordpayin.object.expense_bank[ 1 ]
lds_slippayin.object.expense_branch[ 1 ]		= lds_ordpayin.object.expense_branch[ 1 ]
lds_slippayin.object.expense_accid[ 1 ]		= lds_ordpayin.object.expense_accid[ 1 ]
lds_slippayin.object.tofrom_accid[ 1 ]			= lds_ordpayin.object.tofrom_accid[ 1 ]

// ใส่ค่าที่เปลี่ยนแปลงแล้วกลับไป
astr_initpayin.xml_sliphead	= inv_dwxmliesrv.of_xmlexport( lds_slippayin )

if astr_initpayin.xml_slipshr <> "" then
	ls_dwopayindet		= inv_dwxmliesrv.of_getdataobject( astr_initpayin.xml_slipshr )
elseif astr_initpayin.xml_sliplon <> "" then
	ls_dwopayindet		= inv_dwxmliesrv.of_getdataobject( astr_initpayin.xml_sliplon )
elseif astr_initpayin.xml_slipetc <> "" then
	ls_dwopayindet		= inv_dwxmliesrv.of_getdataobject( astr_initpayin.xml_slipetc )
else
	ls_dwopayindet		= ""
end if

// ถ้า ค่า detail ไม่มี
if ls_dwopayindet = "" then
	this.of_setsrvlnoperate( false )
	ithw_exception.text	= "ไม่พบรายการที่จะรับชำระได้ รายการอาจมีการเปลี่ยนแปลงไปแล้ว กรุณาตรวจสอบ"
	throw ithw_exception
end if

lds_slippayindet	= create n_ds
lds_slippayindet.dataobject	= ls_dwopayindet

// ตรวจรายการหนี้ก่อนว่ามีการคิด ด/บ แบบจากยอดชำระหรือไม่
if astr_initpayin.xml_sliplon <> "" then
	lds_slippayindet.importstring( XML!, astr_initpayin.xml_sliplon )
	
	ll_findmethod	= lds_slippayindet.find( "bfpayspec_method = 2", 1, lds_slippayindet.rowcount() )
	ll_ordlncount	= lds_ordpayindet.find( "slipitemtype_code = 'LON'", 1, lds_ordpayindet.rowcount() )
	
	// ถ้ามีการคิด ด/บ จากยอดชำระและมีการสั่งให้ชำระหนี้ด้วย
	if ll_findmethod > 0 and ll_ordlncount > 0 then
		
		ll_count	= lds_slippayindet.rowcount()
		for ll_index = 1 to ll_count
			ls_contno			= lds_slippayindet.getitemstring( ll_index, "loancontract_no" )
			li_payspecmethod	= lds_slippayindet.getitemnumber( ll_index, "bfpayspec_method" )
			
			if li_payspecmethod = 2 then
				ll_row			= lds_ordpayindet.find( "slipitemtype_code = 'LON' and loancontract_no = '"+ls_contno+"'", 1, lds_ordpayindet.rowcount() )
				if ll_row > 0 then
					lds_slippayindet.object.operate_flag[ ll_index ]			= 1
					lds_slippayindet.object.principal_payamt[ ll_index ]	= lds_ordpayindet.object.principal_payamt[ ll_row ]
				end if
			end if
		next
		
		// ส่งไปคำนวณ ด/บ จากยอดชำระ
		astr_initpayin.xml_sliplon		= inv_dwxmliesrv.of_xmlexport( lds_slippayindet )
		
		inv_lnoperatesrv.of_initslippayin_calint( astr_initpayin.xml_sliplon, astr_initpayin.sliptype_code, astr_initpayin.operate_date )
	end if
end if

this.of_setsrvlnoperate( false )

// นำเข้ายอดชำระ
lds_slippayindet.reset()
lds_slippayindet.importstring( XML!, astr_initpayin.xml_slipshr )
lds_slippayindet.importstring( XML!, astr_initpayin.xml_sliplon )
lds_slippayindet.importstring( XML!, astr_initpayin.xml_slipetc )

// Set ค่าชำระให้เท่ากับยอดสั่ง
this.of_setpayinbyorder( lds_slippayindet, lds_ordpayindet )

// Export ข้อมูลอีกครั้งเพื่อให้ได้ค่าสุดท้าย
astr_initpayin.xml_slipshr	= ""
astr_initpayin.xml_sliplon		= ""
astr_initpayin.xml_slipetc		= ""

// รายการซื้อหุ้นเพิ่ม
lds_slippayindet.setfilter( "slipitemtype_code = 'SHR'" )
lds_slippayindet.filter()
if lds_slippayindet.rowcount() > 0 then
	astr_initpayin.xml_slipshr	= string( lds_slippayindet.describe( "Datawindow.data.XML" ) )
end if

// รายการชำระหนี้
lds_slippayindet.setfilter( "slipitemtype_code = 'LON'" )
lds_slippayindet.filter()
if lds_slippayindet.rowcount() > 0 then
	astr_initpayin.xml_sliplon	= string( lds_slippayindet.describe( "Datawindow.data.XML" ) )
end if

// รายการชำระอื่นๆ
lds_slippayindet.setfilter( "slipitemtype_code not in ( 'LON', 'SHR' )" )
lds_slippayindet.filter()
if lds_slippayindet.rowcount() > 0 then
	astr_initpayin.xml_slipetc	= string( lds_slippayindet.describe( "Datawindow.data.XML" ) )
end if

return li_return
end function

public function integer of_saveslip_payin (ref str_slippayin astr_lnslip) throws Exception;/***********************************************************
<description>
	สำหรับบันทึกและผ่านรายการจ่ายเงินกู้รวมถึงรายการหักกลบต่างๆ
</description>

<arguments>  
	str_slippayout		Structure รายการ Slip จ่าย
		Attrib ภายใน Structure ที่ต้องใช้คือ
		- xml_sliphead		String			XML รายการจ่ายเงินกู้
		- xml_slipcutloan	String			XML รายการหักกลบหนี้เก่า
		- xml_slipcutetc		String			XML รายการหักชำระอื่นๆ
		- entry_id			string			ผู้ทำรายการ
		- branch_id			String			สาขาที่ทำรายการ
</arguments> 

<return> 
	1						Integer	ถ้าไม่มีข้อผิดพลาด
</return> 

<usage> 
	เรียกใช้โดยส่งข้อมูลผ่าน Structure เข้ามาฟังก์ชั่นจะทำการบันทึกใบจ่ายเงินกู้
	และปรับปรุงยอดคงเหลือ,ด/บ ค้างในสัญญา
	ถ้ามีการหักกลบก็จะไปทำการสร้าง Slip Payin และผ่านรายการรับชำระอืนๆด้วย
	
	str_slippayout		lstr_slippayout
	
	lstr_slippayout.xml_sliphead		= dw_lnrcv.describe( "Datawindow.Data.XML" )
	lstr_slippayout.xml_slipcutloan	= dw_clrlon.describe( "Datawindow.Data.XML" )
	lstr_slippayout.xml_slipcutetc	= dw_clretc.describe( "Datawindow.Data.XML" )
	lstr_slippayout.entry_id			= entry_id
	lstr_slippayout.branch_id			= branch_id
	
	lnv_lnoperate.of_saveslip_lnrcv( lstr_slippayout )
	----------------------------------------------------------------------
	Revision History:
	Version 1.0 (Initial version) Modified Date 20/9/2010 by OhhO

</usage> 
***********************************************************/
string		ls_dwopayin, ls_orderno
integer	li_return
n_ds		lds_slippayin

// เรียกการ Save จาก LnOperate
this.of_setsrvlnoperate( true )
li_return		= inv_lnoperatesrv.of_saveslip_payin( astr_lnslip )
this.of_setsrvlnoperate( false )

// ดึงค่า DWObject ออกมาจาก XML จะไม่กำหนดเอง
ls_dwopayin	= inv_dwxmliesrv.of_getdataobject( astr_lnslip.xml_sliphead )

// สร้าง Slip สำหรับดึงค่าเลขที่ใบสั่งจ่ายเงิน
lds_slippayin	= create n_ds
lds_slippayin.dataobject	= ls_dwopayin
lds_slippayin.importstring( XML!, astr_lnslip.xml_sliphead )

// เลขที่ใบสั่งชำระ
ls_orderno	= lds_slippayin.getitemstring( 1, "payinorder_no" )

// ปรับสถานะในใบสั่งว่ามีการจ่ายเงินไปแล้ว
update	slorderpayin
set			slip_status		= 1
where	( payinorder_no = :ls_orderno )
using		itr_sqlca ;

if itr_sqlca.sqlcode <> 0 then
	rollback using itr_sqlca ;
	ithw_exception.text	= "ไม่สามารถปรับปรุงสถานะใบสั่งชำระเงินได้ เลขที่ใบสั่งรับชำระ "+ls_orderno
	throw ithw_exception
end if

commit using itr_sqlca ;

return li_return
end function

public function integer of_getmembslippayin (string as_memno, ref string as_ordno, ref string as_xmlordlist) throws Exception;long		ll_count
n_ds		lds_finlist

as_ordno			= ""
as_xmlordlist	= ""

lds_finlist		= create n_ds
lds_finlist.dataobject	= "d_loansrv_finlist_payinbymem"
lds_finlist.settransobject( itr_sqlca )

ll_count		= lds_finlist.retrieve( as_memno )

if ll_count = 1 then
	as_ordno	= lds_finlist.getitemstring( 1, "payinorder_no" )
elseif ll_count > 1 then
	as_xmlordlist	= inv_dwxmliesrv.of_xmlexport( lds_finlist )
end if

return ll_count
end function

public function integer of_initshrwtd (ref str_slippayout astr_initpayout) throws Exception;/***********************************************************
<description>
	สำหรับ Init ค่ารายละเอียดของสัญญาหรือใบคำขอกุ้ที่อนุมัติแล้ว เพื่อเตรียมสำหรับการจ่ายเงินกู้
</description>

<arguments>  
	str_slippayout		Structure รายการ Slip จ่าย
		Attrib ภายใน Structure ที่ต้องใช้คือ
		- initfrom_type			String			แหล่งที่มาการจ่ายเงินกู้(REQ/CONT)
		- member_no			String			ทะเบียนสมาชิก
		- loancontract_no		String			เลขที่สัญญา
		- slip_date				datetime		วันที่ Slip
		- operate_date			String			วันที่จ่ายเงินกู้
</arguments> 

<return> 
	1						Integer	ถ้าไม่มีข้อผิดพลาด
</return> 

<usage> 
	เรียกใช้โดยส่งข้อมูลผ่าน Structure เข้ามาฟังก์ชั่นจะ Generate XML สัญญาเงินกู้ที่จะจ่าย
	XML สัญญาเงินกู้ที่จะหักกลบ, XML รายการหักอื่นๆ ให้
	
	str_slippayout		lstr_slippayout
	
	lstr_slippayout.initfrom_type		= dw_list.getitemstring( ll_row, "lnrcvfrom_code" )
	lstr_slippayout.member_no		= dw_list.getitemstring( ll_row, "member_no" )
	lstr_slippayout.loancontract_no	= dw_list.getitemstring( ll_row, "loancontract_no" )
	lstr_slippayout.slip_date			= system_date
	lstr_slippayout.operate_date	= system_date
	
	lnv_lnoperate.of_initlnrcv( lstr_slippayout )
	
	dw_lnrcv.reset()
	dw_lnrcv.importstring( XML!, lstr_slippayout.xml_sliphead )
	
	dw_clrloan.reset()
	dw_clrloan.importstring( XML!, lstr_slippayout.xml_slipcutlon )
	
	dw_clrother.reset()
	dw_clrother.importstring( XML!, lstr_slippayout.xml_slipcutetc )
	----------------------------------------------------------------------
	Revision History:
	Version 1.0 (Initial version) Modified Date 20/9/2010 by OhhO

</usage> 
***********************************************************/
string		ls_orderno, ls_slipitemtype, ls_contno
string		ls_dwopayout, ls_dwoclear
long		ll_row, ll_index, ll_count
integer	li_return
dec{2}	ldc_payout, ldc_shrstk
datetime	ldtm_slipdate, ldtm_orderdate
n_ds		lds_ordpayout, lds_ordpayoutclr
n_ds		lds_slippayout, lds_slipclear

ls_orderno		= astr_initpayout.payoutorder_no
ldtm_slipdate	= astr_initpayout.slip_date

if isnull( ls_orderno ) or trim( ls_orderno ) = "" then
	ithw_exception.text	= "ไม่มีการส่งเลขที่ใบสั่งจ่ายคืนเงินค่าหุ้นเข้ามา( Init Share Withdraw ) กรุณาตรวจสอบ"
	throw ithw_exception
end if

lds_ordpayout	= create n_ds
lds_ordpayout.dataobject	= "d_loansrv_order_payout"
lds_ordpayout.settransobject( itr_sqlca )

lds_ordpayoutclr	= create n_ds
lds_ordpayoutclr.dataobject	= "d_loansrv_order_payoutclr"
lds_ordpayoutclr.settransobject( itr_sqlca )

ll_row		= lds_ordpayout.retrieve( ls_orderno )

// ถ้าหาเลขที่ Order ไม่เจอ
if ll_row <= 0 then
	ithw_exception.text	= "ไม่พบเลขที่ใบสั่งถอนหุ้น "+ls_orderno+" ที่ระบุ กรุณาตรวจสอบ"
	throw ithw_exception
end if

ldtm_orderdate		= lds_ordpayout.getitemdatetime( ll_row, "slip_date" )

// ตรวจสอบวันที่ในใบสั่งจ่ายกับวันที่จ่ายต้องตรงกัน
if ldtm_slipdate <> ldtm_orderdate then
	ithw_exception.text	= "ไม่สามารถถอนหุ้นได้ เพราะวันที่สั่งถอน ("+string( ldtm_orderdate, "dd/mm/" )+string( year( date( ldtm_orderdate ) )+543 )+") ไม่ตรงกับวันถอน กรุณาตรวจสอบ"
	throw ithw_exception
end if

astr_initpayout.initfrom_type		= lds_ordpayout.getitemstring( ll_row, "sliptype_code" )
astr_initpayout.member_no			= lds_ordpayout.getitemstring( ll_row, "member_no" )
astr_initpayout.slip_date				= ldtm_slipdate
astr_initpayout.operate_date		= ldtm_orderdate

// เรียกการ Init ค่าจาก lnoperate ก่อน
this.of_setsrvlnoperate( true )
li_return		= inv_lnoperatesrv.of_initshrwtd( astr_initpayout )
this.of_setsrvlnoperate( false )

// ดึงค่า DWObject ออกมาจาก XML จะไม่กำหนดเอง
ls_dwopayout	= inv_dwxmliesrv.of_getdataobject( astr_initpayout.xml_sliphead )

// สร้าง Slip สำหรับกำหนดค่าให้เป็นไปตาม Order
lds_slippayout	= create n_ds
lds_slippayout.dataobject	= ls_dwopayout
lds_slippayout.importstring( XML!, astr_initpayout.xml_sliphead )

// ตรวจสอบยอดถอนกับทุนเรือนหุ้นที่มีก่อน
ldc_payout		= lds_ordpayout.getitemdecimal( ll_row, "payout_amt" )
ldc_shrstk		= lds_slippayout.getitemdecimal( 1, "bfshrcont_balamt" )

if ldc_payout > ldc_shrstk then
	ithw_exception.text	= "ยอดถอนหุ้นมีมากกว่าทุนเรือนหุ้นทีมี กรุณาตรวจสอบ"
	throw ithw_exception
end if

// เก็บเลขที่ใบสั่งจ่ายเอาไว้ด้วย
lds_slippayout.setitem( 1, "payoutorder_no", ls_orderno )

// ตรวจสอบว่าตัว Order สั่งให้จ่ายเท่าไหร่
lds_slippayout.object.payout_amt[ 1 ]			= lds_ordpayout.object.payout_amt[ 1 ]
lds_slippayout.object.payoutclr_amt[ 1 ]		= lds_ordpayout.object.payoutclr_amt[ 1 ]
lds_slippayout.object.payoutnet_amt[ 1 ]		= lds_ordpayout.object.payoutnet_amt[ 1 ]
lds_slippayout.object.moneytype_code[ 1 ]	= lds_ordpayout.object.moneytype_code[ 1 ]
lds_slippayout.object.expense_bank[ 1 ]		= lds_ordpayout.object.expense_bank[ 1 ]
lds_slippayout.object.expense_branch[ 1 ]	= lds_ordpayout.object.expense_branch[ 1 ]
lds_slippayout.object.expense_accid[ 1 ]		= lds_ordpayout.object.expense_accid[ 1 ]
lds_slippayout.object.bankfee_amt[ 1 ]		= lds_ordpayout.object.bankfee_amt[ 1 ]
lds_slippayout.object.banksrv_amt[ 1 ]		= lds_ordpayout.object.banksrv_amt[ 1 ]
lds_slippayout.object.bankvat_amt[ 1 ]		= lds_ordpayout.object.bankvat_amt[ 1 ]
lds_slippayout.object.tofrom_accid[ 1 ]		= lds_ordpayout.object.tofrom_accid[ 1 ]

// ใส่ค่าที่เปลี่ยนแปลงแล้วกลับไป
astr_initpayout.xml_sliphead	= inv_dwxmliesrv.of_xmlexport( lds_slippayout )

if astr_initpayout.xml_slipcutlon = "" then
	if astr_initpayout.xml_slipcutetc = "" then
		ls_dwoclear		= ""
	else
		ls_dwoclear		= inv_dwxmliesrv.of_getdataobject( astr_initpayout.xml_slipcutetc )
	end if
else
	ls_dwoclear		= inv_dwxmliesrv.of_getdataobject( astr_initpayout.xml_slipcutlon )
end if

// ถ้า ค่า Clear ไม่มี
if ls_dwoclear = "" then
	return li_return
end if

lds_slipclear	= create n_ds
lds_slipclear.dataobject	= ls_dwoclear
lds_slipclear.importstring( XML!, astr_initpayout.xml_slipcutlon )
lds_slipclear.importstring( XML!, astr_initpayout.xml_slipcutetc )

// ล้างการชำระที่โดน init มาจาก lnoperate ก่อน
ll_count		= lds_slipclear.rowcount()
for ll_index = 1 to ll_count
	lds_slipclear.setitem( ll_index, "operate_flag", 0 )
	lds_slipclear.setitem( ll_index, "principal_payamt", 0 )
	lds_slipclear.setitem( ll_index, "interest_payamt", 0 )
	lds_slipclear.setitem( ll_index, "item_payamt", 0 )
	lds_slipclear.object.item_balance[ ll_index ]		= lds_slipclear.object.bfshrcont_balamt[ ll_index ]
next

// ดึงข้อมูลการสั่งชำระว่าเคลียร์อะไร
lds_ordpayoutclr.retrieve( ls_orderno )

// Set ค่าการชำระตามใบสั่ง
this.of_setpayinbyorder( lds_slipclear, lds_ordpayoutclr )

// Export ข้อมูลอีกครั้งเพื่อให้ได้ค่าสุดท้าย
astr_initpayout.xml_slipcutlon	= ""
astr_initpayout.xml_slipcutetc	= ""

// รายการหักกลบหนี้
lds_slipclear.setfilter( "slipitemtype_code = 'LON'" )
lds_slipclear.filter()
if lds_slipclear.rowcount() > 0 then
	astr_initpayout.xml_slipcutlon	= string( lds_slipclear.describe( "Datawindow.data.XML" ) )
end if

// รายการหักอื่นๆ
lds_slipclear.setfilter( "slipitemtype_code <> 'LON'" )
lds_slipclear.filter()
if lds_slipclear.rowcount() > 0 then
	astr_initpayout.xml_slipcutetc	= string( lds_slipclear.describe( "Datawindow.data.XML" ) )
end if

return li_return
end function

public function integer of_saveslip_shrwtd (ref str_slippayout astr_lnslip) throws Exception;/***********************************************************
<description>
	สำหรับบันทึกและผ่านรายการจ่ายเงินกู้รวมถึงรายการหักกลบต่างๆ
</description>

<arguments>  
	str_slippayout		Structure รายการ Slip จ่าย
		Attrib ภายใน Structure ที่ต้องใช้คือ
		- xml_sliphead		String			XML รายการจ่ายเงินกู้
		- xml_slipcutloan	String			XML รายการหักกลบหนี้เก่า
		- xml_slipcutetc		String			XML รายการหักชำระอื่นๆ
		- entry_id			string			ผู้ทำรายการ
		- branch_id			String			สาขาที่ทำรายการ
</arguments> 

<return> 
	1						Integer	ถ้าไม่มีข้อผิดพลาด
</return> 

<usage> 
	เรียกใช้โดยส่งข้อมูลผ่าน Structure เข้ามาฟังก์ชั่นจะทำการบันทึกใบจ่ายเงินกู้
	และปรับปรุงยอดคงเหลือ,ด/บ ค้างในสัญญา
	ถ้ามีการหักกลบก็จะไปทำการสร้าง Slip Payin และผ่านรายการรับชำระอืนๆด้วย
	
	str_slippayout		lstr_slippayout
	
	lstr_slippayout.xml_sliphead		= dw_lnrcv.describe( "Datawindow.Data.XML" )
	lstr_slippayout.xml_slipcutloan	= dw_clrlon.describe( "Datawindow.Data.XML" )
	lstr_slippayout.xml_slipcutetc	= dw_clretc.describe( "Datawindow.Data.XML" )
	lstr_slippayout.entry_id			= entry_id
	lstr_slippayout.branch_id			= branch_id
	
	lnv_lnoperate.of_saveslip_lnrcv( lstr_slippayout )
	----------------------------------------------------------------------
	Revision History:
	Version 1.0 (Initial version) Modified Date 20/9/2010 by OhhO

</usage> 
***********************************************************/
string		ls_dwopayout, ls_orderno
integer	li_return
n_ds		lds_slippayout

// เรียกการ Save จาก LnOperate
this.of_setsrvlnoperate( true )
li_return		= inv_lnoperatesrv.of_saveslip_shrwtd( astr_lnslip )
this.of_setsrvlnoperate( false )

// ดึงค่า DWObject ออกมาจาก XML จะไม่กำหนดเอง
ls_dwopayout	= inv_dwxmliesrv.of_getdataobject( astr_lnslip.xml_sliphead )

// สร้าง Slip สำหรับดึงค่าเลขที่ใบสั่งถอนหุ้น
lds_slippayout	= create n_ds
lds_slippayout.dataobject	= ls_dwopayout
lds_slippayout.importstring( XML!, astr_lnslip.xml_sliphead )

// เลขที่ใบสั่งจ่าย
ls_orderno	= trim( lds_slippayout.getitemstring( 1, "payoutorder_no" ) )

// ปรับสถานะในใบสั่งว่ามีการจ่ายเงินไปแล้ว
update	slorderpayout
set			slip_status		= 1
where	( payoutorder_no = :ls_orderno )
using		itr_sqlca ;

if itr_sqlca.sqlcode <> 0 then
	rollback using itr_sqlca ;
	ithw_exception.text	= "ไม่สามารถปรับปรุงสถานะใบสั่งถอนหุ้นได้ เลขที่ใบสั่งถอน "+ls_orderno
	throw ithw_exception
end if

commit using itr_sqlca ;

return li_return
end function

public function integer of_getmembshrwtd (string as_memno, string as_sliptype, ref string as_ordno, ref string as_xmlordlist) throws Exception;long		ll_count
n_ds		lds_lnrcv

as_ordno			= ""
as_xmlordlist	= ""

lds_lnrcv		= create n_ds
lds_lnrcv.dataobject	= "d_loansrv_finlist_shrwtdbymem"
lds_lnrcv.settransobject( itr_sqlca )

ll_count		= lds_lnrcv.retrieve( as_memno, as_sliptype )

if ll_count = 1 then
	as_ordno	= lds_lnrcv.getitemstring( 1, "payoutorder_no" )
elseif ll_count > 1 then
	as_xmlordlist	= inv_dwxmliesrv.of_xmlexport( lds_lnrcv )
end if

return ll_count
end function

private function integer of_setpayinbyorder (ref n_ds ads_slippayindet, ref n_ds ads_ordpayindet) throws Exception;string		ls_slipitemtype, ls_contno
integer	li_opeflag
long		ll_count, ll_index, ll_row
dec{2}	ldc_bfprnbal, ldc_prnamt, ldc_prnbal

ll_count		= ads_ordpayindet.rowcount()

for ll_index = 1 to ll_count
	
	ls_slipitemtype	= ads_ordpayindet.getitemstring( ll_index, "slipitemtype_code" )
	ls_contno		= ads_ordpayindet.getitemstring( ll_index, "loancontract_no" )
	li_opeflag		= ads_ordpayindet.getitemnumber( ll_index, "operate_flag" )
	
	if li_opeflag = 0 then
		continue
	end if
	
	choose case ls_slipitemtype
		case "LON"
			ll_row		= ads_slippayindet.find( "slipitemtype_code = '"+ls_slipitemtype+"' and loancontract_no = '"+ls_contno+"'", 1, ads_slippayindet.rowcount() )
	
			// ไม่เจอรายการต้องแจ้ง Error ออกไป
			if ll_row <= 0 then
				ithw_exception.text	= "ไม่พบรายการหักสัญญาที่ระบุในใบสั่งจ่าย เลขที่สัญญา ( "+ls_contno+") รายการอาจมีการเปลี่ยนแปลงไปแล้ว กรุณาตรวจสอบ"
				throw ithw_exception
			end if
			
			ldc_bfprnbal		= ads_slippayindet.getitemdecimal( ll_row, "bfshrcont_balamt" )
			ldc_prnamt		= ads_ordpayindet.getitemdecimal( ll_index, "principal_payamt" )
			ldc_prnbal		= ldc_bfprnbal - ldc_prnamt
			
			if ldc_prnbal < 0 then
				ithw_exception.text	= "เลขที่สัญญา ( "+ls_contno+") ถ้าชำระตามใบสั่ง ยอดคงเหลือจะติดลบ รายการอาจมีการเปลี่ยนแปลงไปแล้ว กรุณาตรวจสอบ"
				throw ithw_exception
			end if
		
		case "SHR"
			ll_row			= ads_slippayindet.find( "slipitemtype_code = '"+ls_slipitemtype+"'", 1, ads_slippayindet.rowcount() )
			
			// ไม่เจอรายการต้องแจ้ง Error ออกไป
			if ll_row <= 0 then
				ithw_exception.text	= "ไม่พบรายการหักหุ้นที่ระบุในใบสั่งจ่าย รายการอาจมีการเปลี่ยนแปลงไปแล้ว กรุณาตรวจสอบ"
				throw ithw_exception
			end if
			
			ldc_bfprnbal		= ads_slippayindet.getitemdecimal( ll_row, "bfshrcont_balamt" )
			ldc_prnamt		= ads_ordpayindet.getitemdecimal( ll_index, "item_payamt" )
			ldc_prnbal		= ldc_bfprnbal + ldc_prnamt
		case else
			ll_row			= ads_slippayindet.find( "slipitemtype_code = '"+ls_slipitemtype+"'", 1, ads_slippayindet.rowcount() )
			
			if ll_row <= 0 then
				ll_row		= ads_slippayindet.insertrow( 0 )
				
				ads_slippayindet.setitem( ll_row, "slipitemtype_code", ls_slipitemtype )
				
				ads_slippayindet.object.shrlontype_code[ ll_row ]		= ads_ordpayindet.object.shrlontype_code[ ll_index ]
				ads_slippayindet.object.loancontract_no[ ll_row ]		= ads_ordpayindet.object.loancontract_no[ ll_index ]
				ads_slippayindet.object.slipitem_desc[ ll_row ]			= ads_ordpayindet.object.slipitem_desc[ ll_index ]
				ads_slippayindet.object.bfshrcont_balamt[ ll_row ]	= ads_ordpayindet.object.bfshrcont_balamt[ ll_index ]
			end if
			
			ldc_bfprnbal		= ads_slippayindet.getitemdecimal( ll_row, "bfshrcont_balamt" )
			ldc_prnamt		= ads_ordpayindet.getitemdecimal( ll_index, "item_payamt" )
			ldc_prnbal		= ldc_bfprnbal - ldc_prnamt
	end choose

	ads_slippayindet.object.operate_flag[ ll_row ]		= 1
	ads_slippayindet.object.principal_payamt[ ll_row ]	= ads_ordpayindet.object.principal_payamt[ ll_index ]
	ads_slippayindet.object.interest_payamt[ ll_row ]	= ads_ordpayindet.object.interest_payamt[ ll_index ]
	ads_slippayindet.object.item_payamt[ ll_row ]		= ads_ordpayindet.object.item_payamt[ ll_index ]
	ads_slippayindet.object.item_balance[ ll_row ]		= ldc_prnbal

next

return 1
end function

public function string of_initlist_lnrcv (string as_moneytype, datetime adtm_paydate, string as_coopid);/***********************************************************
<description>
	สำหรับแสดง List ข้อมูลเงินกู้ที่รอจ่ายทั้งหมด
</description>

<arguments>  
</arguments> 

<return> 
	String			XML รายการเงินกู้ที่รอจ่ายทั้งหมด
</return> 

<usage> 
	เรียกใช้โดยไม่ต้องส่ง Argument เข้ามา ระบบจะคืนค่า
	XML รายการเงินกู้ที่รอจ่ายทั้งหมดออกไปให้
	
	string		ls_xmllnrcvlist
	
	ls_xmllnrcvlist	= lnv_lnoperate.of_initlist_lnrcv()
	
	dw_example.reset()
	dw_example.importstring( XML!, ls_xmllnrcvlist )
	
	----------------------------------------------------------------------
	Revision History:
	Version 1.0 (Initial version) Modified Date 20/9/2010 by OhhO

</usage> 
***********************************************************/
string		ls_xmllnrcvlist, ls_moneytype
long		ll_count
n_ds		lds_lnrcvlist

ls_xmllnrcvlist		= ""

lds_lnrcvlist	= create n_ds
lds_lnrcvlist.dataobject	= "d_loansrv_finlist_lnrcv"
lds_lnrcvlist.settransobject( itr_sqlca ) 

ls_moneytype	= trim( as_moneytype )

if isnull(ls_moneytype) then
	ls_moneytype	= ""
end if
 
ll_count		= lds_lnrcvlist.retrieve( as_coopid,adtm_paydate )

if ll_count <= 0 then
	return ls_xmllnrcvlist
end if

if ls_moneytype <> "" then
	lds_lnrcvlist.setfilter( "moneytype_code = '"+ls_moneytype+"'" )
	lds_lnrcvlist.filter()
end if

if lds_lnrcvlist.rowcount() > 0 then
	ls_xmllnrcvlist		= string( lds_lnrcvlist.describe( "Datawindow.data.XML" ) )
end if

destroy( lds_lnrcvlist )

return ls_xmllnrcvlist
end function

public function integer of_getmemblnrcv (string as_coopid, string as_memno, ref string as_ordcoopid, ref string as_ordno, ref string as_xmlordlist) throws Exception;long		ll_count
n_ds		lds_lnrcv

as_ordno			= ""
as_xmlordlist	= ""

lds_lnrcv		= create n_ds
lds_lnrcv.dataobject	= "d_loansrv_finlist_lnrcvbymem"
lds_lnrcv.settransobject( itr_sqlca )

ll_count		= lds_lnrcv.retrieve( as_coopid, as_memno )

if ll_count = 1 then
	as_ordcoopid	= lds_lnrcv.getitemstring( 1, "coop_id" )
	as_ordno			= lds_lnrcv.getitemstring( 1, "payoutslip_no" )
elseif ll_count > 1 then
	as_xmlordlist	= inv_dwxmliesrv.of_xmlexport( lds_lnrcv )
end if

return ll_count
end function

public function integer of_saveslip_lnrcv (string as_slipcoopid, string as_slipno, string as_concoopid) throws Exception;/***********************************************************
<description>
	สำหรับบันทึกและผ่านรายการจ่ายเงินกู้รวมถึงรายการหักกลบต่างๆ
</description>

<arguments>  
	str_slippayout		Structure รายการ Slip จ่าย
		Attrib ภายใน Structure ที่ต้องใช้คือ
		- xml_sliphead		String			XML รายการจ่ายเงินกู้
		- xml_slipcutloan	String			XML รายการหักกลบหนี้เก่า
		- xml_slipcutetc		String			XML รายการหักชำระอื่นๆ
		- entry_id			string			ผู้ทำรายการ
		- branch_id			String			สาขาที่ทำรายการ
</arguments> 

<return> 
	1						Integer	ถ้าไม่มีข้อผิดพลาด
</return> 

<usage> 
	เรียกใช้โดยส่งข้อมูลผ่าน Structure เข้ามาฟังก์ชั่นจะทำการบันทึกใบจ่ายเงินกู้
	และปรับปรุงยอดคงเหลือ,ด/บ ค้างในสัญญา
	ถ้ามีการหักกลบก็จะไปทำการสร้าง Slip Payin และผ่านรายการรับชำระอืนๆด้วย
	
	str_slippayout		lstr_slippayout
	
	lstr_slippayout.xml_sliphead		= dw_lnrcv.describe( "Datawindow.Data.XML" )
	lstr_slippayout.xml_slipcutloan	= dw_clrlon.describe( "Datawindow.Data.XML" )
	lstr_slippayout.xml_slipcutetc	= dw_clretc.describe( "Datawindow.Data.XML" )
	lstr_slippayout.entry_id			= entry_id
	lstr_slippayout.branch_id			= branch_id
	
	lnv_lnoperate.of_saveslip_lnrcv( lstr_slippayout )
	----------------------------------------------------------------------
	Revision History:
	Version 1.0 (Initial version) Modified Date 20/9/2010 by OhhO

</usage> 
***********************************************************/
string		ls_slipclrno

// ตรวจดูข้อมูลว่ามีเลขที่ใบจ่ายหรือไม่
select		slipclear_no
into		:ls_slipclrno
from		slslippayout
where	( payoutslip_no		= :as_slipno ) and
			( coop_id				= :as_slipcoopid )
using		itr_sqlca ;

if itr_sqlca.sqlcode <> 0 then
	ithw_exception.text	= "ไม่พบข้อมูล Slip การจ่ายเงินกู้เลขที่ "+as_slipno+" กรุณาตรวจสอบ"
	throw ithw_exception
end if

if isnull( ls_slipclrno ) then ls_slipclrno = ""

// เรียก LnOperate
this.of_setsrvlnoperate( true )

try
	inv_lnoperatesrv.of_postslip( "LWD", as_slipcoopid, as_slipno, as_concoopid)
	
	if ls_slipclrno <> "" and not isnull( ls_slipclrno ) then
		inv_lnoperatesrv.of_postslip( "CLC", as_slipcoopid, ls_slipclrno,as_concoopid )
	end if
	
	this.of_setsrvlnoperate( false )
catch( Exception lthw_error )
	rollback using itr_sqlca ;
	throw lthw_error
end try

commit using itr_sqlca ;

return 1
end function

on n_cst_loansrv_lnfinance.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_loansrv_lnfinance.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;this.of_setsrvdwxmlie( true )
end event

event constructor;/***************************************************************
<object>
เป็น Object ที่รวบรวมฟังก์ชั่นสำหรับการทำงานที่เกี่ยวข้องกับการทำรายการเงินกู้ต่างๆ
เช่นการจ่ายเงินกู้ การชำระ การโอนหนี้ การยกเลิก การปรับปรุง ฯลฯ
เมื่อมีการประกาศ Object นี้เสร็จแล้วจำเป็นที่จะต้องเรียกใช้ฟังก์ชั่น
of_initservice( transection ) เพื่อกำหนดตัวแปรหรือค่าคงที่ต่างๆที่จำเป็นสำหรับ
การทำงานของ Object 
</object>
	  
<author>
	Initial Version by Oh ho
</author>
 
<usage>  
  	ตัวอย่างการเรียกใช้งาน
	n_cst_loansrv_lnoperate		lnv_lnoperate 
	lnv_lnoperate	= create n_cst_loansrv_lnoperate
	lnv_lnoperate.initservice( transection ) 
</usage> 
****************************************************************/ 

// ประกาศ Throw สำหรับ Err
ithw_exception	= create Exception
end event

