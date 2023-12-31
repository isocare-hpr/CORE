$PBExportHeader$n_deposit.sru
namespace
namespace pbservice125
end namespace

forward
global type n_deposit from NonVisualObject
end type
end forward

global type n_deposit from NonVisualObject
end type
global n_deposit n_deposit

forward prototypes
public function integer of_close_year (string as_wspass, integer year, datetime operateDate, string entryId, string machineId, string application, string branchId) throws Exception
public function integer of_print_slip (string as_wspass, string slipNo, string coopId, string printSet, integer ai_status, ref string xml_return) throws Exception
public function string of_analizeaccno (string as_wspass, string deptAccountNoFormat) throws Exception
public function string of_init_deptslip (string as_wspass, string coopId, string deptaccountNo, string SlipcoopId, datetime entryDate, string entryId, string machineId) throws Exception
public function string of_get_default_accid (string as_wspass, string coop_id, string deptwith) throws Exception
public function string of_getrevpaygrp (string as_wspass, string recvpaytype_code) throws Exception
public function string of_get_cashtype (string as_wspass, string recPayType) throws Exception
public function string of_get_deptgroup (string as_wspass, string depttype_code) throws Exception
public function string of_init_deptslip_det (string as_wspass, string deptType, string deptAccountNo, string branchID, datetime entryDate, string recpPayGrp) throws Exception
public function integer of_init_deptslip_calint (string as_wspass, string accNo, string deptcoopID, string entryID, datetime entryDate, string machineID, ref string xmlSlipMaster, ref string xmlSlipItem, ref string errorMessage, ref decimal adc_intsum) throws Exception
public function decimal of_is_equal_dept (string as_wspass, string deptAccountNo, string as_coop_id, decimal balance, string deptTypeCode, string slipType, ref decimal deptAmt) throws Exception
public function integer of_chack_masdue (string as_wspass, string accno) throws Exception
public function integer of_chk_withdrawcount (string as_wspass, string deptTypeCode, string CoopControl, string accNo, string ls_itemGrp, string ls_itemtype_code, integer count_wtd, decimal ldc_intslip_amt, ref integer count_wtdref, ref decimal ldc_fee, datetime WorkDate, ref string as_errmessage) throws Exception
public function string of_deposit (string as_wspass, string xmlSlipMaster, string xmlSlipChq, string xmlSlipItem, string as_apvdoc) throws Exception
public function string of_withdraw_close (string as_wspass, string xmlSlipMaster, string xmlSlipItem, string xmlSlipChq, string as_apvdoc) throws Exception
public function integer of_check_right_permission (string as_wspass, string userId, string branchId, string deptslipXml, string deptChqXml, integer OpenAccount, ref string as_apvdoc, ref string apvCode, ref string codeDesc) throws Exception
public function integer of_openaccount (string as_wspass, string xmlMaster, string xmlCheque, string xmlCoDept, integer period, ref string deptAccountNo, ref string slip_no, ref string as_apvdoc) throws Exception
public function datetime of_getduedate (string as_wspass, string deptType, datetime fromDate) throws Exception
public function string of_get_namemember (string as_wspass, string memberNo, string branchId, integer memberFlag) throws Exception
public function string of_cancel_close (string as_wspass, string deptAccountNo, string branchId, datetime entryDate, string entryId, string apv_id) throws Exception
public function string of_operate_cancel (string as_Wspass, string slipNo, string branchId, string entryId, string machineId, datetime workDate, string apv_id) throws Exception
public function string of_init_data_for_sequest (string as_wspass, string deptacc, string branchid, string machine, string userid, datetime date) throws Exception
public function integer of_update_sequest (string as_wspass, string sequestxml) throws Exception
public function integer of_procdepttrancut_loankeep (string as_wspass, datetime adtm_entrydate, string as_entryid, string as_machine, string as_period, string as_coopid) throws Exception
public function integer of_procdeptupmonth (string as_wspass, string appName, string w_sheet_id, ref str_procdeptupmonth str) throws Exception
public function string of_initintrate_onedate (string as_wspass, string headxml) throws Exception
public function integer of_insert_newrate_int (string as_wspass, string headxml, string ratexml, string entryid, datetime entrydate) throws Exception
public function integer of_get_intdisplay (string as_wspass, string depttype, ref string intdisplay) throws Exception
public function integer of_show_int_all (string as_wspass, ref string ls_xml_int) throws Exception
public function string of_check_approved (string as_wspass, string processId, string branchId) throws Exception
public function integer of_print_book_firstpage (string as_wspass, string deptAccountNo, string as_coopid, datetime workDate, string entryId, string bookNo, string reason, string avpId, integer nf, string printSet, integer rp, integer p_status, ref string xml_return) throws Exception
public function string of_get_chqlist (string as_wspass, datetime deptDate, integer stat, string branchId) throws Exception
public function integer of_genint_f (string as_wspass, string regisXml, ref string as_xml_report) throws Exception
public function integer of_init_statement_f (string as_wspass, string deptaccount_no, ref string as_xml_statement_f) throws Exception
public function integer of_print_statement_f (string as_wspass, string as_xml_main, string as_xml_detail, ref string as_xml_report) throws Exception
public function integer of_cancelchq_bylist (string as_wspass, string entryId, datetime entryDate, string machineId, string branchId, string xmlChqList, integer oldStat) throws Exception
public function decimal[] of_get_permiss_amount (string as_wspass, string userId, string branchId) throws Exception
public function string of_get_apvlist (string as_wspass, decimal deptMax, decimal widthMax, string branchId) throws Exception
public function string of_get_apvlist_detail (string as_wspass, string processId, string branchId) throws Exception
public function boolean of_close_month (string as_wspass, datetime closeDate, string appName, integer month, integer year, string branchId, string entryId) throws Exception
public function integer of_add_newdepttype (string as_wspass, string xmlNewDepttype, string branchId, datetime workDate) throws Exception
public function boolean of_pastchq_bylist (string as_wspass, string entryId, datetime entryDate, string machineId, string branchId, string xmlChqList) throws Exception
public function integer of_init_sum_with_dept (string as_wspass, datetime adtm_date, ref string sum_xml) throws Exception
public function integer of_comfirmbook (string as_wspass, string regisXml, ref string as_xml_report) throws Exception
public function boolean of_calint_estimate (string as_wspass, datetime cal_to_date, string coop_id, string xmlListMidGroup) throws Exception
public function string of_get_extramem_detail (string as_wspass, string extramemno, ref string extramemxml) throws Exception
public function integer of_update_extramem (string as_wspass, string extramemxml) throws Exception
public function boolean of_multi_deposit (string as_wspass, string xmlMain, string xmlDeptCash, string xmlDeptCheque, string branchId, string entryId, string machineId, datetime operateDate, ref string as_apvdoc) throws Exception
public function integer of_recallinterest_statement (string as_wspass, string depttype_code, string accno, decimal spcint_rate, integer spcint_rate_status, datetime date, ref decimal calinterest, ref decimal caltax, integer intchreturn, ref string xml_result) throws Exception
public function integer of_init_reqchgdept (string as_wspass, string accno, ref string xmlreturn, ref string messerror) throws Exception
public function integer of_reqchgdept (string as_wspass, string xml, integer sta_flg) throws Exception
public function string of_get_new_startbook_no (string as_wspass, string BookType, string BookGroup, string BranchID) throws Exception
public function integer of_check_right_permission_cancel (string as_wspass, string userId, string branchId, string deptslipNo, datetime adtmDate, ref string apvCode, ref string codeDesc) throws Exception
public function string of_init_openslip (string as_wspass, string as_tofdept, string personCode, string as_coopid, datetime entryDate, string entryId, string machineId) throws Exception
public function integer of_dept_adjust (string as_wspass, string as_xml_main, string as_xml_detail, string as_entryid, datetime adtm_entry, string as_machine, string as_apv_doc) throws Exception
public function integer of_apv_adj (string as_wspass, string as_apv_docno, datetime adtm_apv, string as_apvuser_id) throws Exception
public function integer of_apv_cancel (string as_wspass, string as_apv_docno, datetime adtm_apv, string as_apvuser_id) throws Exception
public function integer of_apv_permiss (string as_wspass, string as_apv_docno, datetime adtm_apv, string as_apvuser_id) throws Exception
public function integer of_register_book (string as_wspass, string as_bookregis_xml, string as_coop_id, string as_entry_id, string as_machine_id, datetime adtm_operate_date)
public function integer of_init_printbook (string as_wspass, string as_deptaccount_no, string as_coop_id, ref string as_printfrom_xml) throws Exception
public function integer of_print_book (string as_wspass, string as_account_no, string as_coop_id, integer ai_print_from_seq_no, integer ai_page, integer ai_line, boolean ab_bf, string as_printset, ref string as_return, integer ai_print_status, ref string as_xml_return) throws Exception
public function integer of_using_book (string as_wspass, string as_account_no, string as_coop_id, datetime adtm_operate_date, string as_entry_id, string as_apv_id, string as_reson, string as_book_no, string as_book_group, string as_book_type) throws Exception
public function integer of_operate_endday (string as_wspass, datetime adtm_wdate, string as_coop_id, string as_entry_id, string as_machineid) throws Exception
public function integer of_process_upint (string as_wspass, string as_coopid, string as_entry_id, string as_machine_id, datetime adtm_entry_date, datetime adtm_upint_date) throws Exception
public function integer of_updatereport_balday (string as_wspass, datetime adtm_entrydate, string as_coopid, string as_entryid) throws Exception
public function boolean of_is_endmonth_date (string as_wspass, datetime adtm_date) throws Exception
public function integer of_calint_remain (string as_wspass, datetime adtm_calint_to) throws Exception
public function boolean of_is_endyear_date (string as_wspass, datetime adtm_date) throws Exception
public function integer of_genreport_balday (string as_wspass, datetime adtm_date, string as_coopid, string as_entryid) throws Exception
public function integer of_postint_nextday (string as_wspass, datetime adtm_close_date, datetime adtm_wdate, string as_entry_id, string as_coop_id, string as_machineid, string ls_errmessage) throws Exception
public function integer of_update_closedaystatus (string as_wspass, datetime adtm_close_date, string as_app_name, string as_coop_id)
public function integer of_get_loopcloseday (string as_wspass, datetime ldtm_closedate) throws Exception
public function integer of_close_day (string as_wspass, datetime adtm_close_date, datetime adtm_wdate, string as_app_name, string as_coop_id, string as_entry_id, string as_machineid) throws Exception
end prototypes

