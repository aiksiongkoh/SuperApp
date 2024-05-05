"
The independent variable is assigned the value of its argument x.
"
Class {
	#name : #StMIndependentVariable,
	#superclass : #StMVariable,
	#category : #'StMath-Symbolic'
}

{ #category : #'VisualWorks metadata' }
StMIndependentVariable class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #accessing }
StMIndependentVariable >> aIndependentVariable [
	^self
]

{ #category : #evaluating }
StMIndependentVariable >> differentiateWRT: variable [ 
	^self == variable
		ifTrue: [StMConstant with: 1]
		ifFalse: [StMConstant with: 0]
]

{ #category : #printing }
StMIndependentVariable >> printOn: aStream [ 
	aStream nextPutAll: name
]
