Class {
	#name : 'StMTan',
	#superclass : 'StMTrig',
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
StMTan >> funcName [

	^ 'tan'
]

{ #category : 'testing' }
StMTan >> isZero [

	^ x isZero
]

{ #category : 'printing' }
StMTan >> printFuntionNameOn: aStream [
	aStream nextPutAll: 'tan'
]

{ #category : 'evaluating' }
StMTan >> value [
	^x value tan
]