public function integer of_close_year (string as_wspass, integer year, datetime operateDate, string entryId, string machineId, string application, string branchId) throws Exception;

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	dp_service.of_close_year(year, operateDate, entryId, machineId, application, branchId)
	
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return 1
end function

public function integer of_print_slip (string as_wspass, string slipNo, string coopId, string printSet, integer ai_status, ref string xml_return) throws Exception;int result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_print_slip(slipNo, coopId, printSet, 1, ref xml_return)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function string of_analizeaccno (string as_wspass, string deptAccountNoFormat) throws Exception;string result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = ""		//กำหนดค่าตัวแปร return
string err = ""
string re = ""
//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_analizeaccno(deptAccountNoFormat.Replace("-",""))
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function string of_init_deptslip (string as_wspass, string coopId, string deptaccountNo, string SlipcoopId, datetime entryDate, string entryId, string machineId) throws Exception;decimal result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0		//กำหนดค่าตัวแปร return
string err = ""
string re = ""
//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_init_deptslip(coopId, deptaccountNo, SlipcoopId, entryId, entryDate, machineId, ref re, ref err)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return re
end function

public function string of_get_default_accid (string as_wspass, string coop_id, string deptwith) throws Exception;string result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = ""		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_get_default_accid(coop_id, deptwith)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function string of_getrevpaygrp (string as_wspass, string recvpaytype_code) throws Exception;string result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = ""		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_getrevpaygrp(recvpaytype_code).Trim()
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function string of_get_cashtype (string as_wspass, string recPayType) throws Exception;string result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = ""		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_get_cashtype(recPayType)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function string of_get_deptgroup (string as_wspass, string depttype_code) throws Exception;string result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = ""		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_get_deptgroup(depttype_code).Trim()
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function string of_init_deptslip_det (string as_wspass, string deptType, string deptAccountNo, string branchID, datetime entryDate, string recpPayGrp) throws Exception;integer result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0		//กำหนดค่าตัวแปร return
string xmlSlipItem = ""
string errorMessage = ""
//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_init_deptslip_det(deptType, deptAccountNo, branchID, entryDate, recpPayGrp, ref xmlSlipItem, ref errorMessage)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return xmlSlipItem
end function

