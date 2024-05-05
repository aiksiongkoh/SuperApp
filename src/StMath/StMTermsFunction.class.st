Class {
	#name : #StMTermsFunction,
	#superclass : #StMFunction,
	#instVars : [
		'terms'
	],
	#category : #'StMath-Symbolic'
}

{ #category : #'VisualWorks metadata' }
StMTermsFunction class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #'instance creation' }
StMTermsFunction class >> with: arg1 [ 
	| instance |
	instance := self new.
	instance terms add: (instance conditionArgument: arg1).
	^instance
]

{ #category : #'instance creation' }
StMTermsFunction class >> with: arg1 with: arg2 [ 
	| instance |
	instance := self new.
	instance terms add: (instance conditionArgument: arg1).
	instance terms add: (instance conditionArgument: arg2).
	^instance
]

{ #category : #'instance creation' }
StMTermsFunction class >> with: arg1 with: arg2 with: arg3 [ 
	| instance |
	instance := self new.
	instance terms add: (instance conditionArgument: arg1).
	instance terms add: (instance conditionArgument: arg2).
	instance terms add: (instance conditionArgument: arg3).
	^instance
]

{ #category : #comparing }
StMTermsFunction >> = anObject [ 
	^super = anObject and: [terms = anObject terms]
]

{ #category : #accessing }
StMTermsFunction >> addTerm: term [ 
	terms add: term.
	^term
]

{ #category : #accessing }
StMTermsFunction >> addTerms: collection [ 
	terms addAll: collection.
	^collection
]

{ #category : #'message handling' }
StMTermsFunction >> argsPerform: selector withArguments: anArray [ 
	terms do: [:term | term perform: selector withArguments: anArray]
]

{ #category : #'initialize-release' }
StMTermsFunction >> initialize [
	super initialize.
	terms := OrderedCollection new
]

{ #category : #copying }
StMTermsFunction >> postCopy [
	terms := terms
				collect: 
					[:term | 
					| newTerm |
					newTerm := term copy.
					newTerm]
]

{ #category : #printing }
StMTermsFunction >> printOn1: aStream [ 
	aStream print: self class.
	aStream nextPutAll: '('.
	terms isNil ifFalse: [terms do: [:term | term printOn: aStream]
			separatedBy: [aStream space]].
	aStream nextPut: $)
]

{ #category : #printing }
StMTermsFunction >> printOn: aStream [ 
	aStream print: self class.
	aStream nextPutAll: '('.
	terms isNil ifFalse: [terms do: [:term | term printOn: aStream]
			separatedBy: [aStream space]].
	aStream nextPut: $)
]

{ #category : #changing }
StMTermsFunction >> substitute: var1 with1: var2 [ 
	terms := terms collect: [:term | term == var1
					ifTrue: [var2]
					ifFalse: [term substitute: var1 with: var2]]
]

{ #category : #changing }
StMTermsFunction >> substitute: var1 with: var2 [ 
	^self class new terms: (terms collect: [:term | term substitute: var1 with: var2])
]

{ #category : #accessing }
StMTermsFunction >> terms [
	^terms
]

{ #category : #accessing }
StMTermsFunction >> terms: collection [ 
	terms := collection
]
