Class {
	#name : 'SymEndFramec',
	#superclass : 'SymEndFrame',
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'calc' }
SymEndFramec >> calcPostDynCorrectorIteration [

	
]

{ #category : 'calc' }
SymEndFramec >> calcomeOeO [

	^ sup omeOmO
]

{ #category : 'calc' }
SymEndFramec >> calcvOeO [

	^ sup vOmO + (sup pAOmpt timesFullColumn: self rmem)
]

{ #category : 'initialization' }
SymEndFramec >> initialize [

	| rmemc1 rmemc2 rmemc3 themec1x themec2y themec3z |
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
	aAme := theme aA.
	aAFf := aAme
]

{ #category : 'accessing' }
SymEndFramec >> omemem [

	^ SymFullColumn zero: 3
]

{ #category : 'accessing' }
SymEndFramec >> sup: aStMarkerFrame [

	sup := aStMarkerFrame
]
