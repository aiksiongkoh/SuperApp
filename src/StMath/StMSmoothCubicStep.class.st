Class {
	#name : 'StMSmoothCubicStep',
	#superclass : 'StMSmoothStep',
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'VisualWorks metadata' }
StMSmoothCubicStep class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'calc' }
StMSmoothCubicStep >> transitionFunctionx1: x1 y1: y1 x2: x2 y2: y2 [ 
	| x1v y1v x2v y2v b mat |
	x1v := x1 value.
	y1v := y1 value.
	x2v := x2 value.
	y2v := y2 value.
	x2v > x1v ifFalse: [self error: 'x2 must be greater than x1.'].
	b := StMFullColumn new: 4.
	mat := StMFullMatrix new: 4 by: 4.
	mat at: 1 and: 1 put: 1.0.
	mat at: 1 and: 2 put: x1v.
	mat at: 1 and: 3 put: x1v * x1v.
	mat at: 1 and: 4 put: x1v * x1v * x1v.
	mat at: 2 and: 1 put: 1.0.
	mat at: 2 and: 2 put: x2v.
	mat at: 2 and: 3 put: x2v * x2v.
	mat at: 2 and: 4 put: x2v * x2v * x2v.
	mat at: 3 and: 1 put: 0.0.
	mat at: 3 and: 2 put: 1.0.
	mat at: 3 and: 3 put: 2.0 * x1v.
	mat at: 3 and: 4 put: 3.0 * x1v * x1v.
	mat at: 4 and: 1 put: 0.0.
	mat at: 4 and: 2 put: 1.0.
	mat at: 4 and: 3 put: 2.0 * x2v.
	mat at: 4 and: 4 put: 3.0 * x2v * x2v.
	b at: 1 put: y1v.
	b at: 2 put: y2v.
	b at: 3 put: 0.0.
	b at: 4 put: 0.0.
	^StMPolynomialX with: x copy coeffs: (GEFullMatParPv new solve: mat with: b saveOriginal: false)
]
