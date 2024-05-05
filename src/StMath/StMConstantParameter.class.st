Class {
	#name : #StMConstantParameter,
	#superclass : #StMConstant,
	#category : #'StMath-Symbolic'
}

{ #category : #testing }
StMConstantParameter >> isConstant [

	^ false
]

{ #category : #printing }
StMConstantParameter >> printOn: aStream [

	aStream print: name.
	value ifNotNil: [
		aStream nextPut: $(.
		aStream print: value.
		aStream nextPut: $) ]
]

{ #category : #accessing }
StMConstantParameter >> value [

	^ value ifNil: [ self ]
]
