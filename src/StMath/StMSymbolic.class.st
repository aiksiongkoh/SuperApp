Class {
	#name : 'StMSymbolic',
	#superclass : 'StMath',
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'VisualWorks metadata' }
StMSymbolic class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
	)

]

{ #category : 'ops' }
StMSymbolic >> * arg [

	^ self times: arg
]

{ #category : 'ops' }
StMSymbolic >> + arg [

	^ self plus: arg
]

{ #category : 'ops' }
StMSymbolic >> - arg [

	| func |
	func := self conditionArgument: arg.
	^ StMSum with: self copy minus: func
]

{ #category : 'ops' }
StMSymbolic >> / arg [

	| func |
	func := self conditionArgument: arg.
	^ StMProduct with: self shallowCopy over: func
]

{ #category : 'comparing' }
StMSymbolic >> = anObject [ 
	self subclassResponsibility
]

{ #category : 'ops' }
StMSymbolic >> abs [

	^ self isZero
		  ifTrue: [ StMConstant with: 0.0 ]
		  ifFalse: [ StMAbs with: self copy ]
]

{ #category : 'message handling' }
StMSymbolic >> adaptToNumber: rcvr andSend: selector [

	| aConstant |
	aConstant := StMConstant with: rcvr.
	^ aConstant perform: selector with: self
]

{ #category : 'ops' }
StMSymbolic >> arcTan [

	^ self isZero
		  ifTrue: [ StMConstant with: 0.0 ]
		  ifFalse: [ StMArcTan with: self copy ]
]

{ #category : 'message handling' }
StMSymbolic >> argsPerform: selector withArguments: anArray [ 
	self subclassResponsibility
]

{ #category : 'changing' }
StMSymbolic >> asFloat [

	^ self
]

{ #category : 'changing' }
StMSymbolic >> asFunctionOf: xarg [ 
	^StMExpressionX with: xarg expression: self
]

{ #category : 'changing' }
StMSymbolic >> asFunctionOf: xarg and: yarg [ 
	^StMExpressionXY
		with: xarg
		and: yarg
		expression: self
]

{ #category : 'changing' }
StMSymbolic >> asSymbolic [

	^ self
]

{ #category : 'StCAD-UI' }
StMSymbolic >> cadString [
	"Answer a math expression for the StCAD interface."

	| aStream |
	aStream := WriteStream on: (String new: 16).
	self cadStringOn: aStream.
	^aStream contents
]

{ #category : 'StCAD-UI' }
StMSymbolic >> cadStringOn: aStream [ 
	self printOn: aStream
]

{ #category : 'ops' }
StMSymbolic >> conditionArgument: arg [ 
	| answer |
	answer := arg isNumber
				ifTrue: [StMConstant with: arg]
				ifFalse: [arg].
	^answer
]

{ #category : 'ops' }
StMSymbolic >> cos [

	^ self isZero
		  ifTrue: [ StMConstant with: 1.0 ]
		  ifFalse: [ StMCos with: self copy ]
]

{ #category : 'evaluating' }
StMSymbolic >> differentiateWRT: variable [ 
	self subclassResponsibility
]

{ #category : 'message handling' }
StMSymbolic >> doesNotUnderstand: aMessage [ 
	^self argsPerform: aMessage selector withArguments: aMessage arguments
]

{ #category : 'ops' }
StMSymbolic >> exp [

	^ self isZero
		  ifTrue: [ StMConstant with: 1.0 ]
		  ifFalse: [ StMExp with: self copy ]
]

{ #category : 'evaluating' }
StMSymbolic >> expandUntil: set [

	^ self
]

{ #category : 'testing' }
StMSymbolic >> hasCosSq [

	^ false
]

{ #category : 'testing' }
StMSymbolic >> hasSinSq [

	^ false
]

{ #category : 'comparing' }
StMSymbolic >> hash [

	self halt: 'Check this.'
]

{ #category : 'accessing' }
StMSymbolic >> independentVar [

	^ nil
]

{ #category : 'initialization' }
StMSymbolic >> initialize [
	"Do nothing"
]

{ #category : 'testing' }
StMSymbolic >> isConstant [
	^false
]

{ #category : 'testing' }
StMSymbolic >> isCos [

	^ false
]

{ #category : 'testing' }
StMSymbolic >> isIndependentVariable [

	^ false
]

{ #category : 'testing' }
StMSymbolic >> isNegative [

	^ false
]

{ #category : 'testing' }
StMSymbolic >> isOne [
	^false
]

{ #category : 'testing' }
StMSymbolic >> isPower [

	^ false
]

{ #category : 'testing' }
StMSymbolic >> isProduct [
	^false
]

{ #category : 'testing' }
StMSymbolic >> isReciprocal [

	^ false
]

{ #category : 'testing' }
StMSymbolic >> isSequenceable [

	^ false
]

{ #category : 'testing' }
StMSymbolic >> isSin [

	^ false
]

{ #category : 'testing' }
StMSymbolic >> isSum [
	^false
]

{ #category : 'testing' }
StMSymbolic >> isSymbolic [
	^true
]

{ #category : 'testing' }
StMSymbolic >> isTrig [

	^ false
]

{ #category : 'testing' }
StMSymbolic >> isUnity [

	^ self isConstant and: [ self value = 1.0 ]
]

{ #category : 'testing' }
StMSymbolic >> isUserFunction [
	^false
]

{ #category : 'testing' }
StMSymbolic >> isZero [
	^false
]

{ #category : 'ops' }
StMSymbolic >> lg [

	^ self isOne
		  ifTrue: [ StMConstant with: 0.0 ]
		  ifFalse: [ StMLg with: self copy ]
]

{ #category : 'ops' }
StMSymbolic >> ln [

	^ self isOne
		  ifTrue: [ StMConstant with: 0.0 ]
		  ifFalse: [ StMLn with: self copy ]
]

{ #category : 'ops' }
StMSymbolic >> minus: arg [

	| func |
	func := self conditionArgument: arg.
	^ StMSum with: self minus: func
]

{ #category : 'ops' }
StMSymbolic >> negated [

	^ self isZero
		  ifTrue: [ StMConstant with: 0.0 ]
		  ifFalse: [ StMNegative with: self copy ]
]

{ #category : 'testing' }
StMSymbolic >> negative [

	^ false
]

{ #category : 'evaluating' }
StMSymbolic >> partialDifferentiateWRT: variable [ 
	self subclassResponsibility
]

{ #category : 'ops' }
StMSymbolic >> plus: arg [

	| func |
	func := self conditionArgument: arg.
	^ StMSum with: self plus: func
]

{ #category : 'copying' }
StMSymbolic >> postCopy [
	"Should always mean instance variables are copied too."

	self subclassResponsibility
]

{ #category : 'printing' }
StMSymbolic >> printOn: aStream [ 
	self subclassResponsibility
]

{ #category : 'ops' }
StMSymbolic >> raisedTo: arg [

	| exponent |
	exponent := self conditionArgument: arg.
	^ StMPower with: self raisedTo: exponent
]

{ #category : 'ops' }
StMSymbolic >> reciprocal [

	^ StMReciprocal with: self copy
]

{ #category : 'evaluating' }
StMSymbolic >> simplified [
	| answer |
	self halt: 'Depreciated.'.
	answer := self expandUntil: Set new.
	^answer simplifyUntil: Set new
]

{ #category : 'evaluating' }
StMSymbolic >> simplifyAll [
	"
	Maxima
	Constant folding: Combining constants (e.g., 2 + 3 becomes 5).
	Basic arithmetic operations: Simplifying expressions like x + 0 to x or x * 1 to x.
	Polynomial simplifications: Combining like terms, expanding products, and factoring.
	Rational expressions: Simplifying fractions by finding the greatest common divisor (GCD) of the numerator and denominator.
	Trigonometric Simplifications:
	Exponential and Logarithmic Simplifications:
	Special Functions:
	Handling symbolic expressions and applying rules to simplify them.
	SymPy
	Expansion and Factorization:
	Rational Function Simplification:
	Power Simplification:
	Trigonometric Simplification:
	Logarithmic Simplification:
	Radical Simplification:
	Bessel Function Simplification:
	Custom Simplification:
	Reduce
	Expansion
	Factoring
	Combining Like Terms
	Applying Algebraic Identities
	Rational Function Simplification
	"

	^ self simplifyZero simplifyOne simplifyNegative simplifyConstant simplifyReciprocal simplifyPower simplifyLogExp
		  simplifyTrig simplifyProduct simplifySum
]

{ #category : 'evaluating' }
StMSymbolic >> simplifyConstant [

	
]

{ #category : 'evaluating' }
StMSymbolic >> simplifyLogExp [
	"Do nothing."

	
]

{ #category : 'evaluating' }
StMSymbolic >> simplifyNegative [
	"Do nothing."

	
]

{ #category : 'evaluating' }
StMSymbolic >> simplifyOne [
	"Do nothing."

	
]

{ #category : 'evaluating' }
StMSymbolic >> simplifyPower [
	"Do nothing."

	
]

{ #category : 'evaluating' }
StMSymbolic >> simplifyProduct [
	"Do nothing."

	
]

{ #category : 'evaluating' }
StMSymbolic >> simplifyReciprocal [
	"Do nothing."

	
]

{ #category : 'evaluating' }
StMSymbolic >> simplifySum [
	"Do nothing."

	
]

{ #category : 'evaluating' }
StMSymbolic >> simplifyTrig [
	"Do nothing."

	
]

{ #category : 'evaluating' }
StMSymbolic >> simplifyZero [
	"Do nothing."

	
]

{ #category : 'ops' }
StMSymbolic >> sin [

	^ self isZero
		  ifTrue: [ StMConstant with: 0.0 ]
		  ifFalse: [ StMSin with: self copy ]
]

{ #category : 'ops' }
StMSymbolic >> sqrt [

	^ self isZero
		  ifTrue: [ StMConstant with: 0.0 ]
		  ifFalse: [ StMSqrt with: self copy ]
]

{ #category : 'changing' }
StMSymbolic >> substitute: var1 with: var2 [ 
	self subclassResponsibility
]

{ #category : 'ops' }
StMSymbolic >> tan [

	^ self isZero
		  ifTrue: [ StMConstant with: 0.0 ]
		  ifFalse: [ StMTan with: self copy ]
]

{ #category : 'ops' }
StMSymbolic >> times: symbolic [

	^ symbolic isSum
		  ifTrue: [ self timesSum: symbolic ]
		  ifFalse: [
				  symbolic isProduct
					  ifTrue: [ self timesProduct: symbolic ]
					  ifFalse: [ self timesFunction: symbolic ] ]
]

{ #category : 'ops' }
StMSymbolic >> timesFunction: symbolic [

	^ StMProduct with: self times: symbolic
]

{ #category : 'ops' }
StMSymbolic >> timesProduct: aProduct [

	^ aProduct timesFunction: self
]

{ #category : 'ops' }
StMSymbolic >> timesSum: aSum [

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
StMSymbolic >> value [
	self subclassResponsibility
]

{ #category : 'accessing - structure variables' }
StMSymbolic >> x: arg [
	"Do nothing."

	
]
