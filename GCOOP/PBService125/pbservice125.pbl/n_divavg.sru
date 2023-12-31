$PBExportHeader$n_divavg.sru
namespace
namespace pbservice125
end namespace

forward
global type n_divavg from NonVisualObject
end type
end forward

global type n_divavg from NonVisualObject
end type
global n_divavg n_divavg

forward prototypes
public function string of_test (string as_test)
public function integer of_save_memdet_methpay (string as_wspass, ref str_divsrv_det astr_divsrv_det) throws Exception
public function integer of_prc_methpay_opt (string as_wspass, ref str_divsrv_proc astr_divsrv_proc) throws Exception
public function integer of_init_reqchg (string as_wspass, ref str_divsrv_req astr_divsrv_req) throws Exception
public function integer of_init_methpay_ccl (string as_wspass, ref str_divsrv_req astr_divsrv_req) throws Exception
public function integer of_init_slip_grp (string as_wspass, ref str_divsrv_oper astr_divavg_oper) throws Exception
public function integer of_init_slip_ccl (string as_wspass, ref str_divsrv_oper astr_divavg_oper) throws Exception
public function integer of_init_slip (string as_wspass, ref str_divsrv_oper astr_divavg_oper) throws Exception
public function integer of_init_detail (string as_wspass, ref str_divsrv_det astr_divsrv_det) throws Exception
public function integer of_init_memdet_methpay (string as_wspass, ref str_divsrv_det astr_divsrv_det) throws Exception
public function integer of_save_slip (string as_wspass, ref str_divsrv_oper astr_divavg_oper) throws Exception
public function integer of_save_slip_ccl (string as_wspass, ref str_divsrv_oper astr_divavg_oper) throws Exception
public function integer of_save_slip_grp (string as_wspass, ref str_divsrv_oper astr_divavg_oper) throws Exception
public function integer of_save_methpay_ccl (string as_wspass, ref str_divsrv_req astr_divsrv_req) throws Exception
public function integer of_save_reqchg (string as_wspass, ref str_divsrv_req astr_divsrv_req) throws Exception
public function integer of_init_methpay (string as_wspass, ref str_divsrv_req astr_divsrv_req) throws Exception
public function integer of_save_methpay (string as_wspass, ref str_divsrv_req astr_divsrv_req) throws Exception
end prototypes

public function string of_test (string as_test);string ls_result

ls_result = "test " + as_test

return ls_result
end function

public function integer of_save_memdet_methpay (string as_wspass, ref str_divsrv_det astr_divsrv_det) throws Exception;integer  result
 

n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice

try
	in_conn.of_connectdb(as_wspass)
	
	n_cst_divsrv_memdet ln_service
	ln_service = create n_cst_divsrv_memdet
	 
	
	ln_service.of_initservice(in_conn)
	
	result = ln_service.of_save_memdet_methpay(astr_divsrv_det)
	in_conn.of_disconnectdb()
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_prc_methpay_opt (string as_wspass, ref str_divsrv_proc astr_divsrv_proc) throws Exception;integer  result
 

n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice

try
	in_conn.of_connectdb(as_wspass)
	
	n_cst_divsrv_process ln_service
	ln_service = create n_cst_divsrv_process
	 
	
	ln_service.of_initservice(in_conn)
	
	result = ln_service.of_prc_methpay_opt(astr_divsrv_proc)
	in_conn.of_disconnectdb()
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_init_reqchg (string as_wspass, ref str_divsrv_req astr_divsrv_req) throws Exception;integer  result
 

n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice

try
	in_conn.of_connectdb(as_wspass)
	
	n_cst_divsrv_request ln_service
	ln_service = create n_cst_divsrv_request
	 
	
	ln_service.of_initservice(in_conn)
	
	result = ln_service.of_init_reqchg(astr_divsrv_req)
	in_conn.of_disconnectdb()
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_init_methpay_ccl (string as_wspass, ref str_divsrv_req astr_divsrv_req) throws Exception;integer  result
 

n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice

try
	in_conn.of_connectdb(as_wspass)
	
	n_cst_divsrv_request ln_service
	ln_service = create n_cst_divsrv_request
	 
	
	ln_service.of_initservice(in_conn)
	
	result = ln_service.of_init_methpay_ccl(astr_divsrv_req)
	in_conn.of_disconnectdb()
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_init_slip_grp (string as_wspass, ref str_divsrv_oper astr_divavg_oper) throws Exception;integer  result
 

n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice

try
	in_conn.of_connectdb(as_wspass)
	
	n_cst_divsrv_operate ln_service
	ln_service = create n_cst_divsrv_operate
	 
	
	ln_service.of_initservice(in_conn)
	
	result = ln_service.of_init_slip_grp(astr_divavg_oper)
	in_conn.of_disconnectdb()
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_init_slip_ccl (string as_wspass, ref str_divsrv_oper astr_divavg_oper) throws Exception;integer  result
 

n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice

