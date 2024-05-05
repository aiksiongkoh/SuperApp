Class {
	#name : #StMLn,
	#superclass : #StMIntrinsicFunctionX,
	#category : #'StMath-Symbolic'
}

{ #category : #accessing }
StMLn class >> functionSymbol [
	^'ln'
]

{ #category : #'VisualWorks metadata' }
StMLn class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #evaluating }
StMLn >> differentiateWRTx [
	^StMPower with: x copy raisedTo: (StMConstant with: -1)
]

{ #category : #printing }
StMLn >> printFuntionNameOn: aStream [
	aStream nextPutAll: 'ln'
]

{ #category : #evaluating }
StMLn >> value [
	^x value ln
]
