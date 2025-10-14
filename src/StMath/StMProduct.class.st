"
numerator and denominator terms do not store negatives and reciprocals terms.
""positive"" stores the sign of product.
"
Class {
	#name : 'StMProduct',
	#superclass : 'StMTermsFunction',
	#instVars : [
		'coeff',
		'numTerms',
		'denTerms'
	],
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'instance creation' }
StMProduct class >> coeff: number numTerms: numTrms [

	^ self
		  coeff: number
		  numTerms: numTrms
		  denTerms: OrderedCollection new
]

{ #category : 'instance creation' }
StMProduct class >> coeff: coeff numTerms: numTrms denTerms: denTrms [

	| numSize denSize |
	coeff isZero ifTrue: [ ^ StMConstant with: 0.0 ].
	numSize := numTrms size.
	denSize := denTrms size.
	^ numSize = 0
		  ifTrue: [
				  denSize = 0
					  ifTrue: [ StMConstant with: coeff ]
					  ifFalse: [
							  (denSize = 1 and: [ coeff isOne ])
								  ifTrue: [ StMReciprocal with: denTrms first ]
								  ifFalse: [
										  self new
											  coeff: coeff;
											  addDenTerms: denTrms;
											  yourself ] ] ]
		  ifFalse: [
				  denSize = 0
					  ifTrue: [
							  (numSize = 1 and: [ coeff isOne ])
								  ifTrue: [ numTrms first ]
								  ifFalse: [
										  self new
											  coeff: coeff;
											  addNumTerms: numTrms;
											  yourself ] ]
					  ifFalse: [
							  self new
								  coeff: coeff;
								  addNumTerms: numTrms;
								  addDenTerms: denTrms;
								  yourself ] ]
]

{ #category : 'accessing' }
StMProduct class >> denTerms: denTrms [

	^ self coeff: 1.0 numTerms: OrderedCollection new denTerms: denTrms
]

{ #category : 'accessing' }
StMProduct class >> numTerms: numTrms [

	^ self coeff: 1.0 numTerms: numTrms denTerms: OrderedCollection new
]

{ #category : 'VisualWorks metadata' }
StMProduct class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'instance creation' }
StMProduct class >> with: numerator over: denominator [

	^ self
		  coeff: 1.0
		  numTerms: (OrderedCollection with: numerator)
		  denTerms: (OrderedCollection with: denominator)
]

{ #category : 'instance creation' }
StMProduct class >> with: arg1 times: arg2 [

	^ self
		  coeff: 1.0
		  numTerms: (OrderedCollection with: arg1 with: arg2)
		  denTerms: OrderedCollection new
]

{ #category : 'comparing' }
StMProduct >> = anObject [

	| otherTerms otherInverseTerms |
	^ self == anObject or: [
			  self class == anObject class and: [
					  coeff = anObject coeff and: [
							  otherTerms := anObject numTerms.
							  numTerms size = otherTerms size and: [
									  (numTerms allSatisfy: [ :term | otherTerms includes: term ])
										  and: [
												  otherInverseTerms := anObject denTerms.
												  denTerms size = otherInverseTerms size and: [
													  denTerms allSatisfy: [ :term |
														  otherInverseTerms includes: term ] ] ] ] ] ] ]
]

{ #category : 'accessing' }
StMProduct >> addDenTerm: numTerm [

	numTerm isProduct
		ifTrue: [
				self coeff: coeff asNumber / numTerm coeff asNumber.
				self addNumTerms: numTerm denTerms.
				self addDenTerms: numTerm numTerms ]
		ifFalse: [
				numTerm isReciprocal
					ifTrue: [ self addNumTerm: numTerm x ]
					ifFalse: [
							numTerm isConstant
								ifTrue: [ self coeff: coeff asNumber / numTerm asNumber ]
								ifFalse: [
								numTerm isOne not ifTrue: [ denTerms add: numTerm ] ] ] ].
	^ numTerm
]

{ #category : 'accessing' }
StMProduct >> addDenTerms: collection [

	collection do: [ :term | self addDenTerm: term ].
	^ collection
]

{ #category : 'accessing' }
StMProduct >> addNumTerm: numTerm [

	numTerm isProduct
		ifTrue: [
				self coeff: coeff asNumber * numTerm coeff asNumber.
				self addNumTerms: numTerm numTerms.
				self addDenTerms: numTerm denTerms ]
		ifFalse: [
				numTerm isReciprocal
					ifTrue: [ self addDenTerm: numTerm x ]
					ifFalse: [
							numTerm isConstant
								ifTrue: [ self coeff: coeff asNumber * numTerm asNumber ]
								ifFalse: [
								numTerm isOne not ifTrue: [ numTerms add: numTerm ] ] ] ].
	^ numTerm
]

{ #category : 'accessing' }
StMProduct >> addNumTerms: collection [

	collection do: [ :term | self addNumTerm: term ].
	^ collection
]

{ #category : 'converting' }
StMProduct >> asNumber [

	| answer |
	answer := coeff asNumber.
	numTerms do: [ :term | answer := answer * term asNumber ].
	denTerms do: [ :term | answer := answer / term asNumber ].
	^ answer
]

{ #category : 'converting' }
StMProduct >> asValue [

	| answer |
	answer := coeff asValue.
	numTerms do: [ :term | answer := answer * term asValue ].
	denTerms do: [ :term | answer := answer / term asValue ].
	^ answer
]

{ #category : 'StCAD-UI' }
StMProduct >> cadStringOn: aStream [

	numTerms isEmpty
		ifTrue: [
			denTerms isEmpty
				ifTrue: [ aStream nextPutAll: '()/()' ]
				ifFalse: [
					aStream nextPutAll: '1.0'.
					aStream nextPutAll: '/('.
					1 to: denTerms size do: [ :i |
						i > 1 ifTrue: [ aStream nextPutAll: '*' ].
						(denTerms at: i) cadStringOn: aStream ].
					aStream nextPutAll: ')' ] ]
		ifFalse: [
			aStream nextPutAll: '('.
			denTerms isEmpty
				ifTrue: [
					1 to: numTerms size do: [ :i |
						i > 1 ifTrue: [ aStream nextPutAll: '*' ].
						(numTerms at: i) cadStringOn: aStream ] ]
				ifFalse: [
					1 to: numTerms size do: [ :i |
						i > 1 ifTrue: [ aStream nextPutAll: '*' ].
						(numTerms at: i) cadStringOn: aStream ].
					aStream nextPutAll: ')/('.
					1 to: denTerms size do: [ :i |
						i > 1 ifTrue: [ aStream nextPutAll: '*' ].
						(denTerms at: i) cadStringOn: aStream ] ].
			aStream nextPutAll: ')' ]
]

{ #category : 'accessing' }
StMProduct >> coeff [

	^ coeff
]

{ #category : 'accessing' }
StMProduct >> coeff: number [

	coeff := number asSymbolic
]

{ #category : 'simplify' }
StMProduct >> collectTerms: newTerms inverseTerms: newInvTerms [

	| bagTerms bagInvBag |
	bagTerms := newTerms asBag.
	bagInvBag := newInvTerms asBag.
	bagTerms keysAndValuesDo: [ :k :v |
		v > 1 ifTrue: [
			v timesRepeat: [ newTerms remove: k ].
			newTerms add: (StMPower with: k raisedTo: v) simplified ] ].
	bagInvBag keysAndValuesDo: [ :k :v |
		v > 1 ifTrue: [
			v timesRepeat: [ newInvTerms remove: k ].
			newInvTerms add: (StMPower with: k raisedTo: v) simplified ] ]
]

{ #category : 'ops' }
StMProduct >> copyWithNum: symbolic [
	"Do not call simplifyAll to avoid infinite loop."

	^ self class new
		  addNumTerms: numTerms;
		  addNumTerm: symbolic;
		  addDenTerms: denTerms;
		  yourself
]

{ #category : 'calc' }
StMProduct >> cosSq [
	self shouldBeImplemented.
]

{ #category : 'accessing' }
StMProduct >> denTerms [

	^ denTerms
]

{ #category : 'accessing' }
StMProduct >> denTerms: anObject [

	denTerms := anObject
]

{ #category : 'evaluating' }
StMProduct >> differentiateWRT: var [
	"Apply chain rule of differentiation."

	"(xyz)' := x'yz + xy'z + xyz'."

	"(a/b)' = a'/b - a*b'/b*b"

	^ var isSequenceable
		  ifTrue: [ var collect: [ :vari | self differentiateWRT: vari ] ]
		  ifFalse: [
				  | derivatives derivativeTerms derivative newTermFunctions newTerm block a b tempTerms ap bp apOverb abp bb abpOverbb |
				  block := [ :trms |
					           derivatives := trms collect: [ :term |
						                          term differentiateWRT: var ].
					           derivativeTerms := OrderedCollection new.
					           1 to: trms size do: [ :i |
							           derivative := derivatives at: i.
							           newTermFunctions := trms shallowCopy.
							           newTermFunctions at: i put: derivative.
							           newTerm := StMProduct new.
							           newTerm addNumTerms: newTermFunctions.
							           derivativeTerms add: newTerm ].
					           StMSum new
						           addPlusTerms: derivativeTerms;
						           yourself ].
				  a := self class new
					       coeff: coeff;
					       numTerms: numTerms;
					       yourself.
				  b := self class new
					       numTerms: denTerms;
					       yourself.
				  tempTerms := OrderedCollection with: coeff.
				  tempTerms addAll: numTerms.
				  ap := block value: tempTerms.
				  bp := block value: denTerms.
				  apOverb := ap / b.
				  abp := a * bp.
				  bb := b raisedTo: 2.
				  abpOverbb := abp / bb.
				  apOverb - abpOverbb ]
]

{ #category : 'evaluating' }
StMProduct >> expandUntil: set [
	"(a+b)*(c+d)*(e*f)*g = (a*c + a*d + b*c + b*d)*e*f*g"

	| sumTerms sumInverseTerms productTerms productInverseTerms sumOfProductsOfNumeratorSums numeratorFactor denominatorFactor sumOfProductsOfDenominatorSums numerator denominator tmpCoeff tmpTrms tmpInvTrms |
	self halt: 'Depreciated.'.
	^ (set includes: self)
		  ifTrue: [ self ]
		  ifFalse: [
				  tmpCoeff := coeff.
				  tmpTrms := numTerms copy.
				  tmpInvTrms := denTerms copy.
				  tmpTrms asArray do: [ :term |
						  term isProduct ifTrue: [
								  tmpCoeff := tmpCoeff * term coeff.
								  tmpTrms addAll: term numTerms.
								  tmpInvTrms addAll: term denTerms ] ].
				  tmpInvTrms asArray do: [ :term |
						  term isProduct ifTrue: [
								  tmpCoeff := tmpCoeff / term coeff.
								  tmpTrms addAll: term denTerms.
								  tmpInvTrms addAll: term numTerms ] ].
				  sumTerms := OrderedCollection new.
				  sumInverseTerms := OrderedCollection new.
				  productTerms := OrderedCollection new.
				  productInverseTerms := OrderedCollection new.
				  tmpTrms do: [ :arg |
						  | term |
						  term := arg expandUntil: set.
						  term isSum
							  ifTrue: [ sumTerms add: term ]
							  ifFalse: [
									  term isProduct
										  ifTrue: [
												  productTerms addAll: term numTerms.
												  productInverseTerms addAll: term denTerms ]
										  ifFalse: [
												  term isZero ifTrue: [ ^ StMConstant with: 0.0 ].
												  term isOne ifFalse: [ productTerms add: term ] ] ] ].
				  tmpInvTrms do: [ :arg |
						  | term |
						  term := arg expandUntil: set.
						  term isSum
							  ifTrue: [ sumInverseTerms add: term ]
							  ifFalse: [
									  term isProduct
										  ifTrue: [
												  productTerms addAll: term denTerms.
												  productInverseTerms addAll: term numTerms ]
										  ifFalse: [
												  term isZero ifTrue: [ self halt: 'Check this.' ].
												  term isOne ifFalse: [ productInverseTerms add: term ] ] ] ].
				  numeratorFactor := self class numTerms: productTerms.
				  denominatorFactor := self class denTerms: productInverseTerms.
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
				  tmpCoeff = 1.0 & denominator isOne
					  ifTrue: [ numerator ]
					  ifFalse: [
					  self class
						  coeff: tmpCoeff
						  numTerm: numerator
						  denTerm: denominator ] ]
]

{ #category : 'testing' }
StMProduct >> hasCosSq [

	| bagTerms bagInvBag |
	bagTerms := numTerms asBag.
	bagInvBag := denTerms asBag.
	bagTerms keysAndValuesDo: [ :k :v |
		k isCos ifTrue: [ v even ifTrue: [ ^ true ] ].
		k isPower ifTrue: [ k x isCos ifTrue: [ k y even ifTrue: [ ^ true ] ] ] ].
	bagInvBag keysAndValuesDo: [ :k :v |
		k isCos ifTrue: [ v even ifTrue: [ ^ true ] ].
		k isPower ifTrue: [ k x isCos ifTrue: [ k y even ifTrue: [ ^ true ] ] ] ].
	^ false
]

{ #category : 'comparing' }
StMProduct >> hasEqualFactors: anObject [

	| otherTerms otherInverseTerms |
	^ self == anObject or: [
			  self class == anObject class and: [
					  otherTerms := anObject numTerms.
					  numTerms size = otherTerms size and: [
							  (numTerms allSatisfy: [ :term | otherTerms includes: term ])
								  and: [
										  otherInverseTerms := anObject denTerms.
										  denTerms size = otherInverseTerms size and: [
											  denTerms allSatisfy: [ :term |
												  otherInverseTerms includes: term ] ] ] ] ] ]
]

{ #category : 'testing' }
StMProduct >> hasSinSq [

	| bagTerms bagInvBag |
	bagTerms := numTerms asBag.
	bagInvBag := denTerms asBag.
	bagTerms keysAndValuesDo: [ :k :v |
		k isSin ifTrue: [ v even ifTrue: [ ^ true ] ].
		k isPower ifTrue: [ k x isSin ifTrue: [ k y even ifTrue: [ ^ true ] ] ] ].
	bagInvBag keysAndValuesDo: [ :k :v |
		k isSin ifTrue: [ v even ifTrue: [ ^ true ] ].
		k isPower ifTrue: [ k x isSin ifTrue: [ k y even ifTrue: [ ^ true ] ] ] ].
	^ false
]

{ #category : 'comparing' }
StMProduct >> hash [

	| hash |
	hash := self class hash.
	hash := hash bitXor: coeff hash.
	numTerms do: [ :elem | hash := hash bitXor: elem hash ].
	denTerms do: [ :elem | hash := hash bitXor: elem hash ].
	^ hash
]

{ #category : 'initialization' }
StMProduct >> initialize [

	super initialize.
	numTerms := OrderedCollection new.
	denTerms := OrderedCollection new.
	coeff := 1.0 asSymbolic
]

{ #category : 'testing' }
StMProduct >> isNegative [

	^ coeff negative
]

{ #category : 'testing' }
StMProduct >> isOne [

	^ coeff isOne & numTerms isEmpty & denTerms isEmpty
]

{ #category : 'testing' }
StMProduct >> isProduct [
	^true
]

{ #category : 'testing' }
StMProduct >> isTrig [

	^ (numTerms anySatisfy: [ :trm | trm isTrig ]) or: [ denTerms anySatisfy: [ :trm | trm isTrig ] ]
]

{ #category : 'testing' }
StMProduct >> isZero [

	^ coeff isZero or: [ numTerms anySatisfy: [ :term | term isZero ] ]
]

{ #category : 'ops' }
StMProduct >> negated [

	^ self class
		  coeff: coeff negated
		  numTerms: numTerms
		  denTerms: denTerms
]

{ #category : 'testing' }
StMProduct >> negative [

	| neg |
	neg := false.
	numTerms do: [ :term | term negative ifTrue: [ neg := neg not ] ].
	denTerms do: [ :term | term negative ifTrue: [ neg := neg not ] ].
	^ neg
]

{ #category : 'ops' }
StMProduct >> negativeProduct [

	| newTerms newInverseTerms positiveProduct |
	newTerms := numTerms collect: [ :term |
			            term negative
				            ifTrue: [ term x ]
				            ifFalse: [ term ] ].
	newInverseTerms := denTerms collect: [ :term |
			                   term negative
				                   ifTrue: [ term x ]
				                   ifFalse: [ term ] ].
	positiveProduct := self class
		                   coeff: coeff
		                   numTerms: newTerms
		                   denTerms: newInverseTerms.
	^ StMNegative with: positiveProduct
]

{ #category : 'ops' }
StMProduct >> negativesRemoved [

	^ self negative
		  ifTrue: [ StMNegative with: self positiveProduct ]
		  ifFalse: [ self positiveProduct ]
]

{ #category : 'accessing' }
StMProduct >> numTerms [

	^ numTerms
]

{ #category : 'accessing' }
StMProduct >> numTerms: anObject [

	numTerms := anObject
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
				         newTerm := self class new.
				         newTerm addNumTerms: newTermFunctions.
				         derivativeTerms add: newTerm ].
		         derivativeTerms ].
	a := numTerms asArray.
	b := denTerms asArray.
	ap := block value: numTerms.
	bp := block value: denTerms.
	apOverb := self class coeff: coeff numTerms: ap denTerms: b.
	abp := a , bp.
	bb := (self class numTerms: b) raisedTo: 2.
	abpOverbb := self class new.
	abpOverbb addNumTerms: abp.
	abpOverbb addDenTerm: bb.
	^ apOverb - abpOverbb
]

{ #category : 'ops' }
StMProduct >> positiveProduct [

	^ self class coeff: coeff abs numTerms: numTerms denTerms: denTerms
]

{ #category : 'copying' }
StMProduct >> postCopy [

	numTerms := numTerms collect: [ :term | term copy ].
	denTerms := denTerms collect: [ :term | term copy ].
	coeff := coeff copy
]

{ #category : 'printing' }
StMProduct >> printOn: aStream [

	aStream
		nextPut: $(;
		print: coeff.
	numTerms do: [ :term |
		aStream
			nextPut: $*;
			print: term ].
	denTerms do: [ :term |
		aStream
			nextPut: $/;
			print: term ].
	aStream nextPut: $)
]

{ #category : 'evaluating' }
StMProduct >> simplifyConstant [

	| newCoeff newNumTerms newDenTerms |
	newCoeff := coeff.
	newNumTerms := numTerms collect: [ :trm | trm simplifyConstant ].
	newDenTerms := denTerms collect: [ :trm | trm simplifyConstant ].
	newNumTerms asArray do: [ :trm |
			trm isConstant ifTrue: [
					newCoeff := newCoeff * trm value.
					newNumTerms remove: trm ] ].
	newDenTerms asArray do: [ :trm |
			trm isConstant ifTrue: [
					newCoeff := newCoeff / trm value.
					newDenTerms remove: trm ] ].
	^ self class
		  coeff: newCoeff
		  numTerms: newNumTerms
		  denTerms: newDenTerms
]

{ #category : 'evaluating' }
StMProduct >> simplifyLogExp [

	| newNumTerms newDenTerms |
	newNumTerms := numTerms collect: [ :term | term simplifyLogExp ].
	newDenTerms := denTerms collect: [ :term | term simplifyLogExp ].
	^ self class coeff: coeff numTerms: newNumTerms denTerms: newDenTerms
]

{ #category : 'evaluating' }
StMProduct >> simplifyNegative [

	| newCoeff newNumTerms newDenTerms block |
	newCoeff := coeff.
	newNumTerms := numTerms collect: [ :trm | trm simplifyNegative ].
	newDenTerms := denTerms collect: [ :trm | trm simplifyNegative ].
	block := [ :trm |
		         trm isNegative
			         ifTrue: [
					         newCoeff := newCoeff negated.
					         trm negated ]
			         ifFalse: [ trm ] ].
	newNumTerms := newNumTerms collect: block.
	newDenTerms := newDenTerms collect: block.
	^ self class
		  coeff: newCoeff
		  numTerms: newNumTerms
		  denTerms: newDenTerms
]

{ #category : 'evaluating' }
StMProduct >> simplifyOne [

	| newNumTerms newDenTerms term |
	newNumTerms := OrderedCollection new.
	newDenTerms := OrderedCollection new.
	numTerms do: [ :trm |
			term := trm simplifyOne.
			term isOne ifFalse: [ newNumTerms add: term ] ].
	denTerms do: [ :trm |
			term := trm simplifyOne.
			term isOne ifFalse: [ newDenTerms add: term ] ].
	^ self class coeff: coeff numTerms: newNumTerms denTerms: newDenTerms
]

{ #category : 'evaluating' }
StMProduct >> simplifyPower [

	| newNumTerms newDenTerms |
	newNumTerms := numTerms collect: [ :term | term simplifyPower ].
	newDenTerms := denTerms collect: [ :term | term simplifyPower ].
	^ self class coeff: coeff numTerms: newNumTerms denTerms: newDenTerms
]

{ #category : 'evaluating' }
StMProduct >> simplifyProduct [

	| newCoeff block newNumTerms newDenTerms |
	"Cancellation"
	numTerms := numTerms collect: [ :trm | trm simplifyProduct ].
	denTerms := denTerms collect: [ :trm | trm simplifyProduct ].
	[
		numTerms , denTerms allSatisfy: [ :trm |
			trm isNegative not and: [ trm isReciprocal not ] ] ] assert.
	numTerms asArray do: [ :trm |
			(denTerms includes: trm) ifTrue: [
					numTerms remove: trm.
					denTerms remove: trm ] ].
	newCoeff := coeff.
	numTerms asArray do: [ :term |
			term isProduct ifTrue: [
					newCoeff := newCoeff * term coeff.
					numTerms addAll: term numTerms.
					denTerms addAll: term denTerms ] ].
	denTerms asArray do: [ :term |
			term isProduct ifTrue: [
					newCoeff := newCoeff / term coeff.
					numTerms addAll: term denTerms.
					denTerms addAll: term numTerms ] ].
	block := [ :trms |
		         | bag newTrms |
		         bag := trms asBag.
		         bag sortedCounts.
		         newTrms := OrderedCollection new.
		         bag keysAndValuesDo: [ :k :v |
				         v = 1
					         ifTrue: [ newTrms add: k ]
					         ifFalse: [ newTrms add: (StMPower with: k raisedTo: v) ] ].
		         newTrms ].
	newNumTerms := block value: numTerms.
	newDenTerms := block value: denTerms.
	^ self class coeff: coeff numTerms: newNumTerms denTerms: newDenTerms
]

{ #category : 'evaluating' }
StMProduct >> simplifyReciprocal [

	| newCoeff newNumTerms newDenTerms |
	newCoeff := coeff.
	newNumTerms := numTerms collect: [ :trm | trm simplifyReciprocal ].
	newDenTerms := denTerms collect: [ :trm | trm simplifyReciprocal ].
	newNumTerms asArray do: [ :trm |
			trm isReciprocal ifTrue: [
					newNumTerms remove: trm.
					newDenTerms add: trm reciprocal ] ].
	newDenTerms asArray do: [ :trm |
			trm isReciprocal ifTrue: [
					newDenTerms remove: trm.
					newNumTerms add: trm reciprocal ] ].
	^ self class
		  coeff: newCoeff
		  numTerms: newNumTerms
		  denTerms: newDenTerms
]

{ #category : 'evaluating' }
StMProduct >> simplifySum [
	"(a+b)*(c+d)*(e*f)*g = (a*c + a*d + b*c + b*d)*e*f*g"

	| newCoeff newNumTerms newDenTerms sumNumTerms sumDenTerms productNumTerms productDenTerms set numeratorFactor denominatorFactor sumOfProductsOfNumeratorSums sumOfProductsOfDenominatorSums numerator denominator |
	newCoeff := coeff.
	newNumTerms := numTerms collect: [ :term | term simplifySum ].
	newDenTerms := denTerms collect: [ :term | term simplifySum ].
	newNumTerms asArray do: [ :term |
			term isProduct ifTrue: [
					newCoeff := newCoeff * term coeff.
					newNumTerms addAll: term numTerms.
					newDenTerms addAll: term denTerms ] ].
	newDenTerms asArray do: [ :term |
			term isProduct ifTrue: [
					newCoeff := newCoeff / term coeff.
					newNumTerms addAll: term denTerms.
					newDenTerms addAll: term numTerms ] ].
	sumNumTerms := OrderedCollection new.
	sumDenTerms := OrderedCollection new.
	productNumTerms := OrderedCollection new.
	productDenTerms := OrderedCollection new.
	newNumTerms do: [ :term |
			term isSum
				ifTrue: [ sumNumTerms add: term ]
				ifFalse: [
						term isProduct
							ifTrue: [
									productNumTerms addAll: term numTerms.
									productDenTerms addAll: term denTerms ]
							ifFalse: [
									term isZero ifTrue: [ ^ StMConstant with: 0.0 ].
									term isOne ifFalse: [ productNumTerms add: term ] ] ] ].
	newDenTerms do: [ :term |
			term isSum
				ifTrue: [ sumDenTerms add: term ]
				ifFalse: [
						term isProduct
							ifTrue: [
									productNumTerms addAll: term denTerms.
									productDenTerms addAll: term numTerms ]
							ifFalse: [
									term isZero ifTrue: [ self halt: 'Check this.' ].
									term isOne ifFalse: [ productDenTerms add: term ] ] ] ].
	numeratorFactor := self class numTerms: productNumTerms.
	denominatorFactor := self class denTerms: productDenTerms.
	sumOfProductsOfNumeratorSums := StMSum with: 1.
	sumNumTerms do: [ :sumTerm |
			sumOfProductsOfNumeratorSums := sumOfProductsOfNumeratorSums
				                                timesSum: sumTerm ].
	sumOfProductsOfDenominatorSums := StMSum with: 1.
	sumDenTerms do: [ :sumTerm |
			sumOfProductsOfDenominatorSums := sumOfProductsOfDenominatorSums
				                                  timesSum: sumTerm ].
	numerator := numeratorFactor timesSum: sumOfProductsOfNumeratorSums.
	denominator := denominatorFactor timesSum:
		               sumOfProductsOfDenominatorSums.
	^ self class
		  coeff: newCoeff
		  numTerms: numerator
		  denTerms: denominator
]

{ #category : 'evaluating' }
StMProduct >> simplifyTrig [

	| newNumTerms newDenTerms |
	newNumTerms := numTerms collect: [ :term | term simplifyTrig ].
	newDenTerms := denTerms collect: [ :term | term simplifyTrig ].
	^ self class coeff: coeff numTerms: newNumTerms denTerms: newDenTerms
]

{ #category : 'evaluating' }
StMProduct >> simplifyUntil: set [

	| block newTerms newInverseTerms newSize newInvSize bagTerms bagInverseTerms tmpCoeff tmpTrms tmpInvTrms |
	^ (set includes: self)
		  ifTrue: [ self ]
		  ifFalse: [
				  tmpCoeff := coeff.
				  tmpTrms := numTerms copy.
				  tmpInvTrms := denTerms copy.
				  block := [ :term | term simplifyUntil: set ].
				  tmpTrms := tmpTrms collect: block.
				  tmpInvTrms := tmpInvTrms collect: block.
				  block := [ :term |
					           term isNegative
						           ifTrue: [
								           tmpCoeff := tmpCoeff negated.
								           term negated ]
						           ifFalse: [ term ] ].
				  tmpTrms := tmpTrms collect: block.
				  tmpInvTrms := tmpInvTrms collect: block.
				  tmpTrms asArray do: [ :term |
						  term isReciprocal ifTrue: [
								  tmpTrms remove: term.
								  tmpInvTrms add: term x ] ].
				  tmpInvTrms asArray do: [ :term |
						  term isReciprocal ifTrue: [
								  tmpInvTrms remove: term.
								  tmpTrms add: term x ] ].
				  tmpTrms asArray do: [ :term |
						  term isConstant ifTrue: [
								  tmpCoeff := tmpCoeff * term value.
								  tmpTrms remove: term ] ].
				  tmpInvTrms asArray do: [ :term |
						  term isConstant ifTrue: [
								  tmpCoeff := tmpCoeff / term value.
								  tmpInvTrms remove: term ] ].
				  tmpCoeff isZero ifTrue: [ ^ StMConstant with: 0.0 ].
				  tmpTrms asArray do: [ :term |
						  (tmpInvTrms includes: term) ifTrue: [ "Cancellation"
								  tmpTrms remove: term.
								  tmpInvTrms remove: term ] ].
				  bagTerms := tmpTrms asBag.
				  bagInverseTerms := tmpInvTrms asBag.
				  bagTerms sortedCounts.
				  bagInverseTerms sortedCounts.
				  newTerms := OrderedCollection new.
				  newInverseTerms := OrderedCollection new.
				  bagTerms keysAndValuesDo: [ :k :v |
						  v = 1
							  ifTrue: [ newTerms add: k ]
							  ifFalse: [
							  newTerms add:
								  ((StMPower with: k raisedTo: v) simplifyUntil: set) ] ].
				  bagInverseTerms keysAndValuesDo: [ :k :v |
						  v = 1
							  ifTrue: [ newInverseTerms add: k ]
							  ifFalse: [
									  newInverseTerms add:
										  ((StMPower with: k raisedTo: v) simplifyUntil: set) ] ].
				  newSize := newTerms size.
				  newInvSize := newInverseTerms size.
				  newSize == 0
					  ifTrue: [
							  newInvSize == 0
								  ifTrue: [ StMConstant with: tmpCoeff ]
								  ifFalse: [
										  newInvSize == 1
											  ifTrue: [ StMReciprocal with: (newInverseTerms at: 1) ]
											  ifFalse: [
													  self class
														  coeff: tmpCoeff
														  numTerms: newTerms
														  denTerms: newInverseTerms ] ] ]
					  ifFalse: [
							  (newSize == 1 and: [ newInvSize == 0 and: [ tmpCoeff = 1.0 ] ])
								  ifTrue: [ newTerms first ]
								  ifFalse: [
										  self class
											  coeff: tmpCoeff
											  numTerms: newTerms
											  denTerms: newInverseTerms ] ] ]
]

{ #category : 'evaluating' }
StMProduct >> simplifyZero [

	| newNumTerms newDenTerms newTerm |
	coeff isZero ifTrue: [ ^ StMConstant with: 0.0 ].
	numTerms := numTerms.
	denTerms := denTerms.
	newNumTerms := OrderedCollection new.
	newDenTerms := OrderedCollection new.
	numTerms do: [ :term |
			newTerm := term simplifyZero.
			newTerm isZero
				ifTrue: [ ^ StMConstant with: 0.0 ]
				ifFalse: [ newNumTerms add: newTerm ] ].
	denTerms do: [ :term |
			newTerm := term simplifyZero.
			newTerm isZero
				ifTrue: [ self halt: 'Check this.' ]
				ifFalse: [ newDenTerms add: newTerm ] ].
	^ self class coeff: coeff numTerms: newNumTerms denTerms: newDenTerms
]

{ #category : 'changing' }
StMProduct >> substitute: var1 with: var2 [

	| answer |
	answer := self class new.
	answer addNumTerms:
		(numTerms collect: [ :term | term substitute: var1 with: var2 ]).
	answer addDenTerms:
		(denTerms collect: [ :term | term substitute: var1 with: var2 ]).
	^ answer
]

{ #category : 'ops' }
StMProduct >> timesFunction: symbolic [

	^ self class new
		  addNumTerms: numTerms;
		  addNumTerm: symbolic;
		  addDenTerms: denTerms;
		  yourself
]

{ #category : 'accessing' }
StMProduct >> timesProduct: aProduct [

	| answer |
	answer := self class new.
	answer coeff: coeff asNumber * aProduct coeff asNumber.
	answer addNumTerms: numTerms , aProduct numTerms.
	answer addDenTerms: denTerms , aProduct denTerms.
	^ answer
]

{ #category : 'accessing' }
StMProduct >> timesSum: aSum [
	"(a*b*c)*(A + B + C) = (a*b*c*A + a*b*c*B + a*b*c*C)"

	| answer |
	[ aSum isSum ] assert.
	answer := StMSum new.
	answer addPlusTerm: (self times: aSum const).
	aSum plusTerms do: [ :term | answer addPlusTerm: (self times: term) ].
	aSum minusTerms do: [ :term |
		answer addMinusTerm: (self times: term) ].
	^ answer
]

{ #category : 'evaluating' }
StMProduct >> value [

	| answer |
	answer := 1.0.
	numTerms do: [ :term | answer := answer * term value ].
	denTerms do: [ :term | answer := answer / term value ].
	^ answer
]
