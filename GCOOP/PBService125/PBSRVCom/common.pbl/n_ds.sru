$PBExportHeader$n_ds.sru
forward
global type n_ds from datastore
end type
end forward

global type n_ds from datastore
end type
global n_ds n_ds

type variables
string		is_errmsg


end variables

forward prototypes
public function any of_getitemany (long al_row, integer ai_column)
public function any of_getitemany (long al_row, integer ai_column, dwbuffer adw_buffer, boolean ab_orig_value)
public function any of_getitemany (long al_row, string as_column)
public function any of_getitemany (long al_row, string as_column, dwbuffer adw_buffer, boolean ab_orig_value)
public function integer of_setitem (long al_row, string as_column, string as_value)
public function integer of_setitem (long al_row, integer ai_column, string as_value)
private function date of_conversiondate (string as_datetime)
private function time of_conversiontime (string as_datetime)
public function string of_geterrormessage ()
public function integer of_update (boolean ab_accepttext, boolean ab_resetflag, ref string as_error)
public function integer of_update (ref string as_error)
end prototypes

public function any of_getitemany (long al_row, integer ai_column);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetItemany (FORMAT 1) 
//
//	Access:    Public
//
//	Arguments:
//   al_row			   : The row reference
//   ai_column    	: The column number reference
//
//	Returns:  Any
//	  The column value cast to an any datatype
//
//	Description:  Returns a column's value cast to an any datatype
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2005, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the GNU Lesser General
 * Public License Version 2.1, February 1999
 *
 * http://www.gnu.org/copyleft/lesser.html
 *
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals and was originally based on software copyright (c) 
 * 1996-2004 Sybase, Inc. http://www.sybase.com.  For more
 * information on the Open Source PowerBuilder Foundation Class
 * Libraries see http://pfc.codexchange.sybase.com
*/
//
//////////////////////////////////////////////////////////////////////////////
string ls_columnname 

ls_columnname = this.Describe ( "#" + String( ai_column ) + ".name" )

Return of_GetItemany ( al_row, ls_columnname, Primary!, FALSE )
end function

