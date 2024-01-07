"
Abstract class
"
Class {
	#name : #SymVariable,
	#superclass : #Symbolic,
	#instVars : [
		'name',
		'value'
	],
	#category : #'StCAD-Math-StMathFunctionSymbolic'
}

{ #category : #'binary storage' }
SymVariable class >> binaryReaderBlockForVersion: oldVersion format: oldFormat [ 
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
			new at: 1 put: (oldObj at: 4).
			new at: 2 put: (oldObj at: 1).
			oldObj become: new.
			oldObj changeClassToThatOf: inst]].
	^super binaryReaderBlockForVersion: oldVersion format: oldFormat
]

{ #category : #'binary storage' }
SymVariable class >> binaryRepresentationVersion [
	^30
]

{ #category : #'instance creation' }
SymVariable class >> name: symbol [ 
	^super new name: symbol
]

{ #category : #'VisualWorks metadata' }
SymVariable class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #comparing }
SymVariable >> = anObject [ 
	^self == anObject
]

{ #category : #copying }
SymVariable >> copy [
	"A SymVariable is unique."
	"Do nothing."
]

{ #category : #evaluating }
SymVariable >> expandUntil: set [ 
	"Do nothing."
]

{ #category : #accessing }
SymVariable >> name [
	^name
]

{ #category : #accessing }
SymVariable >> name: symbol [ 
	name := symbol asSymbol
]

{ #category : #evaluating }
SymVariable >> partialDifferentiateWRT: variable [ 
	^self == variable
		ifTrue: [Constant with: 1]
		ifFalse: [Constant with: 0]
]

{ #category : #printing }
SymVariable >> printOn: aStream [ 
	aStream print: self class.
	aStream nextPut: $'.
	aStream print: name.
	aStream nextPut: $'.
	aStream nextPut: $(.
	aStream print: value.
	aStream nextPut: $)
]

{ #category : #evaluating }
SymVariable >> simplifyUntil: set [ 
	"Do nothing."
]

{ #category : #changing }
SymVariable >> substitute: var1 with: var2 [ 
	^self == var1
		ifTrue: [var2]
		ifFalse: [self]
]

{ #category : #accessing }
SymVariable >> value [
	^value
]

{ #category : #accessing }
SymVariable >> value: arg [ 
	value := arg isReal
				ifTrue: [arg]
				ifFalse: [self error: 'Argument must be a constant.']
]

{ #category : #accessing }
SymVariable >> withUnits: argUnits [ 
	"Do nothing."
]
