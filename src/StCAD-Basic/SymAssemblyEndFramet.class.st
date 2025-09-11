Class {
	#name : 'SymAssemblyEndFramet',
	#superclass : 'SymAssemblyEndFrame',
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'accessing' }
SymAssemblyEndFramet >> initVariables [

	| t block selffullName |
	t := self time.
	rFfF do: [ :r | r x: t ].
	theFf do: [ :the | the x: t ].
	selffullName := self fullName.
	block := [ :var |
		         | fullName |
		         fullName := String new writeStream
			                     nextPutAll: selffullName;
			                     nextPut: $/;
			                     nextPutAll: var name;
			                     contents.
		         var name: fullName asSymbol ].
	rFfF do: block.
	theFf do: block
]

{ #category : 'initialization' }
SymAssemblyEndFramet >> initialize [

	| rmemt1 rmemt2 rmemt3 rmem themet1x themet2y themet3z theme aAme |
	super initialize.
	rmemt1 := StMVariableParameter name: #rmemt1.
	rmemt2 := StMVariableParameter name: #rmemt2.
	rmemt3 := StMVariableParameter name: #rmemt3.
	rmem := SymFullColumn with: rmemt1 with: rmemt2 with: rmemt3.
	rFfF := rmem.
	themet1x := StMVariableParameter name: #themet1x.
	themet2y := StMVariableParameter name: #themet2y.
	themet3z := StMVariableParameter name: #themet3z.
	theme := SymEulerAngles with: themet1x with: themet2y with: themet3z.
	theFf := theme.
	aAme := theme aA.
	aAFf := aAme
]

{ #category : 'accessing' }
SymAssemblyEndFramet >> rOeO [

	^ rOfO
]

{ #category : 'accessing' }
SymAssemblyEndFramet >> theta3z: sym [

	(theFf at: 3) rhs: sym
]