public function any of_getitemany (long al_row, integer ai_column, dwbuffer adw_buffer, boolean ab_orig_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetItemany (FORMAT 2) 
//
//	Access:    Public
//
//	Arguments:
//   al_row			   : The row reference
//   ai_column    	: The column number reference
//   adw_buffer   	: The dw buffer from which to get the column's data value.
//   ab_orig_value	: When True, returns the original values that were 
//							  retrieved from the database.
//
//	Returns:  Any
//	  The column value cast to an any datatype
//
//	Description:  Returns a column's value cast to an any datatype
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2005, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the GNU Lesser General
 * Public License Version 2.1, February 1999
 *
 * http://www.gnu.org/copyleft/lesser.html
 *
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals and was originally based on software copyright (c) 
 * 1996-2004 Sybase, Inc. http://www.sybase.com.  For more
 * information on the Open Source PowerBuilder Foundation Class
 * Libraries see http://pfc.codexchange.sybase.com
*/
//
//////////////////////////////////////////////////////////////////////////////
string ls_columnname 

ls_columnname = this.Describe ( "#" + String( ai_column ) + ".name" )

Return of_GetItemany ( al_row, ls_columnname, adw_buffer, ab_orig_value )
end function

public function any of_getitemany (long al_row, string as_column);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetItemany (FORMAT 3) 
//
//	Access:    Public
//
//	Arguments:
//   al_row			   : The row reference
//   as_column    	: The column name reference
//
//	Returns:  Any
//	  The column value cast to an any datatype
//
//	Description:  Returns a column's value cast to an any datatype
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2005, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the GNU Lesser General
 * Public License Version 2.1, February 1999
 *
 * http://www.gnu.org/copyleft/lesser.html
 *
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals and was originally based on software copyright (c) 
 * 1996-2004 Sybase, Inc. http://www.sybase.com.  For more
 * information on the Open Source PowerBuilder Foundation Class
 * Libraries see http://pfc.codexchange.sybase.com
*/
//
//////////////////////////////////////////////////////////////////////////////
Return of_GetItemany ( al_row, as_column, Primary!, FALSE )
end function

public function any of_getitemany (long al_row, string as_column, dwbuffer adw_buffer, boolean ab_orig_value);//////////////////////////////////////////////////////////////////////////////
//	Public Function:  of_GetItemAny (FORMAT 4) 
//	Arguments:   	al_row			   : The row reference
//   					as_column    		: The column name reference
//   					adw_buffer   		: The dw buffer from which to get the column's data value.
//   					ab_orig_value		: When True, returns the original values that were 
//							  					  retrieved from the database.
//	Returns:			Any - The column value cast to an any datatype
//	Description:	Returns a column's value cast to an any datatype
//////////////////////////////////////////////////////////////////////////////
//	Rev. History	Version
//						5.0   Initial version
//						7.0	Removed test on computed columns.  They can be treated
//								as normal columns.
//////////////////////////////////////////////////////////////////////////////
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2005, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the GNU Lesser General
 * Public License Version 2.1, February 1999
 *
 * http://www.gnu.org/copyleft/lesser.html
 *
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals and was originally based on software copyright (c) 
 * 1996-2004 Sybase, Inc. http://www.sybase.com.  For more
 * information on the Open Source PowerBuilder Foundation Class
 * Libraries see http://pfc.codexchange.sybase.com
*/
//////////////////////////////////////////////////////////////////////////////
any 		la_value

/*  Determine the datatype of the column and then call the appropriate 
	 GetItemxxx function and cast the returned value */
CHOOSE CASE Lower ( Left ( this.Describe ( as_column + ".ColType" ) , 5 ) )

		CASE "char(", "char"		//  CHARACTER DATATYPE
			la_value = this.GetItemString ( al_row, as_column, adw_buffer, ab_orig_value ) 
	
		CASE "date"					//  DATE DATATYPE
			la_value = this.GetItemDate ( al_row, as_column, adw_buffer, ab_orig_value ) 

		CASE "datet"				//  DATETIME DATATYPE
			la_value = this.GetItemDateTime ( al_row, as_column, adw_buffer, ab_orig_value ) 

		CASE "decim"				//  DECIMAL DATATYPE
			la_value = this.GetItemDecimal ( al_row, as_column, adw_buffer, ab_orig_value ) 
	
		CASE "numbe", "long", "ulong", "real", "int"				//  NUMBER DATATYPE	
			la_value = this.GetItemNumber ( al_row, as_column, adw_buffer, ab_orig_value ) 
	
		CASE "time", "times"		//  TIME DATATYPE
			la_value = this.GetItemTime ( al_row, as_column, adw_buffer, ab_orig_value ) 

		CASE ELSE 					
			SetNull ( la_value ) 

END CHOOSE

Return la_value
end function

public function integer of_setitem (long al_row, string as_column, string as_value);//////////////////////////////////////////////////////////////////////////////
//	Public Function:		of_SetItem (FORMAT 2) 
//	Arguments:			al_row			:  The row reference for the value to be set
//							as_column		:  The column name reference
//							as_value			:  The value of the column in string format
//	Returns:				Integer: 			1 if successful,	-1 if an error occurrs.
//	Description:			Sets the specified row/column to the passed value.
//////////////////////////////////////////////////////////////////////////////
//	Rev. History:		Version
//							5.0		Initial version
//							5.0.02	Fixed problem with datetime columns being set to invalid datetime values
//										Added error checking for arguments.
//							6.0.01	Fixed where number and real datatype was being converted into a long.
//							8.0		Check datetime columns for absence of time value
//////////////////////////////////////////////////////////////////////////////
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2005, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the GNU Lesser General
 * Public License Version 2.1, February 1999
 *
 * http://www.gnu.org/copyleft/lesser.html
 *
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals and was originally based on software copyright (c) 
 * 1996-2004 Sybase, Inc. http://www.sybase.com.  For more
 * information on the Open Source PowerBuilder Foundation Class
 * Libraries see http://pfc.codexchange.sybase.com
*/
//////////////////////////////////////////////////////////////////////////////
integer	li_rc
date		ld_val
decimal	ldc_val
double	ldb_val
long		ll_val
real		lr_val
string		ls_string_value
time		ltm_val
n_cst_stringservice	lnv_string

// Check arguments
if IsNull (al_row) or IsNull (as_column) then
	return -1
end if

lnv_string	= create n_cst_stringservice

/*  Determine the datatype of the column and then call the SetItem
	 with proper datatype */

CHOOSE CASE Lower ( Left ( this.Describe ( as_column + ".ColType" ) , 5 ) )

		CASE "char(", "char"		//  CHARACTER DATATYPE
			li_rc = this.SetItem ( al_row, as_column, as_value ) 
	
		CASE "date"			//  DATE DATATYPE
			li_rc = this.SetItem ( al_row, as_column, Date (as_value) ) 

		CASE "datet"		//  DATETIME DATATYPE
			ld_val = this.of_conversiondate (as_value)
			If Pos ( as_value, " " ) > 0 Then
				/*  There was a time entered  */
				ltm_val = this.of_conversiontime(as_value)
			Else
				ltm_val = Time ( "00:00:00" )
			End If
			li_rc = this.SetItem (al_row, as_column, DateTime (ld_val, ltm_val))	
				
		CASE "decim"		//  DECIMAL DATATYPE
			/*  Replace formatting characters in passed string */
			ls_string_value = lnv_string.of_GlobalReplace (as_value, "$", "" ) 
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, ",", "" ) 
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, "(", "-")
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, ")", "")
			if Pos (ls_string_value, "%") > 0 then
				ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, "%", "")
				ldc_val = Dec (ls_string_value) / 100
			else
				ldc_val = Dec (ls_string_value)
			end if

			li_rc = this.SetItem ( al_row, as_column, ldc_val) 
	
		CASE "numbe", "doubl"			//  NUMBER DATATYPE	
			/*  Replace formatting characters in passed string */
			ls_string_value = lnv_string.of_GlobalReplace (as_value, "$", "" ) 
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, ",", "" ) 
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, "(", "-")
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, ")", "")
			if Pos (ls_string_value, "%") > 0 then
				ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, "%", "")
				ldb_val = Double (ls_string_value) / 100
			else
				ldb_val = Double (ls_string_value)
			end if
						
			li_rc = this.SetItem ( al_row, as_column, ldb_val) 
		
		CASE "real"				//  REAL DATATYPE	
			/*  Replace formatting characters in passed string */
			ls_string_value = lnv_string.of_GlobalReplace (as_value, "$", "" ) 
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, ",", "" ) 
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, "(", "-")
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, ")", "")
			if Pos (ls_string_value, "%") > 0 then
				ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, "%", "")
				lr_val = Real (ls_string_value) / 100
			else
				lr_val = Real (ls_string_value)
			end if
						
			li_rc = this.SetItem ( al_row, as_column, lr_val) 
		
		CASE "long", "ulong"		//  LONG/INTEGER DATATYPE	
			/*  Replace formatting characters in passed string */
			ls_string_value = lnv_string.of_GlobalReplace (as_value, "$", "" ) 
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, ",", "" ) 
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, "(", "-")
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, ")", "")
			if Pos (ls_string_value, "%") > 0 then
				ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, "%", "")
				ll_val = Long (ls_string_value) / 100
			else
				ll_val = Long (ls_string_value)
			end if
						
			li_rc = this.SetItem ( al_row, as_column, ll_val) 
		
		CASE "time", "times"		//  TIME DATATYPE
			li_rc = this.SetItem ( al_row, as_column, Time ( as_value ) ) 


