Class {
	#name : #StMTan,
	#superclass : #StMIntrinsicFunctionX,
	#category : #'StMath-Symbolic'
}

{ #category : #accessing }
StMTan class >> functionSymbol [
	^'tan'
]

{ #category : #'VisualWorks metadata' }
StMTan class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #evaluating }
StMTan >> differentiateWRTx [
	^StMPower with: (StMCos with: x copy)
		raisedTo: (StMConstant with: -2)
]

{ #category : #printing }
StMTan >> printFuntionNameOn: aStream [
	aStream nextPutAll: 'tan'
]

{ #category : #evaluating }
StMTan >> value [
	^x value tan
]
