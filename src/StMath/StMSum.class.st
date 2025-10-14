"
plusTerms and minusTerms do not store negatives.
"
Class {
	#name : 'StMSum',
	#superclass : 'StMTermsFunction',
	#instVars : [
		'const',
		'plusTerms',
		'minusTerms'
	],
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'instance creation' }
StMSum class >> const: number plusTerms: plusTrms minusTerms: minusTrms [

	| plusSize minusSize |
	"
	[ plusTrms allSatisfy: [ :trm | trm isSum not ] ] assert.
	[ minusTrms allSatisfy: [ :trm | trm isSum not ] ] assert.
"
	plusSize := plusTrms size.
	minusSize := minusTrms size.
	^ plusSize == 0
		  ifTrue: [
				  minusSize == 0
					  ifTrue: [ StMConstant with: number ]
					  ifFalse: [
							  minusSize == 1
								  ifTrue: [ StMNegative with: minusTrms first ]
								  ifFalse: [
										  self new
											  const: number;
											  addMinusTerms: minusTrms;
											  yourself ] ] ]
		  ifFalse: [
				  (plusSize == 1 and: [ minusSize == 0 and: [ number isZero ] ])
					  ifTrue: [ plusTrms first ]
					  ifFalse: [
							  self new
								  const: number;
								  addPlusTerms: plusTrms;
								  addMinusTerms: minusTrms;
								  yourself ] ]
]

