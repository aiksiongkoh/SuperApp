Class {
	#name : 'SymAssemblyEndFramec',
	#superclass : 'SymAssemblyEndFrame',
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'initialization' }
SymAssemblyEndFramec >> initialize [

	| rmemc1 rmemc2 rmemc3 rmem themec1x themec2y themec3z theme aAme |
	super initialize.
	rmemc1 := StMConstantParameter name: #rmemc1.
	rmemc2 := StMConstantParameter name: #rmemc2.
	rmemc3 := StMConstantParameter name: #rmemc3.
	rmem := SymFullColumn with: rmemc1 with: rmemc2 with: rmemc3.
	rFfF := rmem.
	themec1x := StMConstantParameter name: #themec1x.
	themec2y := StMConstantParameter name: #themec2y.
	themec3z := StMConstantParameter name: #themec3z.
	theme := SymEulerAngles with: themec1x with: themec2y with: themec3z.
	theFf := theme.
	aAme := theme aA.
	aAFf := theme aA
]

{ #category : 'instance creation' }
SymAssemblyEndFramec >> newEndFramet [

	| endFrmt |
	endFrmt := SymAssemblyEndFramet new.
	endFrmt name: name , 't'.
	endFrmt sup: sup.
	^ endFrmt
]

{ #category : 'accessing' }
SymAssemblyEndFramec >> rOeO [

	^ rOfO
]

{ #category : 'accessing' }
SymAssemblyEndFramec >> rmem: col [

	self rFfF: col
]
