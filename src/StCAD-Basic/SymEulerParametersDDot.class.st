Class {
	#name : #SymEulerParametersDDot,
	#superclass : #SymEulerArray,
	#type : #variable,
	#instVars : [
		'qEdot',
		'aAddot',
		'aBddot',
		'aCddot'
	],
	#category : #'StCAD-Basic'
}

{ #category : #'instance creation' }
SymEulerParametersDDot class >> fromqEdot: qEdot qEddot: qEddot [ 
	^self new fromqEdot: qEdot qEddot: qEddot
]

{ #category : #'instance creation' }
SymEulerParametersDDot class >> new [
	^(super new: 4) initialize
]

{ #category : #'VisualWorks metadata' }
SymEulerParametersDDot class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #'instance creation' }
SymEulerParametersDDot class >> with: aEulerParametersDot [ 
	| answer |
	answer := super new: 4.
	answer initialize: aEulerParametersDot.
	^answer
]

{ #category : #accessing }
SymEulerParametersDDot >> aA [
	^qEdot aA
]

{ #category : #accessing }
SymEulerParametersDDot >> aAddot [
	^aAddot
]

{ #category : #accessing }
SymEulerParametersDDot >> aAdot [
	^qEdot aAdot
]

{ #category : #accessing }
SymEulerParametersDDot >> aB [
	^qEdot aB
]

{ #category : #accessing }
SymEulerParametersDDot >> aBddot [
	^aBddot
]

{ #category : #accessing }
SymEulerParametersDDot >> aBdot [
	^qEdot aBdot
]

{ #category : #accessing }
SymEulerParametersDDot >> aC [
	^qEdot aC
]

{ #category : #accessing }
SymEulerParametersDDot >> aCddot [
	^aCddot
]

{ #category : #accessing }
SymEulerParametersDDot >> aCdot [
	^qEdot aCdot
]

{ #category : #accessing }
SymEulerParametersDDot >> alpF [
	^(self aBdot timesFullColumn: qEdot) + (self aB timesFullColumn: self) 
		times: 2.0
]

{ #category : #accessing }
SymEulerParametersDDot >> alpOpO [
	^(self aBdot timesFullColumn: qEdot) + (self aB timesFullColumn: self) 
		times: 2.0
]

{ #category : #calc }
SymEulerParametersDDot >> calc [
	qEdot calc.
	self calcAddotBddotCddot
]

{ #category : #calc }
SymEulerParametersDDot >> calcAddotBddotCddot [
	"aAddot, aBddot and aCddot are all calculated together and only here.

	aA := aB*aCT.
	aAdot := aBdot*aCT + aB*aCTdot
	Since  aBdot*aCT = aB*aCTdot (prove by direct evaluation).
	Therefore, aAdot := 2*aBdot*aCT := 2*aB*aCTdot.
	aAddot := 2*aBdot*aCTdot + 2*aB*aCTddot.
	"

	| aE1ddot aE2ddot aE3ddot aE4ddot mE1ddot mE2ddot mE3ddot |
	aE1ddot := self at: 1.
	aE2ddot := self at: 2.
	aE3ddot := self at: 3.
	aE4ddot := self at: 4.
	mE1ddot := 0.0 - aE1ddot.
	mE2ddot := 0.0 - aE2ddot.
	mE3ddot := 0.0 - aE3ddot.
	(aBddot at: 1)
		at: 1 put: aE4ddot;
		at: 2 put: mE3ddot;
		at: 3 put: aE2ddot;
		at: 4 put: mE1ddot.
	(aBddot at: 2)
		at: 1 put: aE3ddot;
		at: 2 put: aE4ddot;
		at: 3 put: mE1ddot;
		at: 4 put: mE2ddot.
	(aBddot at: 3)
		at: 1 put: mE2ddot;
		at: 2 put: aE1ddot;
		at: 3 put: aE4ddot;
		at: 4 put: mE3ddot.
	(aCddot at: 1)
		at: 1 put: aE4ddot;
		at: 2 put: aE3ddot;
		at: 3 put: mE2ddot;
		at: 4 put: mE1ddot.
	(aCddot at: 2)
		at: 1 put: mE3ddot;
		at: 2 put: aE4ddot;
		at: 3 put: aE1ddot;
		at: 4 put: mE2ddot.
	(aCddot at: 3)
		at: 1 put: aE2ddot;
		at: 2 put: mE1ddot;
		at: 3 put: aE4ddot;
		at: 4 put: mE3ddot.
	aAddot := (self aBdot timesTransposeFullMatrix: self aCdot) 
				+ (self aB timesTransposeFullMatrix: aCddot) times: 2.0
]

{ #category : #calc }
SymEulerParametersDDot >> calcSymbolic [
	qEdot calcSymbolic.
	self calcSymbolicAddotBddotCddot
]

{ #category : #calc }
SymEulerParametersDDot >> calcSymbolicAddotBddotCddot [
	"aAddot, aBddot and aCddot are all calculated together and only here.

	aA := aB*aCT.
	aAdot := aBdot*aCT + aB*aCTdot
	Since  aBdot*aCT = aB*aCTdot (prove by direct evaluation).
	Therefore, aAdot := 2*aBdot*aCT := 2*aB*aCTdot.
	aAddot := 2*aBdot*aCTdot + 2*aB*aCTddot.
	"

	| aE1ddot aE2ddot aE3ddot aE4ddot mE1ddot mE2ddot mE3ddot |
	aE1ddot := self at: 1.
	aE2ddot := self at: 2.
	aE3ddot := self at: 3.
	aE4ddot := self at: 4.
	mE1ddot := aE1ddot negated.
	mE2ddot := aE2ddot negated.
	mE3ddot := aE3ddot negated.
	(aBddot at: 1)
		at: 1 put: aE4ddot;
		at: 2 put: mE3ddot;
		at: 3 put: aE2ddot;
		at: 4 put: mE1ddot.
	(aBddot at: 2)
		at: 1 put: aE3ddot;
		at: 2 put: aE4ddot;
		at: 3 put: mE1ddot;
		at: 4 put: mE2ddot.
	(aBddot at: 3)
		at: 1 put: mE2ddot;
		at: 2 put: aE1ddot;
		at: 3 put: aE4ddot;
		at: 4 put: mE3ddot.
	(aCddot at: 1)
		at: 1 put: aE4ddot;
		at: 2 put: aE3ddot;
		at: 3 put: mE2ddot;
		at: 4 put: mE1ddot.
	(aCddot at: 2)
		at: 1 put: mE3ddot;
		at: 2 put: aE4ddot;
		at: 3 put: aE1ddot;
		at: 4 put: mE2ddot.
	(aCddot at: 3)
		at: 1 put: aE2ddot;
		at: 2 put: mE1ddot;
		at: 3 put: aE4ddot;
		at: 4 put: mE3ddot.
	aAddot := (self aBdot timesFullMatrix: self aCdot transpose) 
				+ (self aB timesFullMatrix: aCddot transpose) times: 2.0
]

{ #category : #accessing }
SymEulerParametersDDot >> fromqEdot: aqEdot qEddot: qEddot [ 
	qEdot := aqEdot.
	1 to: 4 do: [:i | self at: i put: (qEddot at: i)]
]

{ #category : #'initialize-release' }
SymEulerParametersDDot >> initialize [
	aAddot := StMFullMatrix new: 3 by: 3.
	aBddot := StMFullMatrix new: 3 by: 4.
	aCddot := StMFullMatrix new: 3 by: 4
]

{ #category : #'initialize-release' }
SymEulerParametersDDot >> initialize: aEulerParametersDot [ 
	self initialize.
	qEdot := aEulerParametersDot
]

{ #category : #accessing }
SymEulerParametersDDot >> qEdot: aMbDEulerParametersDot [ 
	qEdot := aMbDEulerParametersDot
]

{ #category : #'basic ops' }
SymEulerParametersDDot >> simplified [
	| answer |
	answer := super simplified.
	answer initialize: qEdot.
	^answer
]

{ #category : #'ops on self' }
SymEulerParametersDDot >> zeroSelf [
	super zeroSelf.
	self calc
]
