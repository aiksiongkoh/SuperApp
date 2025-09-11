Class {
	#name : 'SymSolver',
	#superclass : 'StMSymbolic',
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'printing' }
SymSolver >> printOn: aStream [
	"Append to the argument, aStream, a sequence of characters that
	identifies the receiver."

	aStream
		nextPut: $a;
		nextPutAll: self class name;
		nextPut: $(;
		nextPut: $)
]