{ #category : 'instance creation' }
StMSum class >> const: float with: arg1 minus: arg2 [

	^ self new
		  const: float;
		  addPlusTerm: arg1;
		  addMinusTerm: arg2;
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

{ #category : 'VisualWorks metadata' }
StMSum class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'instance creation' }
StMSum class >> with: plusTrm [

	| instance |
	instance := self new.
	^ instance
		  addPlusTerm: (instance conditionArgument: plusTrm);
		  yourself
]

{ #category : 'instance creation' }
StMSum class >> with: arg1 minus: arg2 [

	| instance |
	instance := self new.
	^ instance
		  addPlusTerm: (instance conditionArgument: arg1);
		  addMinusTerm: (instance conditionArgument: arg2);
		  yourself
]

{ #category : 'instance creation' }
StMSum class >> with: arg1 plus: arg2 [

	| instance |
	instance := self new.
	^ instance
		  addPlusTerm: (instance conditionArgument: arg1);
		  addPlusTerm: (instance conditionArgument: arg2);
		  yourself
]

{ #category : 'comparing' }
StMSum >> = anObject [

	| otherTerms otherInverseTerms |
	^ self == anObject or: [
		  self class == anObject class and: [
			  self const = anObject const and: [
				  otherTerms := anObject plusTerms.
				  plusTerms size = otherTerms size and: [
					  (plusTerms allSatisfy: [ :term | otherTerms includes: term ]) and: [
						  otherInverseTerms := anObject minusTerms.
						  minusTerms size = otherInverseTerms size and: [
							  minusTerms allSatisfy: [ :term | otherInverseTerms includes: term ] ] ] ] ] ] ]
]

{ #category : 'accessing' }
StMSum >> addMinusTerm: term [

	term isSum
		ifTrue: [
				self const: const asNumber - term const asNumber.
				self addPlusTerms: term minusTerms.
				self addMinusTerms: term plusTerms ]
		ifFalse: [
				term isNegative
					ifTrue: [ self addPlusTerm: term negated ]
					ifFalse: [
							term isConstant
								ifTrue: [ self const: const asNumber - term asNumber ]
								ifFalse: [ term isZero not ifTrue: [ minusTerms add: term ] ] ] ].
	^ term
]

{ #category : 'accessing' }
StMSum >> addMinusTerms: collection [

	collection do: [ :term | self addMinusTerm: term ].
	^ collection
]

{ #category : 'accessing' }
StMSum >> addPlusTerm: term [

	term isSum
		ifTrue: [
				self const: const asNumber + term const asNumber.
				self addPlusTerms: term plusTerms.
				self addMinusTerms: term minusTerms ]
		ifFalse: [
				term isNegative
					ifTrue: [ self addMinusTerm: term negated ]
					ifFalse: [
							term isConstant
								ifTrue: [ self const: const asNumber + term asNumber ]
								ifFalse: [ term isZero not ifTrue: [ plusTerms add: term ] ] ] ].
	^ term
]

{ #category : 'accessing' }
StMSum >> addPlusTerms: collection [

	collection do: [ :term | self addPlusTerm: term ].
	^ collection
]

{ #category : 'converting' }
StMSum >> asNumber [

	| answer |
	answer := const asNumber.
	self plusTerms do: [ :term | answer := answer + term asNumber ].
	self minusTerms do: [ :term | answer := answer - term asNumber ].
	^ answer
]

{ #category : 'converting' }
StMSum >> asValue [

	| answer |
	answer := const asValue.
	plusTerms do: [ :term | answer := answer + term asValue ].
	minusTerms do: [ :term | answer := answer - term asValue ].
	^ answer
]

{ #category : 'StCAD-UI' }
StMSum >> cadStringOn: aStream [

	plusTerms isEmpty
		ifTrue: [
			minusTerms isEmpty
				ifTrue: [ self halt: 'Check this' ]
				ifFalse: [
					aStream nextPutAll: '-('.
					1 to: minusTerms size do: [ :i |
						i > 1 ifTrue: [ aStream nextPutAll: ' + ' ].
						(minusTerms at: i) cadStringOn: aStream ].
					aStream nextPutAll: ')' ] ]
		ifFalse: [
			aStream nextPutAll: '('.
			minusTerms isEmpty
				ifTrue: [
					1 to: plusTerms size do: [ :i |
						i > 1 ifTrue: [ aStream nextPutAll: ' + ' ].
						(plusTerms at: i) cadStringOn: aStream ] ]
				ifFalse: [
					1 to: plusTerms size do: [ :i |
						i > 1 ifTrue: [ aStream nextPutAll: ' + ' ].
						(plusTerms at: i) cadStringOn: aStream ].
					aStream nextPutAll: ') - ('.
					1 to: minusTerms size do: [ :i |
						i > 1 ifTrue: [ aStream nextPutAll: ' + ' ].
						(minusTerms at: i) cadStringOn: aStream ] ].
			aStream nextPutAll: ')' ]
]

{ #category : 'simplify' }
StMSum >> collectFunctionTerms [

	| bagPlusTerms bagMinusTerms newPlusTerms newMinusTerms newPlusSize newMinusSize |
	bagPlusTerms := plusTerms asBag.
	bagMinusTerms := minusTerms asBag.
	bagPlusTerms sortedCounts.
	bagMinusTerms sortedCounts.
	newPlusTerms := OrderedCollection new.
	newMinusTerms := OrderedCollection new.
	bagPlusTerms keysAndValuesDo: [ :k :v |
			v = 1
				ifTrue: [ newPlusTerms add: k ]
				ifFalse: [ newPlusTerms add: (StMProduct with: k times: v) ] ].
	bagMinusTerms keysAndValuesDo: [ :k :v |
			v = 1
				ifTrue: [ newMinusTerms add: k ]
				ifFalse: [ newMinusTerms add: (StMProduct with: k times: v) ] ].
	newPlusSize := newPlusTerms size.
	newMinusSize := newMinusTerms size.
	^ newPlusSize == 0
		  ifTrue: [
				  newMinusSize == 0
					  ifTrue: [ const ]
					  ifFalse: [
							  newMinusSize == 1
								  ifTrue: [ StMNegative with: newMinusTerms first ]
								  ifFalse: [
										  self class new
											  const: const;
											  addPlusTerms: newPlusTerms;
											  addMinusTerms: newMinusTerms;
											  yourself ] ] ]
		  ifFalse: [
				  (newPlusSize == 1 and: [
					   newMinusSize == 0 and: [ const isZero ] ])
					  ifTrue: [ newPlusTerms first ]
					  ifFalse: [
							  self class new
								  const: const;
								  addPlusTerms: newPlusTerms;
								  addMinusTerms: newMinusTerms;
								  yourself ] ]
]

{ #category : 'simplify' }
StMSum >> collectProductTerms [

	| block plusDict minusDict plusProductTerms plusFunctionTerms minusProductTerms minusFunctionTerms coeff minusTermsWithEqualFactors minusTrm newPlusTerms newMinusTerms |
	"Cancellation"
	plusProductTerms := plusTerms select: [ :trm | trm isProduct ].
	plusFunctionTerms := plusTerms select: [ :trm | trm isProduct not ].
	minusProductTerms := minusTerms select: [ :trm | trm isProduct ].
	minusFunctionTerms := minusTerms select: [ :trm | trm isProduct not ].
	block := [ :productTerms |
		         | dict |
		         dict := Dictionary new.
		         productTerms do: [ :trm |
				         dict keys
					         detect: [ :k | trm hasEqualFactors: k ]
					         ifFound: [ :k | (dict at: k) add: trm ]
					         ifNone: [
					         dict at: trm put: (OrderedCollection with: trm) ] ].
		         dict ].
	plusDict := block value: plusProductTerms.
	minusDict := block value: minusProductTerms.
	block := [ :dict |
		         | productTerms |
		         productTerms := OrderedCollection new.
		         dict valuesDo: [ :trms |
				         trms size > 1 ifTrue: [
						         coeff := 0 asSymbolic.
						         trms do: [ :trm | coeff := coeff + trm coeff ].
						         trms first coeff: coeff ].
				         productTerms add: trms first ].
		         productTerms ].
	plusProductTerms := block value: plusDict.
	minusProductTerms := block value: minusDict.
	plusProductTerms asArray do: [ :term |
			term isProduct ifTrue: [
					coeff := term coeff.
					minusTermsWithEqualFactors := OrderedCollection new.
					minusProductTerms asArray do: [ :invTerm |
							(term hasEqualFactors: invTerm) ifTrue: [
									coeff := coeff - invTerm coeff.
									minusTermsWithEqualFactors add: invTerm ] ].
					coeff asNumber > 0.0 ifTrue: [
							term coeff: coeff.
							minusTermsWithEqualFactors do: [ :trm |
								minusProductTerms remove: trm ] ].
					coeff isZero ifTrue: [
							plusProductTerms remove: term.
							minusProductTerms remove: term ].
					coeff asNumber < 0.0 ifTrue: [
							plusProductTerms remove: term.
							minusTrm := minusTermsWithEqualFactors first.
							minusTrm coeff: coeff abs.
							minusTermsWithEqualFactors removeFirst.
							minusTermsWithEqualFactors do: [ :trm |
								minusProductTerms remove: trm ] ] ] ].
	newPlusTerms := plusFunctionTerms , plusProductTerms.
	newMinusTerms := minusFunctionTerms , minusProductTerms.
	^ self class
		  const: const
		  plusTerms: newPlusTerms
		  minusTerms: newMinusTerms
]

{ #category : 'simplify' }
StMSum >> collectTerms [

	| answer |
	answer := self collectFunctionTerms.
	answer := answer collectProductTerms.
	^ answer
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
StMSum >> const: number [

	const := number asSymbolic
]

{ #category : 'ops' }
StMSum >> copyWithPlus: symbolic [

	| answer |
	answer := self class new.
	answer addPlusTerm: (const asSymbolic times: symbolic).
	plusTerms do: [ :plusTerm |
		answer addPlusTerm: (plusTerm times: symbolic) ].
	minusTerms do: [ :minusTerm |
		answer addMinusTerm: (minusTerm times: symbolic) ].
	^ answer simplifyAll
]

{ #category : 'evaluating' }
StMSum >> differentiateWRT: var [

	^ var isSequenceable
		  ifTrue: [ var collect: [ :vari | self differentiateWRT: vari ] ]
		  ifFalse: [
				  | plusDerivatives minusDerivatives |
				  plusDerivatives := plusTerms collect: [ :term |
					                     term differentiateWRT: var ].
				  minusDerivatives := minusTerms collect: [ :term |
					                      term differentiateWRT: var ].
				  self class
					  const: 0.0
					  plusTerms: plusDerivatives
					  minusTerms: minusDerivatives ]
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
				  1 to: plusTerms size do: [ :i |
						  term := (plusTerms at: i) expandUntil: set.
						  term isSum
							  ifTrue: [
									  newConst := newConst + term const.
									  newTerms addAll: term plusTerms.
									  newInverseTerms addAll: term minusTerms ]
							  ifFalse: [
									  term isZero ifFalse: [
											  term isNegative
												  ifTrue: [ newInverseTerms add: term negated ]
												  ifFalse: [ newTerms add: term ] ] ] ].
				  1 to: minusTerms size do: [ :i |
						  term := (minusTerms at: i) expandUntil: set.
						  term isSum
							  ifTrue: [
									  newConst := newConst - term const.
									  newInverseTerms addAll: term plusTerms.
									  newTerms addAll: term minusTerms ]
							  ifFalse: [
									  term isZero ifFalse: [
											  term isNegative
												  ifTrue: [ newTerms add: term negated ]
												  ifFalse: [ newInverseTerms add: term ] ] ] ].
				  self class new
					  const: newConst
					  plusTerms: newTerms
					  minusTerms: newInverseTerms ]
]

{ #category : 'comparing' }
StMSum >> hash [

	| hash |
	hash := self class hash.
	hash := hash bitXor: const hash.
	plusTerms do: [ :elem | hash := hash bitXor: elem hash ].
	minusTerms do: [ :elem | hash := hash bitXor: elem hash ].
	^ hash
]

{ #category : 'initialization' }
StMSum >> initialize [

	super initialize.
	plusTerms := OrderedCollection new.
	minusTerms := OrderedCollection new.
	const := 0.0 asSymbolic
]

{ #category : 'testing' }
StMSum >> isConstant [

	^ plusTerms size = 0
		  ifTrue: [
			  minusTerms size = 0
				  ifTrue: [ true ]
				  ifFalse: [ minusTerms allSatisfy: [ :trm | trm isConstant ] ] ]
		  ifFalse: [
			  minusTerms size = 0
				  ifTrue: [ plusTerms allSatisfy: [ :trm | trm isConstant ] ]
				  ifFalse: [ plusTerms , minusTerms allSatisfy: [ :trm | trm isConstant ] ] ]
]

{ #category : 'testing' }
StMSum >> isSum [
	^true
]

{ #category : 'testing' }
StMSum >> isZero [

	^ const isZero and: [
		  (plusTerms allSatisfy: [ :term | term isZero ]) and: [
			  minusTerms allSatisfy: [ :term | term isZero ] ] ]
]

{ #category : 'ops' }
StMSum >> minus: symbolic [

	^ symbolic isSum
		  ifTrue: [ self minusSum: symbolic ]
		  ifFalse: [
				  self class new
					  addPlusTerms: plusTerms;
					  addMinusTerms: minusTerms;
					  addMinusTerm: symbolic;
					  simplifyAll ]
]

{ #category : 'ops' }
StMSum >> minusSum: aSum [

	[ aSum isSum ] assert.
	^ self class new
		  const: const - aSum const;
		  addPlusTerms: plusTerms , aSum minusTerms;
		  addMinusTerms: minusTerms , aSum plusTerms;
		  simplifyAll
]

{ #category : 'accessing' }
StMSum >> minusTerms [

	^ minusTerms
]

{ #category : 'accessing' }
StMSum >> minusTerms: anObject [

	minusTerms := anObject
]

{ #category : 'ops' }
StMSum >> negated [

	| answer |
	answer := self class new
		          const: const negated
		          plusTerms: minusTerms
		          minusTerms: plusTerms.
	^ answer
]

{ #category : 'evaluating' }
StMSum >> partialDifferentiateWRT: variable [

	| plusDerivatives minusDerivatives |
	plusDerivatives := plusTerms collect: [ :term |
		                   term partialDifferentiateWRT: variable ].
	minusDerivatives := minusTerms collect: [ :term |
		                      term partialDifferentiateWRT: variable ].
	^ self class
		  const: 0
		  plusTerms: plusDerivatives
		  minusTerms: minusDerivatives
]

{ #category : 'ops' }
StMSum >> plus: symbolic [

	^ symbolic isSum
		  ifTrue: [ self plusSum: symbolic ]
		  ifFalse: [
				  self class new
					  addPlusTerms: plusTerms;
					  addPlusTerm: symbolic;
					  addMinusTerms: minusTerms;
					  simplifyAll ]
]

{ #category : 'ops' }
StMSum >> plusSum: aSum [

	[ aSum isSum ] assert.
	^ self class new
		  const: const + aSum const;
		  addPlusTerms: plusTerms , aSum plusTerms;
		  addMinusTerms: minusTerms , aSum minusTerms;
		  simplifyAll
]

{ #category : 'accessing' }
StMSum >> plusTerms [

	^ plusTerms
]

{ #category : 'accessing' }
StMSum >> plusTerms: anObject [

	plusTerms := anObject
]

{ #category : 'copying' }
StMSum >> postCopy [

	plusTerms := plusTerms collect: [ :term | term copy ].
	minusTerms := minusTerms collect: [ :term | term copy ].
	const := const copy
]

{ #category : 'printing' }
StMSum >> printOn2: aStream [ 
	aStream nextPut: $(.
	plusTerms ifNotNil: 
			[plusTerms do: [:term | term printOn: aStream]
				separatedBy: [aStream nextPutAll: ' + ']].
	aStream nextPut: $)
]

{ #category : 'printing' }
StMSum >> printOn: aStream [

	aStream
		nextPut: $(;
		print: const.
	plusTerms do: [ :term |
		aStream
			nextPutAll: ' + ';
			print: term ].
	minusTerms do: [ :term |
		aStream
			nextPutAll: ' - ';
			print: term ].
	aStream nextPut: $)
]

{ #category : 'simplify' }
StMSum >> simplifyConstant [

	| newPlusTerms newMinusTerms constant newTerm |
	plusTerms := plusTerms.
	minusTerms := minusTerms.
	newPlusTerms := OrderedCollection new.
	newMinusTerms := OrderedCollection new.
	constant := const.
	plusTerms do: [ :term |
			newTerm := term simplifyConstant.
			newTerm isConstant
				ifTrue: [ constant := constant + newTerm value ]
				ifFalse: [ newPlusTerms add: newTerm ] ].
	minusTerms do: [ :term |
			newTerm := term simplifyConstant.
			newTerm isConstant
				ifTrue: [ constant := constant - newTerm value ]
				ifFalse: [ newMinusTerms add: newTerm ] ].
	^ self class
		  const: constant
		  plusTerms: newPlusTerms
		  minusTerms: newMinusTerms
]

{ #category : 'simplify' }
StMSum >> simplifyLogExp [

	| newPlusTerms newMinusTerms |
	newPlusTerms := plusTerms collect: [ :trm | trm simplifyLogExp ].
	newMinusTerms := minusTerms collect: [ :trm | trm simplifyLogExp ].
	^ self class
		  const: const
		  plusTerms: newPlusTerms
		  minusTerms: newMinusTerms
]

{ #category : 'simplify' }
StMSum >> simplifyNegative [

	| newPlusTerms newMinusTerms newTerm |
	plusTerms := plusTerms.
	minusTerms := minusTerms.
	newPlusTerms := OrderedCollection new.
	newMinusTerms := OrderedCollection new.
	plusTerms do: [ :term |
			newTerm := term simplifyNegative.
			newTerm isNegative
				ifTrue: [ newMinusTerms add: newTerm negated ]
				ifFalse: [ newPlusTerms add: newTerm ] ].
	minusTerms do: [ :term |
			newTerm := term simplifyNegative.
			newTerm isNegative
				ifTrue: [ newPlusTerms add: newTerm negated ]
				ifFalse: [ newMinusTerms add: newTerm ] ].
	^ self class
		  const: const
		  plusTerms: newPlusTerms
		  minusTerms: newMinusTerms
]

{ #category : 'simplify' }
StMSum >> simplifyOne [

	| newPlusTerms newMinusTerms |
	newPlusTerms := plusTerms collect: [ :trm | trm simplifyOne ].
	newMinusTerms := minusTerms collect: [ :trm | trm simplifyOne ].
	^ self class
		  const: const
		  plusTerms: newPlusTerms
		  minusTerms: newMinusTerms
]

{ #category : 'simplify' }
StMSum >> simplifyPower [

	| newPlusTerms newMinusTerms |
	newPlusTerms := plusTerms collect: [ :trm | trm simplifyPower ].
	newMinusTerms := minusTerms collect: [ :trm | trm simplifyPower ].
	^ self class
		  const: const
		  plusTerms: newPlusTerms
		  minusTerms: newMinusTerms
]

{ #category : 'simplify' }
StMSum >> simplifyProduct [

	| newPlusTerms newMinusTerms |
	newPlusTerms := plusTerms collect: [ :trm | trm simplifyProduct ].
	newMinusTerms := minusTerms collect: [ :trm | trm simplifyProduct ].
	^ self class
		  const: const
		  plusTerms: newPlusTerms
		  minusTerms: newMinusTerms
]

{ #category : 'simplify' }
StMSum >> simplifyReciprocal [

	| newPlusTerms newMinusTerms |
	newPlusTerms := plusTerms collect: [ :trm | trm simplifyReciprocal ].
	newMinusTerms := minusTerms collect: [ :trm | trm simplifyReciprocal ].
	^ self class
		  const: const
		  plusTerms: newPlusTerms
		  minusTerms: newMinusTerms
]

{ #category : 'simplify' }
StMSum >> simplifySum [

	| newSum |
	plusTerms := plusTerms collect: [ :trm | trm simplifySum ].
	minusTerms := minusTerms collect: [ :trm | trm simplifySum ].
	newSum := self class
		          const: const
		          plusTerms: plusTerms
		          minusTerms: minusTerms.
	^ newSum collectTerms
]

{ #category : 'simplify' }
StMSum >> simplifyTrig [

	| newPlusTerms newMinusTerms plusTermsTrig minusTermsTrig cosSqPlusTerms sinSqPlusTerms cosSqMinusTerms sinSqMinusTerms |
	newPlusTerms := plusTerms collect: [ :trm | trm simplifyTrig ].
	newMinusTerms := minusTerms collect: [ :trm | trm simplifyTrig ].

	plusTermsTrig := newPlusTerms select: [ :trm | trm isTrig ].
	minusTermsTrig := newMinusTerms select: [ :trm | trm isTrig ].
	cosSqPlusTerms := plusTermsTrig select: [ :trm | trm hasCosSq ].
	sinSqPlusTerms := plusTermsTrig select: [ :trm | trm hasSinSq ].
	cosSqMinusTerms := minusTermsTrig select: [ :trm | trm hasCosSq ].
	sinSqMinusTerms := minusTermsTrig select: [ :trm | trm hasSinSq ].
	"self halt: 'Apply trig identities here.'."
	[ plusTermsTrig isEmpty and: [ minusTermsTrig isEmpty ] ] assert.
	^ self class
		  const: const
		  plusTerms: newPlusTerms
		  minusTerms: newMinusTerms
]

{ #category : 'simplify' }
StMSum >> simplifyUntil: set [

	| newTerms newInverseTerms newSize newInvSize bagTerms bagInverseTerms tmpConst tmpTrms tmpInvTrms block coeff invTermsWithEqualFactors invtrm |
	^ (set includes: self)
		  ifTrue: [ self ]
		  ifFalse: [
				  tmpConst := const copy.
				  tmpTrms := plusTerms copy.
				  tmpInvTrms := minusTerms copy.
				  block := [ :term | term simplifyUntil: set ].
				  tmpTrms := tmpTrms collect: block.
				  tmpInvTrms := tmpInvTrms collect: block.
				  tmpTrms asArray do: [ :term |
						  term isNegative ifTrue: [
								  tmpTrms remove: term.
								  tmpInvTrms add: term negated ] ].
				  tmpInvTrms asArray do: [ :term |
						  term isNegative ifTrue: [
								  tmpInvTrms remove: term.
								  tmpTrms add: term negated ] ].
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
								  tmpInvTrms remove: term ].
						  term isProduct ifTrue: [
								  coeff := term coeff.
								  invTermsWithEqualFactors := OrderedCollection new.
								  tmpInvTrms asArray do: [ :invTerm |
										  (term hasEqualFactors: invTerm) ifTrue: [
												  coeff := coeff - invTerm coeff.
												  invTermsWithEqualFactors add: invTerm ] ].
								  coeff > 0.0 ifTrue: [
										  term coeff: coeff.
										  invTermsWithEqualFactors do: [ :trm |
											  tmpInvTrms remove: trm ] ].
								  coeff = 0.0 ifTrue: [ "Cancellation"
										  tmpTrms remove: term.
										  tmpInvTrms remove: term ].
								  coeff < 0.0 ifTrue: [
										  tmpTrms remove: term.
										  invtrm := invTermsWithEqualFactors first.
										  invtrm coeff: coeff abs.
										  invTermsWithEqualFactors removeFirst.
										  invTermsWithEqualFactors do: [ :trm |
											  tmpInvTrms remove: trm ] ] ] ].
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
								  ((StMProduct with: k times: v) simplifyUntil: set) ] ].
				  bagInverseTerms keysAndValuesDo: [ :k :v |
						  v = 1
							  ifTrue: [ newInverseTerms add: k ]
							  ifFalse: [
									  newInverseTerms add:
										  ((StMProduct with: k times: v) simplifyUntil: set) ] ].
				  newSize := newTerms size.
				  newInvSize := newInverseTerms size.
				  newSize == 0
					  ifTrue: [
							  newInvSize == 0
								  ifTrue: [ StMConstant with: tmpConst ]
								  ifFalse: [
										  newInvSize == 1
											  ifTrue: [ StMNegative with: (newInverseTerms at: 1) ]
											  ifFalse: [
													  self class new
														  const: tmpConst
														  plusTerms: newTerms
														  minusTerms: newInverseTerms ] ] ]
					  ifFalse: [
							  (newSize == 1 and: [ newInvSize == 0 and: [ tmpConst = 0.0 ] ])
								  ifTrue: [ newTerms first ]
								  ifFalse: [
										  self class new
											  const: tmpConst
											  plusTerms: newTerms
											  minusTerms: newInverseTerms ] ] ]
]

{ #category : 'simplify' }
StMSum >> simplifyZero [

	| block newPlusTerms newMinusTerms newTerm |
	block := [ :trms |
		         | newTrms |
		         newTrms := OrderedCollection new.
		         trms do: [ :term |
				         newTerm := term simplifyZero.
				         newTerm isZero ifFalse: [ newTrms add: newTerm ] ].
		         newTrms ].
	newPlusTerms := block value: plusTerms.
	newMinusTerms := block value: minusTerms.
	^ self class
		  const: const
		  plusTerms: newPlusTerms
		  minusTerms: newMinusTerms
]

{ #category : 'changing' }
StMSum >> substitute: var1 with: var2 [

	| answer |
	answer := self class new.
	answer addPlusTerms:
		(plusTerms collect: [ :term | term substitute: var1 with: var2 ]).
	answer addMinusTerms:
		(minusTerms collect: [ :term | term substitute: var1 with: var2 ]).
	^ answer
]

{ #category : 'ops' }
StMSum >> timesFunction: symbolic [

	| answer |
	answer := self class new.
	answer addPlusTerm: (StMProduct with: const times: symbolic).
	plusTerms do: [ :plusTerm |
		answer addPlusTerm: (plusTerm timesFunction: symbolic) ].
	minusTerms do: [ :minusTerm |
		answer addMinusTerm: (minusTerm timesFunction: symbolic) ].
	^ answer
]

{ #category : 'accessing' }
StMSum >> timesProduct: aProduct [

	^ aProduct timesSum: self
]

{ #category : 'ops' }
StMSum >> timesSum: aSum [
	"(a + b)*(A + B + C) = (a*A + a*B + a*C + b*A + b*B + b*C)"

	| answer |
	[ aSum isSum ] assert.
	answer := self class new.
	answer addPlusTerm: const * aSum const.
	aSum plusTerms do: [ :term |
		answer addPlusTerm: (term timesFunction: const) ].
	aSum minusTerms do: [ :term |
		answer addMinusTerm: (term timesFunction: const) ].
	plusTerms do: [ :plusTerm |
			answer addPlusTerm: (plusTerm timesFunction: aSum const).
			aSum plusTerms do: [ :term |
				answer addPlusTerm: (plusTerm times: term) ].
			aSum minusTerms do: [ :term |
				answer addMinusTerm: (plusTerm times: term) ] ].
	minusTerms do: [ :minusTerm |
			answer addMinusTerm: (minusTerm timesFunction: aSum const).
			aSum plusTerms do: [ :term |
				answer addMinusTerm: (minusTerm times: term) ].
			aSum minusTerms do: [ :term |
				answer addPlusTerm: (minusTerm times: term) ] ].
	^ answer
]

{ #category : 'evaluating' }
StMSum >> value [

	| answer |
	answer := 0.0.
	plusTerms do: [ :term | answer := answer + term value ].
	minusTerms do: [ :term | answer := answer - term value ].
	^ answer
]
