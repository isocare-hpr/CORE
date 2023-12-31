$PBExportHeader$n_cst_budget_service.sru
forward
global type n_cst_budget_service from nonvisualobject
end type
end forward

global type n_cst_budget_service from nonvisualobject
end type
global n_cst_budget_service n_cst_budget_service

type variables
private:
transaction	itr_sqlca
Exception	ithw_exception

n_cst_progresscontrol		inv_progress
n_cst_dbconnectservice		inv_connection
n_cst_doccontrolservice		inv_docservice
n_cst_datetimeservice		inv_datetime
n_ds	ids_constant

string		is_doccode
end variables

forward prototypes
public function string of_get_budget_yearlist ()
public function integer of_init (n_cst_dbconnectservice anv_dbtrans)
public function integer of_save_budget_year (string as_budget_xml) throws Exception
public function integer of_save_slip (string as_budget_head_xml, string as_budget_detail_xml) throws Exception
private function any of_get_constant (integer ai_row, string as_col_name)
private function string of_err_generate_import_xml (integer ai_error)
public function integer of_save_budget_type (string as_budgettype_xml) throws Exception
public function integer of_save_budget_detail (string as_budgetdetail_xml) throws Exception
public function integer of_save_budget_group (string as_budgetgroup_xml) throws Exception
public function integer of_save_budget_groupyear (string as_budgetgroupyear_xml) throws Exception
public function integer of_save_budget_typeyear (string as_budgettypeyear_xml) throws Exception
public function string of_get_setbudget_amount (integer ai_year) throws Exception
public function integer of_close_month (integer ai_year, integer ai_month) throws Exception
private function decimal of_get_begin (integer ai_year, integer ai_month, string as_group, string as_type)
private function decimal of_get_pay_between (string as_group, string as_type, datetime adtm_start_date, datetime adtm_end_date, integer ai_inc_lastdate)
private function decimal of_get_balbegin_month (integer ai_year, integer ai_month, string as_group, string as_type)
private function decimal of_get_balbegin_month (integer ai_year, integer ai_month, integer ai_seq_no, integer ai_sort_seq)
public function string of_get_bgtype_nonaccid ()
public function integer of_save_budget_amount (integer an_year, string as_budgetamt_xml) throws Exception
public function integer of_save_fromcut_pay (string as_cutpay_xml) throws Exception
private function integer of_get_daterange_year (integer an_year, ref datetime adtm_start_date, ref datetime adtm_end_date)
public function string of_get_bg_movment_year (integer an_year, string as_group, string as_type)
private function decimal of_get_budget_amt (integer ai_year, string as_group, string as_type)
public function string of_get_bg_movment_month (integer an_year, integer an_month, string as_group, string as_type)
public function string of_process_cutpay (datetime adtm_date, string as_branch_id) throws Exception
private function string of_get_list_fromfin (datetime adtm_date, string as_branch_id) throws Exception
public function integer of_save_closemonth_detail (string as_closemonth_detail_xml) throws Exception
private function integer of_get_sort_seq_year (integer ai_year, string as_budgetgroup_code, string as_budgettype_code, ref integer ai_seq_no, ref integer ai_sort_seq)
private function integer of_get_group_type_year (integer ai_year, ref string as_budgetgroup_code, ref string as_budgettype_code, integer ai_seq_no, integer ai_sort_seq)
public function string of_get_bg_movment_month (integer an_year, integer an_month, integer ai_seq_no, integer ai_sort_seq)
public function string of_get_bg_movment_year (integer an_year, integer ai_seq_no, integer ai_sort_seq)
public function integer of_get_year_budget (datetime adtm_date)
public function integer of_save_fromedit_pay (string as_cutpay_xml) throws Exception
public function string of_gen_rpt_bfclose_month (integer ai_year, integer ai_month) throws Exception
end prototypes

public function string of_get_budget_yearlist ();n_ds		lds_budget_year
integer	li_row
string		ls_return

lds_budget_year	= create n_ds
lds_budget_year.dataobject = "d_bg_budgetyear"
lds_budget_year.Settransobject( itr_sqlca )

li_row		= lds_budget_year.retrieve( )
ls_return	= ""

if ( li_row > 0 ) then
	ls_return	= lds_budget_year.describe( "Datawindow.Data.XML" )
end if

return ls_return	
end function

public function integer of_init (n_cst_dbconnectservice anv_dbtrans);// Service Transection
if isnull( inv_connection ) or not isvalid( inv_connection ) then
	inv_connection	= create n_cst_dbconnectservice	
end if

inv_connection	= anv_dbtrans

itr_sqlca		= create transaction
itr_sqlca 		= inv_connection.itr_dbconnection

// สร้าง Progress สำหรับแสดงสถานะการประมวลผล
inv_progress	= create n_cst_progresscontrol
inv_datetime	= create n_cst_datetimeservice
		

ids_constant		= create n_ds
ids_constant.dataobject = "d_bg_constant"
ids_constant.settransobject( itr_sqlca )
ids_constant.retrieve( )

inv_docservice			= create n_cst_doccontrolservice	
inv_docservice.of_settrans( anv_dbtrans )

return 1
end function

public function integer of_save_budget_year (string as_budget_xml) throws Exception;n_ds		lds_budget_year
integer	li_row, li_rc, li_year, li_close_status, li_found
string		ls_return
datetime	ldtm_date_begin, ldtm_date_end
lds_budget_year	= create n_ds
lds_budget_year.dataobject = "d_bg_budgetyear"

if not  isnull( as_budget_xml ) and trim( as_budget_xml ) <> ""  then
	li_rc	= lds_budget_year.importString( XML!, as_budget_xml )
	if ( li_rc < 0 ) then
		ithw_exception.text		+= this.of_err_generate_import_xml( li_rc )
		throw ithw_exception
	end if
end if

for li_row = 1 to lds_budget_year.rowcount()
	li_found	= 0
	li_year	= lds_budget_year.GetitemNumber( li_row, "budgetyear" )
	
	ldtm_date_begin	= lds_budget_year.GetitemDatetime( li_row, "beginning_of_budget" )
	ldtm_date_end		= lds_budget_year.GetitemDatetime( li_row, "ending_of_budget" )
	li_close_status		= lds_budget_year.GetitemNumber( li_row, "budget_status" )
	
	if isnull( li_year ) or ( li_year = 0 ) or isnull( ldtm_date_begin ) or isnull( ldtm_date_end ) then
		ithw_exception.text		+= "Error ค่าข้อมูลไม่สมบูรณ์กรุณาตรวจสอบ" 
		rollback using itr_sqlca ;
		throw ithw_exception
	end if
	
	select		count( budgetyear )
	into		:li_found
	from		BUDGETYEAR
	where	budgetyear	= :li_year
	using	itr_sqlca;
	
	if isnull( li_found ) then li_found = 0
	
	if ( li_found > 0 ) then
		update	BUDGETYEAR
		set			BEGINNING_OF_BUDGET	= :ldtm_date_begin ,
					ENDING_OF_BUDGET		= :ldtm_date_end,
					BUDGET_STATUS			= :li_close_status
		where	budgetyear	= :li_year
		using	itr_sqlca;
		
	else
		insert into BUDGETYEAR
		(	BUDGETYEAR,			BEGINNING_OF_BUDGET,			ENDING_OF_BUDGET,			BUDGET_STATUS)
		values
		(	:li_year,					:ldtm_date_begin,					:ldtm_date_end,				:li_close_status )
		using	itr_sqlca;
		
	end if
	
	if ( itr_sqlca.sqlcode <> 0 ) then
		ithw_exception.text		+= "Error " + itr_sqlca.sqlerrtext
		rollback using itr_sqlca ;
		throw ithw_exception
	end if
	
next

commit using itr_sqlca ;
return 1
end function

public function integer of_save_slip (string as_budget_head_xml, string as_budget_detail_xml) throws Exception;n_ds		lds_budget_head, lds_budget_detail
integer	li_row, li_rc
string		ls_return
string		ls_doccode, ls_doc_no

// นำเข้าข้อมูลรายการหลัก
lds_budget_head	= create n_ds
lds_budget_head.dataobject = "d_bg_budgetslip"
lds_budget_head.settransobject(itr_sqlca )

if not  isnull( as_budget_head_xml ) and trim( as_budget_head_xml ) <> ""  then
	li_rc	= lds_budget_head.importString( XML!, as_budget_head_xml )
	if ( li_rc < 0 ) then
		ithw_exception.text		+= "Main Data " + this.of_err_generate_import_xml( li_rc )
		throw ithw_exception
	end if
end if

// นำเข้าข้อมูลรายการย่อย
lds_budget_detail	= create n_ds
lds_budget_detail.dataobject = "d_bg_budgetslip"
lds_budget_detail.settransobject(itr_sqlca )

