Class {
	#name : #SymEulerAngles,
	#superclass : #SymEulerArray,
	#type : #variable,
	#instVars : [
		'rotOrder',
		'cA',
		'aA'
	],
	#category : #'StCAD-Basic'
}

{ #category : #'instance creation' }
SymEulerAngles class >> new [
	^(super new: 3) initialize
]

{ #category : #'instance creation' }
SymEulerAngles class >> symbolic: firstObject with: secondObject with: thirdObject [ 
	^self 
		with: firstObject
		with: secondObject
		with: thirdObject
]

{ #category : #'VisualWorks metadata' }
SymEulerAngles class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #'instance creation' }
SymEulerAngles class >> with: firstObject with: secondObject with: thirdObject [ 
	^(super 
		with: firstObject
		with: secondObject
		with: thirdObject)
		initialize;
		yourself
]

{ #category : #accessing }
SymEulerAngles >> aA [
	^aA
]

{ #category : #accessing }
SymEulerAngles >> aTime [
	self do: [:aAngle | aAngle aIndependentVariable ifNotNil: [:aVar | ^aVar]].
	^nil
]

{ #category : #accessing }
SymEulerAngles >> cA [
	^cA
]

{ #category : #calc }
SymEulerAngles >> calc [
	cA := Array new: 3.
	1 to: 3
		do: 
			[:i | 
			| axis angle matA |
			axis := rotOrder at: i.
			angle := (self at: i) value.
			matA := axis == 1 
						ifTrue: [StMFullMatrix rotatex: angle]
						ifFalse: 
							[axis == 2 
								ifTrue: [StMFullMatrix rotatey: angle]
								ifFalse: 
									[axis == 3 
										ifTrue: [StMFullMatrix rotatez: angle]
										ifFalse: 
											[self 
												error: 'Euler angle rotation order must be any permutation of 1,2,3 without consecutive repeats.']]].
			cA at: i put: matA].
	aA := (cA at: 1) timesFullMatrix: ((cA at: 2) timesFullMatrix: (cA at: 3))
]

{ #category : #calc }
SymEulerAngles >> calcSymbolic [
	cA := Array new: 3.
	1 to: 3
		do: 
			[:i | 
			| axis angle matA |
			axis := rotOrder at: i.
			angle := self at: i.
			matA := axis == 1 
						ifTrue: [StMFullMatrix rotateSymbolicx: angle]
						ifFalse: 
							[axis == 2 
								ifTrue: [StMFullMatrix rotateSymbolicy: angle]
								ifFalse: 
									[axis == 3 
										ifTrue: [StMFullMatrix rotateSymbolicz: angle]
										ifFalse: 
											[self 
												error: 'Euler angle rotation order must be any permutation of 1,2,3 without consecutive repeats.']]].
			cA at: i put: matA].
	aA := ((cA at: 1) 
				timesFullMatrix: ((cA at: 2) timesFullMatrix: (cA at: 3))) simplified
]

{ #category : #calc }
SymEulerAngles >> differentiateWRT: var [ 
	| answer |
	answer := SymEulerAnglesDot with: self.
	1 to: 3
		do: 
			[:i | 
			| angle angleVel |
			angle := self at: i.
			angleVel := (angle differentiateWRT: var) simplified.
			answer at: i put: angleVel].
	^answer
]

{ #category : #'initialize-release' }
SymEulerAngles >> initialize [
	rotOrder := Array 
				with: 1
				with: 2
				with: 3
]

{ #category : #accessing }
SymEulerAngles >> rotOrder [
	^rotOrder
]

{ #category : #accessing }
SymEulerAngles >> rotOrder: col [ 
	rotOrder := col
]
