"
terms and inverseTerms do not store negatives.
"
Class {
	#name : 'StMSum',
	#superclass : 'StMTermsFunction',
	#instVars : [
		'const'
	],
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'as yet unclassified' }
StMSum class >> const: num terms: trms inverseTerms: invTrms [

	^ self new
		  const: num;
		  addTerms: trms;
		  addInverseTerms: invTrms;
		  yourself
]

{ #category : 'instance creation' }
StMSum class >> const: float with: arg1 minus: arg2 [

	^ self new
		  const: float;
		  addTerm: arg1;
		  addInverseTerm: arg2;
		  yourself
]

{ #category : 'instance creation' }
StMSum class >> const: float with: arg1 plus: arg2 [

	^ self new
		  const: float;
		  addTerm: arg1;
		  addTerm: arg2;
		  yourself
]

{ #category : 'instance creation' }
StMSum class >> terms: trms inverseTerms1: invTrms [

	| instance ntrm ninvTrm |
	ntrm := trms size.
	ninvTrm := invTrms size.
	^ ntrm = 0
		  ifTrue: [
			  ninvTrm = 0
				  ifTrue: [ StMConstant with: 0.0 ]
				  ifFalse: [
					  ninvTrm = 1
						  ifTrue: [ StMNegative with: invTrms first ]
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

{ #category : 'instance creation' }
StMSum class >> terms: trms inverseTerms: invTrms [

	| instance |
	instance := self new.
	instance addTerms: trms.
	instance addInverseTerms: invTrms.
	^ instance simplified
]

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

	^ super with: arg1 with: arg2
]

{ #category : 'instance creation' }
StMSum class >> with: arg1 plus: arg2 plus: arg3 [

	^ super with: arg1 with: arg2 with: arg3
]

{ #category : 'comparing' }
StMSum >> = anObject [

	| otherTerms otherInverseTerms |
	^ self == anObject or: [
		  self class == anObject class and: [
			  self const = anObject const and: [
				  otherTerms := anObject terms.
				  terms size = otherTerms size and: [
					  (terms allSatisfy: [ :term | otherTerms includes: term ]) and: [
						  otherInverseTerms := anObject inverseTerms.
						  inverseTerms size = otherInverseTerms size and: [
							  inverseTerms allSatisfy: [ :term | otherInverseTerms includes: term ] ] ] ] ] ] ]
]

{ #category : 'accessing' }
StMSum >> addInverseTerm: term [

	term isSum
		ifTrue: [
			self const: self const - term const.
			self addTerms: term inverseTerms.
			self addInverseTerms: term terms ]
		ifFalse: [
			term isNegative
				ifTrue: [ self addTerm: term x ]
				ifFalse: [ term isZero ifFalse: [ inverseTerms add: term copy ] ] ].
	^ term
]

{ #category : 'accessing' }
StMSum >> addTerm: term [

	term isSum
		ifTrue: [
			self const: self const + term const.
			self addTerms: term terms.
			self addInverseTerms: term inverseTerms ]
		ifFalse: [
			term isNegative
				ifTrue: [ self addInverseTerm: term x ]
				ifFalse: [ term isZero ifFalse: [ terms add: term copy ] ] ].
	^ term
]

{ #category : 'converting' }
StMSum >> asNumber [

	| answer |
	answer := const.
	terms do: [ :term | answer := answer + term asNumber ].
	inverseTerms do: [ :term | answer := answer - term asNumber ].
	^ answer
]

{ #category : 'converting' }
StMSum >> asValue [

	| answer |
	answer := const.
	terms do: [ :term | answer := answer + term asValue ].
	inverseTerms do: [ :term | answer := answer - term asValue ].
	^ answer
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

{ #category : 'simplify' }
StMSum >> collectTerms: newTerms inverseTerms: newInvTerms [

	| bagTerms bagInvBag |
	bagTerms := newTerms asBag.
	bagInvBag := newInvTerms asBag.
	bagTerms keysAndValuesDo: [ :k :v |
		v > 1 ifTrue: [
			v timesRepeat: [ newTerms remove: k ].
			newTerms add: (StMProduct with: v times: k) ] ].
	bagInvBag keysAndValuesDo: [ :k :v |
		v > 1 ifTrue: [
			v timesRepeat: [ newInvTerms remove: k ].
			newInvTerms add: (StMProduct with: v times: k) ] ]
]

{ #category : 'accessing' }
StMSum >> const [

	^ const
]

{ #category : 'accessing' }
StMSum >> const: anObject [

	const := anObject
]

{ #category : 'evaluating' }
StMSum >> differentiateWRT: variable [

	| termDerivatives invTermDerivatives |
	termDerivatives := terms collect: [ :term | term differentiateWRT: variable ].
	invTermDerivatives := inverseTerms collect: [ :term | term differentiateWRT: variable ].
	^ (StMSum terms: termDerivatives inverseTerms: invTermDerivatives) simplified
]

{ #category : 'evaluating' }
StMSum >> expandUntil: set [
	"(a+b)+(c+d) + e*f + g = a + b + c + d + e*f + g"

	| term newConst newTerms newInverseTerms |
	^ (set includes: self)
		  ifTrue: [ self ]
		  ifFalse: [
			  newConst := const.
			  newTerms := OrderedCollection new.
			  newInverseTerms := OrderedCollection new.
			  1 to: terms size do: [ :i |
				  term := (terms at: i) expandUntil: set.
				  term isSum
					  ifTrue: [
						  newConst := newConst + term const.
						  newTerms addAll: term terms.
						  newInverseTerms addAll: term inverseTerms ]
					  ifFalse: [
						  term isZero ifFalse: [
							  term isNegative
								  ifTrue: [ newInverseTerms add: term negated ]
								  ifFalse: [ newTerms add: term ] ] ] ].
			  1 to: inverseTerms size do: [ :i |
				  term := (inverseTerms at: i) expandUntil: set.
				  term isSum
					  ifTrue: [
						  newConst := newConst - term const.
						  newInverseTerms addAll: term terms.
						  newTerms addAll: term inverseTerms ]
					  ifFalse: [
						  term isZero ifFalse: [
							  term isNegative
								  ifTrue: [ newTerms add: term negated ]
								  ifFalse: [ newInverseTerms add: term ] ] ] ].
			  StMSum const: newConst terms: newTerms inverseTerms: newInverseTerms ]
]

{ #category : 'initialization' }
StMSum >> initialize [

	super initialize.
	const := 0.0
]

{ #category : 'testing' }
StMSum >> isConstant [

	^ terms size = 0
		  ifTrue: [
			  inverseTerms size = 0
				  ifTrue: [ true ]
				  ifFalse: [ inverseTerms allSatisfy: [ :trm | trm isConstant ] ] ]
		  ifFalse: [
			  inverseTerms size = 0
				  ifTrue: [ terms allSatisfy: [ :trm | trm isConstant ] ]
				  ifFalse: [ terms , inverseTerms allSatisfy: [ :trm | trm isConstant ] ] ]
]

{ #category : 'testing' }
StMSum >> isSum [
	^true
]

{ #category : 'testing' }
StMSum >> isZero [

	^ const isZero and: [
		  (terms allSatisfy: [ :term | term isZero ]) and: [
			  inverseTerms allSatisfy: [ :term | term isZero ] ] ]
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

{ #category : 'copying' }
StMSum >> postCopy [

	super postCopy.
	const := const copy
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

	aStream
		nextPut: $(;
		print: const.
	terms do: [ :term |
		aStream
			nextPutAll: ' + ';
			print: term ].
	inverseTerms do: [ :term |
		aStream
			nextPutAll: ' - ';
			print: term ].
	aStream nextPut: $)
]

{ #category : 'evaluating' }
StMSum >> simplifyConstant [

	| newTerms newInverseTerms constant term |
	newTerms := OrderedCollection new.
	newInverseTerms := OrderedCollection new.
	constant := 0.0.
	terms do: [ :trm |
		term := trm simplifyConstant.
		term isConstant
			ifTrue: [ constant := constant + term value ]
			ifFalse: [ newTerms add: term ] ].
	inverseTerms do: [ :trm |
		term := trm simplifyConstant.
		term isConstant
			ifTrue: [ constant := constant - term value ]
			ifFalse: [ newInverseTerms add: term ] ].
	newTerms add: (StMConstant with: constant).
	^ self class terms: newTerms inverseTerms: newInverseTerms
]

{ #category : 'evaluating' }
StMSum >> simplifyLogExp [

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
StMSum >> simplifyNegative [

	| newTerms newInverseTerms term |
	newTerms := OrderedCollection new.
	newInverseTerms := OrderedCollection new.
	terms do: [ :trm |
		term := trm simplifyNegative.
		term isNegative
			ifTrue: [ newInverseTerms add: term x ]
			ifFalse: [ newTerms add: term ] ].
	inverseTerms do: [ :trm |
		term := trm simplifyNegative.
		term isNegative
			ifTrue: [ newTerms add: term x ]
			ifFalse: [ newInverseTerms add: term ] ].
	^ self class terms: newTerms inverseTerms: newInverseTerms
]

{ #category : 'evaluating' }
StMSum >> simplifyOne [

	| newTerms newInverseTerms term |
	newTerms := OrderedCollection new.
	newInverseTerms := OrderedCollection new.
	terms do: [ :trm |
		term := trm simplifyOne.
		newTerms add: term ].
	inverseTerms do: [ :trm |
		term := trm simplifyOne.
		newInverseTerms add: term ].
	^ self class terms: newTerms inverseTerms: newInverseTerms
]

{ #category : 'evaluating' }
StMSum >> simplifyPower [

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
StMSum >> simplifyProduct [

	| newTerms newInverseTerms term |
	newTerms := OrderedCollection new.
	newInverseTerms := OrderedCollection new.
	terms do: [ :trm |
		term := trm simplifyProduct.
		newTerms add: term ].
	inverseTerms do: [ :trm |
		term := trm simplifyProduct.
		newInverseTerms add: term ].
	"self halt: 'Check this.'."
	^ self class terms: newTerms inverseTerms: newInverseTerms
]

{ #category : 'evaluating' }
StMSum >> simplifyReciprocal [

	| newTerms newInverseTerms term |
	newTerms := OrderedCollection new.
	newInverseTerms := OrderedCollection new.
	terms do: [ :trm |
		term := trm simplifyReciprocal.
		newTerms add: term ].
	inverseTerms do: [ :trm |
		term := trm simplifyReciprocal.
		newInverseTerms add: term ].
	^ self class terms: newTerms inverseTerms: newInverseTerms
]

{ #category : 'evaluating' }
StMSum >> simplifySum [

	| newTerms newInverseTerms term |
	newTerms := OrderedCollection new.
	newInverseTerms := OrderedCollection new.
	terms do: [ :trm |
		term := trm simplifySum.
		newTerms add: term ].
	inverseTerms do: [ :trm |
		term := trm simplifySum.
		newInverseTerms add: term ].
	[ newTerms allSatisfy: [ :trm | trm isNegative not ] ] assert.
	[ newInverseTerms allSatisfy: [ :trm | trm isNegative not ] ] assert.
	self cancelTerms: newTerms inverseTerms: newInverseTerms.
	self collectTerms: newTerms inverseTerms: newInverseTerms.
	^ self class terms: newTerms inverseTerms: newInverseTerms
]

{ #category : 'evaluating' }
StMSum >> simplifyTrig [

	| newTerms newInverseTerms term newTermsTrig newInvTermsTrig cosSqTerms sinSqTerms cosSqInvTerms sinSqInvTerms |
	newTerms := OrderedCollection new.
	newInverseTerms := OrderedCollection new.
	terms do: [ :trm |
		term := trm simplifyTrig.
		newTerms add: term ].
	inverseTerms do: [ :trm |
		term := trm simplifyTrig.
		newInverseTerms add: term ].
	newTermsTrig := newTerms select: [ :trm | trm isTrig ].
	newInvTermsTrig := newInverseTerms select: [ :trm | trm isTrig ].
	cosSqTerms := newTermsTrig select: [ :trm | trm hasCosSq ].
	sinSqTerms := newTermsTrig select: [ :trm | trm hasSinSq ].
	cosSqInvTerms := newInvTermsTrig select: [ :trm | trm hasCosSq ].
	sinSqInvTerms := newInvTermsTrig select: [ :trm | trm hasSinSq ].
	"self halt: 'Apply trig identities here.'."
	^ self class terms: newTerms inverseTerms: newInverseTerms
]

{ #category : 'evaluating' }
StMSum >> simplifyUntil: set [

	| newTerms newInverseTerms newSize newInvSize bagTerms bagInverseTerms tmpConst tmpTrms tmpInvTrms block |
	^ (set includes: self)
		  ifTrue: [ self ]
		  ifFalse: [
			  tmpConst := const copy.
			  tmpTrms := terms copy.
			  tmpInvTrms := inverseTerms copy.
			  block := [ :term | term simplifyUntil: set ].
			  tmpTrms := tmpTrms collect: block.
			  tmpInvTrms := tmpInvTrms collect: block.
			  tmpTrms asArray do: [ :term |
				  term isNegative ifTrue: [
					  tmpTrms remove: term.
					  tmpInvTrms add: term x ] ].
			  tmpInvTrms asArray do: [ :term |
				  term isNegative ifTrue: [
					  tmpInvTrms remove: term.
					  tmpTrms add: term x ] ].
			  tmpTrms asArray do: [ :term |
				  term isConstant ifTrue: [
					  tmpConst := tmpConst + term value.
					  tmpTrms remove: term ] ].
			  tmpInvTrms asArray do: [ :term |
				  term isConstant ifTrue: [
					  tmpConst := tmpConst - term value.
					  tmpInvTrms remove: term ] ].
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
					  ifFalse: [ newTerms add: ((StMProduct with: k times: v) simplifyUntil: set) ] ].
			  bagInverseTerms keysAndValuesDo: [ :k :v |
				  v = 1
					  ifTrue: [ newInverseTerms add: k ]
					  ifFalse: [ newInverseTerms add: ((StMProduct with: k times: v) simplifyUntil: set) ] ].
			  newSize := newTerms size.
			  newInvSize := newInverseTerms size.
			  newSize == 0
				  ifTrue: [
					  newInvSize == 0
						  ifTrue: [ StMConstant with: tmpConst ]
						  ifFalse: [
							  newInvSize == 1
								  ifTrue: [ StMNegative with: (newInverseTerms at: 1) ]
								  ifFalse: [ StMSum const: tmpConst terms: newTerms inverseTerms: newInverseTerms ] ] ]
				  ifFalse: [
					  (newSize == 1 and: [ newInvSize == 0 and: [ tmpConst = 0.0 ] ])
						  ifTrue: [ newTerms first ]
						  ifFalse: [ StMSum const: tmpConst terms: newTerms inverseTerms: newInverseTerms ] ] ]
]

{ #category : 'evaluating' }
StMSum >> simplifyZero [

	| newTerms newInverseTerms term |
	newTerms := OrderedCollection new.
	newInverseTerms := OrderedCollection new.
	terms do: [ :trm |
		term := trm simplifyZero.
		term isZero ifFalse: [ newTerms add: term ] ].
	inverseTerms do: [ :trm |
		term := trm simplifyZero.
		term isZero ifFalse: [ newInverseTerms add: term ] ].
	^ self class terms: newTerms inverseTerms: newInverseTerms
]

{ #category : 'accessing' }
StMSum >> timesFunction: aFunction [ 
	^aFunction timesSum: self
]

{ #category : 'accessing' }
StMSum >> timesProduct: aProduct [ 
	^aProduct timesSum: self
]

{ #category : 'ops' }
StMSum >> timesSum: addendSum [
	"(a + b)*(A + B + C) = (a*A + a*B + a*C + b*A + b*B + b*C)"

	| answer addendConst addendTERMs addendInverseTERMs |
	answer := StMSum new.
	addendConst := addendSum const.
	addendTERMs := addendSum terms.
	addendInverseTERMs := addendSum inverseTerms.
	answer const: const * addendConst.
	addendTERMs do: [ :addendTERM | answer addTerm: addendTERM * const ].
	addendInverseTERMs do: [ :addendInverseTERM | answer addInverseTerm: addendInverseTERM * const ].
	terms do: [ :term |
		answer addTerm: term * addendConst.
		addendTERMs do: [ :addendTERM |
			| termxTERM |
			termxTERM := addendTERM isProduct
				             ifTrue: [ term timesProduct: addendTERM ]
				             ifFalse: [ term timesFunction: addendTERM ].
			answer addTerm: termxTERM ].
		addendInverseTERMs do: [ :addendInverseTERM |
			| termxInvTERM |
			termxInvTERM := addendInverseTERM isProduct
				                ifTrue: [ term timesProduct: addendInverseTERM ]
				                ifFalse: [ term timesFunction: addendInverseTERM ].
			answer addInverseTerm: termxInvTERM ] ].
	inverseTerms do: [ :invterm |
		answer addInverseTerm: invterm * addendConst.
		addendTERMs do: [ :addendTERM |
			| invtermxTERM |
			invtermxTERM := addendTERM isProduct
				                ifTrue: [ invterm timesProduct: addendTERM ]
				                ifFalse: [ invterm timesFunction: addendTERM ].
			answer addInverseTerm: invtermxTERM ].
		addendInverseTERMs do: [ :addendInverseTERM |
			| invtermxInvTERM |
			invtermxInvTERM := addendInverseTERM isProduct
				                   ifTrue: [ invterm timesProduct: addendInverseTERM ]
				                   ifFalse: [ invterm timesFunction: addendInverseTERM ].
			answer addTerm: invtermxInvTERM ] ].
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