if not  isnull( as_budget_detail_xml ) and trim( as_budget_detail_xml ) <> ""  then
	li_rc	= lds_budget_detail.importString( XML!, as_budget_detail_xml )
	if ( li_rc < 0 ) then
		ithw_exception.text		+= "Detail Data " + this.of_err_generate_import_xml( li_rc )
		throw ithw_exception
	end if
end if

// รหัสเลขที่เอกสาร
ls_doccode	= string( this.of_get_constant( 1, "paydoc_code" ) )
if isnull( ls_doccode ) or trim( ls_doccode ) = "" then
	ithw_exception.text		+= "ไม่มีการกำหนดการใช้ รหัสเลขที่ใบสำคัญจ่ายในค่าคงที่ระบบ "
	throw ithw_exception
end if


//a_edit     ls_doc_no	= inv_docservice.of_getnewdocno( ls_doccode )

lds_budget_head.SetItem( 1, "slip_no", ls_doc_no )

for li_row = 1 to lds_budget_detail.rowcount( )
	lds_budget_detail.SetItem( li_row , "slip_no", ls_doc_no )
	lds_budget_detail.SetItem( li_row , "seq_no", li_row )
next

if ( lds_budget_head.Update() <> 1 ) then
	ithw_exception.text		+= "Update Master Fail " + lds_budget_head.of_geterrormessage( )
	rollback using itr_sqlca ;
	throw ithw_exception
end if

if ( lds_budget_detail.Update() <> 1 ) then
	ithw_exception.text		+= "Update Detail Fail " + lds_budget_detail.of_geterrormessage( )
	rollback using itr_sqlca ;
	throw ithw_exception
end if

commit using itr_sqlca ;
return 1
end function

private function any of_get_constant (integer ai_row, string as_col_name);any		la_attribconstant

la_attribconstant	= ids_constant.of_getitemany(ai_row , as_col_name)

return la_attribconstant
end function

private function string of_err_generate_import_xml (integer ai_error);choose case ai_error
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

public function integer of_save_budget_type (string as_budgettype_xml) throws Exception;n_ds		lds_budget_type
integer	li_row, li_rc , li_found
string		ls_budgetgroup_code, ls_budgettype_code, ls_budgettype_desc, ls_account_id

lds_budget_type	= create n_ds
lds_budget_type.dataobject = "d_bg_budgettype_list"

if not  isnull( as_budgettype_xml ) and trim( as_budgettype_xml ) <> ""  then
	li_rc	= lds_budget_type.importString( XML!, as_budgettype_xml )
	if ( li_rc < 0 ) then
		ithw_exception.text		+= this.of_err_generate_import_xml( li_rc )
		throw ithw_exception
	end if
end if

for li_row = 1 to lds_budget_type.rowcount()
	li_found	= 0
	ls_budgetgroup_code	= lds_budget_type.GetitemString( li_row, "budgetgroup_code" )	
	ls_budgettype_code	= lds_budget_type.GetitemString( li_row, "budgettype_code" )
	ls_budgettype_desc	= trim( lds_budget_type.GetitemString( li_row, "budgettype_desc" ) )
	ls_account_id			= trim( lds_budget_type.GetitemString( li_row, "account_id" ) )
	
	select		count( budgetgroup_code )
	into		:li_found
	from		budgettype
	where	budgetgroup_code	= :ls_budgetgroup_code and
				budgettype_code	= :ls_budgettype_code
	using	itr_sqlca;
	
	if isnull( li_found ) then li_found = 0
	
	if ( li_found > 0 ) then
		update	budgettype
		set			budgettype_desc	= :ls_budgettype_desc ,
					account_id			= :ls_account_id
		where	budgetgroup_code	= :ls_budgetgroup_code and
					budgettype_code	= :ls_budgettype_code
		using	itr_sqlca;
		
	else
		insert into budgettype
		(	budgetgroup_code,			budgettype_code,			budgettype_desc,			account_id)
		values
		(	:ls_budgetgroup_code,		:ls_budgettype_code,		:ls_budgettype_desc,		:ls_account_id )
		using	itr_sqlca;
		
	end if
	
	if ( itr_sqlca.sqlcode <> 0 ) then
		ithw_exception.text		+= "Error " + itr_sqlca.sqlerrtext
		rollback using itr_sqlca ;
		throw ithw_exception
	end if
	
next

commit using itr_sqlca ;
return 1
end function

public function integer of_save_budget_detail (string as_budgetdetail_xml) throws Exception;n_ds		lds_budget_detail
integer	li_row, li_rc , li_found, li_budgetyear, li_budgetdetail_flag
integer	li_seq_no, li_sort_seq, li_sort_order
string		ls_budgetdetail_desc, ls_budgetdetail_id, ls_budgetcontrol
dec{2}	ldc_budgetdetail_amt

lds_budget_detail	= create n_ds
lds_budget_detail.dataobject = "d_bg_budgetdetailreq_list"

if not  isnull( as_budgetdetail_xml ) and trim( as_budgetdetail_xml ) <> ""  then
	li_rc	= lds_budget_detail.importString( XML!, as_budgetdetail_xml )
	if ( li_rc < 0 ) then
		ithw_exception.text		+= this.of_err_generate_import_xml( li_rc )
		throw ithw_exception
	end if
end if

li_budgetyear	= lds_budget_detail.GetitemNumber( 1, "budgetyear" )	
li_seq_no		= lds_budget_detail.GetitemNumber( 1, "seq_no" )	
li_sort_seq		= lds_budget_detail.GetitemNumber( 1, "sort_seq" )
	
delete from BUDGETDETAILREQ
where	budgetyear		= :li_budgetyear and
			seq_no			= :li_seq_no and
			sort_seq			= :li_sort_seq
using	itr_sqlca;	
	
for li_row = 1 to lds_budget_detail.rowcount()
	li_found	= 0
	
	ls_budgetdetail_desc		= lds_budget_detail.GetitemString( li_row, "budgetdetail_desc" )
	ls_budgetdetail_id			= lds_budget_detail.GetitemString( li_row, "budgetdetail_id" )
	ls_budgetcontrol			= lds_budget_detail.GetitemString( li_row, "budgetcontrol" )
	ldc_budgetdetail_amt		= lds_budget_detail.GetitemDecimal( li_row, "budgetdetail_amt" )	
	li_budgetdetail_flag		= lds_budget_detail.GetitemNumber( li_row, "budgetdetail_flag" )	
	li_sort_order				= lds_budget_detail.GetitemNumber( li_row, "sort_order" )	
	
	if isnull( li_budgetdetail_flag ) then li_budgetdetail_flag = 0
	if isnull( ldc_budgetdetail_amt ) then ldc_budgetdetail_amt = 0
	if isnull( ls_budgetcontrol ) then ls_budgetcontrol = ls_budgetdetail_id

	insert into BUDGETDETAILREQ
	(	seq_no,							sort_seq,						budgetdetail_id,			budgetyear,
		budgetdetail_desc,				budgetcontrol,				budgetdetail_amt,			budgetdetail_flag,
		sort_order
	)
	values
	(	:li_seq_no,						:li_sort_seq,					:ls_budgetdetail_id,		:li_budgetyear,
		:ls_budgetdetail_desc,		:ls_budgetcontrol,			:ldc_budgetdetail_amt,	:li_budgetdetail_flag,
		:li_sort_order
	)
	using	itr_sqlca;
	
	if ( itr_sqlca.sqlcode <> 0 ) then
		ithw_exception.text		+= "Error " + itr_sqlca.sqlerrtext
		rollback using itr_sqlca ;
		throw ithw_exception
	end if
	
next

commit using itr_sqlca ;
return 1
end function

public function integer of_save_budget_group (string as_budgetgroup_xml) throws Exception;n_ds		lds_budget_group
integer	li_row, li_rc , li_found
string		ls_budgetgroup_code, ls_budgetgroup_desc

lds_budget_group	= create n_ds
lds_budget_group.dataobject = "d_bg_budgetgroup"

if not  isnull( as_budgetgroup_xml ) and trim( as_budgetgroup_xml ) <> ""  then
	li_rc	= lds_budget_group.importString( XML!, as_budgetgroup_xml )
	if ( li_rc < 0 ) then
		ithw_exception.text		+= this.of_err_generate_import_xml( li_rc )
		throw ithw_exception
	end if
end if

