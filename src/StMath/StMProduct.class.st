Class {
	#name : 'StMProduct',
	#superclass : 'StMTermsFunction',
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'VisualWorks metadata' }
StMProduct class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'instance creation' }
StMProduct class >> with: numerator over: denominator [

	| instance |
	instance := StMProduct new.
	instance addTerm: numerator.
	instance addInverseTerm: denominator.
	^ instance
]

{ #category : 'instance creation' }
StMProduct class >> with: arg1 times: arg2 [ 
	^super with: arg1 with: arg2
]

{ #category : 'instance creation' }
StMProduct class >> with: arg1 times: arg2 times: arg3 [ 
	^super
		with: arg1
		with: arg2
		with: arg3
]

{ #category : 'StCAD-UI' }
StMProduct >> cadStringOn: aStream [

	terms isEmpty
		ifTrue: [
			inverseTerms isEmpty
				ifTrue: [ self halt: 'Check this' ]
				ifFalse: [
					aStream nextPutAll: '1.0'.
					aStream nextPutAll: '/('.
					1 to: inverseTerms size do: [ :i |
						i > 1 ifTrue: [ aStream nextPutAll: '*' ].
						(inverseTerms at: i) cadStringOn: aStream ].
					aStream nextPutAll: ')' ] ]
		ifFalse: [
			aStream nextPutAll: '('.
			inverseTerms isEmpty
				ifTrue: [
					1 to: terms size do: [ :i |
						i > 1 ifTrue: [ aStream nextPutAll: '*' ].
						(terms at: i) cadStringOn: aStream ] ]
				ifFalse: [
					1 to: terms size do: [ :i |
						i > 1 ifTrue: [ aStream nextPutAll: '*' ].
						(terms at: i) cadStringOn: aStream ].
					aStream nextPutAll: ')/('.
					1 to: inverseTerms size do: [ :i |
						i > 1 ifTrue: [ aStream nextPutAll: '*' ].
						(inverseTerms at: i) cadStringOn: aStream ] ].
			aStream nextPutAll: ')' ]
]

{ #category : 'evaluating' }
StMProduct >> differentiateWRT: variable [
	"Apply chain rule of differentiation."

	"(xyz)' := x'yz + xy'z + xyz'."

	"(a/b)' = a'/b - a*b'/b*b"

	| derivatives derivativeTerms derivative newTermFunctions newTerm block a b ap bp apOverb abp bb abpOverbb |
	self halt: 'Check this'.
	block := [ :trms |
	         derivatives := trms collect: [ :term |
		                        term differentiateWRT: variable ].
	         derivativeTerms := OrderedCollection new.
	         1 to: trms size do: [ :i |
		         derivative := derivatives at: i.
		         newTermFunctions := trms shallowCopy.
		         newTermFunctions at: i put: derivative.
		         newTerm := StMProduct new.
		         newTerm terms: newTermFunctions.
		         derivativeTerms add: newTerm ].
	         derivativeTerms ].
	a := terms shallowCopy.
	b := inverseTerms shallowCopy.
	ap := block value: terms.
	bp := block value: inverseTerms.
	apOverb := StMProduct terms: ap inverseTerms: b.
	abp := a , bp.
	bb := (StMProduct terms: b) raisedTo: 2.
	abpOverbb := StMProduct new.
	abpOverbb terms: abp.
	abpOverbb addInverseTerm: bb.
	^ apOverb - abpOverbb
]

{ #category : 'evaluating' }
StMProduct >> expandUntil: set [
	"(a+b)*(c+d)*(e*f)*g = (a*c + a*d + b*c + b*d)*e*f*g"

	| sumTerms sumInverseTerms productTerms productInverseTerms term sumOfProductsOfNumeratorSums numeratorFactor denominatorFactor sumOfProductsOfDenominatorSums numerator denominator |
	^ (set includes: self)
		  ifTrue: [ self ]
		  ifFalse: [
			  sumTerms := OrderedCollection new.
			  sumInverseTerms := OrderedCollection new.
			  productTerms := OrderedCollection new.
			  productInverseTerms := OrderedCollection new.
			  1 to: terms size do: [ :i |
				  term := (terms at: i) expandUntil: set.
				  term isSum
					  ifTrue: [ sumTerms add: term ]
					  ifFalse: [
						  term isProduct
							  ifTrue: [ productTerms addAll: term terms ]
							  ifFalse: [ productTerms add: term ] ] ].
			  1 to: inverseTerms size do: [ :i |
				  term := (inverseTerms at: i) expandUntil: set.
				  term isSum
					  ifTrue: [ sumInverseTerms add: term ]
					  ifFalse: [
						  term isProduct
							  ifTrue: [ productInverseTerms addAll: term terms ]
							  ifFalse: [ productInverseTerms add: term ] ] ].
			  numeratorFactor := StMProduct terms: productTerms.
			  denominatorFactor := StMProduct inverseTerms: productInverseTerms.
			  sumOfProductsOfNumeratorSums := StMSum with: 1.
			  sumTerms do: [ :sumTerm |
				  sumOfProductsOfNumeratorSums := sumOfProductsOfNumeratorSums
					                                  timesSum: sumTerm ].
			  sumOfProductsOfDenominatorSums := StMSum with: 1.
			  sumInverseTerms do: [ :sumTerm |
				  sumOfProductsOfDenominatorSums := sumOfProductsOfDenominatorSums
					                                    timesSum: sumTerm ].
			  numerator := numeratorFactor timesSum:
				               sumOfProductsOfNumeratorSums.
			  denominator := denominatorFactor timesSum:
				                 sumOfProductsOfDenominatorSums.
			  StMProduct with: numerator over: denominator ]
]

{ #category : 'testing' }
StMProduct >> isProduct [
	^true
]

{ #category : 'testing' }
StMProduct >> negative [

	| neg |
	neg := false.
	terms do: [ :term | term negative ifTrue: [ neg := neg not ] ].
	inverseTerms do: [ :term | term negative ifTrue: [ neg := neg not ] ].
	^ neg
]

{ #category : 'as yet unclassified' }
StMProduct >> negativeProduct [

	| newTerms newInverseTerms positiveProduct |
	newTerms := terms collect: [ :term |
		            term negative
			            ifTrue: [ term x ]
			            ifFalse: [ term ] ].
	newInverseTerms := inverseTerms collect: [ :term |
		                   term negative
			                   ifTrue: [ term x ]
			                   ifFalse: [ term ] ].
	positiveProduct := StMProduct
		                   terms: newTerms
		                   inverseTerms: newInverseTerms.
	^ StMNegative with: positiveProduct
]

{ #category : 'as yet unclassified' }
StMProduct >> negativesRemoved [

	^ self negative
		  ifTrue: [ StMNegative with: self positiveProduct ]
		  ifFalse: [ self positiveProduct ]
]

{ #category : 'evaluating' }
StMProduct >> partialDifferentiateWRT: variable [
	"Apply chain rule of differentiation."

	"(xyz)' := x'yz + xy'z + xyz'."

	"(a/b)' = a'/b - a*b'/b*b"

	| derivatives derivativeTerms derivative newTermFunctions newTerm block a b ap bp apOverb abp bb abpOverbb |
	self halt: 'Check this'.
	block := [ :trms |
	         derivatives := trms collect: [ :term |
		                        term partialDifferentiateWRT: variable ].
	         derivativeTerms := OrderedCollection new.
	         1 to: trms size do: [ :i |
		         derivative := derivatives at: i.
		         newTermFunctions := trms shallowCopy.
		         newTermFunctions at: i put: derivative.
		         newTerm := StMProduct new.
		         newTerm terms: newTermFunctions.
		         derivativeTerms add: newTerm ].
	         derivativeTerms ].
	a := terms shallowCopy.
	b := inverseTerms shallowCopy.
	ap := block value: terms.
	bp := block value: inverseTerms.
	apOverb := StMProduct terms: ap inverseTerms: b.
	abp := a , bp.
	bb := (StMProduct terms: b) raisedTo: 2.
	abpOverbb := StMProduct new.
	abpOverbb terms: abp.
	abpOverbb addInverseTerm: bb.
	^ apOverb - abpOverbb
]

{ #category : 'as yet unclassified' }
StMProduct >> positiveProduct [

	| newTerms newInverseTerms |
	newTerms := terms collect: [ :term |
		            term negative
			            ifTrue: [ term x ]
			            ifFalse: [ term ] ].
	newInverseTerms := inverseTerms collect: [ :term |
		                   term negative
			                   ifTrue: [ term x ]
			                   ifFalse: [ term ] ].
	^ StMProduct terms: newTerms inverseTerms: newInverseTerms
]

{ #category : 'StCAD-UI' }
StMProduct >> printOn: aStream [

	terms isEmpty
		ifTrue: [
			inverseTerms isEmpty
				ifTrue: [ aStream nextPutAll: '()/()' ]
				ifFalse: [
					aStream nextPutAll: '1.0'.
					aStream nextPutAll: '/('.
					1 to: inverseTerms size do: [ :i |
						i > 1 ifTrue: [ aStream nextPutAll: '*' ].
						(inverseTerms at: i) printOn: aStream ].
					aStream nextPutAll: ')' ] ]
		ifFalse: [
			aStream nextPutAll: '('.
			inverseTerms isEmpty
				ifTrue: [
					1 to: terms size do: [ :i |
						i > 1 ifTrue: [ aStream nextPutAll: '*' ].
						(terms at: i) printOn: aStream ] ]
				ifFalse: [
					1 to: terms size do: [ :i |
						i > 1 ifTrue: [ aStream nextPutAll: '*' ].
						(terms at: i) printOn: aStream ].
					aStream nextPutAll: ')/('.
					1 to: inverseTerms size do: [ :i |
						i > 1 ifTrue: [ aStream nextPutAll: '*' ].
						(inverseTerms at: i) printOn: aStream ] ].
			aStream nextPutAll: ')' ]
]

{ #category : 'evaluating' }
StMProduct >> simplifyUntil: set [

	| newTerms newInverseTerms factor term newSize newInvSize |
	^ (set includes: self)
		  ifTrue: [ self ]
		  ifFalse: [
			  newTerms := OrderedCollection new.
			  newInverseTerms := OrderedCollection new.
			  factor := 1.0.
			  1 to: terms size do: [ :i |
				  term := (terms at: i) simplifyUntil: set.
				  term isConstant
					  ifTrue: [ factor := factor * term value ]
					  ifFalse: [
						  term isReciprocal
							  ifTrue: [
								  term x isProduct
									  ifTrue: [
										  newInverseTerms addAll: term x terms.
										  newTerms addAll: term x inverseTerms ]
									  ifFalse: [ newInverseTerms add: term x ] ]
							  ifFalse: [
								  term isProduct
									  ifTrue: [
										  newTerms addAll: term terms.
										  newInverseTerms addAll: term inverseTerms ]
									  ifFalse: [ newTerms add: term ] ] ] ].
			  1 to: inverseTerms size do: [ :i |
				  term := (inverseTerms at: i) simplifyUntil: set.
				  term isConstant
					  ifTrue: [ factor := factor / term value ]
					  ifFalse: [
						  term isReciprocal
							  ifTrue: [ newTerms add: term x ]
							  ifFalse: [ newInverseTerms add: term ] ] ].
			  factor = 0
				  ifTrue: [ StMConstant with: 0 ]
				  ifFalse: [
					  factor ~= 1 ifTrue: [
						  newTerms addFirst: (StMConstant with: factor) ].
					  newSize := newTerms size.
					  newInvSize := newInverseTerms size.
					  newSize == 0
						  ifTrue: [
							  newInvSize == 0
								  ifTrue: [ StMConstant with: 1.0 ]
								  ifFalse: [
									  newInvSize == 1
										  ifTrue: [ StMReciprocal with: (newInverseTerms at: 1) ]
										  ifFalse: [
										  (StMProduct inverseTerms: newInverseTerms)
											  negativesRemoved ] ] ]
						  ifFalse: [
							  (newSize == 1 and: [ newInvSize == 0 ])
								  ifTrue: [ newTerms first ]
								  ifFalse: [
									  (StMProduct terms: newTerms inverseTerms: newInverseTerms)
										  negativesRemoved ] ] ] ]
]

{ #category : 'accessing' }
StMProduct >> timesFunction: aFunction [

	| answer |
	answer := self copy.
	answer addTerm: aFunction copy.
	^ answer
]

{ #category : 'accessing' }
StMProduct >> timesProduct: aProduct [

	| answer |
	answer := self copy.
	answer addTerms: aProduct copy terms.
	answer addInverseTerms: aProduct copy inverseTerms.
	^ answer
]

{ #category : 'accessing' }
StMProduct >> timesSum: aSum [
	"(a*b*c)*(A + B + C) = (a*b*c*A + a*b*c*B + a*b*c*C)"

	| answer sumTERMs termTERM sumInverseTERMs |
	answer := StMSum new.
	sumTERMs := aSum terms.
	sumInverseTERMs := aSum inverseTerms.
	sumTERMs do: [ :sumTERM |
		termTERM := sumTERM isProduct
			            ifTrue: [ self timesProduct: sumTERM ]
			            ifFalse: [ self timesFunction: sumTERM ].
		answer addTerm: termTERM ].
	sumInverseTERMs do: [ :sumTERM |
		termTERM := sumTERM isProduct
			            ifTrue: [ self timesProduct: sumTERM ]
			            ifFalse: [ self timesFunction: sumTERM ].
		answer addInverseTerm: termTERM ].
	^ answer
]

{ #category : 'evaluating' }
StMProduct >> value [

	| answer |
	answer := 1.0.
	terms do: [ :term | answer := answer * term value ].
	inverseTerms do: [ :term | answer := answer / term value ].
	^ answer
]
