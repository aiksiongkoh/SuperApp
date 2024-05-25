Class {
	#name : 'StMReciprocal',
	#superclass : 'StMIntrinsicFunctionX',
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'accessing' }
StMReciprocal class >> functionSymbol [

	^ '1.0/'
]

{ #category : 'evaluating' }
StMReciprocal >> differentiateWRTx [

	^ StMNegative with: (x copy raisedTo: -2)
]

{ #category : 'printing' }
StMReciprocal >> printFuntionNameOn: aStream [

	aStream nextPutAll: '1.0/'
]

{ #category : 'evaluating' }
StMReciprocal >> value [

	^ x value reciprocal
]
