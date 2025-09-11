Class {
	#name : 'SymAssemblyMarkerFrame',
	#superclass : 'SymIndependentFrame',
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'accessing' }
SymAssemblyMarkerFrame >> initVariables [

	| block selffullName |
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
SymAssemblyMarkerFrame >> initialize [

	| rama1 rama2 rama3 rama theam1x theam2y theam3z theam |
	super initialize.
	rama1 := StMConstantParameter name: #rama1.
	rama2 := StMConstantParameter name: #rama2.
	rama3 := StMConstantParameter name: #rama3.
	rama := SymFullColumn with: rama1 with: rama2 with: rama3.
	rFfF := rama.
	theam1x := StMConstantParameter name: #theam1x.
	theam2y := StMConstantParameter name: #theam2y.
	theam3z := StMConstantParameter name: #theam3z.
	theam := SymEulerAngles with: theam1x with: theam2y with: theam3z.
	theFf := theam.
	aAFf := theam aA
]

{ #category : 'initialization' }
SymAssemblyMarkerFrame >> initializeGlobally [

	subs do: [ :eFrm | eFrm initializeGlobally ]
]

{ #category : 'input-output' }
SymAssemblyMarkerFrame >> postInput [

	super postInput.
	subs do: [ :endFrm | endFrm postInput ]
]

{ #category : 'accIC' }
SymAssemblyMarkerFrame >> preAccIC [

	super preAccIC.
	subs do: [ :endFrm | endFrm preAccIC ]
]

{ #category : 'posIC' }
SymAssemblyMarkerFrame >> prePosIC [

	super prePosIC.
	subs do: [ :endFrm | endFrm prePosIC ]
]
