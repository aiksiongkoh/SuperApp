Class {
	#name : #SymEulerAnglesDDot,
	#superclass : #SymEulerArray,
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
SymEulerAnglesDDot class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #'instance creation' }
SymEulerAnglesDDot class >> with: angledot [ 
	| answer |
	answer := super new: 3.
	answer initialize: angledot.
	^answer
]

{ #category : #accessing }
SymEulerAnglesDDot >> aAddot [
	^aAddot
]

{ #category : #accessing }
SymEulerAnglesDDot >> aEulerAngles [
	^aEulerAnglesDot aEulerAngles
]

{ #category : #accessing }
SymEulerAnglesDDot >> aEulerAnglesDot [
	^aEulerAnglesDot
]

{ #category : #accessing }
SymEulerAnglesDDot >> aTime [
	^aEulerAnglesDot aTime
]

{ #category : #accessing }
SymEulerAnglesDDot >> alpF [
	^alpF
]

{ #category : #accessing }
SymEulerAnglesDDot >> alpF: anObject [
	alpF := anObject
]

{ #category : #accessing }
SymEulerAnglesDDot >> alpf [
	^alpf
]

{ #category : #accessing }
SymEulerAnglesDDot >> alpf: anObject [
	^alpf := anObject
]

{ #category : #accessing }
SymEulerAnglesDDot >> cAddot [
	^cAddot
]

{ #category : #calc }
SymEulerAnglesDDot >> calc [
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
SymEulerAnglesDDot >> calcSymbolic [
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
SymEulerAnglesDDot >> initialize: angledot [ 
	aEulerAnglesDot := angledot
]

{ #category : #accessing }
SymEulerAnglesDDot >> rotOrder [
	^aEulerAnglesDot rotOrder
]

{ #category : #'basic ops' }
SymEulerAnglesDDot >> simplified [
	| answer |
	answer := super simplified.
	answer initialize: aEulerAnglesDot.
	^answer
]
