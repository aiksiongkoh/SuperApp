Class {
	#name : 'StMCos',
	#superclass : 'StMIntrinsicFunctionX',
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'accessing' }
StMCos class >> functionSymbol [
	^'cos'
]

{ #category : 'VisualWorks metadata' }
StMCos class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'evaluating' }
StMCos >> differentiateWRTx [
	^StMNegative with: (StMSin with: x copy)
]

{ #category : 'printing' }
StMCos >> printFuntionNameOn: aStream [
	aStream nextPutAll: 'cos'
]

{ #category : 'evaluating' }
StMCos >> value [
	^x value cos
]
