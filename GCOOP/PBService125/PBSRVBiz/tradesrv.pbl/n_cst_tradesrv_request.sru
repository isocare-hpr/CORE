$PBExportHeader$n_cst_tradesrv_request.sru
$PBExportComments$ใบคำขอซื้อขาย
forward
global type n_cst_tradesrv_request from nonvisualobject
end type
end forward

global type n_cst_tradesrv_request from nonvisualobject
end type
global n_cst_tradesrv_request n_cst_tradesrv_request

type variables
Public:

transaction						itr_sqlca
throwable						ithw_exception

n_cst_dbconnectservice		inv_transection
n_cst_dwxmlieservice			inv_dwxmliesrv
n_cst_doccontrolservice		inv_docsrv


end variables

forward prototypes
private function integer of_setsrvdwxmlie (boolean ab_switch)
public function integer of_initservice (n_cst_dbconnectservice anv_dbtrans) throws throwable
private function integer of_setsrvdoccontrol (boolean ab_switch)
public function integer of_init_req_po (ref str_tradesrv_req astr_tradsrv_req) throws throwable
public function integer of_init_req_qt (ref str_tradesrv_req astr_tradsrv_req) throws throwable
public function integer of_init_req_iv (ref str_tradesrv_req astr_tradsrv_req) throws throwable
public function integer of_save_req_iv (ref str_tradesrv_req astr_tradewsrv_req) throws throwable
public function integer of_save_req_po (ref str_tradesrv_req astr_tradewsrv_req) throws throwable
public function integer of_init_req_cred (ref str_tradesrv_req astr_tradewsrv_req) throws throwable
public function integer of_save_req_cred (ref str_tradesrv_req astr_tradewsrv_req) throws throwable
public function integer of_save_req_debt (ref str_tradesrv_req astr_tradewsrv_req) throws throwable
public function integer of_init_req_debt (ref str_tradesrv_oper astr_tradewsrv_req) throws throwable
public function integer of_save_req_qt (ref str_tradesrv_oper astr_trsrv_oper) throws throwable
public function integer of_init_info_product (ref str_tradesrv_oper astr_tradewsrv_req) throws throwable
end prototypes

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

