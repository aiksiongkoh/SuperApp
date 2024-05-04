"
InertialFrame is the root that contains everything
"
Class {
	#name : #SymInertialFrame,
	#superclass : #SymCartesianFrame,
	#instVars : [
		'symUnits',
		'time'
	],
	#category : #'StCAD-Basic'
}

{ #category : #adding }
SymInertialFrame >> addAssemblyF: aStAssemblyFrame [ 
	subs add: aStAssemblyFrame.
	aStAssemblyFrame sup: self. 
]

{ #category : #calc }
SymInertialFrame >> calcAll [

	subs do: [ :sub | sub calcAll ]
]

{ #category : #initialization }
SymInertialFrame >> initialize [

	| rOOO aAOO |
	super initialize.
	time := StMIndependentVariable name: #t.
	rOOO := StMFullColumn with: 0.0 with: 0.0 with: 0.0.
	rFfF := rOOO asSymbolic.
	rOfO := rFfF.
	aAOO := StMFullMatrix identity: 3.
	aAFf := aAOO asSymbolic.
	aAOf := aAFf
]

{ #category : #accessing }
SymInertialFrame >> time [

	^ time
]
