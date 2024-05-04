Class {
	#name : #SymEndFramet,
	#superclass : #SymEndFrame,
	#instVars : [
		'themet'
	],
	#category : #'StCAD-Basic'
}

{ #category : #initialization }
SymEndFramet >> initialize [

	| rmemt1 rmemt2 rmemt3 rmemt themet1x themet2y themet3z aAme |
	super initialize.
	rmemt1 := StMVariableParameter name: #rmemt1.
	rmemt2 := StMVariableParameter name: #rmemt2.
	rmemt3 := StMVariableParameter name: #rmemt3.
	rmemt := StMFullColumn with: rmemt1 with: rmemt2 with: rmemt3.
	rFfF := rmemt simplified.
	themet1x := StMVariableParameter name: #themet1x.
	themet2y := StMVariableParameter name: #themet2y.
	themet3z := StMVariableParameter name: #themet3z.
	themet := SymEulerAngles with: themet1x with: themet2y with: themet3z.
	aAme := themet
		        calc;
		        aA.
	aAFf := aAme simplified
]

{ #category : #accessing }
SymEndFramet >> sup: aStMarkerFrame [

	| t |
	sup := aStMarkerFrame.
	t := self time.
	rFfF do: [ :r | r x: t ].
	themet do: [ :the | the x: t ]
]
