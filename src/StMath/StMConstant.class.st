Class {
	#name : 'StMConstant',
	#superclass : 'StMSymbolic',
	#instVars : [
		'name',
		'value'
	],
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'binary storage' }
StMConstant class >> binaryReaderBlockForVersion: oldVersion format: oldFormat [ 
	"Remove the instance variable 'value dependents x name'."

	"Remove the instance variable 'name value'."

	oldVersion == nil 
		ifTrue: 
			[| inst |
			inst := self basicNew.
			^
			[:oldObj | 
			| new |
			new := Array new: 2.
			new at: 2 put: (oldObj at: 1).
			oldObj become: new.
			oldObj changeClassToThatOf: inst]].
	^super binaryReaderBlockForVersion: oldVersion format: oldFormat
]

{ #category : 'accessing' }
StMConstant class >> name: symbol [ 
	^super new name: symbol
]

{ #category : 'VisualWorks metadata' }
StMConstant class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'instance creation' }
StMConstant class >> with: arg [ 
	^self basicNew value: arg
]

{ #category : 'comparing' }
StMConstant >> < anObject [

	^ self value < anObject value
]

{ #category : 'comparing' }
StMConstant >> = anObject [
	"Answer whether the receiver and the argument represent the same shape"

	^ (anObject isNumber or: [self class == anObject class]) and: [ value = anObject value ]
]

{ #category : 'message handling' }
StMConstant >> argsPerform: selector withArguments: anArray [ 
	"Do nothing."
]

{ #category : 'converting' }
StMConstant >> asNumber [

	^ value
]

{ #category : 'converting' }
StMConstant >> asValue [

	^ value asValue
]

{ #category : 'copying' }
StMConstant >> copy [
	"A Constant is immutable so it is ok to reuse."
	"Do nothing."
]

{ #category : 'evaluating' }
StMConstant >> differentiateWRT: var [

	^ var isSequenceable
		  ifTrue: [ var collect: [ :vari | self differentiateWRT: vari ] ]
		  ifFalse: [ StMConstant with: 0 ]
]

{ #category : 'testing' }
StMConstant >> even [

	^ value even
]

{ #category : 'evaluating' }
StMConstant >> expandUntil: set [ 
	"Do nothing."
]

{ #category : 'comparing' }
StMConstant >> hash [

	| hash |
	hash := self class hash.
	hash := hash bitXor: name hash.
	hash := hash bitXor: value hash.
	^ hash
]

{ #category : 'testing' }
StMConstant >> isConstant [
	^true
]

{ #category : 'testing' }
StMConstant >> isOne [
	^value = 1
]

{ #category : 'testing' }
StMConstant >> isZero [
	^value = 0
]

{ #category : 'accessing' }
StMConstant >> name: symbol [ 
	name := symbol asSymbol
]

{ #category : 'evaluating' }
StMConstant >> partialDifferentiateWRT: variable [ 
	^StMConstant with: 0
]

{ #category : 'printing' }
StMConstant >> printOn: aStream [

	aStream
		nextPut: $c;
		print: value
]

{ #category : 'evaluating' }
StMConstant >> simplified [
	"Do nothing."

	
]

{ #category : 'evaluating' }
StMConstant >> simplifyUntil: set [
	"Do nothing."

	
]

{ #category : 'changing' }
StMConstant >> substitute: var1 with: var2 [ 
	^self == var1
		ifTrue: [var2]
		ifFalse: [self]
]

{ #category : 'accessing' }
StMConstant >> value [
	^value
]

{ #category : 'private' }
StMConstant >> value: arg [

	value := arg isNumber
		         ifTrue: [ arg ]
		         ifFalse: [ self error: 'Argument must be a constant.' ]
]
