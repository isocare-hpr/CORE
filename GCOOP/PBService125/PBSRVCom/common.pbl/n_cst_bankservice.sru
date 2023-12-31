$PBExportHeader$n_cst_bankservice.sru
forward
global type n_cst_bankservice from nonvisualobject
end type
end forward

global type n_cst_bankservice from nonvisualobject
end type
global n_cst_bankservice n_cst_bankservice

type variables
datastore	ids_feeinfo
end variables

forward prototypes
public function integer of_getfeeamt (string as_bankcode, decimal adc_moneyamt, ref decimal adc_feeamt, ref integer ai_overlap)
public function integer of_calfeeamt (decimal adc_moneyamt, decimal adc_prnamt, decimal adc_roundup, decimal adc_stepamt)
public function string of_getbankname (string as_bankcode)
public function string of_getbankbranchname (string as_bankcode, string as_branchcode)
public function string of_getbankshortname (string as_bankcode)
public function string of_getbankaccformat (string as_bank, integer ai_formattype)
end prototypes

public function integer of_getfeeamt (string as_bankcode, decimal adc_moneyamt, ref decimal adc_feeamt, ref integer ai_overlap);// การเขย่งของ fee เช่น 100,103.00 บาท คิด fee ได้ 110
// แต่ถ้าหัก fee แล้วเหลือ 99,993 จะคิด fee ได้ 100
// ถ้าเอา 100 มาหักก็เป็น 100,003 ก็เกินอีก
string		ls_filter
long		ll_count, ll_stepfee
dec{2}		ldc_feemax, ldc_feemin, ldc_prinamt, ldc_roundup, ldc_stepamt, ldc_modamt
dec{2}		ldc_moneychk, ldc_feechk

ls_filter		= "bank_code = '"+as_bankcode+"' and "+string( adc_moneyamt )+" between start_amt and end_amt"

ids_feeinfo.setfilter( ls_filter )
ids_feeinfo.filter()

ll_count	= ids_feeinfo.rowcount()
ai_overlap	= 0

if ll_count <= 0 then
	messagebox( "หาค่าธรรมเนียมธนาคาร", "ไม่มีการกำหนดข้อมูลค่าธรรมเนียมธนาคาร "+as_bankcode+" ช่วงจำนวนเงิน "+string( adc_moneyamt, "#,##0.00" ) )
	return -1
end if

ldc_prinamt	= ids_feeinfo.getitemdecimal( ll_count, "principal_amt" )
ldc_roundup	= ids_feeinfo.getitemdecimal( ll_count, "roundup_amt" )
ldc_stepamt	= ids_feeinfo.getitemdecimal( ll_count, "fee_amt" )
ldc_feemax	= ids_feeinfo.getitemdecimal( ll_count, "max_feevalue" )
ldc_feemin		= ids_feeinfo.getitemdecimal( ll_count, "min_feevalue" )

if ldc_stepamt <= 0 then
	return 0
end if

// ค่าธรรมเนียม
adc_feeamt	= this.of_calfeeamt( adc_moneyamt, ldc_prinamt, ldc_roundup, ldc_stepamt ) 

// Check ว่ามีการเขย่งหรือเปล่า
ldc_moneychk	= adc_moneyamt - adc_feeamt
ldc_feechk		= this.of_calfeeamt( ldc_moneychk, ldc_prinamt, ldc_roundup, ldc_stepamt ) 

if ldc_feechk <> adc_feeamt then
	ai_overlap	= 1
end if

// Check ยอดต่ำสุด
if adc_feeamt < ldc_feemin then
	adc_feeamt	= ldc_feemin
end if

// Check ยอดสูงสุด
if adc_feeamt >ldc_feemax and ldc_feemax > 0 then
	adc_feeamt	= ldc_feemax
end if

return 1

end function

public function integer of_calfeeamt (decimal adc_moneyamt, decimal adc_prnamt, decimal adc_roundup, decimal adc_stepamt);long		ll_stepfee
dec{2}		ldc_modamt, ldc_feeamt

