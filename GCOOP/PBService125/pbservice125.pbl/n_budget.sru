$PBExportHeader$n_budget.sru
namespace
namespace pbservice125
end namespace

forward
global type n_budget from NonVisualObject
end type
end forward

global type n_budget from NonVisualObject
end type
global n_budget n_budget

forward prototypes
public function string of_test (string as_test)
public function integer of_save_budget_year (string as_wspass, string as_budget_xml) throws Exception
public function integer of_save_budget_type (string as_wspass, string as_budgettype_xml) throws Exception
public function integer of_save_budget_group (string as_wspass, string as_budgetgroup_xml) throws Exception
public function integer of_save_fromedit_pay (string as_wspass, string as_cutpay_xml) throws Exception
public function integer of_get_year_budget (string as_wspass, datetime adtm_date) throws Exception
public function integer of_save_budget_typeyear (string as_wspass, string as_budgettypeyear_xml) throws Exception
public function integer of_close_month (string as_wspass, integer ai_year, integer ai_month) throws Exception
public function integer of_save_budget_groupyear (string as_wspass, string as_budgetgroupyear_xml) throws Exception
public function string of_get_bg_movment_year (string as_wspass, integer an_year, string as_group, string as_type) throws Exception
public function string of_get_bgtype_nonaccid (string as_wspass) throws Exception
end prototypes

public function string of_test (string as_test);string ls_result

ls_result = "test " + as_test

return ls_result
end function

public function integer of_save_budget_year (string as_wspass, string as_budget_xml) throws Exception;integer  result

n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	in_conn.of_connectdb(as_wspass)
	
	n_cst_budget_service ln_service
	ln_service = create n_cst_budget_service
	
	result = ln_service.of_save_budget_year(as_budget_xml)
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_save_budget_type (string as_wspass, string as_budgettype_xml) throws Exception;integer  result

n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	in_conn.of_connectdb(as_wspass)
	
	n_cst_budget_service ln_service
	ln_service = create n_cst_budget_service
	
	result = ln_service.of_save_budget_type(as_budgettype_xml)
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_save_budget_group (string as_wspass, string as_budgetgroup_xml) throws Exception;integer  result

n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	in_conn.of_connectdb(as_wspass)
	
	n_cst_budget_service ln_service
	ln_service = create n_cst_budget_service
	
	result = ln_service.of_save_budget_group(as_budgetgroup_xml)
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_save_fromedit_pay (string as_wspass, string as_cutpay_xml) throws Exception;integer  result

n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	in_conn.of_connectdb(as_wspass)
	
	n_cst_budget_service ln_service
	ln_service = create n_cst_budget_service
	
	result = ln_service.of_save_fromedit_pay(as_cutpay_xml)
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_get_year_budget (string as_wspass, datetime adtm_date) throws Exception;integer  result

n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	in_conn.of_connectdb(as_wspass)
	
	n_cst_budget_service ln_service
	ln_service = create n_cst_budget_service
	
	result = ln_service.of_get_year_budget(adtm_date)
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_save_budget_typeyear (string as_wspass, string as_budgettypeyear_xml) throws Exception;integer  result

n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	in_conn.of_connectdb(as_wspass)
	
	n_cst_budget_service ln_service
	ln_service = create n_cst_budget_service
	
	result = ln_service.of_save_budget_typeyear(as_budgettypeyear_xml)
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_close_month (string as_wspass, integer ai_year, integer ai_month) throws Exception;integer  result

n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	in_conn.of_connectdb(as_wspass)
	
	n_cst_budget_service ln_service
	ln_service = create n_cst_budget_service
	
	result = ln_service.of_close_month(ai_year,ai_month)
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_save_budget_groupyear (string as_wspass, string as_budgetgroupyear_xml) throws Exception;integer  result

n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	in_conn.of_connectdb(as_wspass)
	
	n_cst_budget_service ln_service
	ln_service = create n_cst_budget_service
	
	result = ln_service.of_save_budget_groupyear(as_budgetgroupyear_xml)
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function string of_get_bg_movment_year (string as_wspass, integer an_year, string as_group, string as_type) throws Exception;string  result

n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	in_conn.of_connectdb(as_wspass)
	
	n_cst_budget_service ln_service
	ln_service = create n_cst_budget_service
	
	result = ln_service.of_get_bg_movment_year(an_year,as_group,as_type)
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function string of_get_bgtype_nonaccid (string as_wspass) throws Exception;string  result

n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice
try
	in_conn.of_connectdb(as_wspass)
	
	n_cst_budget_service ln_service
	ln_service = create n_cst_budget_service
	
	result = ln_service.of_get_bgtype_nonaccid()
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

on n_budget.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_budget.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on