try
	in_conn.of_connectdb(as_wspass)
	
	n_cst_divsrv_operate ln_service
	ln_service = create n_cst_divsrv_operate
	 
	
	ln_service.of_initservice(in_conn)
	
	result = ln_service.of_init_slip_ccl(astr_divavg_oper)
	in_conn.of_disconnectdb()
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_init_slip (string as_wspass, ref str_divsrv_oper astr_divavg_oper) throws Exception;integer  result
 

n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice

try
	in_conn.of_connectdb(as_wspass)
	
	n_cst_divsrv_operate ln_service
	ln_service = create n_cst_divsrv_operate
	 
	
	ln_service.of_initservice(in_conn)
	
	result = ln_service.of_init_slip(astr_divavg_oper)
	in_conn.of_disconnectdb()
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_init_detail (string as_wspass, ref str_divsrv_det astr_divsrv_det) throws Exception;integer  result
 

n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice

try
	in_conn.of_connectdb(as_wspass)
	
	n_cst_divsrv_memdet ln_service
	ln_service = create n_cst_divsrv_memdet
	 
	
	ln_service.of_initservice(in_conn)
	
	result = ln_service.of_init_detail(astr_divsrv_det)
	in_conn.of_disconnectdb()
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_init_memdet_methpay (string as_wspass, ref str_divsrv_det astr_divsrv_det) throws Exception;integer  result
 

n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice

try
	in_conn.of_connectdb(as_wspass)
	
	n_cst_divsrv_memdet ln_service
	ln_service = create n_cst_divsrv_memdet
	 
	
	ln_service.of_initservice(in_conn)
	
	result = ln_service.of_init_memdet_methpay(astr_divsrv_det)
	in_conn.of_disconnectdb()
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_save_slip (string as_wspass, ref str_divsrv_oper astr_divavg_oper) throws Exception;integer  result
 

n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice

try
	in_conn.of_connectdb(as_wspass)
	
	n_cst_divsrv_operate ln_service
	ln_service = create n_cst_divsrv_operate
	 
	
	ln_service.of_initservice(in_conn)
	
	result = ln_service.of_save_slip(astr_divavg_oper)
	in_conn.of_disconnectdb()
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_save_slip_ccl (string as_wspass, ref str_divsrv_oper astr_divavg_oper) throws Exception;integer  result
 

n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice

try
	in_conn.of_connectdb(as_wspass)
	
	n_cst_divsrv_operate ln_service
	ln_service = create n_cst_divsrv_operate
	 
	
	ln_service.of_initservice(in_conn)
	
	result = ln_service.of_save_slip_ccl(astr_divavg_oper)
	in_conn.of_disconnectdb()
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_save_slip_grp (string as_wspass, ref str_divsrv_oper astr_divavg_oper) throws Exception;integer  result
 

n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice

try
	in_conn.of_connectdb(as_wspass)
	
	n_cst_divsrv_operate ln_service
	ln_service = create n_cst_divsrv_operate
	 
	
	ln_service.of_initservice(in_conn)
	
	result = ln_service.of_save_slip_grp(astr_divavg_oper)
	in_conn.of_disconnectdb()
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_save_methpay_ccl (string as_wspass, ref str_divsrv_req astr_divsrv_req) throws Exception;integer  result
 

n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice

try
	in_conn.of_connectdb(as_wspass)
	
	n_cst_divsrv_request ln_service
	ln_service = create n_cst_divsrv_request
	 
	
	ln_service.of_initservice(in_conn)
	
	result = ln_service.of_save_methpay_ccl(astr_divsrv_req)
	in_conn.of_disconnectdb()
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_save_reqchg (string as_wspass, ref str_divsrv_req astr_divsrv_req) throws Exception;integer  result
 

n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice

try
	in_conn.of_connectdb(as_wspass)
	
	n_cst_divsrv_request ln_service
	ln_service = create n_cst_divsrv_request
	 
	
	ln_service.of_initservice(in_conn)
	
	result = ln_service.of_save_reqchg(astr_divsrv_req)
	in_conn.of_disconnectdb()
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_init_methpay (string as_wspass, ref str_divsrv_req astr_divsrv_req) throws Exception;integer  result
 

n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice

try
	in_conn.of_connectdb(as_wspass)
	
	n_cst_divsrv_request ln_service
	ln_service = create n_cst_divsrv_request
	 
	
	ln_service.of_initservice(in_conn)
	
	result = ln_service.of_init_methpay(astr_divsrv_req)
	in_conn.of_disconnectdb()
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

public function integer of_save_methpay (string as_wspass, ref str_divsrv_req astr_divsrv_req) throws Exception;integer  result
 

n_cst_dbconnectservice in_conn
in_conn = create n_cst_dbconnectservice

try
	in_conn.of_connectdb(as_wspass)
	
	n_cst_divsrv_request ln_service
	ln_service = create n_cst_divsrv_request
	 
	
	ln_service.of_initservice(in_conn)
	
	result = ln_service.of_save_methpay(astr_divsrv_req)
	in_conn.of_disconnectdb()
catch(Exception ex)
	in_conn.of_disconnectdb()
	throw ex
end try
return result
end function

on n_divavg.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_divavg.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on