for li_row = 1 to lds_budget_group.rowcount()
	li_found	= 0
	ls_budgetgroup_code	= lds_budget_group.GetitemString( li_row, "budgetgroup_code" )	
	ls_budgetgroup_desc	= trim( lds_budget_group.GetitemString( li_row, "budgetgroup_desc" ) )
	
	select		count( budgetgroup_code )
	into		:li_found
	from		budgetgroup
	where	budgetgroup_code	= :ls_budgetgroup_code
	using	itr_sqlca;
	
	if isnull( li_found ) then li_found = 0
	
	if ( li_found > 0 ) then
		update	budgetgroup
		set			budgetgroup_desc	= :ls_budgetgroup_desc
		where	budgetgroup_code	= :ls_budgetgroup_code
		using	itr_sqlca;
		
	else
		insert into budgetgroup
		(	budgetgroup_code,			budgetgroup_desc )
		values
		(	:ls_budgetgroup_code,		:ls_budgetgroup_desc  )
		using	itr_sqlca;
		
	end if
	
	if ( itr_sqlca.sqlcode <> 0 ) then
		ithw_exception.text		+= "Error " + itr_sqlca.sqlerrtext
		rollback using itr_sqlca ;
		throw ithw_exception
	end if
	
next

commit using itr_sqlca ;
return 1
end function

public function integer of_save_budget_groupyear (string as_budgetgroupyear_xml) throws Exception;n_ds		lds_budget_groupyear
integer	li_row, li_rc , li_found,li_budgetyear, li_seq_no, li_sort_order
string		ls_budgetgroup_code

lds_budget_groupyear	= create n_ds
lds_budget_groupyear.dataobject = "d_bg_budgetgroup_year"

if not  isnull( as_budgetgroupyear_xml ) and trim( as_budgetgroupyear_xml ) <> ""  then
	li_rc	= lds_budget_groupyear.importString( XML!, as_budgetgroupyear_xml )
	if ( li_rc < 0 ) then
		ithw_exception.text		+= this.of_err_generate_import_xml( li_rc )
		throw ithw_exception
	end if
end if

for li_row = 1 to lds_budget_groupyear.rowcount()
	li_found	= 0
	ls_budgetgroup_code	= lds_budget_groupyear.GetitemString( li_row, "budgetgroup_code" )	
	li_budgetyear			= lds_budget_groupyear.GetitemNumber( li_row, "budgetyear" )
	li_seq_no				= lds_budget_groupyear.GetitemNumber( li_row, "seq_no" )
	li_sort_order			= lds_budget_groupyear.GetitemNumber( li_row, "sort_order" )
	
	
	select		count( budgetgroup_code )
	into		:li_found
	from		BUDGETGROUP_YEAR
	where	budgetyear	= :li_budgetyear and
				seq_no		= :li_seq_no
	using	itr_sqlca;
	
	if isnull( li_found ) then li_found = 0
	
	if ( li_found = 0 ) then
		insert into BUDGETGROUP_YEAR
		(	budgetgroup_code,			budgetyear,				seq_no,			sort_order )
		values
		(	:ls_budgetgroup_code,		:li_budgetyear,			:li_seq_no,		:li_sort_order  )
		using	itr_sqlca;
		
	end if
	
	if ( itr_sqlca.sqlcode <> 0 ) then
		ithw_exception.text		+= "Error " + itr_sqlca.sqlerrtext
		rollback using itr_sqlca ;
		throw ithw_exception
	end if
	
next

commit using itr_sqlca ;
return 1
end function

public function integer of_save_budget_typeyear (string as_budgettypeyear_xml) throws Exception;n_ds		lds_budgettypeyear
integer	li_row, li_rc , li_found,li_budgetyear, li_seq_no, li_sort_seq
string		ls_budgetgroup_code, ls_budgettype_code, ls_seq_text, ls_sort_desc

lds_budgettypeyear	= create n_ds
lds_budgettypeyear.dataobject = "d_bg_budgettype_year"

if not  isnull( as_budgettypeyear_xml ) and trim( as_budgettypeyear_xml ) <> ""  then
	li_rc	= lds_budgettypeyear.importString( XML!, as_budgettypeyear_xml )
	if ( li_rc < 0 ) then
		ithw_exception.text		+= this.of_err_generate_import_xml( li_rc )
		throw ithw_exception
	end if
end if

for li_row = 1 to lds_budgettypeyear.rowcount()
	li_found	= 0
	ls_budgetgroup_code	= lds_budgettypeyear.GetitemString( li_row, "budgetgroup_code" )	
	ls_budgettype_code	= lds_budgettypeyear.GetitemString( li_row, "budgettype_code" )
	ls_seq_text				= trim( lds_budgettypeyear.GetitemString( li_row, "seq_text" ) )
	ls_sort_desc				= trim( lds_budgettypeyear.GetitemString( li_row, "sort_desc" ) )
	
	li_sort_seq				= lds_budgettypeyear.GetitemNumber( li_row, "sort_seq" )
	li_budgetyear			= lds_budgettypeyear.GetitemNumber( li_row, "budgetyear" )
	li_seq_no				= lds_budgettypeyear.GetitemNumber( li_row, "seq_no" )
	
	select		count( budgetgroup_code )
	into		:li_found
	from		BUDGETTYPE_YEAR
	where	budgetyear	= :li_budgetyear and
				seq_no		= :li_seq_no and
				sort_seq		= :li_sort_seq
	using	itr_sqlca;
	
	if isnull( li_found ) then li_found = 0
	
	if ( li_found = 0 ) then
		insert into BUDGETTYPE_YEAR
		(	budgetgroup_code,			budgetyear,				seq_no,				budgettype_code,
			seq_text,							sort_seq,					sort_desc
		)
		values
		(	:ls_budgetgroup_code,		:li_budgetyear,			:li_seq_no,			:ls_budgettype_code,
			:ls_seq_text,					:li_sort_seq,				:ls_sort_desc
		)
		using	itr_sqlca;
	else
		update	BUDGETTYPE_YEAR
		set			budgetgroup_code		= :ls_budgetgroup_code ,
					budgettype_code		= :ls_budgettype_code,
					seq_text					= :ls_seq_text
		where	budgetyear	= :li_budgetyear and
					seq_no		= :li_seq_no and
					sort_seq		= :li_sort_seq
		using	itr_sqlca;
	
	end if
	
	if ( itr_sqlca.sqlcode <> 0 ) then
		ithw_exception.text		+= "Error " + itr_sqlca.sqlerrtext
		rollback using itr_sqlca ;
		throw ithw_exception
	end if
	
next

commit using itr_sqlca ;
return 1
end function

public function string of_get_setbudget_amount (integer ai_year) throws Exception;n_ds		lds_data
integer	li_row, li_seq_no, li_sort_seq

declare cur_select cursor for
select		SEQ_NO, SORT_SEQ
from		budgettype_year
where	BUDGETYEAR = :ai_year
using itr_sqlca;

open cur_select ;

fetch cur_select into :li_seq_no, :li_sort_seq ;

do while itr_sqlca.sqlnrows > 0
	li_row		= 0
	select		count( BUDGETYEAR ) 
	into		:li_row
	from		BUDGETSETAMOUNT
	where	BUDGETYEAR	= :ai_year and
				SEQ_NO			= :li_seq_no and
				SORT_SEQ		= :li_sort_seq
	using itr_sqlca ;
	
	if ( li_row = 0 ) then
		INSERT INTO BUDGETSETAMOUNT  
		(	BUDGETYEAR,				SEQ_NO,   				SETBUDGET_AMT,   				SORT_SEQ,   
			BUDGETREASON
		)  
		VALUES
		(	:ai_year,   					:li_seq_no,   			0,   									:li_sort_seq,   
			null 
		) using itr_sqlca  ;
		
		if ( itr_sqlca.sqlcode <> 0 ) then
			ithw_exception.text		+= "ไม่สามารถเพิ่มข้อมูลใน BUDGETSETAMOUNT ได้ " +  itr_sqlca.sqlerrtext
			close cur_select;
			rollback using itr_sqlca;
			throw ithw_exception
		end if
	end if
	
	fetch cur_select into :li_seq_no, :li_sort_seq ;
loop

close cur_select;
commit using itr_sqlca ;

lds_data		= create n_ds
lds_data.dataobject = "d_bg_budgetsetamt_list_new"
lds_data.settransobject( itr_sqlca )

li_row		= 0
li_row		= lds_data.retrieve( ai_year )


if ( li_row > 0 ) then
	return lds_data.Describe( "Datawindow.Data.XML" )
else
	return "" 
end if

end function

public function integer of_close_month (integer ai_year, integer ai_month) throws Exception;integer		li_seq_no, li_sort_seq, li_max, li_index
dec{2}		ldc_bal_begin, ldc_actpay_amt, ldc_balance_amt, ldc_actpayyear_amt
string			ls_group, ls_type
datetime		ldtm_start_date, ldtm_end_date, ldtm_startyear_date
integer		li_budgetyear, li_found

ldtm_start_date	= datetime( date( ai_year, ai_month, 1  ) )
ldtm_end_date		= datetime( inv_datetime.of_lastdayofmonth( date( ldtm_start_date ) ) )

inv_progress.istr_progress.progress_max = 1
inv_progress.istr_progress.status	= 8
inv_progress.istr_progress.progress_text = "ปิดงานประจำเดือน "

