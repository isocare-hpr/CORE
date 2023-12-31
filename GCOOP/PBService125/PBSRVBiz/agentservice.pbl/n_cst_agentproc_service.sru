$PBExportHeader$n_cst_agentproc_service.sru
$PBExportComments$ประมวลผลลูกหนี้ตัวแทน
forward
global type n_cst_agentproc_service from nonvisualobject
end type
end forward

global type n_cst_agentproc_service from nonvisualobject
end type
global n_cst_agentproc_service n_cst_agentproc_service

type variables
transaction	itr_sqlca
Exception	ithw_exception

datastore	ids_storage

n_cst_progresscontrol		inv_progress
n_cst_dbconnectservice		inv_connection

string	is_recvperiod, is_arg[]
integer ii_proctype , ii_procstatus
end variables

forward prototypes
public function integer of_initservice (n_cst_dbconnectservice anv_dbtrans)
private function integer of_buildsqlext (string as_arg[], string as_column, ref string as_sqlext)
private function integer of_getsqlselect (ref n_ds ads_info)
private function integer of_analyzestring (string as_soucetext, ref string as_arg[]) throws Exception
public function integer of_setprogress (ref n_cst_progresscontrol anv_progress) throws Exception
private function integer of_deleteagreceive () throws Exception
private function integer of_deleteagmaster () throws Exception
private function integer of_processagreceive () throws Exception
private function integer of_processagmaster () throws Exception
public function integer of_agentprocess (str_agent astr_agent) throws Exception
private function decimal of_get_begin (string as_period, string as_memno, string as_refmemno)
end prototypes

public function integer of_initservice (n_cst_dbconnectservice anv_dbtrans);// Service Transection
if isnull( inv_connection ) or not isvalid( inv_connection ) then
	inv_connection	= create n_cst_dbconnectservice
	inv_connection	= anv_dbtrans
end if

itr_sqlca 		= inv_connection.itr_dbconnection

// สร้าง Progress สำหรับแสดงสถานะการประมวลผล
inv_progress = create n_cst_progresscontrol

return 1
end function

private function integer of_buildsqlext (string as_arg[], string as_column, ref string as_sqlext);/***********************************************************
<description>
	สร้างชุด SQL จากชื่อคอลัมน์ที่ำกำหนด
</description>

<arguments>  
	as_arg[]				String		สาย string
	as_column			String		ชื่อคอลัมน์
	as_sqlext	 (ref)		String		ผลลัพธ์ SQL
</arguments> 

<return> 
	Integer			1 = success
</return> 

<usage> 

	Revision History:
	Version 1.0 (Initial version) Modified Date 16/11/2010 by Godji
</usage> 
***********************************************************/

integer	li_index, li_count

li_count = upperbound(as_arg[])
if isnull(li_count) then li_count = 0

for li_index = 1 to li_count
	if li_index = 1 then
		as_sqlext = " ( "+as_column+as_arg[li_index]+" ) "
	else
		as_sqlext += " or ( "+as_column+as_arg[li_index]+" ) "
	end if
next

if len(as_sqlext) > 0 then
	as_sqlext = "( "+as_sqlext+" )"
end if

return 1

end function

private function integer of_getsqlselect (ref n_ds ads_info);/***********************************************************
<description>
	สร้างชุด sql ในส่วน Where เพิ่มเติมสำหรับการประมวลผล 
	จากการเลือกช่วงสังกัด หรือ ช่วงเลขสมาชิก
</description>

<arguments>  
	ads_info			n_ds		datastore ข้อมูลรายการที่จะทำการจัดเก็บ
</arguments> 

<return> 
	integer		1 = success, -1 = failure
</return> 

<usage> 
		
	Revision History:
	Version 1.0 (Initial version) Modified Date 16/11/2010 by Godji
</usage> 
***********************************************************/

string		ls_sqlext, ls_temp
integer	li_ret

choose case ii_procstatus
	case 1
		ls_sqlext	= " and ( kptempreceive.recv_period = '"+is_recvperiod+"' ) "
	case 2
		this.of_buildsqlext( is_arg[], "mbucfmembgroup.agentgrp_code", ls_sqlext )
		ls_sqlext	= "and ( kptempreceive.recv_period = '"+is_recvperiod+"' ) and "+ls_sqlext
	case 3
		this.of_buildsqlext( is_arg[], "mbmembmaster.member_no", ls_sqlext )
		ls_sqlext	= "and ( kptempreceive.recv_period = '"+is_recvperiod+"' ) and "+ls_sqlext
