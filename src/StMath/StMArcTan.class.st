Class {
	#name : 'StMArcTan',
	#superclass : 'StMTrig',
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'accessing' }
StMArcTan class >> functionSymbol [
	^'arctan'
]

{ #category : 'VisualWorks metadata' }
StMArcTan class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'evaluating' }
StMArcTan >> differentiateWRTx [

	^ StMReciprocal with: (StMSum with: 1 with: (x copy raisedTo: 2))
]

{ #category : 'printing' }
StMArcTan >> funcName [

	^ 'arctan'
]

{ #category : 'testing' }
StMArcTan >> isZero [

	^ x isZero
]

{ #category : 'printing' }
StMArcTan >> printFuntionNameOn: aStream [

	aStream nextPutAll: 'arctan'
]

{ #category : 'evaluating' }
StMArcTan >> value [
	^x value arcTan
]