select		budgetyear, beginning_of_budget
into		:li_budgetyear, :ldtm_startyear_date
from		budgetyear
where	beginning_of_budget	<= :ldtm_start_date and
			ending_of_budget		>= :ldtm_start_date
using itr_sqlca;

//delete from budgetclosemonth
//where	budgetyear		= :ai_year and
//			budgetmonth	= :ai_month
//using itr_sqlca;
//
//if ( itr_sqlca.sqlcode <> 0  ) then
//	inv_progress.istr_progress.status	= -1
//	ithw_exception.text		+= "Error " + itr_sqlca.sqlerrtext
//	rollback using itr_sqlca ;
//	throw ithw_exception
//end if

select		count( SEQ_NO )
into		:li_max
from		budgettype_year
where	BUDGETYEAR = :li_budgetyear
using itr_sqlca;

if isnull( li_max ) then li_max = 0

inv_progress.istr_progress.subprogress_max = li_max

declare cur_select cursor for
select		SEQ_NO, SORT_SEQ
from		budgettype_year
where	BUDGETYEAR = :li_budgetyear
using itr_sqlca;

open cur_select ;

fetch cur_select into :li_seq_no, :li_sort_seq ;

li_index	= 0

do while itr_sqlca.sqlnrows > 0
	li_index ++
	
	inv_progress.istr_progress.subprogress_index	= li_index
	inv_progress.istr_progress.subprogress_text	= "ปรับปรุงสถานะ ปิดงานสิ้นเดือน"
	
	select		budgetgroup_code,budgettype_code
	into		:ls_group, :ls_type
	from		budgettype_year
	where	BUDGETYEAR		= :li_budgetyear and
				( SEQ_NO			= :li_seq_no ) AND  
				( SORT_SEQ		= :li_sort_seq )
	using itr_sqlca;

	ldc_bal_begin			= this.of_get_balbegin_month( ai_year, ai_month, li_seq_no, li_sort_seq )
	// หากเป็น 0 ให้ใช้ยอดตั้ง
	if ( ldc_bal_begin = 0 ) then
		ldc_actpay_amt	= 0.00
		ldc_bal_begin	= this.of_get_budget_amt( li_budgetyear, ls_group,ls_type )
		ldc_actpay_amt	= this.of_get_pay_between(ls_group,ls_type , ldtm_startyear_date , ldtm_start_date , 0  )
		ldc_bal_begin	= ldc_bal_begin - ldc_actpay_amt
	end if
	
	ldc_actpay_amt			= 0.00
	ldc_actpay_amt			= this.of_get_pay_between(ls_group,ls_type , ldtm_start_date, ldtm_end_date, 1  )
	
	ldc_actpayyear_amt	= 0.00
	ldc_actpayyear_amt	= this.of_get_pay_between(ls_group,ls_type , ldtm_startyear_date , ldtm_end_date, 1  )
	
	ldc_balance_amt		= ldc_bal_begin - ldc_actpay_amt
	li_found					= 0
	
	select		count( BUDGETYEAR )
	into		:li_found
	from		BUDGETCLOSEMONTH
	where	BUDGETYEAR		= :ai_year and
				SEQ_NO				= :li_seq_no and
				SORT_SEQ			= :li_sort_seq and
				BUDGETMONTH		= :ai_month
	using itr_sqlca;
	
	if isnull( li_found ) then li_found= 0
	
	if ( li_found = 0 ) then
		INSERT INTO BUDGETCLOSEMONTH  
		(	BUDGETYEAR,   				SEQ_NO,   				SORT_SEQ,   				BUDGETMONTH,   
			BAL_BEGIN,   					ACTPAY_AMT,   		ACTPAYYEAR_AMT,   		BALANCE_AMT
		)  
		VALUES
		( 	:ai_year,   						:li_seq_no,   			:li_sort_seq,					:ai_month,
			:ldc_bal_begin,					:ldc_actpay_amt,		:ldc_actpayyear_amt,		:ldc_balance_amt
		) using itr_sqlca;
	else
		update	BUDGETCLOSEMONTH
		set			BAL_BEGIN				= :ldc_bal_begin ,
					ACTPAY_AMT			= :ldc_actpay_amt ,
					ACTPAYYEAR_AMT	= :ldc_actpayyear_amt,
					BALANCE_AMT			= :ldc_balance_amt
		where	BUDGETYEAR		= :ai_year and
					SEQ_NO				= :li_seq_no and
					SORT_SEQ			= :li_sort_seq and
					BUDGETMONTH		= :ai_month
		using itr_sqlca;
	
	end if
		
	
	if ( itr_sqlca.sqlcode <> 0  ) then
		inv_progress.istr_progress.status	= -1
		ithw_exception.text		+= "Error " + itr_sqlca.sqlerrtext
		rollback using itr_sqlca ;
		close cur_select;
		throw ithw_exception
	end if
	
	fetch cur_select into :li_seq_no, :li_sort_seq ;
loop
	
inv_progress.istr_progress.status	= 1
close cur_select;
commit using itr_sqlca ;
return 1
end function

private function decimal of_get_begin (integer ai_year, integer ai_month, string as_group, string as_type);datetime		ldtm_start_date, ldtm_end_date
dec{2}		ldc_begin_amt, ldc_pay_amt


ldtm_start_date	= datetime( date( ai_year, ai_month, 1  ) )
ldtm_end_date		= datetime( inv_datetime.of_lastdayofmonth( date( ldtm_start_date ) ) )

ldc_begin_amt	= this.of_get_balbegin_month( ai_year ,ai_month, as_group, as_type)
ldc_pay_amt	= this.of_get_pay_between( as_group, as_type, ldtm_start_date, ldtm_end_date , 0  )
ldc_begin_amt	= ldc_begin_amt - ldc_pay_amt

return ldc_begin_amt
end function

private function decimal of_get_pay_between (string as_group, string as_type, datetime adtm_start_date, datetime adtm_end_date, integer ai_inc_lastdate);dec{2}	ldc_amt

if ai_inc_lastdate = 1 then
	SELECT	sum(  BUDGETSLIP_DET.ITEMPAY_AMT   )  
	INTO		:ldc_amt
	FROM		BUDGETSLIP,  BUDGETSLIP_DET  
	WHERE	( BUDGETSLIP_DET.SLIP_NO				= BUDGETSLIP.SLIP_NO ) and  
				( BUDGETSLIP.PAYMENT_STATUS			= 1 ) AND  
				( BUDGETSLIP.ENTRY_DATE					between :adtm_start_date and :adtm_end_date ) AND  
				( BUDGETSLIP_DET.SLIPITEM_STATUS	= 1 ) and
				( BUDGETSLIP_DET.budgetgroup_code	= :as_group ) and
				( BUDGETSLIP_DET.budgettype_code		= :as_type )
	using itr_sqlca ;
else
	SELECT	sum(  BUDGETSLIP_DET.ITEMPAY_AMT )  
	INTO		:ldc_amt
	FROM		BUDGETSLIP,  BUDGETSLIP_DET  
	WHERE	( BUDGETSLIP_DET.SLIP_NO				= BUDGETSLIP.SLIP_NO ) and  
				( BUDGETSLIP.PAYMENT_STATUS			= 1 ) AND  
				( BUDGETSLIP.ENTRY_DATE					>= :adtm_start_date ) AND
				( BUDGETSLIP.ENTRY_DATE					< :adtm_end_date ) AND
				( BUDGETSLIP_DET.SLIPITEM_STATUS	= 1 ) and
				( BUDGETSLIP_DET.budgetgroup_code	= :as_group ) and
				( BUDGETSLIP_DET.budgettype_code		= :as_type )
	using itr_sqlca ;
end if

if isnull( ldc_amt ) then ldc_amt = 0.00

return ldc_amt
end function

private function decimal of_get_balbegin_month (integer ai_year, integer ai_month, string as_group, string as_type);dec{2}		ldc_begin_amt
integer		li_seq_no, li_sort_seq, li_budgetyear
datetime		ldtm_start_date

ldtm_start_date	= datetime( date( ai_year, ai_month, 1  ) )
li_budgetyear		= this.of_get_year_budget( ldtm_start_date )


select		SEQ_NO, SORT_SEQ
into		:li_seq_no, :li_sort_seq
from		budgettype_year
where	BUDGETYEAR		= :li_budgetyear and
			budgetgroup_code	= :as_group and
			budgettype_code	= :as_type
using itr_sqlca;

SELECT	BALANCE_AMT  
INTO		:ldc_begin_amt
FROM		BUDGETCLOSEMONTH  
WHERE	( BUDGETYEAR		= :ai_year ) AND  
			( BUDGETMONTH	= :ai_month ) AND  
			( SEQ_NO			= :li_seq_no ) AND  
			( SORT_SEQ		= :li_sort_seq )
