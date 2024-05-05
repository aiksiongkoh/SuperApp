Class {
	#name : #StMDifferentiatedGeneralSplineX,
	#superclass : #StMGeneralSplineX,
	#instVars : [
		'derivativeOrder'
	],
	#category : #'StMath-Symbolic'
}

{ #category : #'VisualWorks metadata' }
StMDifferentiatedGeneralSplineX class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #'instance creation' }
StMDifferentiatedGeneralSplineX class >> with: aStMGeneralSpline derivativeOrder: integer [ 
	^super new generalSpline: aStMGeneralSpline derivativeOrder: integer
]

{ #category : #comparing }
StMDifferentiatedGeneralSplineX >> = anObject [ 
	^super = anObject and: [derivativeOrder = anObject derivativeOrder]
]

{ #category : #accessing }
StMDifferentiatedGeneralSplineX >> derivativeOrder [
	^derivativeOrder
]

{ #category : #evaluating }
StMDifferentiatedGeneralSplineX >> differentiateWRTx [
	^StMDifferentiatedGeneralSplineX with: self derivativeOrder: self derivativeOrder + 1
]

{ #category : #'instance creation' }
StMDifferentiatedGeneralSplineX >> generalSpline: stmGeneralSpline derivativeOrder: integer [ 
	x := stmGeneralSpline x copy.
	xs := stmGeneralSpline xs.
	ys := stmGeneralSpline ys.
	derivs := stmGeneralSpline derivs.
	degree := stmGeneralSpline degree.
	derivativeOrder := integer asInteger
]

{ #category : #copying }
StMDifferentiatedGeneralSplineX >> postCopy [
	super postCopy.
	derivativeOrder := derivativeOrder copy
]

{ #category : #changing }
StMDifferentiatedGeneralSplineX >> substitute: var1 with: var2 [ 
	| answer |
	^self = var1
		ifTrue: [var2]
		ifFalse: 
			[answer := self shallowCopy.
			answer x: (x substitute: var1 with: var2).
			answer]
]

{ #category : #evaluating }
StMDifferentiatedGeneralSplineX >> value [
	^self derivative: derivativeOrder at: x value
]
