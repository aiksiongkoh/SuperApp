Class {
	#name : #StEulerAnglesDot,
	#superclass : #StEulerArray,
	#type : #variable,
	#instVars : [
		'aEulerAngles',
		'cAdot',
		'aAdot',
		'omeF',
		'omef'
	],
	#category : #'StCAD-Basic'
}

{ #category : #'VisualWorks metadata' }
StEulerAnglesDot class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #'instance creation' }
StEulerAnglesDot class >> with: angle [ 
	| answer |
	answer := super new: 3.
	answer initialize: angle.
	^answer
]

{ #category : #accessing }
StEulerAnglesDot >> aAdot [
	^aAdot
]

{ #category : #accessing }
StEulerAnglesDot >> aEulerAngles [
	^aEulerAngles
]

{ #category : #accessing }
StEulerAnglesDot >> aTime [
	^aEulerAngles aTime
]

{ #category : #accessing }
StEulerAnglesDot >> cA [
	^aEulerAngles cA
]

{ #category : #accessing }
StEulerAnglesDot >> cAdot [
	^cAdot
]

{ #category : #calc }
StEulerAnglesDot >> calc [
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

{ #category : #calc }
StEulerAnglesDot >> calcSymbolic [
	| rotOrder cA |
	aEulerAngles calcSymbolic.
	rotOrder := aEulerAngles rotOrder.
	cA := aEulerAngles cA.
	cAdot := Array new: 3.
	1 to: 3
		do: 
			[:i | 
			| axis angle angleDot matAdot |
			axis := rotOrder at: i.
			angle := aEulerAngles at: i.
			angleDot := self at: i.
			matAdot := axis == 1 
						ifTrue: [StMFullMatrix rotateSymbolicx: angle rotDot: angleDot]
						ifFalse: 
							[axis == 2 
								ifTrue: [StMFullMatrix rotateSymbolicy: angle rotDot: angleDot]
								ifFalse: 
									[axis == 3 
										ifTrue: [StMFullMatrix rotateSymbolicz: angle rotDot: angleDot]
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

{ #category : #calc }
StEulerAnglesDot >> differentiateWRT: var [ 
	| answer |
	answer := StEulerAnglesDDot with: self.
	1 to: 3
		do: 
			[:i | 
			| angleVel angleAcc |
			angleVel := self at: i.
			angleAcc := (angleVel differentiateWRT: var) simplified.
			answer at: i put: angleAcc].
	^answer
]

{ #category : #'initialize-release' }
StEulerAnglesDot >> initialize: angle [ 
	aEulerAngles := angle
]

{ #category : #accessing }
StEulerAnglesDot >> omeF [
	^omeF
]

{ #category : #accessing }
StEulerAnglesDot >> omef [
	^omef
]

{ #category : #accessing }
StEulerAnglesDot >> rotOrder [
	^aEulerAngles rotOrder
]

{ #category : #'basic ops' }
StEulerAnglesDot >> simplified [
	| answer |
	answer := super simplified.
	answer initialize: aEulerAngles.
	^answer
]