end choose

ads_info.settransobject( itr_sqlca )

if ls_sqlext <> "" then
	ls_temp	= ads_info.getsqlselect()
	ls_temp	+= ls_sqlext
	li_ret = ads_info.setsqlselect( ls_temp )
	
	if ( li_ret <> 1 ) then
		return -1
	end if	
	ads_info.settransobject( itr_sqlca )
end if

return 1
end function

private function integer of_analyzestring (string as_soucetext, ref string as_arg[]) throws Exception;/***********************************************************
<description>
	วิเคราะห์สาย string ให้อยู่ในรูปที่เหมาะสมเพื่อที่จะนำไปใช้ในการสร้างชุดคำสั่ง SQL ต่อไป
</description>

<arguments>  
	as_sourcetext		String		สาย string
	as_arg[]	(ref)		String		กลุ่มของ string ที่จัดกลุ่มแล้ว
</arguments> 

<return> 
	Integer			1 = success
</return> 

<usage> 

	Revision History:
	Version 1.0 (Initial version) Modified Date 16/11/2010 by Godji
</usage> 
***********************************************************/

string	ls_souce[], ls_dessingle[], ls_desbetween[], ls_desless[], ls_desmore[]
string	ls_temp[], ls_empty[], ls_text
integer	li_count, li_index, li_csingle, li_ctemp
n_cst_stringservice	lnv_string

lnv_string = create n_cst_stringservice

lnv_string.of_parsetoarray ( as_soucetext, ",", ls_souce[] )
li_count = upperbound(ls_souce[])

for li_index = 1 to li_count
	ls_text = trim(ls_souce[li_index])
	if lnv_string.of_isalphanumthai(ls_text) then
		li_csingle++
		ls_dessingle[li_csingle] = "'"+trim(ls_text)+"'"
	else
		if pos(ls_text, "-", 1) = 0 then
			destroy lnv_string
			ithw_exception.text = " รหัสที่ใส่ เครื่องดูแล้วไม่เข้าใจ (งง) ใส่ใหม่นะ...~n " + ls_text + "~n" + ithw_exception.text 
			throw ithw_exception
		end if
		
		lnv_string.of_parsetoarray ( ls_text, "-", ls_temp[] )
		choose case upperbound(ls_temp[])
			case 1		// ประเภท ขีด ตามหลัง เช่น   11030-
				li_ctemp	= upperbound(ls_desmore[])
				if isnull(li_ctemp) then li_ctemp = 0
				ls_desmore[li_ctemp +1] = "'"+trim(ls_temp[1])+"'"
				
			case 2		// ประเภท มีขีด ตรงกลาง หรือ ขีดนำหน้า เช่น 11030-11040, -11050
				if trim(ls_temp[1]) = "" or isnull(ls_temp[1]) then
					li_ctemp	= upperbound(ls_desless[])
					if isnull(li_ctemp) then li_ctemp = 0
					ls_desless[li_ctemp +1] = "'"+trim(ls_temp[2])+"'"
				else
					li_ctemp	= upperbound(ls_desbetween[])
					if isnull(li_ctemp) then li_ctemp = 0
					ls_desbetween[li_ctemp +1] = "'"+trim(ls_temp[1])+"' and '"+trim(ls_temp[2])+"'"
				end if
				
			case else	// ประเภทใส่ขีดมากกว่า 1 ขีด
				destroy lnv_string
				ithw_exception.text = " รหัสที่ใส่ เครื่องดูแล้วไม่เข้าใจ (งง) ใส่ใหม่นะ...~n " + ls_text + "~n" + ithw_exception.text 
				throw ithw_exception
				
		end choose
		ls_temp[] = ls_empty[]
	end if
next

// ตรวจ between
li_count = upperbound(ls_desbetween[])
for li_index = 1 to li_count
	as_arg[li_index] = " between "+ls_desbetween[li_index]
next

// ตรวจ less than
li_count = upperbound(ls_desless[])
for li_index = 1 to li_count
	li_ctemp	= upperbound(as_arg[])
	if isnull(li_ctemp) then li_ctemp = 0
	as_arg[li_ctemp + 1] = " <= "+ls_desless[li_index]
