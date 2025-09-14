"
numerator and denominator terms do not store negatives and reciprocals terms.
""positive"" stores the sign of product.
"
Class {
	#name : 'StMProduct',
	#superclass : 'StMTermsFunction',
	#instVars : [
		'coeff'
	],
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'instance creation' }
StMProduct class >> coeff: num terms: trms [

	^ self new
		  coeff: num;
		  addTerms: trms;
		  yourself
]

{ #category : 'instance creation' }
StMProduct class >> coeff: num terms: trms inverseTerms: invTrms [

	^ self new
		  coeff: num;
		  addTerms: trms;
		  addInverseTerms: invTrms;
		  yourself
]

{ #category : 'instance creation' }
StMProduct class >> coeff: float with: numerator over: denominator [

	^ self new
		  coeff: float;
		  addTerm: numerator;
		  addInverseTerm: denominator;
		  yourself
]

{ #category : 'as yet unclassified' }
StMProduct class >> terms: trms inverseTerms: invTrms [

	| instance ntrm ninvTrm |
	ntrm := trms size.
	ninvTrm := invTrms size.
	^ ntrm = 0
		  ifTrue: [
			  ninvTrm = 0
				  ifTrue: [ StMConstant with: 1.0 ]
				  ifFalse: [
					  ninvTrm = 1
						  ifTrue: [ StMReciprocal with: invTrms first ]
						  ifFalse: [
							  instance := self new.
							  instance addInverseTerms: invTrms.
							  instance ] ] ]
		  ifFalse: [
			  ninvTrm = 0
				  ifTrue: [
					  ntrm = 1
						  ifTrue: [ trms first ]
						  ifFalse: [
							  instance := self new.
							  instance addTerms: trms.
							  instance ] ]
				  ifFalse: [
					  instance := self new.
					  instance addTerms: trms.
					  instance addInverseTerms: invTrms.
					  instance ] ]
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

	^ self new
		  addTerm: numerator;
		  addInverseTerm: denominator;
		  yourself
]

{ #category : 'instance creation' }
StMProduct class >> with: arg1 times: arg2 [

	^ super with: arg1 with: arg2
]

{ #category : 'instance creation' }
StMProduct class >> with: arg1 times: arg2 times: arg3 [

	^ super with: arg1 with: arg2 with: arg3
]

{ #category : 'comparing' }
StMProduct >> = anObject [

	| otherTerms otherInverseTerms |
	^ self == anObject or: [
		  self class == anObject class and: [
			  self coeff = anObject coeff and: [
				  otherTerms := anObject terms.
				  terms size = otherTerms size and: [
					  (terms allSatisfy: [ :term | otherTerms includes: term ]) and: [
						  otherInverseTerms := anObject inverseTerms.
						  inverseTerms size = otherInverseTerms size and: [
							  inverseTerms allSatisfy: [ :term | otherInverseTerms includes: term ] ] ] ] ] ] ]
]

{ #category : 'accessing' }
StMProduct >> addInverseTerm: term [

	term isProduct
		ifTrue: [
			self coeff: self coeff / term coeff.
			self addTerms: term inverseTerms.
			self addInverseTerms: term terms ]
		ifFalse: [
			term isReciprocal
				ifTrue: [ self addTerm: term x ]
				ifFalse: [ term isOne ifFalse: [ inverseTerms add: term copy ] ] ].
	^ term
]

{ #category : 'accessing' }
StMProduct >> addTerm: term [

	term isProduct
		ifTrue: [
			self coeff: self coeff * term coeff.
			self addTerms: term terms.
			self addInverseTerms: term inverseTerms ]
		ifFalse: [
			term isReciprocal
				ifTrue: [ self addInverseTerm: term x ]
				ifFalse: [ term isOne ifFalse: [ terms add: term copy ] ] ].
	^ term
]

{ #category : 'converting' }
StMProduct >> asNumber [

	| answer |
	answer := coeff.
	terms do: [ :term | answer := answer * term asNumber ].
	inverseTerms do: [ :term | answer := answer / term asNumber ].
	^ answer
]

{ #category : 'converting' }
StMProduct >> asValue [

	| answer |
	answer := coeff.
	terms do: [ :term | answer := answer * term asValue ].
	inverseTerms do: [ :term | answer := answer / term asValue ].
	^ answer
]

{ #category : 'StCAD-UI' }
StMProduct >> cadStringOn: aStream [

	terms isEmpty
		ifTrue: [
			inverseTerms isEmpty
				ifTrue: [ aStream nextPutAll: '()/()' ]
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

{ #category : 'accessing' }
StMProduct >> coeff [

	^ coeff
]

{ #category : 'accessing' }
StMProduct >> coeff: anObject [

	coeff := anObject
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

{ #category : 'calc' }
StMProduct >> cosSq [
	self shouldBeImplemented.
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
							           newTermFunctions := trms copy.
							           newTermFunctions at: i put: derivative.
							           newTerm := StMProduct new.
							           newTerm addTerms: newTermFunctions.
							           derivativeTerms add: newTerm simplified ].
					           (StMSum terms: derivativeTerms) simplified ].
				  a := (StMProduct coeff: coeff terms: terms) simplified.
				  b := (StMProduct terms: inverseTerms) simplified.
				  tempTerms := OrderedCollection with: (StMConstant with: coeff).
				  tempTerms addAll: terms.
				  ap := block value: tempTerms.
				  bp := block value: inverseTerms.
				  apOverb := (ap / b) simplified.
				  abp := (a * bp) simplified.
				  bb := b raisedTo: 2.
				  abpOverbb := (abp / bb) simplified.
				  (apOverb - abpOverbb) simplified ]
]

{ #category : 'evaluating' }
StMProduct >> expandUntil: set [
	"(a+b)*(c+d)*(e*f)*g = (a*c + a*d + b*c + b*d)*e*f*g"

	| sumTerms sumInverseTerms productTerms productInverseTerms sumOfProductsOfNumeratorSums numeratorFactor denominatorFactor sumOfProductsOfDenominatorSums numerator denominator tmpCoeff tmpTrms tmpInvTrms |
	^ (set includes: self)
		  ifTrue: [ self ]
		  ifFalse: [
				  tmpCoeff := coeff.
				  tmpTrms := terms copy.
				  tmpInvTrms := inverseTerms copy.
				  tmpTrms asArray do: [ :term |
						  term isProduct ifTrue: [
								  tmpCoeff := tmpCoeff * term coeff.
								  tmpTrms addAll: term terms.
								  tmpInvTrms addAll: term inverseTerms ] ].
				  tmpInvTrms asArray do: [ :term |
						  term isProduct ifTrue: [
								  tmpCoeff := tmpCoeff / term coeff.
								  tmpTrms addAll: term inverseTerms.
								  tmpInvTrms addAll: term terms ] ].
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
												  productTerms addAll: term terms.
												  productInverseTerms addAll: term inverseTerms ]
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
												  productTerms addAll: term inverseTerms.
												  productInverseTerms addAll: term terms ]
										  ifFalse: [
												  term isZero ifTrue: [ self halt: 'Check this.' ].
												  term isOne ifFalse: [ productInverseTerms add: term ] ] ] ].
				  numeratorFactor := self class terms: productTerms.
				  denominatorFactor := self class inverseTerms:
					                       productInverseTerms.
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
					  self class coeff: tmpCoeff with: numerator over: denominator ] ]
]

{ #category : 'testing' }
StMProduct >> hasCosSq [

	| bagTerms bagInvBag |
	bagTerms := terms asBag.
	bagInvBag := inverseTerms asBag.
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
					  otherTerms := anObject terms.
					  terms size = otherTerms size and: [
							  (terms allSatisfy: [ :term | otherTerms includes: term ])
								  and: [
										  otherInverseTerms := anObject inverseTerms.
										  inverseTerms size = otherInverseTerms size and: [
											  inverseTerms allSatisfy: [ :term |
												  otherInverseTerms includes: term ] ] ] ] ] ]
]

{ #category : 'testing' }
StMProduct >> hasSinSq [

	| bagTerms bagInvBag |
	bagTerms := terms asBag.
	bagInvBag := inverseTerms asBag.
	bagTerms keysAndValuesDo: [ :k :v |
		k isSin ifTrue: [ v even ifTrue: [ ^ true ] ].
		k isPower ifTrue: [ k x isSin ifTrue: [ k y even ifTrue: [ ^ true ] ] ] ].
	bagInvBag keysAndValuesDo: [ :k :v |
		k isSin ifTrue: [ v even ifTrue: [ ^ true ] ].
		k isPower ifTrue: [ k x isSin ifTrue: [ k y even ifTrue: [ ^ true ] ] ] ].
	^ false
]

{ #category : 'initialization' }
StMProduct >> initialize [

	super initialize.
	coeff := 1.0
]

{ #category : 'testing' }
StMProduct >> isNegative [

	^ coeff negative
]

{ #category : 'testing' }
StMProduct >> isOne [

	^ coeff = 1.0 & terms isEmpty & inverseTerms isEmpty
]

{ #category : 'testing' }
StMProduct >> isProduct [
	^true
]

{ #category : 'testing' }
StMProduct >> isTrig [

	^ (terms anySatisfy: [ :trm | trm isTrig ]) or: [ inverseTerms anySatisfy: [ :trm | trm isTrig ] ]
]

{ #category : 'testing' }
StMProduct >> isZero [

	^ coeff isZero or: [ terms anySatisfy: [ :term | term isZero ] ]
]

{ #category : 'ops' }
StMProduct >> negated [

	| answer |
	answer := self copy.
	answer coeff: answer coeff negated.
	^ answer simplified
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
	         derivatives := trms collect: [ :term | term partialDifferentiateWRT: variable ].
	         derivativeTerms := OrderedCollection new.
	         1 to: trms size do: [ :i |
		         derivative := derivatives at: i.
		         newTermFunctions := trms shallowCopy.
		         newTermFunctions at: i put: derivative.
		         newTerm := self class new.
		         newTerm addTerms: newTermFunctions.
		         derivativeTerms add: newTerm ].
	         derivativeTerms ].
	a := terms asArray.
	b := inverseTerms asArray.
	ap := block value: terms.
	bp := block value: inverseTerms.
	apOverb := self class terms: ap inverseTerms: b.
	abp := a , bp.
	bb := (self class terms: b) raisedTo: 2.
	abpOverbb := self class new.
	abpOverbb addTerms: abp.
	abpOverbb addInverseTerm: bb.
	^ apOverb - abpOverbb
]

{ #category : 'as yet unclassified' }
StMProduct >> positiveProduct [

	^ StMProduct coeff: coeff abs terms: terms inverseTerms: inverseTerms
]

{ #category : 'copying' }
StMProduct >> postCopy [

	super postCopy.
	coeff := coeff copy
]

{ #category : 'printing' }
StMProduct >> printOn1: aStream [

	aStream nextPutAll: '('.
	coeff printOn: aStream.
	terms do: [ :term |
		aStream nextPutAll: '*'.
		term printOn: aStream ].
	aStream nextPutAll: ')'.
	inverseTerms isEmpty ifFalse: [
		aStream nextPutAll: ')/('.
		inverseTerms do: [ :term | term printOn: aStream ] separatedBy: [ aStream nextPutAll: '*' ] ].
	aStream nextPutAll: ')'
]

{ #category : 'printing' }
StMProduct >> printOn: aStream [

	aStream
		nextPut: $(;
		print: coeff.
	terms do: [ :term |
		aStream
			nextPut: $*;
			print: term ].
	inverseTerms do: [ :term |
		aStream
			nextPut: $/;
			print: term ].
	aStream nextPut: $)
]

{ #category : 'evaluating' }
StMProduct >> simplifyConstant [

	| newTerms newInverseTerms constant term |
	newTerms := OrderedCollection new.
	newInverseTerms := OrderedCollection new.
	constant := 1.0.
	terms do: [ :trm |
		term := trm simplifyConstant.
		term isConstant
			ifTrue: [ constant := constant * term value ]
			ifFalse: [ newTerms add: term ] ].
	inverseTerms do: [ :trm |
		term := trm simplifyConstant.
		term isConstant
			ifTrue: [ constant := constant / term value ]
			ifFalse: [ newInverseTerms add: term ] ].
	newTerms add: (StMConstant with: constant).
	^ self class terms: newTerms inverseTerms: newInverseTerms
]

{ #category : 'evaluating' }
StMProduct >> simplifyLogExp [

	| newTerms newInverseTerms term |
	newTerms := OrderedCollection new.
	newInverseTerms := OrderedCollection new.
	terms do: [ :trm |
		term := trm simplifyLogExp.
		newTerms add: term ].
	inverseTerms do: [ :trm |
		term := trm simplifyLogExp.
		newInverseTerms add: term ].
	^ self class terms: newTerms inverseTerms: newInverseTerms
]

{ #category : 'evaluating' }
StMProduct >> simplifyNegative [

	| posSign newTerms newInverseTerms term answer |
	posSign := true.
	newTerms := OrderedCollection new.
	newInverseTerms := OrderedCollection new.
	terms do: [ :trm |
		term := trm simplifyNegative.
		term isNegative
			ifTrue: [
				posSign := posSign not.
				newTerms add: term negated ]
			ifFalse: [ newTerms add: term ] ].
	inverseTerms do: [ :trm |
		term := trm simplifyNegative.
		term isNegative
			ifTrue: [
				posSign := posSign not.
				newInverseTerms add: term negated ]
			ifFalse: [ newInverseTerms add: term ] ].
	answer := self class terms: newTerms inverseTerms: newInverseTerms.
	^ posSign
		  ifTrue: [ answer ]
		  ifFalse: [ StMNegative with: answer ]
]

{ #category : 'evaluating' }
StMProduct >> simplifyOne [

	| newTerms newInverseTerms term |
	newTerms := OrderedCollection new.
	newInverseTerms := OrderedCollection new.
	terms do: [ :trm |
		term := trm simplifyOne.
		term isOne ifFalse: [ newTerms add: term ] ].
	inverseTerms do: [ :trm |
		term := trm simplifyOne.
		term isOne ifFalse: [ newInverseTerms add: term ] ].
	^ self class terms: newTerms inverseTerms: newInverseTerms
]

{ #category : 'evaluating' }
StMProduct >> simplifyPower [

	| newTerms newInverseTerms term |
	newTerms := OrderedCollection new.
	newInverseTerms := OrderedCollection new.
	terms do: [ :trm |
		term := trm simplifyPower.
		newTerms add: term ].
	inverseTerms do: [ :trm |
		term := trm simplifyPower.
		newInverseTerms add: term ].
	^ self class terms: newTerms inverseTerms: newInverseTerms
]

{ #category : 'evaluating' }
StMProduct >> simplifyProduct [

	| newTerms newInverseTerms term |
	newTerms := OrderedCollection new.
	newInverseTerms := OrderedCollection new.
	terms do: [ :trm |
		term := trm simplifyProduct.
		newTerms add: term ].
	inverseTerms do: [ :trm |
		term := trm simplifyProduct.
		newInverseTerms add: term ].
	[ newTerms allSatisfy: [ :trm | trm isNegative not and: [ trm isReciprocal not ] ] ] assert.
	[ newInverseTerms allSatisfy: [ :trm | trm isNegative not and: [ trm isReciprocal not ] ] ] assert.
	self cancelTerms: newTerms inverseTerms: newInverseTerms.
	self collectTerms: newTerms inverseTerms: newInverseTerms.
	^ self class terms: newTerms inverseTerms: newInverseTerms
]

{ #category : 'evaluating' }
StMProduct >> simplifyReciprocal [

	| newTerms newInverseTerms term |
	newTerms := OrderedCollection new.
	newInverseTerms := OrderedCollection new.
	terms do: [ :trm |
		term := trm simplifyReciprocal.
		term isReciprocal
			ifTrue: [ newInverseTerms add: term x ]
			ifFalse: [ newTerms add: term ] ].
	inverseTerms do: [ :trm |
		term := trm simplifyReciprocal.
		term isReciprocal
			ifTrue: [ newTerms add: term x ]
			ifFalse: [ newInverseTerms add: term ] ].
	^ self class terms: newTerms inverseTerms: newInverseTerms
]

{ #category : 'evaluating' }
StMProduct >> simplifySum [

	| newTerms newInverseTerms term |
	newTerms := OrderedCollection new.
	newInverseTerms := OrderedCollection new.
	terms do: [ :trm |
		term := trm simplifySum.
		newTerms add: term ].
	inverseTerms do: [ :trm |
		term := trm simplifySum.
		newInverseTerms add: term ].
	^ self class terms: newTerms inverseTerms: newInverseTerms
]

{ #category : 'evaluating' }
StMProduct >> simplifyTrig [

	| newTerms newInverseTerms term |
	newTerms := OrderedCollection new.
	newInverseTerms := OrderedCollection new.
	terms do: [ :trm |
		term := trm simplifyTrig.
		newTerms add: term ].
	inverseTerms do: [ :trm |
		term := trm simplifyTrig.
		newInverseTerms add: term ].
	"Apply trig identities here."
	^ self class terms: newTerms inverseTerms: newInverseTerms
]

{ #category : 'evaluating' }
StMProduct >> simplifyUntil: set [

	| block newTerms newInverseTerms newSize newInvSize bagTerms bagInverseTerms tmpCoeff tmpTrms tmpInvTrms |
	^ (set includes: self)
		  ifTrue: [ self ]
		  ifFalse: [
				  tmpCoeff := coeff.
				  tmpTrms := terms copy.
				  tmpInvTrms := inverseTerms copy.
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
													  StMProduct
														  coeff: tmpCoeff
														  terms: newTerms
														  inverseTerms: newInverseTerms ] ] ]
					  ifFalse: [
							  (newSize == 1 and: [ newInvSize == 0 and: [ tmpCoeff = 1.0 ] ])
								  ifTrue: [ newTerms first ]
								  ifFalse: [
										  StMProduct
											  coeff: tmpCoeff
											  terms: newTerms
											  inverseTerms: newInverseTerms ] ] ]
]

{ #category : 'evaluating' }
StMProduct >> simplifyZero [

	| newTerms newInverseTerms term |
	newTerms := OrderedCollection new.
	newInverseTerms := OrderedCollection new.
	terms do: [ :trm |
		term := trm simplifyZero.
		term isZero
			ifTrue: [ ^ StMConstant with: 0.0 ]
			ifFalse: [ newTerms add: term ] ].
	inverseTerms do: [ :trm |
		term := trm simplifyZero.
		term isZero
			ifTrue: [ self halt: 'Check this.' ]
			ifFalse: [ newInverseTerms add: term ] ].
	^ self class terms: newTerms inverseTerms: newInverseTerms
]

{ #category : 'accessing' }
StMProduct >> timesFunction: aFunction [

	| answer |
	answer := self copy.
	(aFunction isConstant and: [ aFunction value = 1.0 ]) ifFalse: [ answer addTerm: aFunction copy ].
	^ answer
]

{ #category : 'accessing' }
StMProduct >> timesProduct: aProduct [

	| answer |
	answer := self copy.
	answer coeff: self coeff * aProduct coeff.
	answer addTerms: aProduct copy terms.
	answer addInverseTerms: aProduct copy inverseTerms.
	^ answer
]

{ #category : 'accessing' }
StMProduct >> timesSum: aSum [
	"(a*b*c)*(A + B + C) = (a*b*c*A + a*b*c*B + a*b*c*C)"

	| answer sumTERMs termTERM sumInverseTERMs |
	[ aSum isSum ] assert.
	^ self isConstant
		  ifTrue: [
			  aSum isConstant
				  ifTrue: [ StMConstant with: self value * aSum value ]
				  ifFalse: [
					  answer := (aSum terms size = 1 and: [ aSum inverseTerms size = 0 ])
						            ifTrue: [ aSum terms first ]
						            ifFalse: [ aSum ].
					  self value = 1.0
						  ifTrue: [ answer ]
						  ifFalse: [ self times: answer ] ] ]
		  ifFalse: [
			  aSum isConstant
				  ifTrue: [
					  answer := (self terms size = 1 and: [ self inverseTerms size = 0 ])
						            ifTrue: [ self terms first ]
						            ifFalse: [ self ].
					  aSum value = 1.0
						  ifTrue: [ answer ]
						  ifFalse: [ aSum times: answer ] ]
				  ifFalse: [
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
					  (answer terms size = 1 and: [ answer inverseTerms size = 0 ])
						  ifTrue: [ answer terms first ]
						  ifFalse: [ answer ] ] ]
]

{ #category : 'evaluating' }
StMProduct >> value [

	| answer |
	answer := 1.0.
	terms do: [ :term | answer := answer * term value ].
	inverseTerms do: [ :term | answer := answer / term value ].
	^ answer
]
