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
StMReciprocal >> funcName [

	^ '1.0/'
]

{ #category : 'testing' }
StMReciprocal >> isTrig [

	self halt: 'Check this.'.
	^ x isTrig
]

{ #category : 'printing' }
StMReciprocal >> printFuntionNameOn: aStream [

	aStream nextPutAll: '1.0/'
]

{ #category : 'evaluating' }
StMReciprocal >> simplifyReciprocal [

	| newx answer |
	newx := x simplifyReciprocal.
	answer := self class with: newx.
	^ newx isConstant
		  ifTrue: [ StMConstant with: answer value ]
		  ifFalse: [
			  newx isReciprocal
				  ifTrue: [ newx x ]
				  ifFalse: [ answer ] ]
]

{ #category : 'evaluating' }
StMReciprocal >> value [

	^ x value reciprocal
]
