Class {
	#name : #StMNegative,
	#superclass : #StMFunctionX,
	#category : #'StMath-Symbolic'
}

{ #category : #'VisualWorks metadata' }
StMNegative class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #'StCAD-UI' }
StMNegative >> cadStringOn: aStream [ 
	aStream nextPut: $(.
	aStream nextPut: $-.
	x cadStringOn: aStream.
	aStream nextPut: $)
]

{ #category : #evaluating }
StMNegative >> differentiateWRTx [
	^StMConstant with: -1
]

{ #category : #testing }
StMNegative >> negative [

	^ true
]

{ #category : #printing }
StMNegative >> printFuntionNameOn: aStream [
	aStream nextPutAll: '-'
]

{ #category : #evaluating }
StMNegative >> value [
	^x value negated
]
