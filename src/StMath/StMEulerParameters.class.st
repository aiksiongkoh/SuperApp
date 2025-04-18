Class {
	#name : 'StMEulerParameters',
	#superclass : 'StMEulerArray',
	#type : 'variable',
	#instVars : [
		'aA',
		'aB',
		'aC'
	],
	#category : 'StMath-StMathArray',
	#package : 'StMath',
	#tag : 'StMathArray'
}

{ #category : 'instance creation' }
StMEulerParameters class >> new [

	^ (super new: 4) initialize
]

{ #category : 'instance creation' }
StMEulerParameters class >> symbolic: aE1 with: aE2 with: aE3 with: aE4 [ 
	^(self new)
		at: 1 put: aE1;
		at: 2 put: aE2;
		at: 3 put: aE3;
		at: 4 put: aE4;
		calcSymbolic;
		yourself
]

{ #category : 'VisualWorks metadata' }
StMEulerParameters class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'instance creation' }
StMEulerParameters class >> with: aE1 with: aE2 with: aE3 with: aE4 [

	^ self new
		  at: 1 put: aE1 asFloat;
		  at: 2 put: aE2 asFloat;
		  at: 3 put: aE3 asFloat;
		  at: 4 put: aE4 asFloat;
		  conditionSelf;
		  calc;
		  yourself
]

{ #category : 'initialize-release' }
StMEulerParameters class >> withAxis: axis theta: theta [

	^ self new withAxis: axis theta: theta
]

{ #category : 'accessing' }
StMEulerParameters >> aA [
	^aA
]

{ #category : 'accessing' }
StMEulerParameters >> aB [
	^aB
]

{ #category : 'accessing' }
StMEulerParameters >> aC [
	^aC
]

{ #category : 'calc' }
StMEulerParameters >> calc [
	self calcABC
]

{ #category : 'calc' }
StMEulerParameters >> calc1 [
	self calcBC.
	aA := aB timesTransposeFullMatrix: aC
]

{ #category : 'calc' }
StMEulerParameters >> calcABC [
	"aA, aB and aC are all calculated together and only here."

	| aE1 aE2 aE3 aE4 mE1 mE2 mE3 |
	aE1 := self at: 1.
	aE2 := self at: 2.
	aE3 := self at: 3.
	aE4 := self at: 4.
	mE1 := aE1 negated.
	mE2 := aE2 negated.
	mE3 := aE3 negated.
	(aB at: 1) at: 1 put: aE4; at: 2 put: mE3; at: 3 put: aE2; at: 4 put: mE1.
	(aB at: 2) at: 1 put: aE3; at: 2 put: aE4; at: 3 put: mE1; at: 4 put: mE2.
	(aB at: 3) at: 1 put: mE2; at: 2 put: aE1; at: 3 put: aE4; at: 4 put: mE3.
	(aC at: 1) at: 1 put: aE4; at: 2 put: aE3; at: 3 put: mE2; at: 4 put: mE1.
	(aC at: 2) at: 1 put: mE3; at: 2 put: aE4; at: 3 put: aE1; at: 4 put: mE2.
	(aC at: 3) at: 1 put: aE2; at: 2 put: mE1; at: 3 put: aE4; at: 4 put: mE3.
	aA := aB timesTransposeFullMatrix: aC
]

{ #category : 'calc' }
StMEulerParameters >> calcBC [
	"aB and aC are all calculated together and only here."

	| aE1 aE2 aE3 aE4 mE1 mE2 mE3 |
	aE1 := self at: 1.
	aE2 := self at: 2.
	aE3 := self at: 3.
	aE4 := self at: 4.
	mE1 := aE1 negated.
	mE2 := aE2 negated.
	mE3 := aE3 negated.
	(aB at: 1) at: 1 put: aE4; at: 2 put: mE3; at: 3 put: aE2; at: 4 put: mE1.
	(aB at: 2) at: 1 put: aE3; at: 2 put: aE4; at: 3 put: mE1; at: 4 put: mE2.
	(aB at: 3) at: 1 put: mE2; at: 2 put: aE1; at: 3 put: aE4; at: 4 put: mE3.
	(aC at: 1) at: 1 put: aE4; at: 2 put: aE3; at: 3 put: mE2; at: 4 put: mE1.
	(aC at: 2) at: 1 put: mE3; at: 2 put: aE4; at: 3 put: aE1; at: 4 put: mE2.
	(aC at: 3) at: 1 put: aE2; at: 2 put: mE1; at: 3 put: aE4; at: 4 put: mE3.
]

{ #category : 'calc' }
StMEulerParameters >> calcSymbolic [
	self calc
]

{ #category : 'calc' }
StMEulerParameters >> calcSymbolic1 [
	self calcBC.
	aA := aB timesFullMatrix: aC transpose
]

{ #category : 'ops on self' }
StMEulerParameters >> conditionSelf [

	super conditionSelf.
	self normalizeSelf
]

{ #category : 'basic ops' }
StMEulerParameters >> differentiateWRT: var [

	| answer |
	answer := SymEulerParametersDot with: self.
	1 to: 4 do: [ :i |
		| angle angleVel |
		angle := self at: i.
		angleVel := angle differentiateWRT: var.
		answer at: i put: angleVel ].
	^ answer
]

{ #category : 'as yet unclassified' }
StMEulerParameters >> extendTo: qEO2 factor: factor [

	| qEO1 cosHalfTheta12 qEOmid halfTheta12 sinHalfTheta12 ratio1 ratio2 |
	[ factor >= 0.0 and: [ factor <= 1.0 ] ] assert.
	qEO1 := self.
	cosHalfTheta12 := qEO1 dot: qEO2.
	cosHalfTheta12 abs >= 1.0
		ifTrue: [ qEOmid := qEO1 copy ]
		ifFalse: [
			halfTheta12 := cosHalfTheta12 arcCos.
			sinHalfTheta12 := halfTheta12 sin.
			ratio1 := (1.0 - factor * halfTheta12) sin / sinHalfTheta12.
			ratio2 := (factor * halfTheta12) sin / sinHalfTheta12.
			qEOmid := qEO1 times: ratio1 plusFullColumn: qEO2 times: ratio2 ].
	^ qEOmid conditionSelf
]

{ #category : 'initialize-release' }
StMEulerParameters >> initialize [

	aA := StMFullMatrix new: 3 by: 3.
	aB := StMFullMatrix new: 3 by: 4.
	aC := StMFullMatrix new: 3 by: 4
]

{ #category : 'patching' }
StMEulerParameters >> pApE [

	| pApE pApEi |
	pApE := StMFullColumn new: 4.
	1 to: 4 do: [ :i |
		pApEi := aA differentiateWRT: (self at: i).
		pApE at: i put: pApEi ].
	^ pApE
]

{ #category : 'patching' }
StMEulerParameters >> ppApEpE [

	| ppApEpE pApEi ppApEipEj |
	ppApEpE := StMFullMatrix new: 4 by: 4.
	1 to: 4 do: [ :i |
		pApEi := aA differentiateWRT: (self at: i).
		1 to: 4 do: [ :j |
			ppApEipEj := pApEi differentiateWRT: (self at: j).
			ppApEpE at: i and: j put: ppApEipEj ] ].
	^ ppApEpE
]

{ #category : 'initialize-release' }
StMEulerParameters >> withAxis: axis theta: theta [

	| halfTheta sinHalfTheta cosHalfTheta |
	halfTheta := theta / 2.0.
	sinHalfTheta := halfTheta sin.
	cosHalfTheta := halfTheta cos.
	self at: 1 putFullVector: axis copy normalizeSelf * sinHalfTheta.
	self at: 4 put: cosHalfTheta.
	self conditionSelf.
	self calc
]