next

// ตรวจ more than
li_count = upperbound(ls_desmore[])
for li_index = 1 to li_count
	li_ctemp	= upperbound(as_arg[])
	if isnull(li_ctemp) then li_ctemp = 0
	as_arg[li_ctemp + 1] = " >= "+ls_desmore[li_index]
next

// ตรวจ single
ls_text = ""
lnv_string.of_arraytostring(ls_dessingle[],",",ls_text)

if len(ls_text) > 0 then
	li_index = upperbound(as_arg[])
	if isnull(li_index) then li_index = 0
	as_arg[li_index+1] = " in ("+ls_text+") "
end if

destroy lnv_string

return 1
end function

public function integer of_setprogress (ref n_cst_progresscontrol anv_progress) throws Exception;/***********************************************************
<description>
	กำหนด progress bar ที่ใช้แสดงผล
</description>

<arguments>

</arguments> 

<return> 
	Integer	1 = success
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 16/11/2010 by Godji
</usage> 
***********************************************************/

anv_progress = inv_progress

return 1
end function

private function integer of_deleteagreceive () throws Exception;/***********************************************************
<description>
	ลบข้อมูลลูกหนี้ตัวแทนรายคน agagentmaster
	กรณีมีการประมวลผลซ้ำ
</description>

<arguments>  
	
</arguments> 

<return> 
		1					Integer	ถ้าไม่มีข้อผิดพลาด
</return> 

<usage> 
		
	Revision History:
	Version 1.0 (Initial version) Modified Date 16/11/2010 by Godji
</usage> 
***********************************************************/
string		ls_sqlext, ls_sql, ls_sqlupext, ls_temp
integer		li_chk
string 		ls_sqldet

inv_progress.istr_progress.progress_text		= "กำลัง Clear ข้อมูลเก่า (ลูกหนี้ตัวแทนรายบุคคล)"
inv_progress.istr_progress.subprogress_text	= "กำลัง Clear ข้อมูลเก่า (ลูกหนี้ตัวแทนรายบุคคล)"

// syntax สำหรับ ลบ master ใบเสร็จ
ls_sql	= "delete from agreceive " + &
		   "where	( recv_period	= '"+is_recvperiod+"' ) "

choose case ii_procstatus
	case 1
		ls_sqlext		= ""

      case 2
		of_buildsqlext(is_arg[], "mbucfmembgroup.agentgrp_code", ls_sqlext)
		ls_sqlext		= " and ( member_no in ( select member_no from mbmembmaster where membgroup_code in ( select membgroup_code from mbucfmembgroup where "+ ls_sqlext + " ) ) )"
	case 3
		of_buildsqlext( is_arg[], "member_no", ls_sqlext )
		ls_sqlext		= " and "+ ls_sqlext
end choose

// เคลียร์ลูกหนี้ตัวแทนรายคน
ls_temp	= ls_sql + ls_sqlext
execute immediate :ls_temp using itr_sqlca;
yield()
if itr_sqlca.sqlcode = -1 then
	ithw_exception.text += "พบข้อผิดพลาด ขณะ Clear ข้อมูลเดิม (ลูกหนี้ตัวแทนรายบุคคล)~r~n"+itr_sqlca.sqlerrtext
	return -1
end if

return 1
end function

private function integer of_deleteagmaster () throws Exception;/***********************************************************
<description>
	ลบข้อมูลลูกหนี้ตัวแทนรายสังกัด agreceive
	กรณีมีการประมวลผลซ้ำ
</description>

<arguments>  
	
</arguments> 

<return> 
		1					Integer	ถ้าไม่มีข้อผิดพลาด
</return> 

<usage> 
		
	Revision History:
	Version 1.0 (Initial version) Modified Date 16/11/2010 by Godji
</usage> 
***********************************************************/
string		ls_sqlext, ls_sql, ls_sqlupext, ls_temp
integer		li_chk
string 		ls_sqldet

inv_progress.istr_progress.progress_text		= "กำลัง Clear ข้อมูลเก่า (ลูกหนี้ตัวแทนรายสังกัด)"
inv_progress.istr_progress.subprogress_text	= "กำลัง Clear ข้อมูลเก่า (ลูกหนี้ตัวแทนรายสังกัด)"

