Class {
	#name : 'StMSqrt',
	#superclass : 'StMIntrinsicFunctionX',
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'accessing' }
StMSqrt class >> functionSymbol [
	^'sqrt'
]

{ #category : 'VisualWorks metadata' }
StMSqrt class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'evaluating' }
StMSqrt >> differentiateWRTx [

	^ StMReciprocal with:
		  (StMProduct with: 2 with: (StMSqrt with: x copy))
]

{ #category : 'printing' }
StMSqrt >> funcName [

	^ 'sqrt'
]

{ #category : 'printing' }
StMSqrt >> printFuntionNameOn: aStream [
	aStream nextPutAll: 'sqrt'
]

{ #category : 'evaluating' }
StMSqrt >> value [
	^x value sqrt
]
