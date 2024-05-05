Class {
	#name : #StMSymbolic,
	#superclass : #Object,
	#category : #'StMath-Symbolic'
}

{ #category : #'VisualWorks metadata' }
StMSymbolic class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
	)

]

{ #category : #ops }
StMSymbolic >> * arg [ 
	| func |
	func := self conditionArgument: arg.
	^StMProduct with: self copy times: func copy
]

{ #category : #ops }
StMSymbolic >> + arg [ 
	| func |
	func := self conditionArgument: arg.
	^StMSum with: self copy plus: func copy
]

{ #category : #ops }
StMSymbolic >> - arg [ 
	| func |
	func := self conditionArgument: arg.
	^StMSum with: self copy plus: func negated
]

{ #category : #ops }
StMSymbolic >> / arg [ 
	| func |
	func := self conditionArgument: arg.
	^StMProduct with: self copy times: func reciprocal
]

{ #category : #comparing }
StMSymbolic >> = anObject [ 
	self subclassResponsibility
]

{ #category : #ops }
StMSymbolic >> abs [
	^StMAbs with: self copy
]

{ #category : #'message handling' }
StMSymbolic >> adaptToNumber: rcvr andSend: selector [

	| aConstant |
	aConstant := StMConstant with: rcvr.
	^ aConstant perform: selector with: self
]

{ #category : #ops }
StMSymbolic >> arcTan [
	^StMArcTan with: self copy
]

{ #category : #'message handling' }
StMSymbolic >> argsPerform: selector withArguments: anArray [ 
	self subclassResponsibility
]

{ #category : #changing }
StMSymbolic >> asFloat [

	^ self
]

{ #category : #changing }
StMSymbolic >> asFunctionOf: xarg [ 
	^StMExpressionX with: xarg expression: self
]

{ #category : #changing }
StMSymbolic >> asFunctionOf: xarg and: yarg [ 
	^StMExpressionXY
		with: xarg
		and: yarg
		expression: self
]

{ #category : #'StCAD-UI' }
StMSymbolic >> cadString [
	"Answer a math expression for the StCAD interface."

	| aStream |
	aStream := WriteStream on: (String new: 16).
	self cadStringOn: aStream.
	^aStream contents
]

{ #category : #'StCAD-UI' }
StMSymbolic >> cadStringOn: aStream [ 
	self printOn: aStream
]

{ #category : #ops }
StMSymbolic >> conditionArgument: arg [ 
	| answer |
	answer := arg isNumber
				ifTrue: [StMConstant with: arg]
				ifFalse: [arg].
	^answer
]

{ #category : #ops }
StMSymbolic >> cos [
	^StMCos with: self copy
]

{ #category : #evaluating }
StMSymbolic >> differentiateWRT: variable [ 
	self subclassResponsibility
]

{ #category : #'message handling' }
StMSymbolic >> doesNotUnderstand: aMessage [ 
	^self argsPerform: aMessage selector withArguments: aMessage arguments
]

{ #category : #ops }
StMSymbolic >> exp [
	^StMExp with: self copy
]

{ #category : #'initialize-release' }
StMSymbolic >> initialize [
	"Do nothing"
]

{ #category : #testing }
StMSymbolic >> isConstant [
	^false
]

{ #category : #testing }
StMSymbolic >> isOne [
	^false
]

{ #category : #testing }
StMSymbolic >> isProduct [
	^false
]

{ #category : #testing }
StMSymbolic >> isReciprocal [

	^ false
]

{ #category : #testing }
StMSymbolic >> isSequenceable [

	^ false
]

{ #category : #testing }
StMSymbolic >> isSum [
	^false
]

{ #category : #testing }
StMSymbolic >> isSymbolic [
	^true
]

{ #category : #testing }
StMSymbolic >> isUserFunction [
	^false
]

{ #category : #testing }
StMSymbolic >> isZero [
	^false
]

{ #category : #ops }
StMSymbolic >> lg [
	^StMLg with: self copy
]

{ #category : #ops }
StMSymbolic >> ln [
	^StMLn with: self copy
]

{ #category : #ops }
StMSymbolic >> minus: arg [ 
	| func |
	func := self conditionArgument: arg.
	^StMSum with: self copy plus: func negated
]

{ #category : #ops }
StMSymbolic >> negated [
	^StMNegative with: self copy
]

{ #category : #testing }
StMSymbolic >> negative [

	^ false
]

{ #category : #evaluating }
StMSymbolic >> partialDifferentiateWRT: variable [ 
	self subclassResponsibility
]

{ #category : #ops }
StMSymbolic >> plus: arg [ 
	| func |
	func := self conditionArgument: arg.
	^StMSum with: self copy plus: func copy
]

{ #category : #copying }
StMSymbolic >> postCopy [
	self subclassResponsibility
]

{ #category : #printing }
StMSymbolic >> printOn: aStream [ 
	self subclassResponsibility
]

{ #category : #ops }
StMSymbolic >> raisedTo: arg [ 
	| exponent |
	exponent := self conditionArgument: arg.
	^StMPower with: self copy raisedTo: exponent copy
]

{ #category : #ops }
StMSymbolic >> reciprocal [
	^StMPower with: self copy raisedTo: -1
]

{ #category : #evaluating }
StMSymbolic >> simplified [
	| answer |
	answer := self expandUntil: Set new.
	^answer simplifyUntil: Set new
]

{ #category : #ops }
StMSymbolic >> sin [
	^StMSin with: self copy
]

{ #category : #ops }
StMSymbolic >> sqrt [
	^StMSqrt with: self copy
]

{ #category : #changing }
StMSymbolic >> substitute: var1 with: var2 [ 
	self subclassResponsibility
]

{ #category : #ops }
StMSymbolic >> tan [
	^StMTan with: self copy
]

{ #category : #ops }
StMSymbolic >> times: arg [ 
	| func |
	func := self conditionArgument: arg.
	^StMProduct with: self copy times: func copy
]

{ #category : #ops }
StMSymbolic >> timesFunction: aFunction [ 
	^self * aFunction
]

{ #category : #ops }
StMSymbolic >> timesProduct: aProduct [ 
	| answer |
	answer := aProduct copy.
	answer terms addFirst: self copy.
	^answer
]

{ #category : #ops }
StMSymbolic >> timesSum: aSum [ 
	| product |
	product := StMProduct with: self.
	^product timesSum: aSum
]

{ #category : #evaluating }
StMSymbolic >> value [
	self subclassResponsibility
]