ll_stepfee		= truncate( ( adc_moneyamt / adc_prnamt ), 0 )
ldc_modamt	= mod( adc_moneyamt, adc_prnamt )
	
if ldc_modamt > adc_roundup then
	ll_stepfee++
end if
	
ldc_feeamt		= ll_stepfee * adc_stepamt

return ldc_feeamt
end function

public function string of_getbankname (string as_bankcode);string	ls_bankdesc

select	bank_desc
into		:ls_bankdesc
from	cmucfbank
where	( bank_code	= :as_bankcode ) ;

if sqlca.sqlcode <> 0 then
	ls_bankdesc	= ""
end if

return ls_bankdesc
end function

public function string of_getbankbranchname (string as_bankcode, string as_branchcode);string	ls_branchdesc

select	branch_name
into		:ls_branchdesc
from	cmucfbankbranch
where	( bank_code	= :as_bankcode ) and
		( branch_id		= :as_branchcode ) ;

if sqlca.sqlcode <> 0 then
	ls_branchdesc	= ""
end if

return ls_branchdesc
end function

public function string of_getbankshortname (string as_bankcode);string	ls_bankdesc

select	bank_shortname
into		:ls_bankdesc
from	cmucfbank
where	( bank_code	= :as_bankcode ) ;

if isnull( ls_bankdesc ) then ls_bankdesc = ""

return ls_bankdesc
end function

public function string of_getbankaccformat (string as_bank, integer ai_formattype);//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Description		: หารูปแบบ format account ของธนาคารนั้น ๆ
// Initial site		: กรมที่ดิน sco02  ( Thursday, March 18, 2004 )
// Argument		:
// ai_formattype 	: 1 = รูปแบบสำหรับการป้อนข้อมูล เหมาะกับการทำ edit mask
//			  		  2 = รูปแบบสำหรับการ display เช่น ออกรายงาน
//					  ค่า default = 1
// Programmer		: MiTja
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
string	ls_format
char	ls_editformat[]
char	ls_ch
integer	li_acclen, li_index

// check formmat type
if ( ai_formattype < 1 ) or ( ai_formattype > 2 ) then
	ai_formattype = 1
end if

// check bank code ที่ฝั่ง client ก่อนโดยยังไม่ไปดึงข้อมูลที่ DB
if isnull( as_bank ) or trim( as_bank ) = "" then
	if ( ai_formattype = 1 ) then
		ls_format = "###-#-#####-#"					// เหมาะกับการ edit mask
	else
		ls_format = "@@@-@-@@@@@-@"		// เหมาะสำหรับการทำ display ข้อมูล
	end if
	return	ls_format
end if

// ค่าถูกต้องค่อยดึงจาก DB
select	account_format
into		:ls_format
from	cmucfbank
where	bank_code = :as_bank ;

ls_format = trim( ls_format )

if ( sqlca.sqlcode <> 0 ) then
	if ( ai_formattype = 1 ) then
		ls_format = "###-#-#####-#"		// เหมาะกับการ edit mask
	else
		ls_format = "@@@-@-@@@@@-@"		// เหมาะสำหรับการทำ display ข้อมูล
	end if
else
	
	// ต้องการรูปแบบ edit mask
	if ( ai_formattype = 1 ) then	
		li_acclen = len( ls_format )
		ls_editformat[] = ls_format
		for	li_index = 1 to li_acclen
			ls_ch = ls_editformat[ li_index ]
			if ( ls_ch <> "-" ) then
				ls_editformat[ li_index ] = "#"
			end if
		next
		ls_format = ls_editformat[]
	end if
	
end if

return ls_format
end function

event constructor;// ค่าธรรมเนียมธนาคาร เงื่อนไขการคิดค่าธรรมเนียม
ids_feeinfo = create datastore
ids_feeinfo.dataobject = "d_cm_feeamtinfo"
ids_feeinfo.settransobject( sqlca )
ids_feeinfo.retrieve()
end event

on n_cst_bankservice.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_bankservice.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

