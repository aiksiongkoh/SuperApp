Class {
	#name : 'StMLg',
	#superclass : 'StMIntrinsicFunctionX',
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'accessing' }
StMLg class >> functionSymbol [
	^'lg'
]

{ #category : 'VisualWorks metadata' }
StMLg class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'evaluating' }
StMLg >> differentiateWRTx [

	^ StMReciprocal with: (StMProduct with: x copy with: (StMLn with: 10))
]

{ #category : 'printing' }
StMLg >> funcName [

	^ 'lg'
]

{ #category : 'printing' }
StMLg >> printFuntionNameOn: aStream [
	aStream nextPutAll: 'lg'
]

{ #category : 'evaluating' }
StMLg >> value [
	^x value log
]
