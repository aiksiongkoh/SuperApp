Class {
	#name : #StInertialFrame,
	#superclass : #StCartesianFrame,
	#instVars : [
		'time'
	],
	#category : #'StCAD-Basic'
}

{ #category : #adding }
StInertialFrame >> addAssemblyF: aStAssemblyFrame [ 
	subs add: aStAssemblyFrame.
	aStAssemblyFrame sup: self. 
]

{ #category : #calc }
StInertialFrame >> calcAll [

	subs do: [ :sub | sub calcAll ]
]

{ #category : #initialization }
StInertialFrame >> initialize [

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
StInertialFrame >> time [

	^ time
]
