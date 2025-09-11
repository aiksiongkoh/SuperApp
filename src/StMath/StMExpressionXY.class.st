Class {
	#name : 'StMExpressionXY',
	#superclass : 'StMFunctionXY',
	#instVars : [
		'expression'
	],
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'VisualWorks metadata' }
StMExpressionXY class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'instance creation' }
StMExpressionXY class >> with: argx and: argy expression: func [ 
	^super new
		x: argx
		y: argy
		expression: func
]

{ #category : 'comparing' }
StMExpressionXY >> = anObject [ 
	^super = anObject and: [expression = anObject expression]
]

{ #category : 'message handling' }
StMExpressionXY >> argsPerform: selector withArguments: anArray [ 
	super argsPerform: selector withArguments: anArray.
	expression perform: selector withArguments: anArray
]

{ #category : 'evaluating' }
StMExpressionXY >> differentiateWRT: var [

	^ var isSequenceable
		  ifTrue: [ var collect: [ :vari | self differentiateWRT: vari ] ]
		  ifFalse: [ expression differentiateWRT: var ]
]

{ #category : 'evaluating' }
StMExpressionXY >> expandUntil: set [ 
	^(set includes: self)
		ifTrue: [self]
		ifFalse: [expression expandUntil: set]
]

{ #category : 'comparing' }
StMExpressionXY >> hash [

	^ super hash bitXor: expression hash
]

{ #category : 'evaluating' }
StMExpressionXY >> partialDifferentiateWRT: variable [ 
	^expression partialDifferentiateWRT: variable
]

{ #category : 'copying' }
StMExpressionXY >> postCopy [
	super postCopy.
	expression := expression copy
]

{ #category : 'printing' }
StMExpressionXY >> printOn: aStream [

	aStream
		print: self class;
		nextPut: $(;
		print: expression;
		nextPut: $)
]

{ #category : 'evaluating' }
StMExpressionXY >> simplifyUntil: set [ 
	^(set includes: self)
		ifTrue: [self]
		ifFalse: [expression simplifyUntil: set]
]

{ #category : 'changing' }
StMExpressionXY >> substitute: var1 with: var2 [ 
	| xx yy expr |
	^self = var1
		ifTrue: [var2]
		ifFalse: 
			[xx := x substitute: var1 with: var2.
			yy := y substitute: var1 with: var2.
			expr := expression substitute: var1 with: var2.
			self class
				with: xx
				and: yy
				expression: expr]
]

{ #category : 'evaluating' }
StMExpressionXY >> value [
	^expression value
]

{ #category : 'accessing' }
StMExpressionXY >> x: arg [ 
	| xold |
	xold := x.
	super x: arg.
	expression notNil ifTrue: [expression := expression substitute: xold with: x]
]

{ #category : 'initialize-release' }
StMExpressionXY >> x: argx y: argy expression: func [ 
	x := self conditionArgument: argx.
	y := self conditionArgument: argy.
	expression := self conditionArgument: func
]

{ #category : 'accessing' }
StMExpressionXY >> y: arg [ 
	| yold |
	yold := y.
	super y: arg.
	expression notNil ifTrue: [expression := expression substitute: yold with: y]
]
