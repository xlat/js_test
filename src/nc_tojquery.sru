HA$PBExportHeader$nc_tojquery.sru
forward
global type nc_tojquery from nonvisualobject
end type
end forward

global type nc_tojquery from nonvisualobject
end type
global nc_tojquery nc_tojquery

forward prototypes
public function any of_getdwcontrols (datawindow adw)
public function any of_getdwheaders (datawindow adw)
public function string of_gridtojquery (datawindow adw)
end prototypes

public function any of_getdwcontrols (datawindow adw);long &
	ll
string &
	ls_controls, &
	ls[]
oleobject &
	json

ls_controls = adw.Object.DataWindow.Objects
json = js.eval("'" + ls_controls + "'.split('\t')")

for ll = json.length to 1 step -1
	ls[ll] = string(json.pop())
next

return ls
end function

public function any of_getdwheaders (datawindow adw);long &
	ll_row, &
	ll, &
	ll_count, &
	ll_pos[]
string &
	ls_errore, &
	ls_control, &
	ls_controls[], &
	ls_headers[], &
	ls_sort[]

datastore lds; lds = create datastore
lds.settransobject( sqlca)
lds.create( ' &
	release 11.5; &
	datawindow() &
	table( &
	column=(type=char(100) name=nome dbname="nome") &
	column=(type=number    name=x    dbname="x"   )' &
+ ')' , ls_errore)

ll_count = 1
ls_controls = of_getdwcontrols(adw)

for ll = 1 to upperbound(ls_controls)
	ls_control = ls_controls[ll]
	if adw.describe(ls_control + ".type") = "text" then

		ll_row = lds.insertrow( 0 )
		lds.setitem(ll_row,"nome", ls_control)
		lds.setitem(ll_row, "x",  long(adw.describe(ls_control + ".x")))
		
		ll_count++
	end if

next
lds.SetSort("x ASC")
lds.Sort()

for ll = 1 to lds.rowcount()
	ls_headers[ll] = lds.getitemstring( ll, "nome")
next

destroy lds
return ls_headers

end function

public function string of_gridtojquery (datawindow adw);string &
	ls, &
	ls_campo, &
	ls_align, &
	ls_headers[]
long &
	ll, &
	ll2
oleobject &
	json, &
	jsonf

jsonf = js.of_parse("[]")

ls_headers = of_getdwheaders(adw)

for ll = 1 to long(adw.object.DataWindow.Column.Count)
	
	json  = js.of_parse("{}")

	ls_campo = adw.describe("#" + string(ll) + ".name" )

	// dbname, index
	json.set( "name",  ls_campo )
	json.set( "index", ls_campo )

	json.set( "label", adw.describe(ls_headers[ll] + ".text"))
	json.set( "width", UnitsToPixels( &
		long(adw.describe(ls_headers[ll] + ".width")), XUnitsToPixels!) &
	)

	// alignment
	choose case adw.describe( ls_campo + ".alignment")
		case "0"; ls_align = 'left'
		case "1"; ls_align = 'center'
		case "2"; ls_align = 'right'
		case "3"; ls_align = 'justified'
	end choose
	json.set( "align", ls_align )
	json.set( "hidden", (adw.describe(ls_campo + ".visible") = "0") )

	jsonf.push(json)
	json.disconnectobject( ); destroy json

next

ls = jsonf.stringify()

jsonf.disconnectobject( ); destroy jsonf
return  ls 


end function

on nc_tojquery.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nc_tojquery.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

