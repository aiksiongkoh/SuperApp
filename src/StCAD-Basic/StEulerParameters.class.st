Class {
	#name : #StEulerParameters,
	#superclass : #StEulerArray,
	#type : #variable,
	#instVars : [
		'aA',
		'aB',
		'aC'
	],
	#category : #'StCAD-Basic'
}

{ #category : #'instance creation' }
StEulerParameters class >> new [
	^(super new: 4) initialize
]

{ #category : #'instance creation' }
StEulerParameters class >> symbolic: aE1 with: aE2 with: aE3 with: aE4 [ 
	^(self new)
		at: 1 put: aE1;
		at: 2 put: aE2;
		at: 3 put: aE3;
		at: 4 put: aE4;
		calcSymbolic;
		yourself
]

{ #category : #'VisualWorks metadata' }
StEulerParameters class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #'instance creation' }
StEulerParameters class >> with: aE1 with: aE2 with: aE3 with: aE4 [

	^ self new
		  at: 1 put: aE1 asFloat;
		  at: 2 put: aE2 asFloat;
		  at: 3 put: aE3 asFloat;
		  at: 4 put: aE4 asFloat;
		  conditionSelf;
		  calc;
		  yourself
]

{ #category : #'instance creation' }
StEulerParameters class >> withAxis: axis theta: theta [ 
	^self new withAxis: axis theta: theta
]

{ #category : #accessing }
StEulerParameters >> aA [
	^aA
]

{ #category : #accessing }
StEulerParameters >> aB [
	^aB
]

{ #category : #accessing }
StEulerParameters >> aC [
	^aC
]

{ #category : #calc }
StEulerParameters >> calc [
	self calcABC
]

{ #category : #calc }
StEulerParameters >> calc1 [
	self calcBC.
	aA := aB timesTransposeFullMatrix: aC
]

{ #category : #calc }
StEulerParameters >> calcABC [
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

{ #category : #calc }
StEulerParameters >> calcBC [
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

{ #category : #calc }
StEulerParameters >> calcSymbolic [
	self calc
]

{ #category : #calc }
StEulerParameters >> calcSymbolic1 [
	self calcBC.
	aA := aB timesFullMatrix: aC transpose
]

{ #category : #'ops on self' }
StEulerParameters >> conditionSelf [

	(self allSatisfy: [ :q | q isNumber ]) ifTrue: [
		super conditionSelf.
		self normalizeSelf ]
]

{ #category : #calc }
StEulerParameters >> differentiateWRT: var [ 
	| answer |
	answer := StEulerParametersDot with: self.
	1 to: 4
		do: 
			[:i | 
			| angle angleVel |
			angle := self at: i.
			angleVel := (angle differentiateWRT: var) simplified.
			answer at: i put: angleVel].
	^answer
]

{ #category : #'initialize-release' }
StEulerParameters >> initialize [
	aA := StMFullMatrix new: 3 by: 3.
	aB := StMFullMatrix new: 3 by: 4.
	aC := StMFullMatrix new: 3 by: 4
]

{ #category : #'initialize-release' }
StEulerParameters >> withAxis: axis theta: theta [ 
	| halfTheta sinHalfTheta cosHalfTheta |
	halfTheta := theta / 2.0d.
	sinHalfTheta := halfTheta sin.
	cosHalfTheta := halfTheta cos.
	self at: 1 putFullVector: axis copy normalizeSelf * sinHalfTheta.
	self at: 4 put: cosHalfTheta.
	self conditionSelf.
	self calc
]