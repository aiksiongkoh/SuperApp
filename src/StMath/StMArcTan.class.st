Class {
	#name : #StMArcTan,
	#superclass : #StMIntrinsicFunctionX,
	#category : #'StMath-Symbolic'
}

{ #category : #accessing }
StMArcTan class >> functionSymbol [
	^'arctan'
]

{ #category : #'VisualWorks metadata' }
StMArcTan class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #evaluating }
StMArcTan >> differentiateWRTx [
	^((x copy raisedTo: 2)
		plus: 1) reciprocal
]

{ #category : #evaluating }
StMArcTan >> value [
	^x value arcTan
]
