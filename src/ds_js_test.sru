HA$PBExportHeader$ds_js_test.sru
forward
global type ds_js_test from datastore
end type
end forward

global type ds_js_test from datastore
string dataobject = "d_js_test"
end type
global ds_js_test ds_js_test

on ds_js_test.create
call super::create
TriggerEvent( this, "constructor" )
end on

on ds_js_test.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

