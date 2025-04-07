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
	instance addInverseTerms: invTrms.
	^ instance
]

{ #category : 'instance creation' }
StMTermsFunction class >> terms: trms [

	| instance |
	instance := self new.
	instance addTerms: trms.
	^ instance
]

{ #category : 'instance creation' }
StMTermsFunction class >> terms: trms inverseTerms: invTrms [

	| instance |
	instance := self new.
	instance addTerms: trms.
	instance addInverseTerms: invTrms.
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
	instance addTerm: (instance conditionArgument: arg1).
	^ instance
]

{ #category : 'instance creation' }
StMTermsFunction class >> with: arg1 with: arg2 [

	| instance |
	instance := self new.
	instance addTerm: (instance conditionArgument: arg1).
	instance addTerm: (instance conditionArgument: arg2).
	^ instance
]

{ #category : 'instance creation' }
StMTermsFunction class >> with: arg1 with: arg2 with: arg3 [

	| instance |
	instance := self new.
	instance addTerm: (instance conditionArgument: arg1).
	instance addTerm: (instance conditionArgument: arg2).
	instance addTerm: (instance conditionArgument: arg3).
	^ instance
]

{ #category : 'comparing' }
StMTermsFunction >> = anObject [

	self halt: 'Check this.'.
	^ super = anObject and: [ terms = anObject terms ]
]

{ #category : 'accessing' }
StMTermsFunction >> addInverseTerm: term [

	inverseTerms add: term.
	^ term
]

{ #category : 'accessing' }
StMTermsFunction >> addInverseTerms: collection [

	collection do: [ :term | self addInverseTerm: term ].
	^ collection
]

{ #category : 'accessing' }
StMTermsFunction >> addTerm: term [

	terms add: term.
	^ term
]

{ #category : 'accessing' }
StMTermsFunction >> addTerms: collection [

	collection do: [ :term | self addTerm: term ].
	^ collection
]

{ #category : 'message handling' }
StMTermsFunction >> argsPerform: selector withArguments: anArray [ 
	terms do: [:term | term perform: selector withArguments: anArray]
]

{ #category : 'simplify' }
StMTermsFunction >> cancelTerms: newTerms inverseTerms: newInvTerms [

	| commonTerms |
	commonTerms := newTerms select: [ :trm | newInvTerms includes: trm ].
	commonTerms do: [ :trm |
		newTerms remove: trm.
		newInvTerms remove: trm ]
]

{ #category : 'as yet unclassified' }
StMTermsFunction >> collectTerms: newTerms inverseTerms: newInvTerms [ 
	^ self subclassResponsibility
]

{ #category : 'comparing' }
StMTermsFunction >> hash [

	| hash |
	hash := self class hash.
	terms do: [ :elem | hash := hash bitXor: elem hash ].
	inverseTerms do: [ :elem | hash := hash bitXor: elem hash ].
	^ hash
]

{ #category : 'initialization' }
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

{ #category : 'as yet unclassified' }
StMTermsFunction >> simplifyUntil: set [ 
	^ self subclassResponsibility
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
	answer addTerms:
		(terms collect: [ :term | term substitute: var1 with: var2 ]).
	answer addInverseTerms:
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