public function integer of_init_deptslip_calint (string as_wspass, string accNo, string deptcoopID, string entryID, datetime entryDate, string machineID, ref string xmlSlipMaster, ref string xmlSlipItem, ref string errorMessage, ref decimal adc_intsum) throws Exception;integer result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0	//กำหนดค่าตัวแปร return


//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_init_deptslip_calint(accNo, deptcoopID, entryID, entryDate, machineID, ref xmlSlipMaster, ref xmlSlipItem, ref errorMessage, ref adc_intsum)
	
	in_conn.of_disconnectdb()  //disconnect database
		
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function decimal of_is_equal_dept (string as_wspass, string deptAccountNo, string as_coop_id, decimal balance, string deptTypeCode, string slipType, ref decimal deptAmt) throws Exception;decimal result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0	//กำหนดค่าตัวแปร return


//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_is_equal_dept(deptAccountNo, as_coop_id, balance, deptTypeCode, slipType, ref deptAmt)
	in_conn.of_disconnectdb()  //disconnect database
		
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_chack_masdue (string as_wspass, string accno) throws Exception;decimal result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0	//กำหนดค่าตัวแปร return


//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_chack_masdue(accno)
	in_conn.of_disconnectdb()  //disconnect database
		
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_chk_withdrawcount (string as_wspass, string deptTypeCode, string CoopControl, string accNo, string ls_itemGrp, string ls_itemtype_code, integer count_wtd, decimal ldc_intslip_amt, ref integer count_wtdref, ref decimal ldc_fee, datetime WorkDate, ref string as_errmessage) throws Exception;integer result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
//result = ""	//กำหนดค่าตัวแปร return