using itr_sqlca ;

if isnull( ldc_begin_amt ) then ldc_begin_amt = 0.00

return ldc_begin_amt
end function

private function decimal of_get_balbegin_month (integer ai_year, integer ai_month, integer ai_seq_no, integer ai_sort_seq);dec{2}		ldc_begin_amt
integer		li_seq_no, li_sort_seq, li_budgetyear

ai_month		= ai_month - 1
if ( ai_month < 1 ) then
	ai_month		= 12
	ai_year		= ai_year - 1
end if
SELECT	BALANCE_AMT  
INTO		:ldc_begin_amt
FROM		BUDGETCLOSEMONTH  
WHERE	( BUDGETYEAR		= :ai_year ) AND  
			( BUDGETMONTH	= :ai_month ) AND  
			( SEQ_NO			= :li_seq_no ) AND  
			( SORT_SEQ		= :li_sort_seq )
using itr_sqlca ;

if isnull( ldc_begin_amt ) then ldc_begin_amt = 0.00

return ldc_begin_amt
end function

public function string of_get_bgtype_nonaccid ();n_ds	lds_data
integer	li_row

lds_data	= create n_ds
lds_data.dataobject = "d_bg_budgettype_noaccid"
lds_data.settransobject( itr_sqlca )

li_row		= lds_data.retrieve( )

if ( li_row > 0 ) then
	return lds_data.describe( "Datawindow.Data.XML" )
end if

return ""
end function

public function integer of_save_budget_amount (integer an_year, string as_budgetamt_xml) throws Exception;n_ds		lds_budget_amt
integer	li_row, li_rc , li_found, li_budgetyear, li_seq_no, li_sort_seq
string		ls_budgetreason
dec{2}	ldc_setbudget_amt

lds_budget_amt	= create n_ds
lds_budget_amt.dataobject = "d_bg_budgetsetamt_list_new"

if not  isnull( as_budgetamt_xml ) and trim( as_budgetamt_xml ) <> ""  then
	li_rc	= lds_budget_amt.importString( XML!, as_budgetamt_xml )
	if ( li_rc < 0 ) then
		ithw_exception.text		+= this.of_err_generate_import_xml( li_rc )
		throw ithw_exception
	end if
end if

li_budgetyear			= an_year

for li_row = 1 to lds_budget_amt.rowcount()
	li_found	= 0
	
	li_seq_no				= lds_budget_amt.GetitemNumber( li_row, "seq_no" )	
	li_sort_seq				= lds_budget_amt.GetitemNumber( li_row, "sort_seq" )
	
	ls_budgetreason		= trim( lds_budget_amt.GetitemString( li_row, "budgetreason" ) )	
	ldc_setbudget_amt	= lds_budget_amt.GetitemDecimal( li_row, "setbudget_amt" )	
	
	if isnull( ldc_setbudget_amt ) then ldc_setbudget_amt = 0
	
	select		count( budgetyear )
	into		:li_found
	from		BUDGETSETAMOUNT
	where	seq_no			= :li_seq_no and
				sort_seq			= :li_sort_seq and
				budgetyear		= :li_budgetyear
	using	itr_sqlca;
	
	if ( li_found > 0 ) then
		update	BUDGETSETAMOUNT
		set			budgetreason		= :ls_budgetreason ,
					setbudget_amt		= :ldc_setbudget_amt
		where	seq_no			= :li_seq_no and
					sort_seq			= :li_sort_seq and
					budgetyear		= :li_budgetyear
		using	itr_sqlca;
	else		
		insert into BUDGETSETAMOUNT
		(	seq_no,							sort_seq,						budgetyear,					budgetreason,
			setbudget_amt
		)
		values
		(	:li_seq_no,						:li_sort_seq,					:li_budgetyear,				:ls_budgetreason,
			:ldc_setbudget_amt
		)
		using	itr_sqlca;
	end if
	
	if ( itr_sqlca.sqlcode <> 0 ) then
		ithw_exception.text		+= "Error " + itr_sqlca.sqlerrtext
		rollback using itr_sqlca ;
		throw ithw_exception
	end if
	
next

commit using itr_sqlca ;
return 1
end function

public function integer of_save_fromcut_pay (string as_cutpay_xml) throws Exception;n_ds		lds_data
integer	li_row, li_index, li_rc, li_seq_no
string		ls_slip_no, ls_budgetgroup_code, ls_budgettype_code, ls_slipitem_desc
string		ls_slip_no_temp

lds_data	= create n_ds
lds_data.dataobject = "d_bg_budgetcut_detail"

if not  isnull( as_cutpay_xml ) and trim( as_cutpay_xml ) <> ""  then
	li_rc	= lds_data.importString( XML!, as_cutpay_xml )
	if ( li_rc < 0 ) then
		ithw_exception.text		+= "Main Data " + this.of_err_generate_import_xml( li_rc )
		throw ithw_exception
	end if
end if

lds_data.Setfilter( "post_flag= 1 ")
lds_data.Filter()

li_row		= lds_data.rowcount( )

ls_slip_no_temp	= ""

for li_index = 1 to li_row
	ls_budgetgroup_code		= lds_data.GetitemString( li_index, "budgetgroup_code" )
	ls_budgettype_code		= lds_data.GetitemString( li_index, "budgettype_code" )
	ls_slipitem_desc			= trim( lds_data.GetitemString( li_index, "slipitem_desc" ) )
	li_seq_no					= lds_data.getitemNumber( li_index, "seq_no" )
	ls_slip_no					= trim( lds_data.GetitemString( li_index, "slip_no" ) )
	
	if ( ls_slip_no <> ls_slip_no_temp) then
		update	budgetslip
		set			payment_status	= 1
		where	slip_no				= :ls_slip_no
		using itr_sqlca ;
		
		if ( itr_sqlca.sqlcode <> 0 ) then
			ithw_exception.text		+= "Error update budgetslip " + itr_sqlca.sqlerrtext
			rollback using itr_sqlca ;
			throw ithw_exception
		end if
		ls_slip_no_temp	= ls_slip_no
	end if
	
	update	budgetslip_det
	set			slipitem_status			= 1,
				budgetgroup_code		= :ls_budgetgroup_code ,
				budgettype_code		= :ls_budgettype_code ,
				slipitem_desc			= :ls_slipitem_desc
	where	slip_no	= :ls_slip_no and
				seq_no	= :li_seq_no
	using itr_sqlca ;
	
	if ( itr_sqlca.sqlcode <> 0 ) then
		ithw_exception.text		+= "Error update budgetslip_det " + itr_sqlca.sqlerrtext
		rollback using itr_sqlca ;
		throw ithw_exception
	end if
	
next

commit using itr_sqlca ;
return 1
end function

private function integer of_get_daterange_year (integer an_year, ref datetime adtm_start_date, ref datetime adtm_end_date);select		beginning_of_budget,		ending_of_budget
into		:adtm_start_date,			:adtm_end_date
from		budgetyear
where	budgetyear		= :an_year 
using itr_sqlca ;

return 1
end function

public function string of_get_bg_movment_year (integer an_year, string as_group, string as_type);n_ds		lds_data
integer	li_row, li_index
datetime	ldtm_start_date, ldtm_end_date
dec{2}	ldc_budget_set, ldc_bal_amt, ldc_item_amt

lds_data	= create n_ds
lds_data.dataobject = "d_bg_movement_detail_nogroup"
lds_data.settransobject( itr_sqlca )

this.of_get_daterange_year( an_year, ldtm_start_date, ldtm_end_date)

li_row		= lds_data.retrieve( as_group, as_type, 	ldtm_start_date, ldtm_end_date )

if ( li_row < 1 ) then
	return ""
end if

ldc_budget_set		= this.of_get_budget_amt( an_year, as_group, as_type )
ldc_bal_amt			= ldc_budget_set

for li_index = 1 to li_row
	ldc_item_amt	= lds_data.getitemDecimal( li_index,  "det_itempay_amt" )
	
	if isnull( ldc_item_amt ) then ldc_item_amt = 0.00
	
	ldc_bal_amt		= ldc_bal_amt - ldc_item_amt
	
	lds_data.Setitem( li_index, "c_begin", ldc_budget_set )
	lds_data.Setitem( li_index, "c_forward", ldc_bal_amt )
	
	ldc_budget_set	= ldc_bal_amt
next

lds_data.accepttext()

return lds_data.describe( "Datawindow.Data.XML" )


end function

private function decimal of_get_budget_amt (integer ai_year, string as_group, string as_type);dec{2}	ldc_amt

