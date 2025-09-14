Class {
	#name : 'SymEulerParametersDotTest',
	#superclass : 'TestCase',
	#category : 'StCAD-Basic-Tests',
	#package : 'StCAD-Basic',
	#tag : 'Tests'
}

{ #category : 'as yet unclassified' }
SymEulerParametersDotTest >> testAdotAT [

	| time qE1 qE2 qE3 qE4 qE qEdot aAdotAT mAAdotT |
	time := StMIndependentVariable name: #t.
	qE1 := UnknownDependentVariable name: #qE1.
	qE2 := UnknownDependentVariable name: #qE2.
	qE3 := UnknownDependentVariable name: #qE3.
	qE4 := UnknownDependentVariable name: #qE4.
	qE := SymEulerParameters new
		      at: 1 put: qE1;
		      at: 2 put: qE2;
		      at: 3 put: qE3;
		      at: 4 put: qE4;
		      yourself.
	qE do: [ :qi | qi x: time ].
	qEdot := qE differentiateWRT: time.
	qEdot calcSymbolic.
	aAdotAT := (qEdot aAdot timesTransposeFullMatrix: qE aA) simplified.
	mAAdotT := (qE aA timesTransposeFullMatrix: qEdot aAdot) negated
		           simplified.
	self assert: aAdotAT equals: mAAdotT
]

{ #category : 'as yet unclassified' }
SymEulerParametersDotTest >> testBdotCT [

	| time qE1 qE2 qE3 qE4 qE qEdot aBdotCT mBCdotT |
	time := StMIndependentVariable name: #t.
	qE1 := UnknownDependentVariable name: #qE1.
	qE2 := UnknownDependentVariable name: #qE2.
	qE3 := UnknownDependentVariable name: #qE3.
	qE4 := UnknownDependentVariable name: #qE4.
	qE := SymEulerParameters new
		      at: 1 put: qE1;
		      at: 2 put: qE2;
		      at: 3 put: qE3;
		      at: 4 put: qE4;
		      yourself.
	qE do: [ :qi | qi x: time ].
	qEdot := qE differentiateWRT: time.
	qEdot calcSymbolic.
	aBdotCT := (qEdot aBdot timesTransposeFullMatrix: qE aC) simplified.
	mBCdotT := (qE aB timesTransposeFullMatrix: qEdot aCdot) simplified.
	self assert: aBdotCT equals: mBCdotT
]

{ #category : 'as yet unclassified' }
SymEulerParametersDotTest >> testBdotqEandCdotqE [

	| time qE1 qE2 qE3 qE4 qE qEdot aBdotqE mBqEdot aCdotqE mCqEdot |
	time := StMIndependentVariable name: #t.
	qE1 := UnknownDependentVariable name: #qE1.
	qE2 := UnknownDependentVariable name: #qE2.
	qE3 := UnknownDependentVariable name: #qE3.
	qE4 := UnknownDependentVariable name: #qE4.
	qE := SymEulerParameters new
		      at: 1 put: qE1;
		      at: 2 put: qE2;
		      at: 3 put: qE3;
		      at: 4 put: qE4;
		      yourself.
	qE do: [ :qi | qi x: time ].
	qEdot := qE differentiateWRT: time.
	qEdot calcSymbolic.
	aBdotqE := (qEdot aBdot timesFullColumn: qE) simplified.
	mBqEdot := (qE aB timesFullColumn: qEdot) negated simplified.
	self assert: aBdotqE equals: mBqEdot.
	aCdotqE := (qEdot aCdot timesFullColumn: qE) simplified.
	mCqEdot := (qE aC timesFullColumn: qEdot) negated simplified.
	self assert: aCdotqE equals: mCqEdot
]
