$PBExportHeader$depositservice.sra
$PBExportComments$Generated Application Object
forward
global type depositservice from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global type depositservice from application
string appname = "depositservice"
end type
global depositservice depositservice

on depositservice.create
appname = "depositservice"
message = create message
sqlca = create transaction
sqlda = create dynamicdescriptionarea
sqlsa = create dynamicstagingarea
error = create error
end on

on depositservice.destroy
destroy( sqlca )
destroy( sqlda )
destroy( sqlsa )
destroy( error )
destroy( message )
end on