//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_chk_withdrawcount(deptTypeCode, CoopControl, accNo, ls_itemGrp, ls_itemtype_code, count_wtd, ldc_intslip_amt, ref count_wtdref, ref ldc_fee, WorkDate, ref as_errmessage)
	in_conn.of_disconnectdb()  //disconnect database
	
		
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function string of_deposit (string as_wspass, string xmlSlipMaster, string xmlSlipChq, string xmlSlipItem, string as_apvdoc) throws Exception;integer result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0	//กำหนดค่าตัวแปร return


//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	string slipNo = ""
	result = dp_service.of_deposit(xmlSlipMaster, xmlSlipChq, xmlSlipItem, ref slipNo, as_apvdoc)
	in_conn.of_disconnectdb()  //disconnect database
		
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return slipNo
end function

public function string of_withdraw_close (string as_wspass, string xmlSlipMaster, string xmlSlipItem, string xmlSlipChq, string as_apvdoc) throws Exception;integer result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	String slipNo = "";	
	result = dp_service.of_withdraw_close(xmlSlipMaster, xmlSlipItem, ref slipNo, xmlSlipChq, as_apvdoc)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return slipNo
end function

public function integer of_check_right_permission (string as_wspass, string userId, string branchId, string deptslipXml, string deptChqXml, integer OpenAccount, ref string as_apvdoc, ref string apvCode, ref string codeDesc) throws Exception;decimal result  //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_check_right_permission(userId, branchId, deptslipXml, deptChqXml, OpenAccount, ref apvCode, ref codeDesc, ref as_apvdoc)
	in_conn.of_disconnectdb()  //disconnect database
	
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_openaccount (string as_wspass, string xmlMaster, string xmlCheque, string xmlCoDept, integer period, ref string deptAccountNo, ref string slip_no, ref string as_apvdoc) throws Exception;integer result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_openaccount(xmlMaster, xmlCheque, xmlCoDept, period, ref deptAccountNo, ref slip_no, ref as_apvdoc)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function datetime of_getduedate (string as_wspass, string deptType, datetime fromDate) throws Exception;datetime result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
//result =		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_getduedate(deptType, fromDate)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function string of_get_namemember (string as_wspass, string memberNo, string branchId, integer memberFlag) throws Exception;string result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = ""		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_get_namemember(memberNo, branchId, memberFlag)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function string of_cancel_close (string as_wspass, string deptAccountNo, string branchId, datetime entryDate, string entryId, string apv_id) throws Exception;string result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = ""		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	string slipNo = ""
	dp_service.of_cancel_close(deptAccountNo, branchId, entryDate, entryId, apv_id, ref slipNo)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return slipNo
