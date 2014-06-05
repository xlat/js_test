HA$PBExportHeader$nv_cst_math.sru
forward
global type nv_cst_math from nonvisualobject
end type
end forward

global type nv_cst_math from nonvisualobject
end type
global nv_cst_math nv_cst_math

forward prototypes
public function integer of_sum (integer a, integer b)
end prototypes

public function integer of_sum (integer a, integer b);return a + b
end function

on nv_cst_math.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nv_cst_math.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

