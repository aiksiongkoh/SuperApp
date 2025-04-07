Class {
	#name : 'StMCos',
	#superclass : 'StMTrig',
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

{ #category : 'converting' }
StMCos >> asValue [

	^ x asValue cos
]

{ #category : 'evaluating' }
StMCos >> differentiateWRTx [
	^StMNegative with: (StMSin with: x copy)
]

{ #category : 'printing' }
StMCos >> funcName [

	^ 'cos'
]

{ #category : 'testing' }
StMCos >> isCos [

	^ true
]

{ #category : 'printing' }
StMCos >> printFuntionNameOn: aStream [
	aStream nextPutAll: 'cos'
]

{ #category : 'evaluating' }
StMCos >> value [
	^x value cos
]
