Class {
	#name : 'SymEulerAnglesDot',
	#superclass : 'SymEulerArray',
	#type : 'variable',
	#instVars : [
		'aEulerAngles',
		'cAdot',
		'aAdot',
		'omeF',
		'omef'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'VisualWorks metadata' }
SymEulerAnglesDot class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'instance creation' }
SymEulerAnglesDot class >> with: angle [ 
	| answer |
	answer := super new: 3.
	answer initialize: angle.
	^answer
]

{ #category : 'accessing' }
SymEulerAnglesDot >> aAdot [
	^aAdot
]

{ #category : 'accessing' }
SymEulerAnglesDot >> aEulerAngles [
	^aEulerAngles
]

{ #category : 'accessing' }
SymEulerAnglesDot >> aTime [
	^aEulerAngles aTime
]

{ #category : 'accessing' }
SymEulerAnglesDot >> cA [
	^aEulerAngles cA
]

{ #category : 'accessing' }
SymEulerAnglesDot >> cAdot [
	^cAdot
]

{ #category : 'calc' }
SymEulerAnglesDot >> calc [
	| rotOrder cA |
	aEulerAngles calc.
	rotOrder := aEulerAngles rotOrder.
	cA := aEulerAngles cA.
	cAdot := Array new: 3.
	1 to: 3
		do: 
			[:i | 
			| axis angle angleDot matAdot |
			axis := rotOrder at: i.
			angle := (aEulerAngles at: i) value.
			angleDot := (self at: i) value.
			matAdot := axis == 1 
						ifTrue: [StMFullMatrix rotatex: angle rotDot: angleDot]
						ifFalse: 
							[axis == 2 
								ifTrue: [StMFullMatrix rotatey: angle rotDot: angleDot]
								ifFalse: 
									[axis == 3 
										ifTrue: [StMFullMatrix rotatez: angle rotDot: angleDot]
										ifFalse: 
											[self 
												error: 'Euler angle rotation order must be any permutation of 1,2,3 without consecutive repeats.']]].
			cAdot at: i put: matAdot].
	aAdot := ((cAdot at: 1) 
				timesFullMatrix: ((cA at: 2) timesFullMatrix: (cA at: 3))) 
					+ ((cA at: 1) timesFullMatrix: ((cAdot at: 2) timesFullMatrix: (cA at: 3))) 
					+ ((cA at: 1) timesFullMatrix: ((cA at: 2) timesFullMatrix: (cAdot at: 3))).
	omeF := ((((cA at: 1) column: 1) times: (self at: 1)) 
				+ ((((cA at: 1) timesFullMatrix: (cA at: 2)) column: 2) times: (self at: 2)) 
					+ ((aEulerAngles aA column: 3) times: (self at: 3))) simplified.
	omef := (aEulerAngles aA transposeTimesFullColumn: omeF) simplified
]

{ #category : 'calc' }
SymEulerAnglesDot >> calcSymbolic [

	| rotOrder cA time |
	aEulerAngles calcSymbolic.
	rotOrder := aEulerAngles rotOrder.
	cA := aEulerAngles cA.
	time := aEulerAngles independentVar.
	cAdot := cA collect: [ :rotMat | rotMat differentiateWRT: time ].
	aAdot := ((cAdot at: 1) timesFullMatrix: ((cA at: 2) timesFullMatrix: (cA at: 3)))
	         + ((cA at: 1) timesFullMatrix: ((cAdot at: 2) timesFullMatrix: (cA at: 3)))
	         + ((cA at: 1) timesFullMatrix: ((cA at: 2) timesFullMatrix: (cAdot at: 3))).
	aAdot := aAdot simplified.
	omeF := ((((cA at: 1) column: (rotOrder at: 1)) times: (self at: 1))
	         +
	         ((((cA at: 1) timesFullMatrix: (cA at: 2)) column: (rotOrder at: 2)) times: (self at: 2))
	         + ((aEulerAngles aA column: (rotOrder at: 3)) times: (self at: 3))) simplified.
	omef := (aEulerAngles aA transposeTimesFullColumn: omeF) simplified
]

{ #category : 'calc' }
SymEulerAnglesDot >> calcomeFfF [

	| cA rotOrder |
	cA := aEulerAngles cA.
	rotOrder := aEulerAngles rotOrder.
	omeF := ((((cA at: 1) column: (rotOrder at: 1)) times: (self at: 1)) simplified
	         +
	         ((((cA at: 1) timesFullMatrix: (cA at: 2)) column: (rotOrder at: 2)) times: (self at: 2))
		         simplified + ((aEulerAngles aA column: (rotOrder at: 3)) times: (self at: 3)) simplified)
		        simplified.
	omef := (aEulerAngles aA transposeTimesFullColumn: omeF) simplified
]

{ #category : 'calc' }
SymEulerAnglesDot >> calcomegas [
	"
	7030euler.odt
	http://www.multibody.net/mbsymba/kinematics/bryant-angles/
	"

	| cA rotOrder |
	cA := aEulerAngles cA.
	rotOrder := aEulerAngles rotOrder.
	omeF := ((((cA at: 1) column: (rotOrder at: 1)) times: (self at: 1)) simplified
	         +
	         ((((cA at: 1) timesFullMatrix: (cA at: 2)) column: (rotOrder at: 2)) times: (self at: 2))
		         simplified + ((aEulerAngles aA column: (rotOrder at: 3)) times: (self at: 3)) simplified)
		        simplified.
	omef := (aEulerAngles aA transposeTimesFullColumn: omeF) simplified
]

{ #category : 'enumerating' }
SymEulerAnglesDot >> collect: aBlock [

	self halt
]

{ #category : 'calc' }
SymEulerAnglesDot >> differentiateWRT: var [

	| answer |
	answer := SymEulerAnglesDDot with: self.
	1 to: 3 do: [ :i |
		| angleVel angleAcc |
		angleVel := self at: i.
		angleAcc := angleVel differentiateWRT: var.
		answer at: i put: angleAcc ].
	^ answer
]

{ #category : 'initialize-release' }
SymEulerAnglesDot >> initialize: symEulerAngles [

	| var angle angleDot |
	aEulerAngles := symEulerAngles.
	var := symEulerAngles independentVar.
	1 to: 3 do: [ :i |
		angle := aEulerAngles at: i.
		angleDot := (angle differentiateWRT: var) simplified.
		self at: i put: angleDot ].
	cAdot := symEulerAngles cA collect: [ :rotMat | (rotMat differentiateWRT: var) simplified ].
	aAdot := (symEulerAngles aA differentiateWRT: var) simplified.
	self calcomegas
]

{ #category : 'accessing' }
SymEulerAnglesDot >> omeF [
	^omeF
]

{ #category : 'accessing' }
SymEulerAnglesDot >> omeFfF [
	"
	7030euler.odt
	http://www.multibody.net/mbsymba/kinematics/bryant-angles/
	Need to generalize for other RotOrder
	"

	| the1x the2y the3z the1xdot the2ydot the3zdot omeFfF1 omeFfF2 omeFfF3 |
	the1x := aEulerAngles at: 1.
	the2y := aEulerAngles at: 2.
	the3z := aEulerAngles at: 3.
	the1xdot := self at: 1.
	the2ydot := self at: 2.
	the3zdot := self at: 3.
	omeFfF1 := the1xdot + (the3zdot * the2y sin).
	omeFfF2 := the2ydot * the1x cos - (the3zdot * the1x sin * the2y cos).
	omeFfF3 := the2ydot * the1x sin + (the3zdot * the1x cos * the2y cos).
	^ SymFullColumn with: omeFfF1 simplified with: omeFfF2 simplified with: omeFfF3 simplified
]

{ #category : 'accessing' }
SymEulerAnglesDot >> omef [
	^omef
]

{ #category : 'accessing' }
SymEulerAnglesDot >> rotOrder [
	^aEulerAngles rotOrder
]

{ #category : 'basic ops' }
SymEulerAnglesDot >> simplified [
	| answer |
	answer := super simplified.
	answer initialize: aEulerAngles.
	^answer
]