end function

public function string of_operate_cancel (string as_Wspass, string slipNo, string branchId, string entryId, string machineId, datetime workDate, string apv_id) throws Exception;integer result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	 String RetslipNo = "";
	result = dp_service.of_operate_cancel(slipNo, branchId, entryId, machineId, workDate, apv_id, ref RetslipNo)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return RetslipNo
end function

public function string of_init_data_for_sequest (string as_wspass, string deptacc, string branchid, string machine, string userid, datetime date) throws Exception;integer result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	String sequestxml = ""
	result = dp_service.of_init_data_for_sequest(deptacc, branchid, machine, userid, date, ref sequestxml)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return sequestxml
end function

public function integer of_update_sequest (string as_wspass, string sequestxml) throws Exception;integer result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_update_sequest(sequestxml)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_procdepttrancut_loankeep (string as_wspass, datetime adtm_entrydate, string as_entryid, string as_machine, string as_period, string as_coopid) throws Exception;integer result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_procdepttrancut_loankeep(adtm_entrydate, as_entryid, as_machine, as_period, as_coopid)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_procdeptupmonth (string as_wspass, string appName, string w_sheet_id, ref str_procdeptupmonth str) throws Exception;integer result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_procdeptupmonth(str)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function string of_initintrate_onedate (string as_wspass, string headxml) throws Exception;integer result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	String ratexml = ""
	result = dp_service.of_initintrate_onedate(headxml, ref ratexml)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return ratexml
end function

public function integer of_insert_newrate_int (string as_wspass, string headxml, string ratexml, string entryid, datetime entrydate) throws Exception;integer result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_insert_newrate_int(headxml, ratexml, entryid, entrydate)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_get_intdisplay (string as_wspass, string depttype, ref string intdisplay) throws Exception;integer result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_get_intdisplay(depttype, ref intdisplay)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_show_int_all (string as_wspass, ref string ls_xml_int) throws Exception;integer result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_show_int_all(ref ls_xml_int)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function string of_check_approved (string as_wspass, string processId, string branchId) throws Exception;string result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = ""		//กำหนดค่าตัวแปร return

string nameapprove =""
//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_check_approved(processId, branchId, ref nameapprove)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_print_book_firstpage (string as_wspass, string deptAccountNo, string as_coopid, datetime workDate, string entryId, string bookNo, string reason, string avpId, integer nf, string printSet, integer rp, integer p_status, ref string xml_return) throws Exception;int result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_print_book_firstpage(deptAccountNo, as_coopid, workDate, entryId, bookNo, reason, avpId, nf, printSet, rp, p_status, ref xml_return, ref xml_return)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function string of_get_chqlist (string as_wspass, datetime deptDate, integer stat, string branchId) throws Exception;integer result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	
	String xmlChequeList = ""
	result = dp_service.of_get_chqlist(deptDate, stat, branchId, ref xmlChequeList)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return xmlChequeList
