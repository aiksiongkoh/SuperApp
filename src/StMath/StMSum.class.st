Class {
	#name : #StMSum,
	#superclass : #StMTermsFunction,
	#category : #'StMath-Symbolic'
}

{ #category : #'VisualWorks metadata' }
StMSum class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #'instance creation' }
StMSum class >> with: arg1 plus: arg2 [ 
	^super with: arg1 with: arg2
]

{ #category : #'instance creation' }
StMSum class >> with: arg1 plus: arg2 plus: arg3 [ 
	^super
		with: arg1
		with: arg2
		with: arg3
]

{ #category : #'StCAD-UI' }
StMSum >> cadStringOn: aStream [ 
	| nterms |
	nterms := terms size.
	nterms > 1 ifTrue: [aStream nextPut: $(].
	1 to: nterms
		do: 
			[:i | 
			i > 1 ifTrue: [aStream nextPutAll: ' + '].
			(terms at: i)
				cadStringOn: aStream].
	nterms > 1 ifTrue: [aStream nextPut: $)]
]

{ #category : #evaluating }
StMSum >> differentiateWRT: variable [ 
	| derivatives answer |
	derivatives := terms collect: [:term | term differentiateWRT: variable].
	answer := self class new.
	answer terms: derivatives.
	^answer
]

{ #category : #evaluating }
StMSum >> expandUntil: set [ 
	| stream term newTerms newSize |
	^(set includes: self)
		ifTrue: [self]
		ifFalse: 
			[stream := OrderedCollection new writeStream.
			1 to: terms size
				do: 
					[:i | 
					term := (terms at: i)
								expandUntil: set.
					term isSum
						ifTrue: [stream nextPutAll: term terms]
						ifFalse: [stream nextPut: term]].
			newTerms := stream contents.
			newSize := newTerms size.
			newSize == 0
				ifTrue: [StMConstant with: 0]
				ifFalse: [newSize == 1
						ifTrue: [newTerms at: 1]
						ifFalse: [(self class new) terms: newTerms; yourself]]]
]

{ #category : #testing }
StMSum >> isSum [
	^true
]

{ #category : #evaluating }
StMSum >> partialDifferentiateWRT: variable [ 
	| derivatives answer |
	derivatives := terms collect: [:term | term partialDifferentiateWRT: variable].
	answer := self class new.
	answer terms: derivatives.
	^answer
]

{ #category : #printing }
StMSum >> printOn2: aStream [ 
	aStream nextPut: $(.
	terms ifNotNil: 
			[terms do: [:term | term printOn: aStream]
				separatedBy: [aStream nextPutAll: ' + ']].
	aStream nextPut: $)
]

{ #category : #printing }
StMSum >> printOn: aStream [

	| n term |
	aStream nextPut: $(.
	terms ifNotNil: [
		n := terms size.
		1 to: n do: [ :i |
			term := terms at: i.
			term negative
				ifTrue: [
					i == 1
						ifTrue: [ term printOn: aStream ]
						ifFalse: [
							aStream nextPutAll: ' - '.
							term x printOn: aStream ] ]
				ifFalse: [
					i > 1 ifTrue: [ aStream nextPutAll: ' + ' ].
					term printOn: aStream ] ] ].
	aStream nextPut: $)
]

{ #category : #evaluating }
StMSum >> simplifyUntil: set [

	| newTerms constant term newSize |
	^ (set includes: self)
		  ifTrue: [ self ]
		  ifFalse: [
			  newTerms := OrderedCollection new.
			  constant := 0.0.
			  1 to: terms size do: [ :i |
				  term := (terms at: i) simplifyUntil: set.
				  term isConstant
					  ifTrue: [ constant := constant + term value ]
					  ifFalse: [
						  term negative
							  ifTrue: [ newTerms add: term ]
							  ifFalse: [ newTerms addFirst: term ] ] ].
			  constant ~= 0 ifTrue: [
				  newTerms addFirst: (StMConstant with: constant) ].
			  newSize := newTerms size.
			  newSize == 0
				  ifTrue: [ StMConstant with: 0 ]
				  ifFalse: [
					  newSize == 1
						  ifTrue: [ newTerms at: 1 ]
						  ifFalse: [
							  self class new
								  terms: newTerms;
								  yourself ] ] ]
]

{ #category : #accessing }
StMSum >> timesFunction: aFunction [ 
	^aFunction timesSum: self
]

{ #category : #accessing }
StMSum >> timesProduct: aProduct [ 
	^aProduct timesSum: self
]

{ #category : #accessing }
StMSum >> timesSum: aSum [ 
	"(a + b)*(A + B + C) = (a*A + a*B + a*C + b*A + b*B + b*C)"

	| answer sumTERMs termTERM |
	answer := StMSum new.
	sumTERMs := aSum terms.
	terms do: [:term | sumTERMs
			do: 
				[:sumTERM | 
				termTERM := sumTERM isProduct
							ifTrue: [term timesProduct: sumTERM]
							ifFalse: [term timesFunction: sumTERM].
				answer terms add: termTERM]].
	^answer
]

{ #category : #evaluating }
StMSum >> value [
	| answer |
	answer := 0.0.
	terms do: [:term | answer := answer + term value].
	^answer
]
