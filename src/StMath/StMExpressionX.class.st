Class {
	#name : 'StMExpressionX',
	#superclass : 'StMFunctionX',
	#instVars : [
		'expression'
	],
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'VisualWorks metadata' }
StMExpressionX class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'instance creation' }
StMExpressionX class >> with: arg expression: func [ 
	^super new x: arg expression: func
]

{ #category : 'comparing' }
StMExpressionX >> = anObject [ 
	^super = anObject and: [expression = anObject expression]
]

{ #category : 'message handling' }
StMExpressionX >> argsPerform: selector withArguments: anArray [ 
	super argsPerform: selector withArguments: anArray.
	expression perform: selector withArguments: anArray
]

{ #category : 'evaluating' }
StMExpressionX >> differentiateWRT: variable [ 
	^expression differentiateWRT: variable
]

{ #category : 'evaluating' }
StMExpressionX >> expandUntil: set [ 
	^(set includes: self)
		ifTrue: [self]
		ifFalse: [expression expandUntil: set]
]

{ #category : 'evaluating' }
StMExpressionX >> partialDifferentiateWRT: variable [ 
	^expression partialDifferentiateWRT: variable
]

{ #category : 'copying' }
StMExpressionX >> postCopy [
	super postCopy.
	expression := expression copy
]

{ #category : 'printing' }
StMExpressionX >> printOn: aStream [ 
	aStream print: self class.
	aStream nextPut: $(.
	aStream print: expression.
	aStream nextPut: $)
]

{ #category : 'evaluating' }
StMExpressionX >> simplifyUntil: set [ 
	^(set includes: self)
		ifTrue: [self]
		ifFalse: [expression simplifyUntil: set]
]

{ #category : 'changing' }
StMExpressionX >> substitute: var1 with: var2 [ 
	| xx expr |
	^self = var1
		ifTrue: [var2]
		ifFalse: 
			[xx := x substitute: var1 with: var2.
			expr := expression substitute: var1 with: var2.
			self class with: xx expression: expr]
]

{ #category : 'evaluating' }
StMExpressionX >> value [
	^expression value
]

{ #category : 'accessing' }
StMExpressionX >> x: arg [ 
	| xold |
	xold := x.
	super x: arg.
	expression notNil ifTrue: [expression := expression substitute: xold with: x]
]

{ #category : 'initialize-release' }
StMExpressionX >> x: arg expression: func [ 
	"
	Future modification: 
	Check that func is a function of arg. 
	No need for self to be dependent of arg since self is dependent of func which is indirectly 
	dependent of of arg. 
	"

	x := self conditionArgument: arg.
	expression := self conditionArgument: func
]
