Class {
	#name : #Constant,
	#superclass : #SymVariable,
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #'binary storage' }
Constant class >> binaryReaderBlockForVersion: oldVersion format: oldFormat [ 
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

{ #category : #'VisualWorks metadata' }
Constant class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #'instance creation' }
Constant class >> with: arg [ 
	^self basicNew value: arg
]

{ #category : #comparing }
Constant >> = anObject [ 
	"Answer whether the receiver and the argument represent the same shape"

	^self class == anObject class and: [value = anObject value]
]

{ #category : #'message handling' }
Constant >> argsPerform: selector withArguments: anArray [ 
	"Do nothing."
]

{ #category : #copying }
Constant >> copy [
	"A Constant is immutable so it is ok to reuse."
	"Do nothing."
]

{ #category : #evaluating }
Constant >> differentiateWRT: variable [ 
	^Constant with: 0
]

{ #category : #evaluating }
Constant >> expandUntil: set [ 
	"Do nothing."
]

{ #category : #testing }
Constant >> isConstant [
	^true
]

{ #category : #testing }
Constant >> isOne [
	^value = 1
]

{ #category : #testing }
Constant >> isZero [
	^value = 0
]

{ #category : #evaluating }
Constant >> partialDifferentiateWRT: variable [ 
	^Constant with: 0
]

{ #category : #printing }
Constant >> printOn: aStream [ 
	aStream print: value
]

{ #category : #evaluating }
Constant >> simplifyUntil: set [ 
	"Do nothing."
]

{ #category : #changing }
Constant >> substitute: var1 with: var2 [ 
	^self == var1
		ifTrue: [var2]
		ifFalse: [self]
]

{ #category : #accessing }
Constant >> value [
	^value
]

{ #category : #private }
Constant >> value: arg [ 
	value := arg isReal
				ifTrue: [arg]
				ifFalse: [self error: 'Argument must be a constant.']
]
