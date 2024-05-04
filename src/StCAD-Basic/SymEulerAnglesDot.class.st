Class {
	#name : #SymEulerAnglesDot,
	#superclass : #SymEulerArray,
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
SymEulerAnglesDot class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #'instance creation' }
SymEulerAnglesDot class >> with: angle [ 
	| answer |
	answer := super new: 3.
	answer initialize: angle.
	^answer
]

{ #category : #accessing }
SymEulerAnglesDot >> aAdot [
	^aAdot
]

{ #category : #accessing }
SymEulerAnglesDot >> aEulerAngles [
	^aEulerAngles
]

{ #category : #accessing }
SymEulerAnglesDot >> aTime [
	^aEulerAngles aTime
]

{ #category : #accessing }
SymEulerAnglesDot >> cA [
	^aEulerAngles cA
]

{ #category : #accessing }
SymEulerAnglesDot >> cAdot [
	^cAdot
]

{ #category : #calc }
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

{ #category : #calc }
SymEulerAnglesDot >> calcSymbolic [
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
SymEulerAnglesDot >> differentiateWRT: var [ 
	| answer |
	answer := SymEulerAnglesDDot with: self.
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
SymEulerAnglesDot >> initialize: angle [ 
	aEulerAngles := angle
]

{ #category : #accessing }
SymEulerAnglesDot >> omeF [
	^omeF
]

{ #category : #accessing }
SymEulerAnglesDot >> omef [
	^omef
]

{ #category : #accessing }
SymEulerAnglesDot >> rotOrder [
	^aEulerAngles rotOrder
]

{ #category : #'basic ops' }
SymEulerAnglesDot >> simplified [
	| answer |
	answer := super simplified.
	answer initialize: aEulerAngles.
	^answer
]
