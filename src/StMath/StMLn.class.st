Class {
	#name : 'StMLn',
	#superclass : 'StMIntrinsicFunctionX',
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'accessing' }
StMLn class >> functionSymbol [
	^'ln'
]

{ #category : 'VisualWorks metadata' }
StMLn class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'evaluating' }
StMLn >> differentiateWRTx [

	^ StMReciprocal with: x copy
]

{ #category : 'printing' }
StMLn >> printFuntionNameOn: aStream [
	aStream nextPutAll: 'ln'
]

{ #category : 'evaluating' }
StMLn >> value [
	^x value ln
]