end function

public function integer of_genint_f (string as_wspass, string regisXml, ref string as_xml_report) throws Exception;integer result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_genint_f(regisXml, as_xml_report)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_init_statement_f (string as_wspass, string deptaccount_no, ref string as_xml_statement_f) throws Exception;integer result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_init_statement_f(deptaccount_no,as_xml_statement_f)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_print_statement_f (string as_wspass, string as_xml_main, string as_xml_detail, ref string as_xml_report) throws Exception;integer result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_print_statement_f(as_xml_main, as_xml_detail, ref as_xml_report)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_cancelchq_bylist (string as_wspass, string entryId, datetime entryDate, string machineId, string branchId, string xmlChqList, integer oldStat) throws Exception;integer result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	String errorMessage = "";
    
	
	
	result = dp_service.of_cancelchq_bylist(entryId, entryDate, machineId, branchId, xmlChqList, oldStat, ref errorMessage)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function decimal[] of_get_permiss_amount (string as_wspass, string userId, string branchId) throws Exception;decimal result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	Decimal widthMax = 0;
    Decimal deptMax = 0;
    Decimal res[2]
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_get_permiss_amount(userId,branchId,ref widthMax,ref deptMax)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return res
end function

public function string of_get_apvlist (string as_wspass, decimal deptMax, decimal widthMax, string branchId) throws Exception;string result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = ""		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	
	//เรียกใช้ฟังก์ชันของ service
	String listxml = "";
	int re = dp_service.of_get_apvlist(deptMax, widthMax, branchId, ref listxml)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return listxml
end function

public function string of_get_apvlist_detail (string as_wspass, string processId, string branchId) throws Exception;string result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = ""		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	
	//เรียกใช้ฟังก์ชันของ service
	String listxml = "";
	int re = dp_service.of_get_apvlist_detail(processId, branchId, ref listxml)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return listxml
end function

public function boolean of_close_month (string as_wspass, datetime closeDate, string appName, integer month, integer year, string branchId, string entryId) throws Exception;boolean result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = false	//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	int res = dp_service.of_close_month(closeDate, appName, month, year, branchId, entryId, closeDate)
	if res = 1 then
		result = true
	else
		result = false
	end if
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_add_newdepttype (string as_wspass, string xmlNewDepttype, string branchId, datetime workDate) throws Exception;int result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0	//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	
	n_cst_deposit_service ln_service
	ln_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	ln_service.of_settrans(in_conn)
	ln_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = ln_service.of_add_newdepttype(xmlNewDepttype, branchId, workDate)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function boolean of_pastchq_bylist (string as_wspass, string entryId, datetime entryDate, string machineId, string branchId, string xmlChqList) throws Exception;boolean result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = false		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	String errorMessage = "";
	int res = dp_service.of_pastchq_bylist(entryId, entryDate, machineId, branchId, xmlChqList, ref errorMessage)
	if res = 1 then
		result = true
	else
		result = false
	end if
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_init_sum_with_dept (string as_wspass, datetime adtm_date, ref string sum_xml) throws Exception;integer result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_init_sum_with_dept(adtm_date, ref sum_xml)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_comfirmbook (string as_wspass, string regisXml, ref string as_xml_report) throws Exception;integer result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_comfirmbook(regisXml, ref as_xml_report)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function boolean of_calint_estimate (string as_wspass, datetime cal_to_date, string coop_id, string xmlListMidGroup) throws Exception;boolean result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = false		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	int res = dp_service.of_calint_estimate(cal_to_date, coop_id, xmlListMidGroup)
	if res = 1 then
		result = true 
	else
		result = false
	end if
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function string of_get_extramem_detail (string as_wspass, string extramemno, ref string extramemxml) throws Exception;string result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = ""		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	// string extramemxml = ""
	int res = dp_service.of_get_extramem_detail(extramemno, ref extramemxml)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return extramemxml
end function