public function integer of_initservice (n_cst_dbconnectservice anv_dbtrans) throws throwable;/***********************************************************
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
//itr_sqlca = anv_dbtrans.itr_dbconnection
//
//if isnull( inv_transection ) or not isvalid( inv_transection ) then
//	inv_transection = create n_cst_dbconnectservice
//	inv_transection = anv_dbtrans
//end if

// Service Transection
if isnull( inv_transection ) or not isvalid( inv_transection ) then
	inv_transection	= create n_cst_dbconnectservice
end if

inv_transection	= anv_dbtrans
itr_sqlca 			= inv_transection.itr_dbconnection

this.of_setsrvdwxmlie( true )

return 1
end function

private function integer of_setsrvdoccontrol (boolean ab_switch);// Check argument
if isnull( ab_switch ) then
	return -1
end if

if ab_switch then
	if isnull( inv_docsrv ) or not isvalid( inv_docsrv ) then
		inv_docsrv	= create n_cst_doccontrolservice
		inv_docsrv.of_settrans( inv_transection )
		return 1
	end if
else
	if isvalid( inv_docsrv ) then
		destroy inv_docsrv
		return 1
	end if
end if

return 0
end function

public function integer of_init_req_po (ref str_tradesrv_req astr_tradsrv_req) throws throwable;return 1
end function

public function integer of_init_req_qt (ref str_tradesrv_req astr_tradsrv_req) throws throwable;return 1
end function

public function integer of_init_req_iv (ref str_tradesrv_req astr_tradsrv_req) throws throwable;return 1
end function

public function integer of_save_req_iv (ref str_tradesrv_req astr_tradewsrv_req) throws throwable;
return 1
end function

public function integer of_save_req_po (ref str_tradesrv_req astr_tradewsrv_req) throws throwable;
return 1
end function

public function integer of_init_req_cred (ref str_tradesrv_req astr_tradewsrv_req) throws throwable;
return 1
end function

public function integer of_save_req_cred (ref str_tradesrv_req astr_tradewsrv_req) throws throwable;
return 1
end function

public function integer of_save_req_debt (ref str_tradesrv_req astr_tradewsrv_req) throws throwable;
return 1
end function

public function integer of_init_req_debt (ref str_tradesrv_oper astr_tradewsrv_req) throws throwable;//string		ls_debtno, ls_xmlmemdet, ls_sql, ls_addr, ls_payment_type
//long		ll_count
//n_ds		lds_main, lds_debtdt
//string	ls_debtnm, ls_contact, ls_phone, ls_fax
//long		ll_creditterm, ll_leadtime
//datetime ldt_slipdate
//boolean lb_err = false
//
//lds_main = create n_ds
//lds_main.dataobject	= astr_tradewsrv_req.dwo_header
//lds_main.settransobject( itr_sqlca )
//
//lds_main.importstring( XML!, astr_tradewsrv_req.xml_header )
//ls_debtno = lds_main.GetItemString(1, 'debt_no')
//ls_sql =  "select debt_name,   "
//ls_sql +=  "         debt_contact,  " 
//ls_sql +=  "         payment_type,   "
//ls_sql +=  "         debt_addr,   "
//ls_sql +=  "         phone,   "
//ls_sql +=  "         fax,   "
//ls_sql +=  "         credit_term, "  
//ls_sql +=  "         lead_time,   "
//ls_sql +=  "         province_desc, "  
//ls_sql +=  "         district_desc,  " 
//ls_sql +=  "         debt_district,   "
//ls_sql +=  "         debt_province,   "
//ls_sql +=  "         post_code,   "
//ls_sql +=  "         debt_addr||' '||' '||district_desc||' '||province_desc  as addr "
//ls_sql +=  "    from tddebtmaster,   "
//ls_sql +=  "         mbucfprovince,   "
//ls_sql +=  "         mbucfdistrict "
//ls_sql +=  "   WHERE ( tddebtmaster.debt_province = mbucfprovince.province_code (+)) and  "
//ls_sql +=  "         ( tddebtmaster.debt_province = mbucfdistrict.province_code (+)) and  "
//ls_sql +=  "         ( tddebtmaster.debt_district = mbucfdistrict.district_code (+))  and  "
//ls_sql +=  "         debt_no = '" + ls_debtno +"'"
//
//lds_debtdt = f_newdatastoresql(itr_sqlca, ls_sql) //"select * from tddebtmaster where debt_no = '" + ls_debtno + "'")
//lds_debtdt.SetTransObject(itr_sqlca)
//if lds_debtdt.retrieve() <= 0 then
//	ithw_exception.text	= "ไม่พบข้อมูลลูกค้า "+ls_debtno+" กรุณาตรวจสอบ"
//	lb_err = true ; Goto objdestroy
//end if
//
////integer li_colcount, i; string	ls_colnm
////li_colcount = integer(lds_debtdt.describe("DataWindow.Column.Count"))
////FOR i=1 TO li_colcount
////	ls_colnm = lds_debtdt.describe ("#" + string (i) + ".name")
////	Messagebox('test', ls_colnm)
////NEXT
//
//ls_debtnm = lds_debtdt.GetItemString(1, 'tddebtmaster_debt_name')
//ls_contact = lds_debtdt.GetItemString(1, 'tddebtmaster_debt_contact')
//ls_phone = lds_debtdt.GetItemString(1, 'tddebtmaster_phone')
//ls_fax = lds_debtdt.GetItemString(1, 'tddebtmaster_fax')
//ll_creditterm = lds_debtdt.GetItemnumber(1, 'tddebtmaster_credit_term')
//ll_leadtime = lds_debtdt.GetItemnumber(1, 'tddebtmaster_lead_time')
//ls_addr = lds_debtdt.GetItemstring(1, 'addr')
//ls_payment_type = lds_debtdt.GetItemstring(1, 'tddebtmaster_payment_type')
//ldt_slipdate = lds_main.GetItemDatetime(1, 'slip_date')
//
////ls_fax = lds_debtdt.GetItemString(1, 'validay')
//
//lds_main.SetItem(1, 'tddebtmaster_debt_name', ls_debtnm)
//lds_main.SetItem(1, 'debt_contact', ls_contact)
//lds_main.SetItem(1, 'contact_phone', ls_phone)
//lds_main.SetItem(1, 'contact_fax', ls_fax)
//lds_main.SetItem(1, 'credit_term', ll_creditterm)
//lds_main.SetItem(1, 'deliday', ll_leadtime)
//lds_main.SetItem(1, 'validay', 7)
//lds_main.SetItem(1, 'debt_addr', ls_addr)
//lds_main.SetItem(1, 'paymentby', ls_payment_type)
//lds_main.SetItem(1, 'due_date', RelativeDate( date(ldt_slipdate), ll_leadtime ))
//ls_xmlmemdet		= string( lds_main.describe( "Datawindow.data.XML" ) )
//
//astr_tradewsrv_req.xml_header	= ls_xmlmemdet
//
//objdestroy:
//if isvalid(lds_debtdt) then destroy lds_debtdt
//if isvalid(lds_main) then destroy lds_main
//
//if lb_err then
//	rollback using itr_sqlca ;
//	ithw_exception.text = "n_cst_tradesrv_operate.of_save_stockslip_so()" + ithw_exception.text
//	throw ithw_exception
//end if
return 1
end function

public function integer of_save_req_qt (ref str_tradesrv_oper astr_trsrv_oper) throws throwable;//n_ds lds_slip_head , lds_slip_detail
//string ls_xmlheader , ls_xmldetail, ls_slipno, ls_branchid, ls_sliptype, &
//ls_storeid, ls_debtno, ls_entryid
//datetime	ldtm_entrydate, ldtm_opedate
//boolean lb_err = false
//long		ll_count, i
//
//lds_slip_head = create n_ds
//lds_slip_head.dataobject = astr_trsrv_oper.dwo_header
//lds_slip_head.settransobject( itr_sqlca )
//
//lds_slip_detail = create n_ds
//lds_slip_detail.dataobject = astr_trsrv_oper.dwo_detail
//lds_slip_detail.settransobject( itr_sqlca )
//
//ls_xmlheader		= astr_trsrv_oper.xml_header
//ls_xmldetail			= astr_trsrv_oper.xml_detail
//
//lds_slip_head.reset()
//if inv_dwxmliesrv.of_xmlimport( lds_slip_head , ls_xmlheader ) < 1 then
//	ithw_exception.text = "~r~nพบข้อผิดพลาดในการนำเข้าข้อมูลใบทำราย Saleorder(0.1)"
//	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
//	lb_err = true ; Goto objdestroy
//end if
//
//lds_slip_detail.reset()
//if inv_dwxmliesrv.of_xmlimport( lds_slip_detail , ls_xmldetail ) < 1 then
//	ithw_exception.text = "~r~nพบข้อผิดพลาดในการนำเข้าข้อมูลรายละเอียดใบทำราย Saleorder(0.2)"
//	ithw_exception.text += "~r~nกรุณาตรวจสอบ"
//	lb_err = true ; Goto objdestroy
//end if
//
//// ตรวจเช็คจำนวนแถว
//ll_count		= lds_slip_detail.rowcount()
//if ll_count <= 0 then
//	return 0
//end if
//
//ls_sliptype= lds_slip_head.getitemstring( 1, "sliptype_code" )
//ls_storeid= lds_slip_head.getitemstring( 1, "store_id" )
//ls_debtno= lds_slip_head.getitemstring( 1, "debt_no" )
//ls_entryid	= astr_trsrv_oper.entry_id
//ls_branchid		= lds_slip_head.getitemstring( 1, "branch_id" )
//ldtm_entrydate	= f_GetCurrentDate(inv_transection)
//if isnull(ls_storeid) or trim(ls_storeid) = '' then ls_storeid = '001'
//try
//	this.of_setsrvdoccontrol( true )
//	ls_slipno	= inv_docsrv.of_getnewdocno( ls_branchid , "TDSLIPSO")	// get เลขที่เอกสาร
//catch( throwable lthw_getreqdoc )
//	ithw_exception.text	= "~r~nพบขอผิดพลาด (20.1)" + lthw_getreqdoc.text
//	lb_err = true
//end try
//
//// ใส่เลขที่ Slip ใน Header
//lds_slip_head.setitem( 1, "branch_id", ls_branchid )
//lds_slip_head.setitem( 1, "slip_no", ls_slipno )
//lds_slip_head.setitem( 1, "store_id", ls_storeid )
//lds_slip_head.setitem( 1, "sliptype_code", ls_sliptype )
//lds_slip_head.setitem( 1, "debt_no", ls_debtno )
//lds_slip_head.setitem( 1, "entry_id", ls_entryid )
//lds_slip_head.setitem( 1, "entry_date", ldtm_entrydate )
//
//// ใส่เลขที่ Slip และลำดับที่ใน detail
//for i = 1 to ll_count
//	lds_slip_detail.setitem( i, "branch_id", ls_branchid )
//	lds_slip_detail.setitem( i, "slip_no", ls_slipno )
//	lds_slip_detail.setitem( i, "store_id", ls_storeid )
//	lds_slip_detail.setitem( i, "sliptype_code", ls_sliptype )
//	lds_slip_detail.setitem( i, "seq_no", i )
//next
//
//// บันทึก Slip
//if lds_slip_head.update() <> 1 then
//	ithw_exception.text	= "บันทึกข้อมูล Slip ไม่ได้"
//	ithw_exception.text	+= lds_slip_head.of_geterrormessage()
//	rollback using itr_sqlca ;
//	throw ithw_exception
//end if
//
//
//// บันทึก Slip Detail
//if lds_slip_detail.update() <> 1 then
//Messagebox('test', itr_sqlca.sqlcode)
//	ithw_exception.text	= "บันทึกข้อมูล SlipDet ไม่ได้"
//	ithw_exception.text	+= lds_slip_detail.of_geterrormessage()
//	rollback using itr_sqlca ;
//	throw ithw_exception
//end if
//
//astr_trsrv_oper.xml_header	= string( lds_slip_head.describe( "Datawindow.data.XML" ) )
//astr_trsrv_oper.xml_detail = string( lds_slip_detail.describe( "Datawindow.data.XML" ) )
//
//if lb_err then Goto objdestroy
//
//objdestroy:
//if isvalid(lds_slip_head) then destroy lds_slip_head
//if isvalid(lds_slip_detail) then destroy lds_slip_detail
//if isvalid(inv_docsrv) then 	this.of_setsrvdoccontrol( false)
//
////this.of_setsrvdwxmlie( false )
//
//if lb_err then
//	rollback using itr_sqlca ;
//	ithw_exception.text = "n_cst_tradesrv_operate.of_save_stockslip_so()" + ithw_exception.text
//	throw ithw_exception
//end if
//commit using itr_sqlca ;
//

return 1
end function

public function integer of_init_info_product (ref str_tradesrv_oper astr_tradewsrv_req) throws throwable;//string		ls_xmlmemdet, ls_sql, ls_prodcd, ls_branchid, ls_prodnm, ls_uncd, ls_storeid, ls_taxopt
//long		ll_count
//n_ds		lds_main, lds_proddt
//dec{2}	ldec_taxamt
//boolean lb_err = false
//
//lds_main = create n_ds
//lds_main.dataobject	= astr_tradewsrv_req.dwo_header
//lds_main.settransobject( itr_sqlca )
//
//lds_main.importstring( XML!, astr_tradewsrv_req.xml_header )
//ls_branchid = lds_main.GetItemString(1, 'branch_id')
//ls_prodcd = lds_main.GetItemString(1, 'product_no')
//ls_storeid = lds_main.GetItemString(1, 'store_id')
//
//ls_sql =  "select tdproductmaster.product_no, product_desc, unit_code, taxtype_code, tax_rate from tdproductmaster, tdstockmaster   "
//ls_sql +=  " where ( tdproductmaster.branch_id = tdstockmaster.branch_id (+)) and " 
//ls_sql +=  "  ( tdproductmaster.product_no = tdstockmaster.product_no (+)) and "
//ls_sql +=  " tdproductmaster.branch_id = '" + ls_branchid + "' and trim(store_id) = '" + ls_storeid + "' and  tdproductmaster.product_no  = '" + ls_prodcd + "'"
//
//lds_proddt = f_newdatastoresql(itr_sqlca, ls_sql) //"select * from tddebtmaster where debt_no = '" + ls_debtno + "'")
//lds_proddt.SetTransObject(itr_sqlca)
//if lds_proddt.retrieve() <= 0 then
//	ithw_exception.text	= "ไม่พบข้อมูลรหัสสินค้า "+ls_storeid+" กรุณาตรวจสอบ"
//	lb_err = true ; Goto objdestroy
//end if
//
////integer li_colcount, i; string	ls_colnm
////li_colcount = integer(lds_proddt.describe("DataWindow.Column.Count"))
////FOR i=1 TO li_colcount
////	ls_colnm = lds_proddt.describe ("#" + string (i) + ".name")
////	Messagebox('test', ls_colnm)
////NEXT
//
//ls_prodnm = lds_proddt.GetItemstring(1, 'tdproductmaster_product_desc')
//ls_uncd = lds_proddt.GetItemstring(1, 'tdproductmaster_unit_code')
//ls_taxopt = lds_proddt.GetItemString(1, 'tdstockmaster_taxopt')
//ldec_taxamt = lds_proddt.GetItemDecimal(1, 'tdstockmaster_tax_amt')
//
//lds_main.SetItem(1, 'tdproductmaster_product_desc', ls_prodnm)
//lds_main.SetItem(1, 'unit_code', ls_uncd)
//lds_main.SetItem(1, 'taxtype_code', ls_taxopt)
//lds_main.SetItem(1, 'tax_rate', ldec_taxamt)
//ls_xmlmemdet		= string( lds_main.describe( "Datawindow.data.XML" ) )
//
//astr_tradewsrv_req.xml_header	= ls_xmlmemdet
//
//objdestroy:
//if isvalid(lds_proddt) then destroy lds_proddt
//if isvalid(lds_main) then destroy lds_main
//
//if lb_err then
//	rollback using itr_sqlca ;
//	ithw_exception.text = "n_cst_tradesrv_operate.of_save_stockslip_so()" + ithw_exception.text
//	throw ithw_exception
//end if
//
return 1
end function

on n_cst_tradesrv_request.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_tradesrv_request.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ithw_exception = create throwable


end event

event destructor;this.of_setsrvdwxmlie( false )
end event

