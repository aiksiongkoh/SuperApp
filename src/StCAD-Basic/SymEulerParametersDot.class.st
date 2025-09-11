Class {
	#name : 'SymEulerParametersDot',
	#superclass : 'SymEulerArray',
	#type : 'variable',
	#instVars : [
		'qE',
		'aAdot',
		'aBdot',
		'aCdot'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'instance creation' }
SymEulerParametersDot class >> fromqEOp: qEOp andOmegaOpO: omeOpO [ 
	^self new fromqEOp: qEOp andOmegaOpO: omeOpO
]

{ #category : 'instance creation' }
SymEulerParametersDot class >> fromqEOp: qEOp andOmegaOpp: omeOpp [ 
	^self new fromqEOp: qEOp andOmegaOpp: omeOpp
]

{ #category : 'instance creation' }
SymEulerParametersDot class >> new [
	^(super new: 4) initialize
]

{ #category : 'VisualWorks metadata' }
SymEulerParametersDot class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'instance creation' }
SymEulerParametersDot class >> with: aEulerParameters [ 
	| answer |
	answer := super new: 4.
	answer initialize: aEulerParameters.
	^answer
]

{ #category : 'accessing' }
SymEulerParametersDot >> aA [
	^qE aA
]

{ #category : 'accessing' }
SymEulerParametersDot >> aAdot [
	^aAdot
]

{ #category : 'accessing' }
SymEulerParametersDot >> aB [
	^qE aB
]

{ #category : 'accessing' }
SymEulerParametersDot >> aBdot [
	^aBdot
]

{ #category : 'accessing' }
SymEulerParametersDot >> aC [
	^qE aC
]

{ #category : 'accessing' }
SymEulerParametersDot >> aCdot [
	^aCdot
]

{ #category : 'calc' }
SymEulerParametersDot >> calc [
	qE calc.
	self calcAdotBdotCdot
]

{ #category : 'calc' }
SymEulerParametersDot >> calcAdotBdotCdot [
	"aAdot, aBdot and aCdot are all calculated together and only here."

	| aE1dot aE2dot aE3dot aE4dot mE1dot mE2dot mE3dot |
	aE1dot := self at: 1.
	aE2dot := self at: 2.
	aE3dot := self at: 3.
	aE4dot := self at: 4.
	mE1dot := 0.0 - aE1dot.
	mE2dot := 0.0 - aE2dot.
	mE3dot := 0.0 - aE3dot.
	(aBdot at: 1)
		at: 1 put: aE4dot;
		at: 2 put: mE3dot;
		at: 3 put: aE2dot;
		at: 4 put: mE1dot.
	(aBdot at: 2)
		at: 1 put: aE3dot;
		at: 2 put: aE4dot;
		at: 3 put: mE1dot;
		at: 4 put: mE2dot.
	(aBdot at: 3)
		at: 1 put: mE2dot;
		at: 2 put: aE1dot;
		at: 3 put: aE4dot;
		at: 4 put: mE3dot.
	(aCdot at: 1)
		at: 1 put: aE4dot;
		at: 2 put: aE3dot;
		at: 3 put: mE2dot;
		at: 4 put: mE1dot.
	(aCdot at: 2)
		at: 1 put: mE3dot;
		at: 2 put: aE4dot;
		at: 3 put: aE1dot;
		at: 4 put: mE2dot.
	(aCdot at: 3)
		at: 1 put: aE2dot;
		at: 2 put: mE1dot;
		at: 3 put: aE4dot;
		at: 4 put: mE3dot.
	aAdot := (self aB timesTransposeFullMatrix: aCdot) times: 2.0
]

{ #category : 'calc' }
SymEulerParametersDot >> calcSymbolic [
	qE calcSymbolic.
	self calcSymbolicAdotBdotCdot
]

{ #category : 'calc' }
SymEulerParametersDot >> calcSymbolicAdotBdotCdot [
	"aAdot, aBdot and aCdot are all calculated together and only here."

	| aE1dot aE2dot aE3dot aE4dot mE1dot mE2dot mE3dot |
	aE1dot := self at: 1.
	aE2dot := self at: 2.
	aE3dot := self at: 3.
	aE4dot := self at: 4.
	mE1dot := aE1dot negated.
	mE2dot := aE2dot negated.
	mE3dot := aE3dot negated.
	(aBdot at: 1)
		at: 1 put: aE4dot;
		at: 2 put: mE3dot;
		at: 3 put: aE2dot;
		at: 4 put: mE1dot.
	(aBdot at: 2)
		at: 1 put: aE3dot;
		at: 2 put: aE4dot;
		at: 3 put: mE1dot;
		at: 4 put: mE2dot.
	(aBdot at: 3)
		at: 1 put: mE2dot;
		at: 2 put: aE1dot;
		at: 3 put: aE4dot;
		at: 4 put: mE3dot.
	(aCdot at: 1)
		at: 1 put: aE4dot;
		at: 2 put: aE3dot;
		at: 3 put: mE2dot;
		at: 4 put: mE1dot.
	(aCdot at: 2)
		at: 1 put: mE3dot;
		at: 2 put: aE4dot;
		at: 3 put: aE1dot;
		at: 4 put: mE2dot.
	(aCdot at: 3)
		at: 1 put: aE2dot;
		at: 2 put: mE1dot;
		at: 3 put: aE4dot;
		at: 4 put: mE3dot.
	aAdot := (self aB timesFullMatrix: aCdot transpose) times: 2.0
]

{ #category : 'accessing' }
SymEulerParametersDot >> dAdt [
	^aAdot
]

{ #category : 'calc' }
SymEulerParametersDot >> differentiateWRT: var [

	^ var isSequenceable
		  ifTrue: [ self halt ]
		  ifFalse: [
				  | answer |
				  answer := SymEulerParametersDDot with: self.
				  1 to: 4 do: [ :i |
						  | angleVel angleAcc |
						  angleVel := self at: i.
						  angleAcc := angleVel differentiateWRT: var.
						  answer at: i put: angleAcc ].
				  answer ]
]

{ #category : 'initialize-release' }
SymEulerParametersDot >> fromqEOp: qEOp andOmegaOpO: omeOpO [ 
	| aB |
	qEOp calcABC.
	aB := qEOp aB.
	self equalFullColumn: (aB transposeTimesFullColumn: (omeOpO times: 0.5)).
	self qE: qEOp.
	self calc
]

{ #category : 'initialize-release' }
SymEulerParametersDot >> fromqEOp: qEOp andOmegaOpp: omeOpp [ 
	| aC |
	qEOp calcABC.
	aC := qEOp aC.
	self equalFullColumn: (aC transposeTimesFullColumn: (omeOpp times: 0.5)).
	self qE: qEOp.
	self calc
]

{ #category : 'initialize-release' }
SymEulerParametersDot >> initialize [
	aAdot := StMFullMatrix new: 3 by: 3.
	aBdot := StMFullMatrix new: 3 by: 4.
	aCdot := StMFullMatrix new: 3 by: 4.
]

{ #category : 'initialize-release' }
SymEulerParametersDot >> initialize: aEulerParameters [ 
	self initialize.
	qE := aEulerParameters
]

{ #category : 'accessing' }
SymEulerParametersDot >> omeFfF [

	^ (self aB timesFullColumn: self) times: 2.0
]

{ #category : 'accessing' }
SymEulerParametersDot >> omeFff [

	^ (self aC timesFullColumn: self) times: 2.0
]

{ #category : 'accessing' }
SymEulerParametersDot >> omeOpO [

	^ self omeFfF
]

{ #category : 'accessing' }
SymEulerParametersDot >> qE: eulerParameters [ 
	qE := eulerParameters
]

{ #category : 'basic ops' }
SymEulerParametersDot >> simplified [
	| answer |
	answer := super simplified.
	answer initialize: qE.
	^answer
]

{ #category : 'ops on self' }
SymEulerParametersDot >> zeroSelf [
	super zeroSelf.
	self calc
]