public function integer of_update_extramem (string as_wspass, string extramemxml) throws Exception;integer result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service	
	result = dp_service.of_update_extramem(extramemxml)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function boolean of_multi_deposit (string as_wspass, string xmlMain, string xmlDeptCash, string xmlDeptCheque, string branchId, string entryId, string machineId, datetime operateDate, ref string as_apvdoc) throws Exception;boolean result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = false		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service	
	int res = dp_service.of_multi_deposit(xmlMain, xmlDeptCash, xmlDeptCheque, branchId, entryId, machineId, operateDate, ref as_apvdoc)
	if res = 1 then
		result = true 
	else
		result = false
	end if		
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_recallinterest_statement (string as_wspass, string depttype_code, string accno, decimal spcint_rate, integer spcint_rate_status, datetime date, ref decimal calinterest, ref decimal caltax, integer intchreturn, ref string xml_result) throws Exception;integer result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service	
	result = dp_service.of_recallinterest_statement(depttype_code, accno, spcint_rate, spcint_rate_status, date, ref calinterest, ref caltax, intchreturn, ref xml_result)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_init_reqchgdept (string as_wspass, string accno, ref string xmlreturn, ref string messerror) throws Exception;int result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_init_reqchgdept(accno, ref xmlreturn, ref messerror)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_reqchgdept (string as_wspass, string xml, integer sta_flg) throws Exception;int result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_reqchgdept(xml, 1);
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function string of_get_new_startbook_no (string as_wspass, string BookType, string BookGroup, string BranchID) throws Exception;string result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = ""	//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	int StartBkNo = 0
	StartBkNo = dp_service.of_get_new_startbook_no(BookType, BookGroup, BranchID, ref result)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_check_right_permission_cancel (string as_wspass, string userId, string branchId, string deptslipNo, datetime adtmDate, ref string apvCode, ref string codeDesc) throws Exception;int result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	string slipNo = ""
	result = dp_service.of_check_right_permission(userId, branchId, deptslipNo, adtmDate, ref apvCode, ref codeDesc)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function string of_init_openslip (string as_wspass, string as_tofdept, string personCode, string as_coopid, datetime entryDate, string entryId, string machineId) throws Exception;decimal result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0		//กำหนดค่าตัวแปร return
string err = ""
string re = ""
//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_init_openslip(as_tofdept, personCode, as_coopid, entryDate, entryId, machineId, ref re, ref err)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return re
end function

public function integer of_dept_adjust (string as_wspass, string as_xml_main, string as_xml_detail, string as_entryid, datetime adtm_entry, string as_machine, string as_apv_doc) throws Exception;integer result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_dept_adjust(as_xml_main, as_xml_detail,as_entryid,adtm_entry,as_machine, as_apv_doc)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_apv_adj (string as_wspass, string as_apv_docno, datetime adtm_apv, string as_apvuser_id) throws Exception;integer result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_apv_adj(as_apv_docno, adtm_apv, as_apvuser_id )
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_apv_cancel (string as_wspass, string as_apv_docno, datetime adtm_apv, string as_apvuser_id) throws Exception;integer result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_apv_cancel(as_apv_docno, adtm_apv, as_apvuser_id )
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_apv_permiss (string as_wspass, string as_apv_docno, datetime adtm_apv, string as_apvuser_id) throws Exception;integer result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_apv_permiss(as_apv_docno, adtm_apv, as_apvuser_id )
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_register_book (string as_wspass, string as_bookregis_xml, string as_coop_id, string as_entry_id, string as_machine_id, datetime adtm_operate_date);integer result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_register_book( as_bookregis_xml, as_coop_id, as_entry_id, as_machine_id, adtm_operate_date )
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_init_printbook (string as_wspass, string as_deptaccount_no, string as_coop_id, ref string as_printfrom_xml) throws Exception;int res
res = 0
//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	res = dp_service.of_init_printbook( as_deptaccount_no, as_coop_id, as_printfrom_xml )
	
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return res
end function

