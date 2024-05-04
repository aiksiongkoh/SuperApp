"
AssemblyFrame is contained by InertialFrame.
AssemblyFrame contains PartFrame(s).
Its motion is prescribed as functions of time.
rOaO(rOaO1(t), rOaO2(t), rOaO3(t))
aAOa(the1x(t), the2y(t), the3z(t)) using Bryant angles
"
Class {
	#name : #SymAssemblyFrame,
	#superclass : #SymCartesianFrame,
	#instVars : [
		'theOa'
	],
	#category : #'StCAD-Basic'
}

{ #category : #accessing }
SymAssemblyFrame >> aAOa [

	^ aAOf
]

{ #category : #adding }
SymAssemblyFrame >> addPartF: aStPartFrame [ 
	subs add: aStPartFrame.
	aStPartFrame sup: self
]

{ #category : #calc }
SymAssemblyFrame >> calcAll [

	rOfO := self calcrOaO.
	aAOf := self calcaAOa.
	subs do: [ :sub | sub calcAll ]
]

{ #category : #calc }
SymAssemblyFrame >> calcaAOa [

	^ aAFf
]

{ #category : #calc }
SymAssemblyFrame >> calcrOaO [

	^ rFfF
]

{ #category : #initialization }
SymAssemblyFrame >> initialize [

	| rOaO1 rOaO2 rOaO3 rOaO theOa1x theOa2y theOa3z aAOa |
	super initialize.
	rOaO1 := StMVariableParameter name: #rOaO1.
	rOaO2 := StMVariableParameter name: #rOaO2.
	rOaO3 := StMVariableParameter name: #rOaO3.
	rOaO := StMFullColumn with: rOaO1 with: rOaO2 with: rOaO3.
	rFfF := rOaO simplified.
	theOa1x := StMVariableParameter name: #theOa1x.
	theOa2y := StMVariableParameter name: #theOa2y.
	theOa3z := StMVariableParameter name: #theOa3z.
	theOa := SymEulerAngles with: theOa1x with: theOa2y with: theOa3z.
	aAOa := theOa
		        calc;
		        aA.
	aAFf := aAOa simplified
]

{ #category : #accessing }
SymAssemblyFrame >> rOaO [

	^ rOfO
]

{ #category : #accessing }
SymAssemblyFrame >> sup: aStInertialFrame [

	| t |
	sup := aStInertialFrame.
	t := self time.
	rFfF do: [ :r | r x: t ].
	theOa do: [ :the | the x: t ]
]