// syntax สำหรับ ลบ master ใบเสร็จ
ls_sql	= "delete from agagentmaster " + &
		   "where	( recv_period	= '"+is_recvperiod+"' ) "

choose case ii_procstatus
	case 1
		ls_sqlext		= ""

      case 2
		of_buildsqlext(is_arg[], "agentgrp_code", ls_sqlext)
		ls_sqlext		= " and "+ ls_sqlext 
	case 3
		of_buildsqlext( is_arg[], "member_no", ls_sqlext )
		ls_sqlext		= " and agentgrp_code in ( select agentgrp_code from mbucfmembgroup where  membgroup_code in ( select membgroup_code from mbmembmaster where "+ ls_sqlext + " ) )"
end choose

// เคลียร์ลูกหนี้ตัวแทนรายคน
ls_temp	= ls_sql + ls_sqlext
execute immediate :ls_temp using itr_sqlca;
yield()
if itr_sqlca.sqlcode = -1 then
	ithw_exception.text += "พบข้อผิดพลาด ขณะ Clear ข้อมูลเดิม (ลูกหนี้ตัวแทนรายสังกัด)~r~n"+itr_sqlca.sqlerrtext
	return -1
end if

return 1
end function

private function integer of_processagreceive () throws Exception;/***********************************************************
<description>
	ประมวลเก็บข้อมูลลูกหนี้ตัวแทนรายบุคคล
</description>

<arguments>  

</arguments> 

<return> 
	Integer	1 = success,  Exception = failure
</return> 

<usage> 
	Revision History:
	Version 1.0 (Initial version) Modified Date 16/11/2010 by Godji
</usage> 
***********************************************************/
string ls_memberno , ls_refmembno , ls_membgroupcode , ls_receiptno , ls_agentgrpcode
integer li_ret, li_chkmem , li_keepingstatus , li_misspaystatus , li_membertype
long ll_index, ll_count
dec{2} ldc_receiveamt , ldc_sharestkvalue , ldc_interestaccum, ldc_outstandingbal_begin
datetime ldtm_processdate , ldtm_receiptdate , ldtm_operatedate
n_ds	lds_agreceive

inv_progress.istr_progress.subprogress_text	= "กำลังดึงข้อมูล"
inv_progress.istr_progress.subprogress_index	= 0
inv_progress.istr_progress.subprogress_max	= 1

lds_agreceive	= create n_ds
choose case ii_proctype
	case 1 // ประมวลจากยอดเรียกเก็บ
		lds_agreceive.dataobject	= "d_ag_rcvproc_kptempdetail"
	case 2 // ประมวลจากใบเสร็จ
		lds_agreceive.dataobject	= "d_ag_rcvproc_kpmastdetail"
end choose
lds_agreceive.settransobject( itr_sqlca )

// สร้างชุด SQL สำหรับการดึงรายการ
li_ret = this.of_getsqlselect( lds_agreceive )
if ( li_ret <> 1 ) then
	destroy lds_agreceive
	ithw_exception.text += "~nพบข้อผิดพลาดในการสร้างชุด SQL รายการอื่น ๆ"
	throw ithw_exception	
end if

ll_count			= lds_agreceive.retrieve()
lds_agreceive.setsort( "member_no" )
lds_agreceive.sort()
inv_progress.istr_progress.subprogress_max	= ll_count

