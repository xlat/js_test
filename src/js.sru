HA$PBExportHeader$js.sru
forward
global type js from oleobject
end type
end forward

global type js from oleobject
end type
global js js

type variables
oleobject &
	ijson, &
	iprocess, &
	isprintf, &
	istring, &
	idate

//Lazy created.
oleobject ipbapp
end variables

forward prototypes
public function integer connecttonewobject (readonly string clsname)
public function integer connecttoobject (readonly string filename)
public function integer connecttoobject (readonly string filename, readonly string clsname)
public function integer connecttoremoteobject (readonly string hostname, readonly string filename)
public function integer connecttonewremoteobject (readonly string hostname, readonly string clsname)
public function integer connecttoremoteobject (readonly string hostname, readonly string filename, readonly string clsname)
public function integer disconnectobject ()
public function oleobject of_parse (string as_json)
public function string of_stringify (oleobject anc)
public function any of_getproperties (oleobject anc)
public function oleobject of_loadlibrary (string as_path)
public function oleobject of_match (string as_input, string as_pattern)
public function string of_replace (string as_input, string as_pattern, string as_new)
public function boolean of_addobject (string as_classname, string as_varname)
end prototypes

public function integer connecttonewobject (readonly string clsname);return -1

end function

public function integer connecttoobject (readonly string filename);return -1

end function

public function integer connecttoobject (readonly string filename, readonly string clsname);return -1

end function

public function integer connecttoremoteobject (readonly string hostname, readonly string filename);return -1

end function

public function integer connecttonewremoteobject (readonly string hostname, readonly string clsname);return -1

end function

public function integer connecttoremoteobject (readonly string hostname, readonly string filename, readonly string clsname);return -1

end function

public function integer disconnectobject ();return -1

end function

public function oleobject of_parse (string as_json);return ijson.parse(as_json)
end function

public function string of_stringify (oleobject anc);return this.ijson.stringify(anc)
end function

public function any of_getproperties (oleobject anc);string &
	ls_properties[]

ls_properties = anc.getproperties()

return ls_properties
end function

public function oleobject of_loadlibrary (string as_path);int &
	li_file
string &
	ls, &
	ls_libraryname

ls_libraryname = of_match( as_path, "/.*?(\w+)\.js$/i").pop()
li_file = FileOpen( as_path, TextMode!)
FileReadEx(li_file, ls)
FileClose(li_file)

this.addcode(ls)
return this.eval(ls_libraryname)


end function

public function oleobject of_match (string as_input, string as_pattern);return istring.match.call( as_input, this.eval( as_pattern ) )
end function

public function string of_replace (string as_input, string as_pattern, string as_new);return istring.replace.call( as_input, this.eval( as_pattern ), as_new )
end function

public function boolean of_addobject (string as_classname, string as_varname);//Append a non visual powerobject of class as_classname and make it available to the JScript engine
//uneder the name as_varname.
//Return true if it success, false if it failed.
if isnull(ipbapp) or not isvalid(ipbapp) then
	//Code inspirated from
	//http://www.techno-kitten.com/Changes_to_PowerBuilder/New_In_PowerBuilder_5/Inbound_OLE_automation/inbound_ole_automation.htm
	ipbapp = create oleobject
	string ls_oleclass = "Powerbuilder.Application"
	string ls_major, ls_minor
	Environment env
	GetEnvironment( env )
	ls_major = string(env.pbmajorrevision)
	ls_minor = string(env.pbminorrevision)
	ls_oleclass+="."+ls_major+"."+ls_minor
	if ipbapp.ConnectToNewObject(ls_oleclass) <> 0 then
		destroy ipbapp
		Messagebox("OLE Automation", "Failed to instantiate "+ls_oleclass, Exclamation!)
		return false
	end if
	ipbapp.LibraryList = GetLibraryList()
	ipbapp.MachineCode = FALSE	//for pCode objects
end if

oleobject lole_obj
lole_obj = ipbapp.CreateObject( as_classname )
if IsValid(lole_obj) and not isnull(lole_obj) then
	//TODO: wrap with the right TRY/CATCH exception handler
	this.AddObject( as_varname, lole_obj, true )
else
	return false
end if

return true
end function

event constructor;SUPER::connecttonewobject("ScriptControl")
this.language = "jscript"

istring = this.eval( "String.prototype" ) 
idate = this.eval("Date.prototype")
ijson = this.of_loadlibrary( "js\JSON.js" )  
iprocess = this.of_loadlibrary( "js\Process.js" )
isprintf = this.of_loadlibrary( "js\sprintf.js" )  
this.addcode( " &
	String.prototype.fmt = function(){ &
		return sprintf.apply(null, arguments); &
	} &
" )

end event

on js.create
call super::create
TriggerEvent( this, "constructor" )
end on

on js.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;SUPER::disconnectobject( )
ijson.disconnectobject( )
DESTROY ijson

if isvalid(ipbapp) and not isnull(ipbapp) then
	ipbapp.disconnectobject()
	destroy ipbapp
end if
end event

