Class {
	#name : 'StMSin',
	#superclass : 'StMTrig',
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

{ #category : 'converting' }
StMSin >> asNumber [

	^ x asNumber sin
]

{ #category : 'converting' }
StMSin >> asValue [

	^ x asValue sin
]

{ #category : 'evaluating' }
StMSin >> differentiateWRTx [
	^StMCos with: x copy
]

{ #category : 'printing' }
StMSin >> funcName [

	^ 'sin'
]

{ #category : 'testing' }
StMSin >> isSin [

	^ true
]

{ #category : 'testing' }
StMSin >> isZero [

	^ x isZero
]

{ #category : 'printing' }
StMSin >> printFuntionNameOn: aStream [
	aStream nextPutAll: 'sin'
]

{ #category : 'evaluating' }
StMSin >> value [
	^x value sin
]