for ll_index = 1 to ll_count
	inv_progress.istr_progress.subprogress_index	= ll_index

	// ตรวจสอบการสั่งหยุดทำงาน
	yield()
	if inv_progress.of_is_stop() then
		destroy lds_agreceive
		return 0
	end if
	
	ls_memberno			= trim( lds_agreceive.object.member_no[ ll_index ] )
	ls_refmembno			= trim( lds_agreceive.object.ref_membno[ ll_index ] )
	ls_membgroupcode 	= lds_agreceive.object.membgroup_code[ll_index]
	ls_agentgrpcode		= lds_agreceive.object.agentgrp_code[ll_index]
	ls_receiptno				= lds_agreceive.object.receipt_no[ll_index]
	li_keepingstatus  		= lds_agreceive.object.keeping_status[ll_index]
	li_misspaystatus		= lds_agreceive.object.misspay_status[ll_index]
	li_membertype			= lds_agreceive.object.member_type[ll_index]
	ldc_sharestkvalue 		= lds_agreceive.object.sharestk_value[ll_index]			;if isnull( ldc_sharestkvalue ) then ldc_sharestkvalue = 0
	ldc_interestaccum		= lds_agreceive.object.interest_accum[ll_index]			;if isnull( ldc_interestaccum ) then ldc_interestaccum = 0
	ldc_receiveamt			= lds_agreceive.object.receive_amt[ ll_index ] 				;if isnull( ldc_receiveamt ) then ldc_receiveamt = 0
	ldtm_processdate		= lds_agreceive.object.process_date[ll_index]
	ldtm_receiptdate  		= lds_agreceive.object.receipt_date[ll_index]
	ldtm_operatedate		= lds_agreceive.object.operate_date[ll_index]
	
	ldc_outstandingbal_begin	= this.of_get_begin( is_recvperiod, ls_memberno ,ls_refmembno )
	
	// นำข้อมูลลง ลูกหนี้ตัวแทนรายคน
	insert into agreceive
	(	member_no , 			recv_period , 			ref_membno , 			process_date , 
		receipt_no , 			receipt_date , 			operate_date , 			sharestk_value , 
		interest_accum , 		receive_amt , 			keeping_status , 		membgroup_code , 
		misspay_status ,		recv_amt ,				agentgrp_code ,		addrecv_amt ,
		ret_all_amt ,			adj_all_amt ,			member_type ,			cancel_all_amt ,
		in_stmtc_amt , 			out_stmtc_amt,			outstandingbal_begin )
	values
	(	:ls_memberno , 		:is_recvperiod , 		:ls_refmembno , 		:ldtm_processdate , 
		:ls_receiptno , 			:ldtm_receiptdate,		:ldtm_operatedate , 	:ldc_sharestkvalue, 
		:ldc_interestaccum , 	:ldc_receiveamt , 		:li_keepingstatus , 	:ls_membgroupcode , 
		:li_misspaystatus ,		0 ,							:ls_agentgrpcode ,		0 ,
		0 ,							0 ,							:li_membertype ,		0 ,
		0 ,							0,							:ldc_outstandingbal_begin )
	using itr_sqlca ;
	
	if itr_sqlca.sqlcode <> 0 then
		ithw_exception.text = "ประมวลผลลูกหนี้ตัวแทนรายบุคคล พบข้อผิดพลาด~n" + string( itr_sqlca.sqlcode ) + "  " + itr_sqlca.sqlerrtext + "~n" + ithw_exception.text
		destroy lds_agreceive
		throw ithw_exception
	end if
	
	inv_progress.istr_progress.subprogress_text = string( ll_index ) +". ทะเบียน "+ls_memberno+" > จำนวนเงิน "+string( ldc_receiveamt, "#,##0.00" )

next

destroy ( lds_agreceive )

return 1
end function

private function integer of_processagmaster () throws Exception;/***********************************************************
<description>
	ประมวลเก็บข้อมูลลูกหนี้ตัวแทนรายสังกัด
</description>

<arguments>  

</arguments> 

<return> 
	Integer	1 = success,  Exception = failure
</return> 

<usage> 
	Revision History:
	Version 1.0 (Initial version) Modified Date 16/11/2010 by Godji
</usage> 
***********************************************************/

string ls_agentgrpcode, ls_agentgrpdesc
string ls_temp , ls_sqlselect , ls_sqlgroup , ls_sqlext
integer li_ret, li_chkagentgrp , li_membertype , li_pos
long ll_index, ll_count
dec{2} ldc_sumreceive

n_ds	lds_agmaster

inv_progress.istr_progress.subprogress_text	= "กำลังดึงข้อมูล"
inv_progress.istr_progress.subprogress_index	= 0
inv_progress.istr_progress.subprogress_max	= 1

lds_agmaster	= create n_ds
lds_agmaster.dataobject	= "d_ag_rcvproc_agmaster"
lds_agmaster.settransobject( itr_sqlca )

choose case ii_procstatus
	case 1
		ls_sqlext	= "and ( agreceive.recv_period = '"+is_recvperiod+"' ) "
	case 2
		this.of_buildsqlext( is_arg[], "agreceive.agentgrp_code", ls_sqlext )
		ls_sqlext	= "and ( agreceive.recv_period = '"+is_recvperiod+"' ) and "+ls_sqlext
	case 3
		this.of_buildsqlext(is_arg[], "agreceive.member_no", ls_sqlext)
		ls_sqlext	= "and ( agreceive.recv_period = '"+is_recvperiod+"' ) and "+ls_sqlext
