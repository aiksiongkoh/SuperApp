Class {
	#name : #StMSqrt,
	#superclass : #StMIntrinsicFunctionX,
	#category : #'StMath-Symbolic'
}

{ #category : #accessing }
StMSqrt class >> functionSymbol [
	^'sqrt'
]

{ #category : #'VisualWorks metadata' }
StMSqrt class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #evaluating }
StMSqrt >> differentiateWRTx [
	^StMProduct with: (StMConstant with: 0.5)
		times: (StMPower with: x copy raisedTo: (StMConstant with: -0.5))
]

{ #category : #printing }
StMSqrt >> printFuntionNameOn: aStream [
	aStream nextPutAll: 'sqrt'
]

{ #category : #evaluating }
StMSqrt >> value [
	^x value sqrt
]
