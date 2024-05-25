Class {
	#name : 'StMTan',
	#superclass : 'StMIntrinsicFunctionX',
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'accessing' }
StMTan class >> functionSymbol [
	^'tan'
]

{ #category : 'VisualWorks metadata' }
StMTan class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'evaluating' }
StMTan >> differentiateWRTx [

	^ (StMCos with: x copy) raisedTo: -2
]

{ #category : 'printing' }
StMTan >> printFuntionNameOn: aStream [
	aStream nextPutAll: 'tan'
]

{ #category : 'evaluating' }
StMTan >> value [
	^x value tan
]