end choose

if ls_sqlext <> "" then
	ls_temp			= lds_agmaster.getsqlselect()
	li_pos				= pos( ls_temp, "GROUP BY", 1 )
	ls_sqlselect		= left( ls_temp, li_pos - 1 )
	ls_sqlgroup		= mid( ls_temp, li_pos - 1 )
	ls_temp			= ls_sqlselect + ls_sqlext + ls_sqlgroup
	lds_agmaster.setsqlselect( ls_temp )
	lds_agmaster.settransobject( itr_sqlca )
end if

ll_count			= lds_agmaster.retrieve()
inv_progress.istr_progress.subprogress_max	= ll_count

for ll_index = 1 to ll_count
	inv_progress.istr_progress.subprogress_index	= ll_index

	// ตรวจสอบการสั่งหยุดทำงาน
	yield()
	if inv_progress.of_is_stop() then
		destroy lds_agmaster
		return 0
	end if
	
	ls_agentgrpcode		= trim( lds_agmaster.object.agentgrp_code[ ll_index ] )
	ls_agentgrpdesc		= trim( lds_agmaster.object.agentgrp_desc[ ll_index ] )
	li_membertype			= lds_agmaster.object.member_type[ ll_index ]
	ldc_sumreceive			= lds_agmaster.object.sumreceive[ ll_index ] 	;if isnull( ldc_sumreceive ) then ldc_sumreceive = 0

	setnull( li_chkagentgrp )
	select 	count( am.agentgrp_code )
	into 		:li_chkagentgrp
	from 		agagentmaster am
	where 	am.agentgrp_code		= :ls_agentgrpcode
	and		am.agentgrp_desc		= :ls_agentgrpdesc
	and 		am.member_type		= :li_membertype
	using itr_sqlca ;
	
	// ถ้าไม่มีค่าแสดงว่ายังไม่มีข้อมูลลง
	if isnull( li_chkagentgrp ) or li_chkagentgrp <= 0 then
		
		// นำข้อมูลลง ลูกหนี้ตัวแทนรายคน
		insert into agagentmaster
		(	recv_period , 			agentgrp_code , 			member_type , 
			agentgrp_desc , 		stmt_amt ,					recv_amt	 ,
			addrecv_amt ,			ret_all_amt ,				adj_all_amt ,			
			cancel_all_amt ,		in_stmtc_amt , 				out_stmtc_amt)
		values
		(	:is_recvperiod ,			:ls_agentgrpcode ,			:li_membertype ,
			:ls_agentgrpdesc ,		:ldc_sumreceive ,			0 ,
			0 ,							0 ,								0 ,
			0 ,							0 ,								0)
		using itr_sqlca ;
		
		if itr_sqlca.sqlcode <> 0 then
			ithw_exception.text = "ประมวลผลลูกหนี้ตัวแทนรายบุคคล พบข้อผิดพลาด~n" + string( itr_sqlca.sqlcode ) + "  " + itr_sqlca.sqlerrtext + "~n" + ithw_exception.text
			destroy lds_agmaster
			throw ithw_exception
		end if
		
		inv_progress.istr_progress.subprogress_text = string( ll_index ) +". สังกัดลูกหนี้ตัวแทน "+ls_agentgrpcode+" > จำนวนเงิน "+string( ldc_sumreceive, "#,##0.00" )
		
	end if
next

destroy lds_agmaster

return 1
end function

public function integer of_agentprocess (str_agent astr_agent) throws Exception;/***********************************************************
<description>
	นำเข้าข้อมูลลูกหนี้ตัวแทนรายคน,รายสังกัด
</description>

<arguments> 
	astr_agent.xml_agentoption		String		xml เงื่อนไขการคำนวณ
</arguments> 

<return> 
	Integer		1 = success, Exception = failure
</return> 

<usage> 
	
	Revision History:
	Version 1.0 (Initial version) Modified Date 16/11/2010 by Godji
</usage> 
***********************************************************/

integer		li_ret , li_year , li_month
string			ls_recvperiod , ls_xmlagentoption
string			ls_agentgroup , ls_memno
n_ds		lds_agentoption

