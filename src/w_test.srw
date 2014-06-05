HA$PBExportHeader$w_test.srw
forward
global type w_test from window
end type
type cb_js2pb from commandbutton within w_test
end type
type cb_5 from commandbutton within w_test
end type
type cb_4 from commandbutton within w_test
end type
type cb_3 from commandbutton within w_test
end type
type cb_2 from commandbutton within w_test
end type
type cb_1 from commandbutton within w_test
end type
type dw_1 from datawindow within w_test
end type
end forward

global type w_test from window
integer width = 2555
integer height = 1636
boolean titlebar = true
string title = "js_test"
boolean controlmenu = true
boolean minbox = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_js2pb cb_js2pb
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_test w_test

type variables
public:
	string is_test
end variables

on w_test.create
this.cb_js2pb=create cb_js2pb
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_js2pb,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_test.destroy
destroy(this.cb_js2pb)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;long &
	ll
	
ll = dw_1.insertrow(0)
dw_1.setitem( ll, "col1", "test")
dw_1.setitem( ll, "col2", 10 )
dw_1.setitem( ll, "col3", 4.5 )
dw_1.setitem( ll, "col4", 2012-03-01 )
dw_1.setitem( ll, "col5", 6)

dw_1.modify("DataWindow.Export.XML.IncludeWhitespace=yes")




end event

type cb_js2pb from commandbutton within w_test
integer x = 425
integer y = 1424
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "JS->PB"
end type

event clicked;//demonstrate how to eval a JScript that can call a powerbuilder object method.
if js.of_addobject("nv_cst_math", "cstmath") then
	Messagebox( this.text, js.eval("cstmath.of_sum( 40, 2)") )
	//you can access the object as :
//	js.eval("tmpds").dataobject = "d_js_test"
	//or from eval
/*	string ls_xml
	ls_xml = &
	js.eval("{ 															&
	   tmpds.dataobject = 'd_js_test';							&
		var row = tmpds.Insertrow(0); 							&
		tmpds.SetItem(row, 'col1', 'Filled from JS');		&
		tmpds.SetItem(row, 'col2', 1);							&
		tmpds.SetItem(row, 'col3', 3.1415);						&
		tmpds.SetItem(row, 'col1', '2012-01-01 12:42:00');	&
		tmpds.SetItem(row, 'col5', 123456789);					&
		tmpds.Describe('datawindow.data.xml');					&
			}")
	messagebox(this.Text, ls_xml)
*/
else
	messagebox(this.Text, "Failed to create a datastore as OLEOBJECT", exclamation!)
end if

end event

type cb_5 from commandbutton within w_test
integer x = 425
integer y = 1292
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "sprintf"
end type

event clicked;string &
	ls

ls = js.istring.fmt("[%s]",  now() )

messagebox( "sprintf", "format: [%s], now() ~r~n" + ls )
 
end event

type cb_4 from commandbutton within w_test
integer x = 846
integer y = 1292
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "replace"
end type

event clicked;string &
	ls

ls = js.of_replace( "teste", "/e/g", "a" )

messagebox( "replace", "replace: 'teste', '/e/g' ~r~n" + ls )

end event

type cb_3 from commandbutton within w_test
integer x = 1262
integer y = 1292
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "body_to_xml"
end type

event clicked;
messagebox("", string(dw_1.object.DataWindow.data.xml))
end event

type cb_2 from commandbutton within w_test
integer x = 1678
integer y = 1288
integer width = 421
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "descr_to_json"
end type

event clicked;nc_tojquery lnc; lnc = CREATE nc_tojquery

messagebox("to_json", lnc.of_gridtojquery( dw_1 ) ) 

DESTROY lnc 
end event

type cb_1 from commandbutton within w_test
integer x = 2103
integer y = 1288
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "close"
boolean cancel = true
end type

event clicked;close(parent)

end event

type dw_1 from datawindow within w_test
integer width = 2542
integer height = 1256
integer taborder = 10
string title = "none"
string dataobject = "d_js_test"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

