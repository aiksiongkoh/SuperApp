Class {
	#name : 'SymEndFramec',
	#superclass : 'SymEndFrame',
	#instVars : [
		'theme'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'initialization' }
SymEndFramec >> initialize [

	| rmem1 rmem2 rmem3 rmem theme1x theme2y theme3z aAme |
	super initialize.
	rmem1 := StMConstantParameter name: #rmem1.
	rmem2 := StMConstantParameter name: #rmem2.
	rmem3 := StMConstantParameter name: #rmem3.
	rmem := StMFullColumn with: rmem1 with: rmem2 with: rmem3.
	rFfF := rmem simplified.
	theme1x := StMConstantParameter name: #theme1x.
	theme2y := StMConstantParameter name: #theme2y.
	theme3z := StMConstantParameter name: #theme3z.
	theme := SymEulerAngles with: theme1x with: theme2y with: theme3z.
	aAme := theme
		        calc;
		        aA.
	aAFf := aAme simplified
]

{ #category : 'accessing' }
SymEndFramec >> sup: aStMarkerFrame [

	sup := aStMarkerFrame
]