ls_xmlagentoption		= astr_agent.xml_agentoption

// ดึงเงื่อนไขการประมวลผล
lds_agentoption = create n_ds
lds_agentoption.dataobject = 'd_ag_trnkeep_option'
lds_agentoption.settransobject( itr_sqlca )
lds_agentoption.importstring( XML!, ls_xmlagentoption )

if lds_agentoption.rowcount() < 1 then 
	destroy( lds_agentoption )
	ithw_exception.text += "~nเนื่องจากไม่ได้รับลายละเอียดเงื่อนไขการประมวล~nไม่สามารถทำรายการประมวลลูกหนี้ตัวแทนได้"
	throw ithw_exception
	return -1
end if

// set ค่า progress bar
inv_progress.istr_progress.progress_text = "เตรียมประมวลผลลูกหนี้ตัวแทน"
inv_progress.istr_progress.progress_index = 0
inv_progress.istr_progress.progress_max = 2
inv_progress.istr_progress.status = 8

li_year				= lds_agentoption.object.receive_year[1]
li_month				= lds_agentoption.object.receive_month[1]
ls_agentgroup 		= lds_agentoption.object.group_text[1]
ls_memno			= lds_agentoption.object.mem_text[1]

// กำหนดค่าให้ instance เพื่อใช้ในฟังก์ชันอื่น ๆ
ii_procstatus		= lds_agentoption.object.proc_status[1]
ii_proctype			= lds_agentoption.object.proc_type[1]
is_recvperiod		= string( li_year ) + string( li_month, "00" )

// รูปแบบการประมวลผล
choose case ii_procstatus
	case 2	// ตามกลุ่ม
		this.of_analyzestring( ls_agentgroup, is_arg[] )
	case 3 // ตามทะเบียน
		this.of_analyzestring( ls_memno, is_arg[] )
end choose

// ลบข้อมูลที่กำลังประมวลผลลูกหนี้ตัวแทนรายคน
if this.of_deleteagreceive( ) <> 1 then
	rollback using itr_sqlca ;
	return -1
end if

// ลบข้อมูลที่กำลังประมวลผลลูกหนี้ตัวแทนรายสังกัด
if this.of_deleteagmaster( ) <> 1 then
	rollback using itr_sqlca ;
	return -1
end if

// เริ่มประมวลผล
// บุคคลลูกหนี้ตัวแทน
inv_progress.istr_progress.progress_text = "ประมวลผลลูกหนี้ตัวแทน"
inv_progress.istr_progress.progress_index = 1
li_ret = this.of_processagreceive( )
if li_ret <> 1 then
	rollback using itr_sqlca ;
	throw ithw_exception
end if

// สังกัดลูกหนี้ตัวแทน
inv_progress.istr_progress.progress_text = "สรุปยอดลงสังกัดลูกหนี้ตัวแทน"
inv_progress.istr_progress.progress_index = 2
li_ret = this.of_processagmaster( )
if li_ret <> 1 then
	rollback using itr_sqlca ;
	throw ithw_exception
end if

commit using itr_sqlca ;

inv_progress.istr_progress.status = 1
destroy( lds_agentoption )

return 1
end function

private function decimal of_get_begin (string as_period, string as_memno, string as_refmemno);dec{2}	ldc_bal
integer	li_year, li_period

li_year	= integer( left( as_period , 4 ) )
li_period	= integer( right( as_period , 2 ) )

li_period	= li_period - 1

if li_period < 1 then
	li_period	= 12
	li_year	= li_year - 1
end if

as_period	= string( li_year, '0000' ) +  string( li_period, '00' )

select		receive_amt + outstandingbal_begin - recv_amt - addrecv_amt + ret_all_amt - adj_all_amt + cancel_all_amt
into		:ldc_bal
from		agreceive
where	member_no		= :as_memno and
			recv_period		= :as_period and
			ref_membno	= :as_refmemno
using itr_sqlca ;

if isnull( ldc_bal) then  ldc_bal = 0.00
return ldc_bal
end function

on n_cst_agentproc_service.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_agentproc_service.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ithw_exception = create Exception
inv_progress = create n_cst_progresscontrol
end event

event destructor;if isvalid( ithw_exception ) then destroy ithw_exception
if isvalid( inv_progress ) then destroy inv_progress
end event