SELECT	BUDGETSETAMOUNT.SETBUDGET_AMT  
INTO		:ldc_amt
FROM		BUDGETSETAMOUNT,   BUDGETTYPE_YEAR  
WHERE	( BUDGETTYPE_YEAR.BUDGETYEAR	= BUDGETSETAMOUNT.BUDGETYEAR ) and  
			( BUDGETTYPE_YEAR.SEQ_NO			= BUDGETSETAMOUNT.SEQ_NO ) and  
			( BUDGETTYPE_YEAR.SORT_SEQ		= BUDGETSETAMOUNT.SORT_SEQ ) and  
			( BUDGETTYPE_YEAR.BUDGETGROUP_CODE	= :as_group ) AND  
			( BUDGETTYPE_YEAR.BUDGETTYPE_CODE	= :as_type ) AND
			( BUDGETTYPE_YEAR.BUDGETYEAR			= :ai_year )
using itr_sqlca			;

if isnull( ldc_amt ) then ldc_amt = 0.00

return ldc_amt

end function

public function string of_get_bg_movment_month (integer an_year, integer an_month, string as_group, string as_type);n_ds		lds_data
integer	li_row, li_index
datetime	ldtm_start_date, ldtm_end_date
datetime	ldtm_start_month, ldtm_end_month
dec{2}	ldc_budget_set, ldc_bal_amt, ldc_item_amt

lds_data	= create n_ds
lds_data.dataobject = "d_bg_movement_detail_nogroup_month"
lds_data.settransobject( itr_sqlca )

this.of_get_daterange_year( an_year, ldtm_start_date, ldtm_end_date)

ldtm_start_month	= datetime( date( an_year, an_month, 1  ) )
ldtm_end_month	= datetime( inv_datetime.of_lastdayofmonth( date( ldtm_start_month ) ) )

li_row		= lds_data.retrieve( as_group, as_type, 	ldtm_start_month, ldtm_end_month )

if ( li_row < 1 ) then
	return ""
end if

ldc_item_amt		= 0.00
if ( date( ldtm_start_date ) <> date( ldtm_start_month ) ) then
	ldc_item_amt		= this.of_get_pay_between( as_group, as_type, ldtm_start_date, ldtm_start_month, 0 )
end if

ldc_budget_set		= this.of_get_budget_amt( an_year, as_group, as_type )

lds_data.Setitem( 1, "c_setbudget", ldc_budget_set )
	
ldc_budget_set		= ldc_budget_set - ldc_item_amt
ldc_bal_amt			= ldc_budget_set

for li_index = 1 to li_row
	
	ldc_item_amt	= lds_data.getitemDecimal( li_index,  "det_itempay_amt" )
	
	if isnull( ldc_item_amt ) then ldc_item_amt = 0.00
	
	ldc_bal_amt		= ldc_bal_amt - ldc_item_amt
	
	lds_data.Setitem( li_index, "c_begin", ldc_budget_set )
	lds_data.Setitem( li_index, "c_forward", ldc_bal_amt )
	
	ldc_budget_set	= ldc_bal_amt
next

lds_data.accepttext()

return lds_data.describe( "Datawindow.Data.XML" )


end function

public function string of_process_cutpay (datetime adtm_date, string as_branch_id) throws Exception;string	ls_return

ls_return		= this.of_get_list_fromfin( adtm_date, as_branch_id )

return ls_return
end function

private function string of_get_list_fromfin (datetime adtm_date, string as_branch_id) throws Exception;n_ds		lds_data, lds_datareturn
integer	li_row, li_index, li_seq_det, li_refer_seq
string		ls_finslip_no, ls_finslip_notemp, ls_slipno, ls_doccode, ls_PAY_TOWHOM
string		ls_REFER_SLIPNO, ls_PAYMENT_DESC, ls_MEMBER_NO, ls_ENTRY_ID
string		ls_CASH_TYPE, ls_COOPBRANCH_ID, ls_MACHINE_ID, ls_ACCOUNT_ID
string		ls_SLIPITEM_DESC, ls_budgetgroup_code, ls_budgettype_code
dec{2}	ldc_ITEMPAY_AMT
integer	li_seq_no, li_sort_seq, li_year

lds_data	= create n_ds
lds_data.dataobject = "d_bg_for_insert_slipbudget"
lds_data.settransobject( itr_sqlca )

lds_datareturn	= create n_ds
lds_datareturn.dataobject = "d_bg_budgetcut_detail"
lds_datareturn.settransobject( itr_sqlca )

li_row		= lds_data.retrieve( adtm_date )

ls_doccode	= string( this.of_get_constant( 1, "paydoc_code" ) )
if isnull( ls_doccode ) or trim( ls_doccode ) = "" then
	ithw_exception.text		+= "ไม่มีการกำหนดการใช้ รหัสเลขที่ใบสำคัญจ่ายในค่าคงที่ระบบ "
	throw ithw_exception
end if

li_year				= this.of_get_year_budget( adtm_date )
li_seq_det			= 0
ls_finslip_notemp	= ""

for li_index = 1 to li_row
	ls_finslip_no		= trim( lds_data.GetitemString( li_index, "slip_no" ) )
	
	if ( ls_finslip_no <> ls_finslip_notemp ) then
		ls_finslip_notemp	= ls_finslip_no
		li_seq_det			= 0
		
		//a_edit     ls_slipno		= inv_docservice.of_getnewdocno( ls_doccode )
		li_refer_seq	= lds_data.GetitemNumber( li_index, "seq_no" )
		
		ls_REFER_SLIPNO		= ls_finslip_no + string( li_refer_seq )
		ls_PAYMENT_DESC	= trim( lds_data.GetitemString( li_index, "payment_desc" ) )
		
		ls_MEMBER_NO			= trim( lds_data.GetitemString( li_index, "member_no" ) )
		ls_CASH_TYPE			= trim( lds_data.GetitemString( li_index, "cash_type" ) )
		ls_COOPBRANCH_ID	= trim( lds_data.GetitemString( li_index, "coopbranch_id" ) )
		ls_MACHINE_ID			= trim( lds_data.GetitemString( li_index, "machine_id" ) )
		ls_ACCOUNT_ID		= trim( lds_data.GetitemString( li_index, "tofrom_accid" ) )
		ls_ENTRY_ID			= trim( lds_data.GetitemString( li_index, "entry_id" ) )
		ls_PAY_TOWHOM		= trim( lds_data.GetitemString( li_index, "nonmember_detail" ) )
		
		INSERT INTO BUDGETSLIP  
		(	SLIP_NO,						PAYOUT_SLIPNO,   				ENTRY_ID,   				ENTRY_DATE,   
			OPERATE_DATE,			FROM_SYSTEM,   					PAYMENT_STATUS,   	CASH_TYPE,   
			PAYMENT_DESC,   		ITEMPAY_AMT,   					PAY_TOWHOM,   			MEMBER_NO,   
			MACHINE_ID,   				ACCOUNT_ID,   					COOPBRANCH_ID,   		REFER_SLIPNO
		)  
		VALUES
		(	:ls_slipno,   					null,   								:ls_ENTRY_ID,  			:adtm_date,   
			:adtm_date,					'FIN',   								8,   							:ls_CASH_TYPE,   
			:ls_PAYMENT_DESC, 		0.00,   								:ls_PAY_TOWHOM,   		:ls_MEMBER_NO,   
			:ls_MACHINE_ID,   		:ls_ACCOUNT_ID,					:ls_COOPBRANCH_ID,		:ls_REFER_SLIPNO
		) using itr_sqlca ;
	
		if ( itr_sqlca.sqlcode <> 0 ) then
			ithw_exception.text		+= itr_sqlca.sqlerrtext
			rollback using itr_sqlca ;
			throw ithw_exception
		end if
	end if
	
	ls_SLIPITEM_DESC	= "จ่าย " +  trim( lds_data.GetitemString( li_index, "nonmember_detail" ) ) + trim( lds_data.GetitemString( li_index, "slipitem_desc" ) )
	ldc_ITEMPAY_AMT		= lds_data.GetitemDecimal( li_index, "itempayamt_net" )
	ls_ACCOUNT_ID		= trim( lds_data.GetitemString( li_index, "finslipdet_account_id" ) )
	ls_budgetgroup_code	= trim( lds_data.GetitemString( li_index, "budgetgroup_code" ) )
	ls_budgettype_code	= trim( lds_data.GetitemString( li_index, "budgettype_code" ) )
	
	if isnull( ls_budgetgroup_code ) then ls_budgetgroup_code = " "
	if isnull( ls_budgettype_code ) then ls_budgettype_code = " "
	
	li_seq_det ++
	
	INSERT INTO BUDGETSLIP_DET  
	(	SLIP_NO,							SEQ_NO,   					BUDGETGROUP_CODE,   				BUDGETTYPE_CODE,   
		SLIPITEM_DESC,   			SLIPITEM_STATUS,   		CANCEL_ID,   							CANCEL_DATE,   
		POSTTOVC_FLAG,   			VOUCHER_NO,   			ITEMPAY_AMT,   						ACCOUNT_ID
	)  
	VALUES
	(	:ls_slipno,   						:li_seq_det,   				:ls_budgetgroup_code,				:ls_budgettype_code,   
		:ls_SLIPITEM_DESC, 			1,   							null,   									null,   
		0,   								null,   						:ldc_ITEMPAY_AMT, 					:ls_ACCOUNT_ID
	) using itr_sqlca ;
	
	if ( itr_sqlca.sqlcode <> 0 ) then
		ithw_exception.text		+= itr_sqlca.sqlerrtext
		rollback using itr_sqlca ;
		throw ithw_exception
	end if
	