public function integer of_print_book (string as_wspass, string as_account_no, string as_coop_id, integer ai_print_from_seq_no, integer ai_page, integer ai_line, boolean ab_bf, string as_printset, ref string as_return, integer ai_print_status, ref string as_xml_return) throws Exception;int res
res = 0

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	res = dp_service.of_print_book( as_account_no, as_coop_id, ai_print_from_seq_no, ai_page, ai_line, ab_bf, as_printset, as_return, ai_print_status, as_xml_return)
	
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return res
end function

public function integer of_using_book (string as_wspass, string as_account_no, string as_coop_id, datetime adtm_operate_date, string as_entry_id, string as_apv_id, string as_reson, string as_book_no, string as_book_group, string as_book_type) throws Exception;int res
res = 0

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	res = dp_service.of_using_book( as_account_no, as_coop_id, adtm_operate_date, as_entry_id, as_apv_id, as_reson, as_book_no, as_book_group, as_book_type)
	
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return res
end function

public function integer of_operate_endday (string as_wspass, datetime adtm_wdate, string as_coop_id, string as_entry_id, string as_machineid) throws Exception;integer result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_operate_endday(adtm_wdate,as_coop_id,as_entry_id,as_machineid)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_process_upint (string as_wspass, string as_coopid, string as_entry_id, string as_machine_id, datetime adtm_entry_date, datetime adtm_upint_date) throws Exception;integer result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_process_upint(as_coopid,as_entry_id,as_machine_id,adtm_entry_date,adtm_upint_date)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_updatereport_balday (string as_wspass, datetime adtm_entrydate, string as_coopid, string as_entryid) throws Exception;integer result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0		//กำหนดค่าตัวแปร return

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_updatereport_balday(adtm_entrydate,as_coopid,as_entryid)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function boolean of_is_endmonth_date (string as_wspass, datetime adtm_date) throws Exception;boolean result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = true
//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_is_endmonth_date(adtm_date)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_calint_remain (string as_wspass, datetime adtm_calint_to) throws Exception;integer result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_calint_remain(adtm_calint_to)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function boolean of_is_endyear_date (string as_wspass, datetime adtm_date) throws Exception;boolean result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = true

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_is_endyear_date(adtm_date)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_genreport_balday (string as_wspass, datetime adtm_date, string as_coopid, string as_entryid) throws Exception;integer result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_genreport_balday(adtm_date,as_coopid,as_entryid)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_postint_nextday (string as_wspass, datetime adtm_close_date, datetime adtm_wdate, string as_entry_id, string as_coop_id, string as_machineid, string ls_errmessage) throws Exception;integer result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_postint_nextday(adtm_close_date,adtm_wdate,as_entry_id,as_coop_id,as_machineid,ls_errmessage)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_update_closedaystatus (string as_wspass, datetime adtm_close_date, string as_app_name, string as_coop_id);integer result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_update_closedaystatus(adtm_close_date,as_app_name,as_coop_id)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_get_loopcloseday (string as_wspass, datetime ldtm_closedate) throws Exception;integer result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_get_loopcloseday(ldtm_closedate)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_close_day (string as_wspass, datetime adtm_close_date, datetime adtm_wdate, string as_app_name, string as_coop_id, string as_entry_id, string as_machineid) throws Exception;integer result //สร้างตัวแปรที่ return ไปที่ฝั่งC#
result = 0

//สร้าง connection ของ database
n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	//เชื่อมต่อ database
	in_conn.of_connectdb(as_wspass)
	//สร้าง object ของ service 
	n_cst_deposit_service dp_service
	dp_service = create n_cst_deposit_service
	//เริ่มต้นการกำหนดค่าของ service
	dp_service.of_settrans(in_conn)
	dp_service.of_init()
	//เรียกใช้ฟังก์ชันของ service
	result = dp_service.of_close_day(adtm_close_date,adtm_wdate,as_app_name,as_coop_id,as_entry_id,as_machineid)
	in_conn.of_disconnectdb()  //disconnect database
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

on n_deposit.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_deposit.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on
