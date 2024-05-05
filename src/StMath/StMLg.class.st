Class {
	#name : #StMLg,
	#superclass : #StMIntrinsicFunctionX,
	#category : #'StMath-Symbolic'
}

{ #category : #accessing }
StMLg class >> functionSymbol [
	^'lg'
]

{ #category : #'VisualWorks metadata' }
StMLg class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #evaluating }
StMLg >> differentiateWRTx [
	^StMProduct with: (StMPower with: x copy raisedTo: (StMConstant with: -1))
		times: (StMConstant with: 1.0 exp log)
]

{ #category : #printing }
StMLg >> printFuntionNameOn: aStream [
	aStream nextPutAll: 'lg'
]

{ #category : #evaluating }
StMLg >> value [
	^x value log
]
