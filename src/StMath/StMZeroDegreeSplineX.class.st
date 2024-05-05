Class {
	#name : #StMZeroDegreeSplineX,
	#superclass : #StMGeneralSplineX,
	#category : #'StMath-Symbolic'
}

{ #category : #'VisualWorks metadata' }
StMZeroDegreeSplineX class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #evaluating }
StMZeroDegreeSplineX >> y: xx [ 
	"y(x) := yi + dydxi*hi + d2ydx2i*hi^2/2! + d3ydx3i*hi^3/3! +"

	self calcIndexAndDeltaFor: xx.
	^ys at: index
]
