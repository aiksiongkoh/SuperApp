"
The independent variable is assigned the value of its argument x.
"
Class {
	#name : #IndependentVariable,
	#superclass : #SymVariable,
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #'VisualWorks metadata' }
IndependentVariable class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #accessing }
IndependentVariable >> aIndependentVariable [
	^self
]

{ #category : #evaluating }
IndependentVariable >> differentiateWRT: variable [ 
	^self == variable
		ifTrue: [Constant with: 1]
		ifFalse: [Constant with: 0]
]

{ #category : #printing }
IndependentVariable >> printOn: aStream [ 
	aStream nextPutAll: name
]
