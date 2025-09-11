"
The independent variable is assigned the value of its argument x.
"
Class {
	#name : 'StMIndependentVariable',
	#superclass : 'StMVariable',
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'VisualWorks metadata' }
StMIndependentVariable class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'accessing' }
StMIndependentVariable >> aIndependentVariable [
	^self
]

{ #category : 'evaluating' }
StMIndependentVariable >> differentiateWRT: var [

	^ var isSequenceable
		  ifTrue: [ var collect: [ :vari | self differentiateWRT: vari ] ]
		  ifFalse: [
				  self == var
					  ifTrue: [ StMConstant with: 1 ]
					  ifFalse: [ StMConstant with: 0 ] ]
]

{ #category : 'accessing' }
StMIndependentVariable >> independentVar [

	^ self
]

{ #category : 'testing' }
StMIndependentVariable >> isIndependentVariable [

	^ true
]

{ #category : 'printing' }
StMIndependentVariable >> printOn: aStream [

	aStream nextPutAll: name.
	aStream nextPut: $(.
	aStream print: value.
	aStream nextPut: $)
]
