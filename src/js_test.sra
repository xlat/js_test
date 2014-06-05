HA$PBExportHeader$js_test.sra
$PBExportComments$Generated Application Object
forward
global type js_test from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables

end variables

global type js_test from application
string appname = "js_test"
end type
global js_test js_test

on js_test.create
appname="js_test"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on js_test.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;js = CREATE js
open(w_test)


end event

event close;DESTROY js
end event

