"
Abstract class
"
Class {
	#name : 'StMVariable',
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
StMVariable class >> binaryReaderBlockForVersion: oldVersion format: oldFormat [ 
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

{ #category : 'binary storage' }
StMVariable class >> binaryRepresentationVersion [
	^30
]

{ #category : 'instance creation' }
StMVariable class >> name: symbol [ 
	^super new name: symbol
]

{ #category : 'VisualWorks metadata' }
StMVariable class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'comparing' }
StMVariable >> = anObject [ 
	^self == anObject
]

{ #category : 'converting' }
StMVariable >> asNumber [

	^ value asNumber
]

{ #category : 'converting' }
StMVariable >> asValue [

	^ value value
]

{ #category : 'copying' }
StMVariable >> copy [
	"A SymVariable is unique."
	"Do nothing."
]

{ #category : 'evaluating' }
StMVariable >> expandUntil: set [ 
	"Do nothing."
]

{ #category : 'comparing' }
StMVariable >> hash [

	^ self identityHash
]

{ #category : 'accessing' }
StMVariable >> name [
	^name
]

{ #category : 'accessing' }
StMVariable >> name: symbol [ 
	name := symbol asSymbol
]

{ #category : 'evaluating' }
StMVariable >> partialDifferentiateWRT: variable [ 
	^self == variable
		ifTrue: [StMConstant with: 1]
		ifFalse: [StMConstant with: 0]
]

{ #category : 'printing' }
StMVariable >> printOn: aStream [ 
	aStream print: self class.
	aStream nextPut: $'.
	aStream print: name.
	aStream nextPut: $'.
	aStream nextPut: $(.
	aStream print: value.
	aStream nextPut: $)
]

{ #category : 'evaluating' }
StMVariable >> simplifyUntil: set [ 
	"Do nothing."
]

{ #category : 'changing' }
StMVariable >> substitute: var1 with: var2 [ 
	^self == var1
		ifTrue: [var2]
		ifFalse: [self]
]

{ #category : 'accessing' }
StMVariable >> value [

	^ value ifNil: [ self ]
]

{ #category : 'accessing' }
StMVariable >> value: arg [

	value := arg
]

{ #category : 'accessing' }
StMVariable >> withUnits: argUnits [ 
	"Do nothing."
]