next

commit using itr_sqlca ;

li_row		= 0
li_row		= lds_datareturn.retrieve( adtm_date )

if ( li_row < 1 ) then
	return ""
end if

for li_index = 1 to li_row
	ls_budgetgroup_code	= trim( lds_datareturn.GetitemString( li_index, "budgetgroup_code" ) )
	ls_budgettype_code	= trim( lds_datareturn.GetitemString( li_index, "budgettype_code" ) )
	
	li_seq_no	= 0
	li_sort_seq	= 0
	
	this.of_get_sort_seq_year( li_year, ls_budgetgroup_code, ls_budgettype_code, li_seq_no, li_sort_seq )
	
	lds_datareturn.Setitem( li_index, "budget_seq_no", li_seq_no )	
	lds_datareturn.Setitem( li_index, "sort_seq", li_sort_seq )
	
next

lds_datareturn.accepttext( )

return lds_datareturn.describe( "Datawindow.Data.XML" )
end function

public function integer of_save_closemonth_detail (string as_closemonth_detail_xml) throws Exception;n_ds		lds_data
integer	li_rc, li_month_seq_no, li_row
integer	li_budgetyear, li_seq_no, li_sort_seq, li_budgetmonth
string		ls_month_desc
dec{2}	ldc_month_amt
lds_data		= create n_ds
lds_data.dataobject = "d_bg_budgetclosemont_det"

if not  isnull( as_closemonth_detail_xml ) and trim( as_closemonth_detail_xml ) <> ""  then
	li_rc	= lds_data.importString( XML!, as_closemonth_detail_xml )
	if ( li_rc < 0 ) then
		ithw_exception.text		+= this.of_err_generate_import_xml( li_rc )
		throw ithw_exception
	end if
end if


li_budgetyear	= lds_data.GetitemNumber( 1, "budgetyear" )	
li_seq_no		= lds_data.GetitemNumber( 1, "seq_no" )	
li_sort_seq		= lds_data.GetitemNumber( 1, "sort_seq" )
li_budgetmonth	= lds_data.GetitemNumber( 1, "budgetmonth" )
	
delete from BUGETCLOSEMONTH_DET
where	budgetyear		= :li_budgetyear and
			seq_no			= :li_seq_no and
			sort_seq			= :li_sort_seq and
			budgetmonth	= :li_budgetmonth
using	itr_sqlca;	
	
for li_row = 1 to lds_data.rowcount()
	
	li_month_seq_no		= lds_data.GetitemNumber( li_row, "month_seq_no" )
	ls_month_desc			= lds_data.GetitemString( li_row, "month_desc" )
	ldc_month_amt			= lds_data.GetitemDecimal( li_row, "month_amt" )
	
	if isnull( ldc_month_amt ) then ldc_month_amt = 0.00
	
	if ( li_month_seq_no = 0) then
		ithw_exception.text		+= "Error ไม่มีการระบุ ลำดับข้อมูล"
		rollback using itr_sqlca ;
		throw ithw_exception
	end if
	insert into BUGETCLOSEMONTH_DET
	(	BUDGETYEAR,					SEQ_NO,						SORT_SEQ,				BUDGETMONTH,
		MONTH_SEQ_NO,				MONTH_DESC,				MONTH_AMT
	)
	values
	(	:li_budgetyear,					:li_seq_no,					:li_sort_seq,				:li_budgetmonth,
		:li_month_seq_no,				:ls_month_desc,			:ldc_month_amt
	)
	using	itr_sqlca;
	
	if ( itr_sqlca.sqlcode <> 0 ) then
		ithw_exception.text		+= "Error " + itr_sqlca.sqlerrtext
		rollback using itr_sqlca ;
		throw ithw_exception
	end if
	
next

commit using itr_sqlca ;
return 1
end function

private function integer of_get_sort_seq_year (integer ai_year, string as_budgetgroup_code, string as_budgettype_code, ref integer ai_seq_no, ref integer ai_sort_seq);integer	li_budgetyear

select		seq_no,				sort_seq
into		:ai_seq_no,			:ai_sort_seq
from		budgettype_year
where	budgetyear			=  :ai_year and
			budgetgroup_code	= :as_budgetgroup_code and
			budgettype_code	= :as_budgettype_code
using itr_sqlca;


return 1
end function

private function integer of_get_group_type_year (integer ai_year, ref string as_budgetgroup_code, ref string as_budgettype_code, integer ai_seq_no, integer ai_sort_seq);integer	li_budgetyear

select		budgetgroup_code,		budgettype_code
into		:as_budgetgroup_code,	:as_budgettype_code
from		budgettype_year
where	budgetyear	=  :ai_year and
			seq_no		= :ai_seq_no and
			sort_seq		= :ai_sort_seq
using itr_sqlca;


return 1
end function

public function string of_get_bg_movment_month (integer an_year, integer an_month, integer ai_seq_no, integer ai_sort_seq);n_ds		lds_data
integer	li_row, li_index
datetime	ldtm_start_date, ldtm_end_date
datetime	ldtm_start_month, ldtm_end_month
dec{2}	ldc_budget_set, ldc_bal_amt, ldc_item_amt
string		ls_group, ls_type

lds_data	= create n_ds
lds_data.dataobject = "d_bg_movement_detail_nogroup_month"
lds_data.settransobject( itr_sqlca )

this.of_get_daterange_year( an_year, ldtm_start_date, ldtm_end_date)

this.of_get_group_type_year( an_year, ls_group, ls_type, ai_seq_no, ai_sort_seq  )

ldtm_start_month	= datetime( date( an_year, an_month, 1  ) )
ldtm_end_month	= datetime( inv_datetime.of_lastdayofmonth( date( ldtm_start_month ) ) )

li_row		= lds_data.retrieve(an_year,  ai_seq_no,ai_sort_seq ,  ldtm_start_month, ldtm_end_month )

if ( li_row < 1 ) then
	return ""
end if

ldc_item_amt		= 0.00
if ( date( ldtm_start_date ) <> date( ldtm_start_month ) ) then
	ldc_item_amt		= this.of_get_pay_between( ls_group, ls_type, ldtm_start_date, ldtm_start_month, 0 )
end if

ldc_budget_set		= this.of_get_budget_amt( an_year, ls_group, ls_type )


lds_data.Setitem( 1, "c_setbudget", ldc_budget_set )

ldc_budget_set		= ldc_budget_set - ldc_item_amt
ldc_bal_amt			= ldc_budget_set

for li_index = 1 to li_row
	
	ldc_item_amt	= lds_data.getitemDecimal( li_index,  "det_itempay_amt" )
	
	if isnull( ldc_item_amt ) then ldc_item_amt = 0.00
	
	ldc_bal_amt		= ldc_bal_amt - ldc_item_amt
	
	lds_data.Setitem( li_index, "c_begin", ldc_budget_set )
	lds_data.Setitem( li_index, "c_forward", ldc_bal_amt )
	
	ldc_budget_set	= ldc_bal_amt
next

lds_data.accepttext()

return lds_data.describe( "Datawindow.Data.XML" )


end function

public function string of_get_bg_movment_year (integer an_year, integer ai_seq_no, integer ai_sort_seq);n_ds		lds_data
integer	li_row, li_index
datetime	ldtm_start_date, ldtm_end_date
dec{2}	ldc_budget_set, ldc_bal_amt, ldc_item_amt
string		ls_group, ls_type

lds_data	= create n_ds
lds_data.dataobject = "d_bg_movement_detail_nogroup"
lds_data.settransobject( itr_sqlca )

this.of_get_daterange_year( an_year, ldtm_start_date, ldtm_end_date)
this.of_get_group_type_year( an_year, ls_group, ls_type, ai_seq_no, ai_sort_seq  )

li_row		= lds_data.retrieve( ls_group, ls_type, 	ldtm_start_date, ldtm_end_date )

if ( li_row < 1 ) then
	return ""
end if

ldc_budget_set		= this.of_get_budget_amt( an_year, ls_group, ls_type )
ldc_bal_amt			= ldc_budget_set

