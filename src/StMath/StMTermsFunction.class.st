Class {
	#name : 'StMTermsFunction',
	#superclass : 'StMFunction',
	#instVars : [
		'terms',
		'inverseTerms'
	],
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'instance creation' }
StMTermsFunction class >> inverseTerms: invTrms [

	| instance |
	instance := self new.
	instance inverseTerms: invTrms.
	^ instance
]

{ #category : 'instance creation' }
StMTermsFunction class >> terms: trms [

	| instance |
	instance := self new.
	instance terms: trms.
	^ instance
]

{ #category : 'instance creation' }
StMTermsFunction class >> terms: trms inverseTerms: invTrms [

	| instance |
	instance := self new.
	instance terms: trms.
	instance inverseTerms: invTrms.
	^ instance
]

{ #category : 'VisualWorks metadata' }
StMTermsFunction class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'instance creation' }
StMTermsFunction class >> with: arg1 [ 
	| instance |
	instance := self new.
	instance terms add: (instance conditionArgument: arg1).
	^instance
]

{ #category : 'instance creation' }
StMTermsFunction class >> with: arg1 with: arg2 [ 
	| instance |
	instance := self new.
	instance terms add: (instance conditionArgument: arg1).
	instance terms add: (instance conditionArgument: arg2).
	^instance
]

{ #category : 'instance creation' }
StMTermsFunction class >> with: arg1 with: arg2 with: arg3 [ 
	| instance |
	instance := self new.
	instance terms add: (instance conditionArgument: arg1).
	instance terms add: (instance conditionArgument: arg2).
	instance terms add: (instance conditionArgument: arg3).
	^instance
]

{ #category : 'comparing' }
StMTermsFunction >> = anObject [ 
	^super = anObject and: [terms = anObject terms]
]

{ #category : 'accessing' }
StMTermsFunction >> addInverseTerm: term [

	inverseTerms add: term.
	^ term
]

{ #category : 'accessing' }
StMTermsFunction >> addInverseTerms: collection [

	inverseTerms addAll: collection.
	^ collection
]

{ #category : 'accessing' }
StMTermsFunction >> addTerm: term [

	terms add: term.
	^ term
]

{ #category : 'accessing' }
StMTermsFunction >> addTerms: collection [ 
	terms addAll: collection.
	^collection
]

{ #category : 'message handling' }
StMTermsFunction >> argsPerform: selector withArguments: anArray [ 
	terms do: [:term | term perform: selector withArguments: anArray]
]

{ #category : 'initialize-release' }
StMTermsFunction >> initialize [

	super initialize.
	terms := OrderedCollection new.
	inverseTerms := OrderedCollection new
]

{ #category : 'accessing' }
StMTermsFunction >> inverseTerms [

	^ inverseTerms
]

{ #category : 'accessing' }
StMTermsFunction >> inverseTerms: collection [

	inverseTerms addAll: collection
]

{ #category : 'copying' }
StMTermsFunction >> postCopy [

	terms := terms collect: [ :term |
		         | newTerm |
		         newTerm := term copy.
		         newTerm ].
	inverseTerms := inverseTerms collect: [ :term |
		                | newTerm |
		                newTerm := term copy.
		                newTerm ]
]

{ #category : 'printing' }
StMTermsFunction >> printOn1: aStream [ 
	aStream print: self class.
	aStream nextPutAll: '('.
	terms isNil ifFalse: [terms do: [:term | term printOn: aStream]
			separatedBy: [aStream space]].
	aStream nextPut: $)
]

{ #category : 'printing' }
StMTermsFunction >> printOn: aStream [ 
	aStream print: self class.
	aStream nextPutAll: '('.
	terms isNil ifFalse: [terms do: [:term | term printOn: aStream]
			separatedBy: [aStream space]].
	aStream nextPut: $)
]

{ #category : 'changing' }
StMTermsFunction >> substitute: var1 with1: var2 [ 
	terms := terms collect: [:term | term == var1
					ifTrue: [var2]
					ifFalse: [term substitute: var1 with: var2]]
]

{ #category : 'changing' }
StMTermsFunction >> substitute: var1 with: var2 [

	| answer |
	answer := self class new.
	answer terms:
		(terms collect: [ :term | term substitute: var1 with: var2 ]).
	answer inverseTerms:
		(inverseTerms collect: [ :term | term substitute: var1 with: var2 ]).
	^ answer
]

{ #category : 'accessing' }
StMTermsFunction >> terms [
	^terms
]

{ #category : 'accessing' }
StMTermsFunction >> terms: collection [

	terms addAll: collection
]
