Class {
	#name : 'StMPI',
	#superclass : 'StMConstant',
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'initialization' }
StMPI >> initialize [

	name := 'pi'.
	value := Float pi
]

{ #category : 'printing' }
StMPI >> printOn: aStream [

	aStream nextPutAll: name
]
