Class {
	#name : 'SymEulerParameters',
	#superclass : 'SymEulerArray',
	#type : 'variable',
	#instVars : [
		'aA',
		'aB',
		'aC',
		'pApE',
		'ppApEpE'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'instance creation' }
SymEulerParameters class >> new [
	^(super new: 4) initialize
]

{ #category : 'instance creation' }
SymEulerParameters class >> symbolic: aE1 with: aE2 with: aE3 with: aE4 [ 
	^(self new)
		at: 1 put: aE1;
		at: 2 put: aE2;
		at: 3 put: aE3;
		at: 4 put: aE4;
		calcSymbolic;
		yourself
]

{ #category : 'VisualWorks metadata' }
SymEulerParameters class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'instance creation' }
SymEulerParameters class >> with: aE1 with: aE2 with: aE3 with: aE4 [

	^ self new
		  at: 1 put: aE1 asFloat;
		  at: 2 put: aE2 asFloat;
		  at: 3 put: aE3 asFloat;
		  at: 4 put: aE4 asFloat;
		  conditionSelf;
		  calc;
		  yourself
]

{ #category : 'instance creation' }
SymEulerParameters class >> withAxis: axis theta: theta [ 
	^self new withAxis: axis theta: theta
]

{ #category : 'accessing' }
SymEulerParameters >> aA [
	"Rotation matrix aAFf"

	^ aA
]

{ #category : 'accessing' }
SymEulerParameters >> aB [
	^aB
]

{ #category : 'accessing' }
SymEulerParameters >> aC [
	^aC
]

{ #category : 'calc' }
SymEulerParameters >> calc [

	self calcABC.
	self calcpApE
]

{ #category : 'calc' }
SymEulerParameters >> calc1 [
	self calcBC.
	aA := aB timesTransposeFullMatrix: aC
]

{ #category : 'calc' }
SymEulerParameters >> calcABC [
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
	aA := (aB timesTransposeFullMatrix: aC) simplified
]

{ #category : 'calc' }
SymEulerParameters >> calcBC [
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
SymEulerParameters >> calcSymbolic [
	self calc
]

{ #category : 'calc' }
SymEulerParameters >> calcSymbolic1 [
	self calcBC.
	aA := aB timesFullMatrix: aC transpose
]

{ #category : 'calc' }
SymEulerParameters >> calcpApE [
	"pApE is a StMFullColumn of Matrices."

	pApE := self asFullColumn collect: [ :qi | aA differentiateWRT: qi ]
]

{ #category : 'calc' }
SymEulerParameters >> calcpApE2 [
	"pApE is a StMFullColumn of Matrices."

	| pApEi aAk pApEik pApEikl ppApEpEi ppApEpEij ppApEpEijk ppApEpEijkl |
	1 to: 4 do: [ :i |
		pApEi := pApE at: i.
		1 to: 3 do: [ :k |
			aAk := aA at: k.
			pApEik := pApEi at: k.
			1 to: 3 do: [ :l |
				pApEikl := (aAk at: l) differentiateWRT: (self at: i).
				pApEik at: l put: pApEikl ] ] ].
	1 to: 4 do: [ :i |
		pApEi := pApE at: i.
		ppApEpEi := ppApEpE at: i.
		1 to: 4 do: [ :j |
			ppApEpEij := ppApEpEi at: j.
			1 to: 3 do: [ :k |
				pApEik := pApEi at: k.
				ppApEpEijk := ppApEpEij at: k.
				1 to: 3 do: [ :l |
					ppApEpEijkl := (pApEik at: l) differentiateWRT: (self at: j).
					ppApEpEijk at: l put: ppApEpEijkl ] ] ] ]
]

{ #category : 'ops on self' }
SymEulerParameters >> conditionSelf [

	(self allSatisfy: [ :q | q isNumber ])
		ifTrue: [
			super conditionSelf.
			self normalizeSelf ]
		ifFalse: [ 1 to: 4 do: [ :i | self at: i put: (self at: i) simplified ] ]
]

{ #category : 'calc' }
SymEulerParameters >> differentiateWRT: var [

	^ var isSequenceable
		  ifTrue: [ self halt ]
		  ifFalse: [
				  | answer |
				  answer := SymEulerParametersDot with: self.
				  1 to: 4 do: [ :i |
						  | angle angleVel |
						  angle := self at: i.
						  angleVel := angle differentiateWRT: var.
						  answer at: i put: angleVel ].
				  answer ]
]

{ #category : 'as yet unclassified' }
SymEulerParameters >> extendTo: qEO2 factor: factor [

	| qEO1 cosHalfTheta qEOmid halfTheta sinHalfTheta ratio1 ratio2 |
	qEO1 := self.
	cosHalfTheta := qEO1 dot: qEO2.
	cosHalfTheta abs >= 1.0
		ifTrue: [ qEOmid := qEO1 copy ]
		ifFalse: [
			halfTheta := cosHalfTheta arcCos.
			sinHalfTheta := halfTheta sin.
			ratio1 := (1.0 - factor * halfTheta) sin / sinHalfTheta.
			ratio2 := (factor * halfTheta) sin / sinHalfTheta.
			qEOmid := qEO1 times: ratio1 plusFullColumn: qEO2 times: ratio2 ].
	^ qEOmid conditionSelf
]

{ #category : 'initialize-release' }
SymEulerParameters >> initialize [

	| ppApEpEi |
	aA := StMFullMatrix new: 3 by: 3.
	aB := StMFullMatrix new: 3 by: 4.
	aC := StMFullMatrix new: 3 by: 4.
	pApE := SymFullColumn new: 4.
	ppApEpE := StMFullMatrix new: 4 by: 4.
	1 to: 4 do: [ :i |
		pApE at: i put: (StMFullMatrix new: 3 by: 3).
		ppApEpEi := ppApEpE at: i.
		1 to: 4 do: [ :j | ppApEpEi at: j put: (StMFullMatrix new: 3 by: 3) ] ]
]

{ #category : 'accessing' }
SymEulerParameters >> pApE [

	^ pApE
]

{ #category : 'accessing' }
SymEulerParameters >> ppApEpE [
	^ ppApEpE
]

{ #category : 'initialize-release' }
SymEulerParameters >> withAxis: axis theta: theta [ 
	| halfTheta sinHalfTheta cosHalfTheta |
	halfTheta := theta / 2.0.
	sinHalfTheta := halfTheta sin.
	cosHalfTheta := halfTheta cos.
	self at: 1 putFullVector: axis copy normalizeSelf * sinHalfTheta.
	self at: 4 put: cosHalfTheta.
	self conditionSelf.
	self calc
]
