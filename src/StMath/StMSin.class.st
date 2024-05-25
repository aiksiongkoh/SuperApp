Class {
	#name : 'StMSin',
	#superclass : 'StMIntrinsicFunctionX',
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'accessing' }
StMSin class >> functionSymbol [
	^'sin'
]

{ #category : 'VisualWorks metadata' }
StMSin class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'evaluating' }
StMSin >> differentiateWRTx [
	^StMCos with: x copy
]

{ #category : 'printing' }
StMSin >> printFuntionNameOn: aStream [
	aStream nextPutAll: 'sin'
]

{ #category : 'evaluating' }
StMSin >> value [
	^x value sin
]
