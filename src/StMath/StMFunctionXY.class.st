Class {
	#name : 'StMFunctionXY',
	#superclass : 'StMFunction',
	#instVars : [
		'x',
		'y'
	],
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'accessing' }
StMFunctionXY class >> functionTemplate [
	^self functionSymbol , '(x, y)'
]

{ #category : 'VisualWorks metadata' }
StMFunctionXY class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'instance creation' }
StMFunctionXY class >> with: xx with: yy [ 
	^super new x: xx y: yy
]

{ #category : 'comparing' }
StMFunctionXY >> = anObject [ 
	^super = anObject and: [x = anObject x and: [y = anObject y]]
]

{ #category : 'message handling' }
StMFunctionXY >> argsPerform: selector withArguments: anArray [ 
	Processor yield.
	x perform: selector withArguments: anArray.
	y perform: selector withArguments: anArray
]

{ #category : 'StCAD-UI' }
StMFunctionXY >> cadStringOn: aStream [ 
	aStream nextPutAll: self class functionSymbol.
	aStream nextPut: $(.
	x cadStringOn: aStream.
	aStream nextPutAll: ', '.
	y cadStringOn: aStream.
	aStream nextPut: $)
]

{ #category : 'evaluating' }
StMFunctionXY >> differentiateWRT: var [

	^ var isSequenceable
		  ifTrue: [ var collect: [ :vari | self differentiateWRT: vari ] ]
		  ifFalse: [
				  | dfdx dxdvar dfdy dydvar |
				  self == var ifTrue: [ ^ StMConstant with: 1 ].
				  dfdx := self differentiateWRTx.
				  dxdvar := x differentiateWRT: var.
				  dfdy := self differentiateWRTy.
				  dydvar := y differentiateWRT: var.
				  (dfdx times: dxdvar) plus: (dfdy times: dydvar) ]
]

{ #category : 'evaluating' }
StMFunctionXY >> differentiateWRTx [
	self subclassResponsibility
]

{ #category : 'evaluating' }
StMFunctionXY >> differentiateWRTy [
	self subclassResponsibility
]

{ #category : 'evaluating' }
StMFunctionXY >> expandUntil: set [ 
	| xx yy copy |
	^(set includes: self)
		ifTrue: [self]
		ifFalse: 
			[xx := x expandUntil: set.
			yy := y expandUntil: set.
			copy := self class with: xx with: yy.
			(xx isConstant and: [yy isConstant])
				ifTrue: [StMConstant with: copy value]
				ifFalse: [copy]]
]

{ #category : 'comparing' }
StMFunctionXY >> hash [

	| hash |
	hash := self class hash.
	hash := hash bitXor: x hash.
	hash := hash bitXor: y hash.
	^ hash
]

{ #category : 'evaluating' }
StMFunctionXY >> partialDifferentiateWRT: variable [ 
	| dfdx dxdvar dfdy dydvar |
	self == variable ifTrue: [^StMConstant with: 1].
	dfdx := self differentiateWRTx.
	dxdvar := x partialDifferentiateWRT: variable.
	dfdy := self differentiateWRTy.
	dydvar := y partialDifferentiateWRT: variable.
	^(dfdx times: dxdvar)
		plus: (dfdy times: dydvar)
]

{ #category : 'copying' }
StMFunctionXY >> postCopy [
	x := x copy.
	y := y copy
]

{ #category : 'printing' }
StMFunctionXY >> printOn: aStream [

	aStream
		print: self class;
		nextPut: $(;
		print: x;
		nextPutAll: ', ';
		print: y;
		nextPut: $)
]

{ #category : 'evaluating' }
StMFunctionXY >> simplifyUntil: set [ 
	| xx yy copy |
	^(set includes: self)
		ifTrue: [self]
		ifFalse: 
			[xx := x simplifyUntil: set.
			yy := y simplifyUntil: set.
			copy := self class with: xx with: yy.
			(xx isConstant and: [yy isConstant])
				ifTrue: [StMConstant with: copy value]
				ifFalse: [copy]]
]

{ #category : 'changing' }
StMFunctionXY >> substitute: var1 with: var2 [ 
	| xx yy |
	^self = var1
		ifTrue: [var2]
		ifFalse: 
			[xx := x substitute: var1 with: var2.
			yy := y substitute: var1 with: var2.
			self class with: xx with: yy]
]

{ #category : 'accessing' }
StMFunctionXY >> x [

	^ x
]

{ #category : 'accessing' }
StMFunctionXY >> x: arg [ 
	x := self conditionArgument: arg
]

{ #category : 'accessing' }
StMFunctionXY >> x: argx y: argy [ 
	x := self conditionArgument: argx.
	y := self conditionArgument: argy
]

{ #category : 'accessing' }
StMFunctionXY >> y [

	^ y
]

{ #category : 'accessing' }
StMFunctionXY >> y: arg [ 
	y := self conditionArgument: arg
]
