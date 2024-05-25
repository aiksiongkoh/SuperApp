Class {
	#name : 'StMFunctionX',
	#superclass : 'StMFunction',
	#instVars : [
		'x'
	],
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'accessing' }
StMFunctionX class >> functionTemplate [
	^self functionSymbol , '(x)'
]

{ #category : 'VisualWorks metadata' }
StMFunctionX class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'instance creation' }
StMFunctionX class >> with: arg [ 
	^super new x: arg
]

{ #category : 'comparing' }
StMFunctionX >> = anObject [ 
	^super = anObject and: [x = anObject x]
]

{ #category : 'message handling' }
StMFunctionX >> argsPerform: selector withArguments: anArray [ 
	Processor yield.
	x perform: selector withArguments: anArray
]

{ #category : 'accessing' }
StMFunctionX >> arguments: array [ 
	array size == 1 ifFalse: [ArgumentNumberError raise].
	self x: (array at: 1)
]

{ #category : 'StCAD-UI' }
StMFunctionX >> cadStringOn: aStream [ 
	aStream nextPutAll: self class functionSymbol.
	aStream nextPut: $(.
	x cadStringOn: aStream.
	aStream nextPut: $)
]

{ #category : 'evaluating' }
StMFunctionX >> differentiateWRT: variable [ 
	| dfdx dxdvar |
	self == variable ifTrue: [^StMConstant with: 1].
	dfdx := self differentiateWRTx.
	dxdvar := x differentiateWRT: variable.
	^dfdx times: dxdvar
]

{ #category : 'evaluating' }
StMFunctionX >> differentiateWRTx [
	self subclassResponsibility
]

{ #category : 'evaluating' }
StMFunctionX >> expandUntil: set [ 
	| xx copy |
	^(set includes: self)
		ifTrue: [self]
		ifFalse: 
			[xx := x expandUntil: set.
			copy := self class with: xx.
			xx isConstant
				ifTrue: [StMConstant with: copy value]
				ifFalse: [copy]]
]

{ #category : 'evaluating' }
StMFunctionX >> partialDifferentiateWRT: variable [ 
	| dfdx dxdvar |
	self == variable ifTrue: [^StMConstant with: 1].
	dfdx := self differentiateWRTx.
	dxdvar := x partialDifferentiateWRT: variable.
	^dfdx times: dxdvar
]

{ #category : 'copying' }
StMFunctionX >> postCopy [
	x := x copy
]

{ #category : 'printing' }
StMFunctionX >> print_cArgumentOn: aStream [ 
	aStream print: x
]

{ #category : 'accessing' }
StMFunctionX >> setx: arg [ 
	x := arg
]

{ #category : 'evaluating' }
StMFunctionX >> simplifyUntil: set [ 
	| xx copy |
	^(set includes: self)
		ifTrue: [self]
		ifFalse: 
			[xx := x simplifyUntil: set.
			copy := self class with: xx.
			xx isConstant
				ifTrue: [StMConstant with: copy value]
				ifFalse: [copy]]
]

{ #category : 'changing' }
StMFunctionX >> substitute: var1 with: var2 [ 
	| xx |
	^self = var1
		ifTrue: [var2]
		ifFalse: 
			[xx := x substitute: var1 with: var2.
			self class with: xx]
]

{ #category : 'accessing' }
StMFunctionX >> x [

	^ x
]

{ #category : 'accessing' }
StMFunctionX >> x: arg [ 
	x := self conditionArgument: arg
]