for li_index = 1 to li_row
	ldc_item_amt	= lds_data.getitemDecimal( li_index,  "det_itempay_amt" )
	
	if isnull( ldc_item_amt ) then ldc_item_amt = 0.00
	
	ldc_bal_amt		= ldc_bal_amt - ldc_item_amt
	
	lds_data.Setitem( li_index, "c_begin", ldc_budget_set )
	lds_data.Setitem( li_index, "c_forward", ldc_bal_amt )
	
	ldc_budget_set	= ldc_bal_amt
next

lds_data.accepttext()

return lds_data.describe( "Datawindow.Data.XML" )


end function

public function integer of_get_year_budget (datetime adtm_date);integer	li_budgetyear

select		budgetyear
into		:li_budgetyear
from		budgetyear
where	beginning_of_budget	<= :adtm_date and
			ending_of_budget		>= :adtm_date
using itr_sqlca;

return li_budgetyear
end function

public function integer of_save_fromedit_pay (string as_cutpay_xml) throws Exception;n_ds		lds_data
integer	li_row, li_index, li_rc, li_seq_no
string		ls_slip_no, ls_budgetgroup_code, ls_budgettype_code, ls_slipitem_desc
string		ls_slip_no_temp

lds_data	= create n_ds
lds_data.dataobject = "d_bg_budgetpaydetail_detail"

if not  isnull( as_cutpay_xml ) and trim( as_cutpay_xml ) <> ""  then
	
	li_rc	= lds_data.importString( XML!, as_cutpay_xml )
	if ( li_rc < 0 ) then
		ithw_exception.text		+= "Main Data " + this.of_err_generate_import_xml( li_rc )
		throw ithw_exception
	end if
end if


li_row		= lds_data.rowcount( )

ls_slip_no_temp	= ""

for li_index = 1 to li_row
	ls_budgetgroup_code		= lds_data.GetitemString( li_index, "budgetgroup_code" )
	ls_budgettype_code		= lds_data.GetitemString( li_index, "budgettype_code" )
	ls_slipitem_desc			= trim( lds_data.GetitemString( li_index, "slipitem_desc" ) )
	li_seq_no					= lds_data.getitemNumber( li_index, "budgetslip_det_seq_no" )
	ls_slip_no					= trim( lds_data.GetitemString( li_index, "slip_no" ) )
	
	if ( ls_slip_no <> ls_slip_no_temp) then
		update	budgetslip
		set			payment_status	= 1
		where	slip_no				= :ls_slip_no
		using itr_sqlca ;
		
		if ( itr_sqlca.sqlcode <> 0 ) then
			ithw_exception.text		+= "Error update budgetslip " + itr_sqlca.sqlerrtext
			rollback using itr_sqlca ;
			throw ithw_exception
		end if
		ls_slip_no_temp	= ls_slip_no
	end if
	
	update	budgetslip_det
	set			slipitem_status			= 1,
				budgetgroup_code		= :ls_budgetgroup_code ,
				budgettype_code		= :ls_budgettype_code ,
				slipitem_desc			= :ls_slipitem_desc
	where	slip_no	= :ls_slip_no and
				seq_no	= :li_seq_no
	using itr_sqlca ;
	
	if ( itr_sqlca.sqlcode <> 0 ) then
		ithw_exception.text		+= "Error update budgetslip_det " + itr_sqlca.sqlerrtext
		rollback using itr_sqlca ;
		throw ithw_exception
	end if
	
next

commit using itr_sqlca ;
return 1
end function

public function string of_gen_rpt_bfclose_month (integer ai_year, integer ai_month) throws Exception;integer		li_seq_no, li_sort_seq, li_max, li_index
dec{2}		ldc_bal_begin, ldc_actpay_amt, ldc_balance_amt, ldc_actpayyear_amt, ldc_setbudget_amt
string			ls_group, ls_type, ls_seq_text, ls_xml_return
datetime		ldtm_start_date, ldtm_end_date, ldtm_startyear_date
integer		li_budgetyear, li_found
string			ls_budgetgroup_desc, ls_budgettype_desc, ls_fix_coopname
n_ds			lds_report

lds_report	= create n_ds
lds_report.dataobject = "b_bg_rpt_budget_month"

ldtm_start_date	= datetime( date( ai_year, ai_month, 1  ) )
ldtm_end_date		= datetime( inv_datetime.of_lastdayofmonth( date( ldtm_start_date ) ) )

select		budgetyear, beginning_of_budget
into		:li_budgetyear, :ldtm_startyear_date
from		budgetyear
where	beginning_of_budget	<= :ldtm_start_date and
			ending_of_budget		>= :ldtm_start_date
using itr_sqlca;

select		count( SEQ_NO )
into		:li_max
from		budgettype_year
where	BUDGETYEAR = :li_budgetyear
using itr_sqlca;
if isnull( li_max ) then li_max = 0


select	coop_name
into	:ls_fix_coopname
from	cmcoopconstant
using itr_sqlca;

if isnull( ls_fix_coopname ) then ls_fix_coopname = ""
ls_fix_coopname	= trim( ls_fix_coopname )

declare cur_select cursor for
select		SEQ_NO, SORT_SEQ
from		budgettype_year
where	BUDGETYEAR = :li_budgetyear
using itr_sqlca;

open cur_select ;

fetch cur_select into :li_seq_no, :li_sort_seq ;

li_index	= 0

do while itr_sqlca.sqlnrows > 0
	
	select		budgettype_year.budgetgroup_code,budgettype_year.budgettype_code, budgettype_year.seq_text,
				budgetgroup.budgetgroup_desc, budgettype.budgettype_desc
	into		:ls_group, :ls_type, :ls_seq_text,
				:ls_budgetgroup_desc, :ls_budgettype_desc
	from		budgettype, budgetgroup, budgettype_year
	where	( budgetgroup.budgetgroup_code		= budgettype.budgetgroup_code ) and
				( budgettype.budgetgroup_code		= budgettype_year.budgetgroup_code ) and
				( budgettype.budgettype_code			= budgettype_year.budgettype_code ) and	
				( budgettype_year.BUDGETYEAR		= :li_budgetyear ) and
				( budgettype_year.SEQ_NO				= :li_seq_no ) AND  
				( budgettype_year.SORT_SEQ			= :li_sort_seq )
	using itr_sqlca;
	
	ldc_setbudget_amt	= 0.00
	ldc_setbudget_amt	= this.of_get_budget_amt( li_budgetyear, ls_group,ls_type )
	ldc_bal_begin			= this.of_get_balbegin_month( ai_year, ai_month, li_seq_no, li_sort_seq )
	
	// หากเป็น 0 ให้ใช้ยอดตั้ง
	if ( ldc_bal_begin = 0 ) then
		ldc_actpay_amt	= 0.00
		ldc_bal_begin	= ldc_setbudget_amt
		ldc_actpay_amt	= this.of_get_pay_between(ls_group,ls_type , ldtm_startyear_date , ldtm_start_date , 0  )
		ldc_bal_begin	= ldc_bal_begin - ldc_actpay_amt
	end if
	
	ldc_actpay_amt			= 0.00
	ldc_actpay_amt			= this.of_get_pay_between(ls_group,ls_type , ldtm_start_date, ldtm_end_date, 1  )
	
	ldc_actpayyear_amt	= 0.00
	ldc_actpayyear_amt	= this.of_get_pay_between(ls_group,ls_type , ldtm_startyear_date , ldtm_end_date, 1  )
	
	ldc_balance_amt		= ldc_bal_begin - ldc_actpay_amt
	li_found					= 0
	
	li_index	= lds_report.insertrow( 0 )
	
	lds_report.Setitem( li_index,"fix_coopname", ls_fix_coopname )
	lds_report.Setitem( li_index,"budgetyear",ai_year )
	lds_report.Setitem( li_index,"budgetmonth",ai_month )
	lds_report.Setitem( li_index,"seq_no",li_seq_no )
	lds_report.Setitem( li_index,"budgetgroup_desc", ls_budgetgroup_desc )
	lds_report.Setitem( li_index,"sort_seq", li_sort_seq )
	lds_report.Setitem( li_index,"seq_text", ls_seq_text )
	lds_report.Setitem( li_index,"budgettype_desc", ls_budgettype_desc )
	lds_report.Setitem( li_index,"bal_begin", ldc_bal_begin )
	lds_report.Setitem( li_index,"setbudget_amt", ldc_setbudget_amt )
	lds_report.Setitem( li_index,"actpay_amt", ldc_actpay_amt )
	lds_report.Setitem( li_index,"actpayyear_amt", ldc_actpayyear_amt )
	lds_report.Setitem( li_index,"balance_amt", ldc_balance_amt )
	
	fetch cur_select into :li_seq_no, :li_sort_seq ;
loop
	
	
close cur_select;

lds_report.accepttext( )

if ( li_index > 0 ) then
	ls_xml_return	= 	lds_report.describe( "Datawindow.Data.XML" )
end if

return ls_xml_return
end function

on n_cst_budget_service.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_budget_service.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ithw_exception		= create Exception
end event

