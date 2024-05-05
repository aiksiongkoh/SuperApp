Class {
	#name : #StMProduct,
	#superclass : #StMTermsFunction,
	#category : #'StMath-Symbolic'
}

{ #category : #'VisualWorks metadata' }
StMProduct class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #'instance creation' }
StMProduct class >> with: arg1 times: arg2 [ 
	^super with: arg1 with: arg2
]

{ #category : #'instance creation' }
StMProduct class >> with: arg1 times: arg2 times: arg3 [ 
	^super
		with: arg1
		with: arg2
		with: arg3
]

{ #category : #'StCAD-UI' }
StMProduct >> cadStringOn: aStream [ 
	1 to: terms size
		do: 
			[:i | 
			i > 1 ifTrue: [aStream nextPutAll: '*'].
			(terms at: i)
				cadStringOn: aStream]
]

{ #category : #evaluating }
StMProduct >> differentiateWRT: variable [ 
	"Apply chain rule of differentiation."
	"(xyz)' := x'yz + xy'z + xyz'."

	| derivatives derivativeTerms derivative newTermFunctions newTerm answer |
	derivatives := terms collect: [:term | term differentiateWRT: variable].
	derivativeTerms := OrderedCollection new.
	1 to: terms size
		do: 
			[:i | 
			derivative := derivatives at: i.
			newTermFunctions := terms shallowCopy.
			newTermFunctions at: i put: derivative.
			newTerm := StMProduct new.
			newTerm terms: newTermFunctions.
			derivativeTerms add: newTerm].
	answer := StMSum new.
	answer terms: derivativeTerms.
	^answer
]

{ #category : #evaluating }
StMProduct >> expandUntil: set [ 
	| sumTerms stream term sumOfProductsOfSums factor |
	^(set includes: self)
		ifTrue: [self]
		ifFalse: 
			[sumTerms := OrderedCollection new.
			stream := OrderedCollection new writeStream.
			1 to: terms size
				do: 
					[:i | 
					term := (terms at: i)
								expandUntil: set.
					term isSum
						ifTrue: [sumTerms add: term]
						ifFalse: [term isProduct
								ifTrue: [stream nextPutAll: term terms]
								ifFalse: [stream nextPut: term]]].
			factor := StMProduct new.
			factor terms: stream contents.
			sumOfProductsOfSums := StMSum with: 1.
			sumTerms do: [:sumTerm | sumOfProductsOfSums := sumOfProductsOfSums timesSum: sumTerm].
			factor timesSum: sumOfProductsOfSums]
]

{ #category : #testing }
StMProduct >> isProduct [
	^true
]

{ #category : #evaluating }
StMProduct >> partialDifferentiateWRT: variable [ 
	"Apply chain rule of differentiation."
	"(xyz)' := x'yz + xy'z + xyz'."

	| derivatives derivativeTerms derivative newTermFunctions newTerm answer |
	derivatives := terms collect: [:term | term partialDifferentiateWRT: variable].
	derivativeTerms := OrderedCollection new.
	1 to: terms size
		do: 
			[:i | 
			derivative := derivatives at: i.
			newTermFunctions := terms shallowCopy.
			newTermFunctions at: i put: derivative.
			newTerm := StMProduct new.
			newTerm terms: newTermFunctions.
			derivativeTerms add: newTerm].
	answer := StMSum new.
	answer terms: derivativeTerms.
	^answer
]

{ #category : #printing }
StMProduct >> printOn: aStream [

	| term numerators denominators |
	terms ifNotNil: [
		numerators := terms select: [ :trm | trm isReciprocal not ].
		denominators := terms select: [ :trm | trm isReciprocal ].
		denominators isEmpty
			ifTrue: [
				aStream nextPut: $(.
				1 to: numerators size do: [ :i |
					term := numerators at: i.
					i > 1 ifTrue: [ aStream nextPut: $* ].
					term printOn: aStream ].
				aStream nextPut: $) ]
			ifFalse: [
				aStream nextPut: $(.
				1 to: numerators size do: [ :i |
					term := numerators at: i.
					i > 1 ifTrue: [ aStream nextPut: $* ].
					term printOn: aStream ].
				aStream nextPutAll: ') / ('.
				1 to: denominators size do: [ :i |
					term := denominators at: i.
					i > 1 ifTrue: [ aStream nextPut: $* ].
					term x printOn: aStream ].
				aStream nextPut: $) ] ]
]

{ #category : #evaluating }
StMProduct >> simplifyUntil: set [

	| newTerms factor term newSize |
	^ (set includes: self)
		  ifTrue: [ self ]
		  ifFalse: [
			  newTerms := OrderedCollection new.
			  factor := 1.0.
			  1 to: terms size do: [ :i |
				  term := (terms at: i) simplifyUntil: set.
				  term isConstant
					  ifTrue: [ factor := factor * term value ]
					  ifFalse: [
						  term isReciprocal
							  ifTrue: [ newTerms add: term ]
							  ifFalse: [ newTerms addFirst: term ] ] ].
			  factor = 0
				  ifTrue: [ StMConstant with: 0 ]
				  ifFalse: [
					  factor ~= 1 ifTrue: [
						  newTerms addFirst: (StMConstant with: factor) ].
					  newSize := newTerms size.
					  newSize == 0
						  ifTrue: [ StMConstant with: 1 ]
						  ifFalse: [
							  newSize == 1
								  ifTrue: [ newTerms at: 1 ]
								  ifFalse: [
									  self class new
										  terms: newTerms;
										  yourself ] ] ] ]
]

{ #category : #accessing }
StMProduct >> timesFunction: aFunction [ 
	| answer |
	answer := self copy.
	answer terms add: aFunction copy.
	^answer
]

{ #category : #accessing }
StMProduct >> timesProduct: aProduct [ 
	| answer |
	answer := self copy.
	answer terms addAll: aProduct copy terms.
	^answer
]

{ #category : #accessing }
StMProduct >> timesSum: aSum [ 
	"(a*b*c)*(A + B + C) = (a*b*c*A + a*b*c*B + a*b*c*C)"

	| answer sumTERMs termTERM |
	answer := StMSum new.
	sumTERMs := aSum terms.
	sumTERMs
		do: 
			[:sumTERM | 
			termTERM := sumTERM isProduct
						ifTrue: [self timesProduct: sumTERM]
						ifFalse: [self timesFunction: sumTERM].
			answer terms add: termTERM].
	^answer
]

{ #category : #evaluating }
StMProduct >> value [
	| answer |
	answer := 1.0.
	terms do: [:term | answer := answer * term value].
	^answer
]
