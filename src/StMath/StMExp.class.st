Class {
	#name : 'StMExp',
	#superclass : 'StMIntrinsicFunctionX',
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'accessing' }
StMExp class >> functionSymbol [
	^'exp'
]

{ #category : 'VisualWorks metadata' }
StMExp class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'evaluating' }
StMExp >> differentiateWRTx [
	^StMExp with: x copy
]

{ #category : 'printing' }
StMExp >> funcName [

	^ 'exp'
]

{ #category : 'printing' }
StMExp >> printFuntionNameOn: aStream [
	aStream nextPutAll: 'exp'
]

{ #category : 'evaluating' }
StMExp >> value [
	^x value exp
]
