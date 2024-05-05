Class {
	#name : #StMLeastSquaresFit,
	#superclass : #StMDataXYFunctionX,
	#instVars : [
		'xOffset'
	],
	#category : #'StMath-Symbolic'
}

{ #category : #'VisualWorks metadata' }
StMLeastSquaresFit class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #'instance creation' }
StMLeastSquaresFit class >> with: var order: order xs: xxs ys: yys [ 
	^super new
		x: var
		order: order
		xs: xxs
		ys: yys
]