END CHOOSE

destroy lnv_string

Return li_rc
end function

public function integer of_setitem (long al_row, integer ai_column, string as_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_SetItem (FORMAT 1)
//
//	Access:    		Public
//
//	Arguments:
//   al_row		:  The row reference for the value to be set
//   ai_column :  The column number reference
//   as_value  :  The value of the column in string format
//
//	Returns:  		Integer
//  					 1 = if it succeeds 
//  					-1 = if an error occurs
//
//	Description:  Sets the specified row/column to the passed value.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2005, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the GNU Lesser General
 * Public License Version 2.1, February 1999
 *
 * http://www.gnu.org/copyleft/lesser.html
 *
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals and was originally based on software copyright (c) 
 * 1996-2004 Sybase, Inc. http://www.sybase.com.  For more
 * information on the Open Source PowerBuilder Foundation Class
 * Libraries see http://pfc.codexchange.sybase.com
*/
//
//////////////////////////////////////////////////////////////////////////////
string ls_columnname

/* Get the Column Name from the Column Number. */
ls_columnname = this.Describe ( "#" + String ( ai_column) + ".Name" ) 

Return of_SetItem ( al_row, ls_columnname, as_value ) 
end function

private function date of_conversiondate (string as_datetime);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_Date
//
//	Access:  public
//
//	Arguments:
//	as_datetime   Datetime value as a string
//
//	Returns:  date
//	If as_datetime does not contain a valid datetime value, return date
//	is 1900-01-01.  If as_datetime is NULL, function returns NULL.
//
//	Description:
//	Converts a string whose value is a valid datetime to a date
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0.02   Initial version
// 5.0.04	Enhanced to handle to more cases.
//
//////////////////////////////////////////////////////////////////////////////
//
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2005, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the GNU Lesser General
 * Public License Version 2.1, February 1999
 *
 * http://www.gnu.org/copyleft/lesser.html
 *
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals and was originally based on software copyright (c) 
 * 1996-2004 Sybase, Inc. http://www.sybase.com.  For more
 * information on the Open Source PowerBuilder Foundation Class
 * Libraries see http://pfc.codexchange.sybase.com
*/
//
//////////////////////////////////////////////////////////////////////////////

date	ld_rc = 1900-01-01
long	ll_count
string	ls_datetime[]
n_cst_stringservice	lnv_string

// Check arguments
if IsNull (as_datetime) then
	SetNull (ld_rc)
	return ld_rc
end if

lnv_string	= create n_cst_stringservice

// Validate datetime string ("1/1/95", "1/1/95 8:00", "1/1/95 8:00 PM")
ll_count = lnv_string.of_ParseToArray (as_datetime, " ", ls_datetime)
if ll_count <= 0 or ll_count > 3 then
	destroy lnv_string
	return ld_rc
end if

// Date string passed in
if ll_count = 1 then
	destroy lnv_string
	return Date (as_datetime)
end if

// Datetime string passed in
if ll_count = 2 or ll_count = 3 then
	destroy lnv_string
	return Date (ls_datetime[1])
end if

return ld_rc


end function

private function time of_conversiontime (string as_datetime);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_Time
//
//	Access:  public
//
//	Arguments:
//	as_datetime   Datetime value as a string
//
//	Returns:  time
//	If as_datetime does not contain a valid datetime value, return time
//	is 00:00:00.000000.  If as_datetime is NULL, function returns NULL.
//
//	Description:
//	Converts a string whose value is a valid datetime to a time value
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0.02   Initial version
// 5.0.04 	Enhanced to handle more cases.
//
//////////////////////////////////////////////////////////////////////////////
//
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2005, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the GNU Lesser General
 * Public License Version 2.1, February 1999
 *
 * http://www.gnu.org/copyleft/lesser.html
 *
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals and was originally based on software copyright (c) 
 * 1996-2004 Sybase, Inc. http://www.sybase.com.  For more
 * information on the Open Source PowerBuilder Foundation Class
 * Libraries see http://pfc.codexchange.sybase.com
*/
//
//////////////////////////////////////////////////////////////////////////////

time	ltm_rc = 00:00:00.000000
long	ll_count
string	ls_datetime[]
n_cst_stringservice	lnv_string

// Check arguments
if IsNull (as_datetime) then
	SetNull (ltm_rc)
	return ltm_rc
end if

lnv_string	= create n_cst_stringservice

// Validate datetime string
ll_count = lnv_string.of_ParseToArray (as_datetime, " ", ls_datetime)
if ll_count <= 0 or ll_count > 3 then
	destroy lnv_string
	return ltm_rc
end if

// Date string passed in ("8:00pm")
if ll_count = 1 then
	destroy lnv_string
	return Time (as_datetime)
end if

// Datetime string passed in ("1/1/95 8:00pm")
if ll_count = 2 then
	destroy lnv_string
	return Time (ls_datetime[2])
end if

// Datetime string passed in ("1/1/95 8:00 pm")
if ll_count = 3 then
	destroy lnv_string
	return Time (ls_datetime[2]+' '+ls_datetime[3])
end if

destroy lnv_string

return ltm_rc
end function

public function string of_geterrormessage ();return is_errmsg
end function

public function integer of_update (boolean ab_accepttext, boolean ab_resetflag, ref string as_error);integer		li_chk

li_chk		= this.update( ab_accepttext, ab_resetflag )

if li_chk <> 1 then
	as_error		= is_errmsg
	
	return li_chk
end if

return 1
end function

public function integer of_update (ref string as_error);return this.of_update( true, true, as_error )
end function

event dberror;is_errmsg	= "A database error has occurred.~r~n~r~n" + &
	"DW Row:  "+string( row ) + "~r~n~r~n" + &
	"Database error code:  " + String (sqldbcode) + "~r~n~r~n" + &
	"Database error message:~r~n" + sqlerrtext

return 0
end event

on n_ds.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_ds.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

