Class {
	#name : #StEulerAnglesDDot,
	#superclass : #StEulerArray,
	#type : #variable,
	#instVars : [
		'aEulerAnglesDot',
		'cAddot',
		'aAddot',
		'alpF',
		'alpf'
	],
	#category : #'StCAD-Basic'
}

{ #category : #'VisualWorks metadata' }
StEulerAnglesDDot class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #'instance creation' }
StEulerAnglesDDot class >> with: angledot [ 
	| answer |
	answer := super new: 3.
	answer initialize: angledot.
	^answer
]

{ #category : #accessing }
StEulerAnglesDDot >> aAddot [
	^aAddot
]

{ #category : #accessing }
StEulerAnglesDDot >> aEulerAngles [
	^aEulerAnglesDot aEulerAngles
]

{ #category : #accessing }
StEulerAnglesDDot >> aEulerAnglesDot [
	^aEulerAnglesDot
]

{ #category : #accessing }
StEulerAnglesDDot >> aTime [
	^aEulerAnglesDot aTime
]

{ #category : #accessing }
StEulerAnglesDDot >> alpF [
	^alpF
]

{ #category : #accessing }
StEulerAnglesDDot >> alpF: anObject [
	alpF := anObject
]

{ #category : #accessing }
StEulerAnglesDDot >> alpf [
	^alpf
]

{ #category : #accessing }
StEulerAnglesDDot >> alpf: anObject [
	^alpf := anObject
]

{ #category : #accessing }
StEulerAnglesDDot >> cAddot [
	^cAddot
]

{ #category : #calc }
StEulerAnglesDDot >> calc [
	| rotOrder cA cAdot |
	aEulerAnglesDot calc.
	rotOrder := aEulerAnglesDot rotOrder.
	cA := aEulerAnglesDot cA.
	cAdot := aEulerAnglesDot cAdot.
	cAddot := Array new: 3.
	1 to: 3
		do: 
			[:i | 
			| axis angle angleDot angleDDot matAddot |
			axis := rotOrder at: i.
			angle := (aEulerAnglesDot aEulerAngles at: i) value.
			angleDot := (aEulerAnglesDot at: i) value.
			angleDDot := (self at: i) value.
			matAddot := axis == 1 
						ifTrue: 
							[StMFullMatrix 
								rotatex: angle
								rotDot: angleDot
								rotDDot: angleDDot]
						ifFalse: 
							[axis == 2 
								ifTrue: 
									[StMFullMatrix 
										rotatey: angle
										rotDot: angleDot
										rotDDot: angleDDot]
								ifFalse: 
									[axis == 3 
										ifTrue: 
											[StMFullMatrix 
												rotatez: angle
												rotDot: angleDot
												rotDDot: angleDDot]
										ifFalse: 
											[self 
												error: 'Euler angle rotation order must be any permutation of 1,2,3 without consecutive repeats.']]].
			cAddot at: i put: matAddot].
	aAddot := ((cAddot at: 1) 
				timesFullMatrix: ((cA at: 2) timesFullMatrix: (cA at: 3))) 
					+ ((cAdot at: 1) 
							timesFullMatrix: ((cAdot at: 2) timesFullMatrix: (cA at: 3))) 
					+ ((cAdot at: 1) 
							timesFullMatrix: ((cA at: 2) timesFullMatrix: (cAdot at: 3))) 
					+ ((cAdot at: 1) 
							timesFullMatrix: ((cAdot at: 2) timesFullMatrix: (cA at: 3))) 
					+ ((cA at: 1) timesFullMatrix: ((cAddot at: 2) timesFullMatrix: (cA at: 3))) 
					+ ((cA at: 1) 
							timesFullMatrix: ((cAdot at: 2) timesFullMatrix: (cAdot at: 3))) 
					+ ((cAdot at: 1) 
							timesFullMatrix: ((cA at: 2) timesFullMatrix: (cAdot at: 3))) 
					+ ((cA at: 1) 
							timesFullMatrix: ((cAdot at: 2) timesFullMatrix: (cAdot at: 3))) 
					+ ((cA at: 1) timesFullMatrix: ((cA at: 2) timesFullMatrix: (cAddot at: 3)))
]

{ #category : #calc }
StEulerAnglesDDot >> calcSymbolic [
	| rotOrder cA cAdot aTime |
	aEulerAnglesDot calcSymbolic.
	rotOrder := aEulerAnglesDot rotOrder.
	cA := aEulerAnglesDot cA.
	cAdot := aEulerAnglesDot cAdot.
	cAddot := Array new: 3.
	1 to: 3
		do: 
			[:i | 
			| axis angle angleDot angleDDot matAddot |
			axis := rotOrder at: i.
			angle := aEulerAnglesDot aEulerAngles at: i.
			angleDot := aEulerAnglesDot at: i.
			angleDDot := self at: i.
			matAddot := axis == 1 
						ifTrue: 
							[StMFullMatrix 
								rotateSymbolicx: angle
								rotDot: angleDot
								rotDDot: angleDDot]
						ifFalse: 
							[axis == 2 
								ifTrue: 
									[StMFullMatrix 
										rotateSymbolicy: angle
										rotDot: angleDot
										rotDDot: angleDDot]
								ifFalse: 
									[axis == 3 
										ifTrue: 
											[StMFullMatrix 
												rotateSymbolicz: angle
												rotDot: angleDot
												rotDDot: angleDDot]
										ifFalse: 
											[self 
												error: 'Euler angle rotation order must be any permutation of 1,2,3 without consecutive repeats.']]].
			cAddot at: i put: matAddot].
	aAddot := ((cAddot at: 1) 
				timesFullMatrix: ((cA at: 2) timesFullMatrix: (cA at: 3))) 
					+ ((cAdot at: 1) 
							timesFullMatrix: ((cAdot at: 2) timesFullMatrix: (cA at: 3))) 
					+ ((cAdot at: 1) 
							timesFullMatrix: ((cA at: 2) timesFullMatrix: (cAdot at: 3))) 
					+ ((cAdot at: 1) 
							timesFullMatrix: ((cAdot at: 2) timesFullMatrix: (cA at: 3))) 
					+ ((cA at: 1) timesFullMatrix: ((cAddot at: 2) timesFullMatrix: (cA at: 3))) 
					+ ((cA at: 1) 
							timesFullMatrix: ((cAdot at: 2) timesFullMatrix: (cAdot at: 3))) 
					+ ((cAdot at: 1) 
							timesFullMatrix: ((cA at: 2) timesFullMatrix: (cAdot at: 3))) 
					+ ((cA at: 1) 
							timesFullMatrix: ((cAdot at: 2) timesFullMatrix: (cAdot at: 3))) 
					+ ((cA at: 1) timesFullMatrix: ((cA at: 2) timesFullMatrix: (cAddot at: 3))).
	aTime := self aTime.
	aTime ifNil: 
			[| zero zeroCol |
			zero := 0 asConstant.
			zeroCol := StMFullColumn 
						with: zero
						with: zero
						with: zero.
			alpF := zeroCol.
			alpf := zeroCol]
		ifNotNil: 
			[alpF := aEulerAnglesDot omeF differentiateWRT: aTime.
			alpf := aEulerAnglesDot omef differentiateWRT: aTime]
]

{ #category : #'initialize-release' }
StEulerAnglesDDot >> initialize: angledot [ 
	aEulerAnglesDot := angledot
]

{ #category : #accessing }
StEulerAnglesDDot >> rotOrder [
	^aEulerAnglesDot rotOrder
]

{ #category : #'basic ops' }
StEulerAnglesDDot >> simplified [
	| answer |
	answer := super simplified.
	answer initialize: aEulerAnglesDot.
	^answer
]
