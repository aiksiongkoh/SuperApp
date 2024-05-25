Class {
	#name : 'StMSum',
	#superclass : 'StMTermsFunction',
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'VisualWorks metadata' }
StMSum class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'instance creation' }
StMSum class >> with: arg1 minus: arg2 [

	| instance |
	instance := StMSum new.
	instance addTerm: arg1.
	instance addInverseTerm: arg2.
	^ instance
]

{ #category : 'instance creation' }
StMSum class >> with: arg1 plus: arg2 [ 
	^super with: arg1 with: arg2
]

{ #category : 'instance creation' }
StMSum class >> with: arg1 plus: arg2 plus: arg3 [ 
	^super
		with: arg1
		with: arg2
		with: arg3
]

{ #category : 'StCAD-UI' }
StMSum >> cadStringOn: aStream [

	terms isEmpty
		ifTrue: [
			inverseTerms isEmpty
				ifTrue: [ self halt: 'Check this' ]
				ifFalse: [
					aStream nextPutAll: '-('.
					1 to: inverseTerms size do: [ :i |
						i > 1 ifTrue: [ aStream nextPutAll: ' + ' ].
						(inverseTerms at: i) cadStringOn: aStream ].
					aStream nextPutAll: ')' ] ]
		ifFalse: [
			aStream nextPutAll: '('.
			inverseTerms isEmpty
				ifTrue: [
					1 to: terms size do: [ :i |
						i > 1 ifTrue: [ aStream nextPutAll: ' + ' ].
						(terms at: i) cadStringOn: aStream ] ]
				ifFalse: [
					1 to: terms size do: [ :i |
						i > 1 ifTrue: [ aStream nextPutAll: ' + ' ].
						(terms at: i) cadStringOn: aStream ].
					aStream nextPutAll: ') - ('.
					1 to: inverseTerms size do: [ :i |
						i > 1 ifTrue: [ aStream nextPutAll: ' + ' ].
						(inverseTerms at: i) cadStringOn: aStream ] ].
			aStream nextPutAll: ')' ]
]

{ #category : 'evaluating' }
StMSum >> differentiateWRT: variable [

	| termDerivatives invTermDerivatives |
	termDerivatives := terms collect: [ :term |
		                   term differentiateWRT: variable ].
	invTermDerivatives := inverseTerms collect: [ :term |
		                      term differentiateWRT: variable ].
	^ StMSum terms: termDerivatives inverseTerms: invTermDerivatives
]

{ #category : 'evaluating' }
StMSum >> expandUntil: set [
	"(a+b)+(c+d) + e*f + g = a + b + c + d + e*f + g"

	| term newTerms newInverseTerms newSize |
	^ (set includes: self)
		  ifTrue: [ self ]
		  ifFalse: [
			  newTerms := OrderedCollection new.
			  newInverseTerms := OrderedCollection new.
			  1 to: terms size do: [ :i |
				  term := (terms at: i) expandUntil: set.
				  term isSum
					  ifTrue: [ newTerms addAll: term terms ]
					  ifFalse: [ newTerms add: term ] ].
			  1 to: inverseTerms size do: [ :i |
				  term := (inverseTerms at: i) expandUntil: set.
				  term isSum
					  ifTrue: [ newInverseTerms addAll: term terms ]
					  ifFalse: [ newInverseTerms add: term ] ].
			  StMSum terms: newTerms inverseTerms: newInverseTerms ]
]

{ #category : 'testing' }
StMSum >> isSum [
	^true
]

{ #category : 'evaluating' }
StMSum >> partialDifferentiateWRT: variable [

	| termDerivatives invTermDerivatives |
	termDerivatives := terms collect: [ :term |
		                   term partialDifferentiateWRT: variable ].
	invTermDerivatives := inverseTerms collect: [ :term |
		                      term partialDifferentiateWRT: variable ].
	^ StMSum terms: termDerivatives inverseTerms: invTermDerivatives
]

{ #category : 'printing' }
StMSum >> printOn2: aStream [ 
	aStream nextPut: $(.
	terms ifNotNil: 
			[terms do: [:term | term printOn: aStream]
				separatedBy: [aStream nextPutAll: ' + ']].
	aStream nextPut: $)
]

{ #category : 'StCAD-UI' }
StMSum >> printOn: aStream [

	terms isEmpty
		ifTrue: [
			inverseTerms isEmpty
				ifTrue: [ self halt: 'Check this' ]
				ifFalse: [
					aStream nextPutAll: '-('.
					1 to: inverseTerms size do: [ :i |
						i > 1 ifTrue: [ aStream nextPutAll: ' + ' ].
						(inverseTerms at: i) printOn: aStream ].
					aStream nextPutAll: ')' ] ]
		ifFalse: [
			aStream nextPutAll: '('.
			inverseTerms isEmpty
				ifTrue: [
					1 to: terms size do: [ :i |
						i > 1 ifTrue: [ aStream nextPutAll: ' + ' ].
						(terms at: i) printOn: aStream ] ]
				ifFalse: [
					1 to: terms size do: [ :i |
						i > 1 ifTrue: [ aStream nextPutAll: ' + ' ].
						(terms at: i) printOn: aStream ].
					aStream nextPutAll: ') - ('.
					1 to: inverseTerms size do: [ :i |
						i > 1 ifTrue: [ aStream nextPutAll: ' + ' ].
						(inverseTerms at: i) printOn: aStream ] ].
			aStream nextPutAll: ')' ]
]

{ #category : 'evaluating' }
StMSum >> simplifyUntil: set [

	| newTerms newInverseTerms constant term newSize newInvSize |
	^ (set includes: self)
		  ifTrue: [ self ]
		  ifFalse: [
			  newTerms := OrderedCollection new.
			  newInverseTerms := OrderedCollection new.
			  constant := 0.0.
			  1 to: terms size do: [ :i |
				  term := (terms at: i) simplifyUntil: set.
				  term isConstant
					  ifTrue: [ constant := constant + term value ]
					  ifFalse: [
						  term negative
							  ifTrue: [
								  term isProduct
									  ifTrue: [ newInverseTerms add: term positiveProduct ]
									  ifFalse: [
										  term x isSum
											  ifTrue: [
												  newTerms addAll: term x inverseTerms.
												  newInverseTerms addAll: term x terms ]
											  ifFalse: [ newInverseTerms add: term x ] ] ]
							  ifFalse: [
								  term isSum
									  ifTrue: [
										  newTerms addAll: term terms.
										  newInverseTerms addAll: term inverseTerms ]
									  ifFalse: [ newTerms add: term ] ] ] ].
			  1 to: inverseTerms size do: [ :i |
				  term := (inverseTerms at: i) simplifyUntil: set.
				  term isConstant
					  ifTrue: [ constant := constant + term value ]
					  ifFalse: [
						  term negative
							  ifTrue: [ newTerms add: term x ]
							  ifFalse: [ newInverseTerms add: term ] ] ].
			  constant ~= 0 ifTrue: [
				  newTerms addFirst: (StMConstant with: constant) ].
			  newSize := newTerms size.
			  newInvSize := newInverseTerms size.
			  newSize == 0
				  ifTrue: [
					  newInvSize == 0
						  ifTrue: [ StMConstant with: 0.0 ]
						  ifFalse: [
							  newInvSize == 1
								  ifTrue: [ StMNegative with: newInverseTerms first ]
								  ifFalse: [ StMSum inverseTerms: newInverseTerms ] ] ]
				  ifFalse: [
					  (newSize == 1 and: [ newInvSize == 0 ])
						  ifTrue: [ newTerms first ]
						  ifFalse: [
						  StMSum terms: newTerms inverseTerms: newInverseTerms ] ] ]
]

{ #category : 'accessing' }
StMSum >> timesFunction: aFunction [ 
	^aFunction timesSum: self
]

{ #category : 'accessing' }
StMSum >> timesProduct: aProduct [ 
	^aProduct timesSum: self
]

{ #category : 'accessing' }
StMSum >> timesSum: aSum [
	"(a + b)*(A + B + C) = (a*A + a*B + a*C + b*A + b*B + b*C)"

	| answer sumTERMs termTERM sumInverseTERMs |
	answer := StMSum new.
	sumTERMs := aSum terms.
	sumInverseTERMs := aSum inverseTerms.
	terms do: [ :term |
		sumTERMs do: [ :sumTERM |
			termTERM := sumTERM isProduct
				            ifTrue: [ term timesProduct: sumTERM ]
				            ifFalse: [ term timesFunction: sumTERM ].
			answer addTerm: termTERM ].
		sumInverseTERMs do: [ :sumTERM |
			termTERM := sumTERM isProduct
				            ifTrue: [ term timesProduct: sumTERM ]
				            ifFalse: [ term timesFunction: sumTERM ].
			answer addInverseTerm: termTERM ] ].
	inverseTerms do: [ :term |
		sumTERMs do: [ :sumTERM |
			termTERM := sumTERM isProduct
				            ifTrue: [ term timesProduct: sumTERM ]
				            ifFalse: [ term timesFunction: sumTERM ].
			answer addInverseTerm: termTERM ].
		sumInverseTERMs do: [ :sumTERM |
			termTERM := sumTERM isProduct
				            ifTrue: [ term timesProduct: sumTERM ]
				            ifFalse: [ term timesFunction: sumTERM ].
			answer addTerm: termTERM ] ].
	^ answer
]

{ #category : 'evaluating' }
StMSum >> value [

	| answer |
	answer := 0.0.
	terms do: [ :term | answer := answer + term value ].
	inverseTerms do: [ :term | answer := answer - term value ].
	^ answer
]
