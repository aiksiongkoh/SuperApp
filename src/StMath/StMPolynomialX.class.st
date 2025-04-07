Class {
	#name : 'StMPolynomialX',
	#superclass : 'StMFunctionX',
	#instVars : [
		'coeffs'
	],
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'VisualWorks metadata' }
StMPolynomialX class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'instance creation' }
StMPolynomialX class >> with: var coeffs: funcs [ 
	^super new x: var coeffs: funcs
]

{ #category : 'comparing' }
StMPolynomialX >> = anObject [ 
	^super = anObject and: [coeffs = anObject coeffs]
]

{ #category : 'message handling' }
StMPolynomialX >> argsPerform: selector withArguments: anArray [ 
	super argsPerform: selector withArguments: anArray.
	coeffs do: [:coeff | coeff perform: selector withArguments: anArray]
]

{ #category : 'changing' }
StMPolynomialX >> asExpression [
	| answer terms |
	answer := StMSum new.
	terms := answer terms.
	1 to: coeffs size
		do: 
			[:i | 
			| coeff term |
			coeff := coeffs at: i.
			i > 2
				ifTrue: [term := coeff * (x raisedTo: i - 1)]
				ifFalse: [i = 2
						ifTrue: [term := coeff * x]
						ifFalse: [term := coeff]].
			terms add: term].
	^answer
]

{ #category : 'StCAD-UI' }
StMPolynomialX >> cadStringOn: aStream [ 
	| coeffSize |
	coeffSize := coeffs size.
	coeffSize > 1 ifTrue: [aStream nextPut: $(].
	1 to: coeffSize
		do: 
			[:i | 
			i > 1 ifTrue: [aStream nextPutAll: ' + '].
			(coeffs at: i)
				cadStringOn: aStream.
			i > 1
				ifTrue: 
					[aStream nextPut: $*.
					x cadStringOn: aStream].
			i > 2
				ifTrue: 
					[aStream nextPut: $^.
					aStream nextPutAll: (i - 1) asString]].
	coeffSize > 1 ifTrue: [aStream nextPut: $)]
]

{ #category : 'accessing' }
StMPolynomialX >> coeffs [
	^coeffs
]

{ #category : 'accessing' }
StMPolynomialX >> coeffs: collection [ 
	coeffs := collection collect: [:coeff | self conditionArgument: coeff]
]

{ #category : 'evaluating' }
StMPolynomialX >> derivative: n at: xx [ 
	| newCoeffSize xpower answer |
	newCoeffSize := coeffs size - n.
	answer := 0.0.
	newCoeffSize > 0
		ifTrue: 
			[xpower := 1.0.
			1 to: newCoeffSize
				do: 
					[:index | 
					| diffCoeff indexpn |
					diffCoeff := 1.
					indexpn := index + n.
					1 to: n do: [:ideriv | diffCoeff := diffCoeff * (indexpn - ideriv)].
					answer := answer + (diffCoeff asDouble * xpower * (coeffs at: indexpn) value).
					xpower := xpower * xx]].
	^answer
]

{ #category : 'evaluating' }
StMPolynomialX >> differentiateWRT: variable [ 
	| dfuncdx dxdvar dcoeffsdvar |
	self == variable ifTrue: [^StMConstant with: 1].
	dfuncdx := self differentiateWRTx.
	dxdvar := x differentiateWRT: variable.
	dcoeffsdvar := StMPolynomialX with: x copy coeffs: (coeffs collect: [:coeff | coeff differentiateWRT: variable]).
	^(dfuncdx times: dxdvar)
		plus: dcoeffsdvar
]

{ #category : 'evaluating' }
StMPolynomialX >> differentiateWRTx [
	| n newCoeffs |
	n := coeffs size.
	n < 2 ifTrue: [^StMConstant with: 0].
	n == 2 ifTrue: [^coeffs at: 2].
	newCoeffs := Array new: n - 1.
	2 to: n do: [:i | newCoeffs at: i - 1 put: ((coeffs at: i)
				times: i - 1)].
	^StMPolynomialX with: x copy coeffs: newCoeffs
]

{ #category : 'evaluating' }
StMPolynomialX >> expandUntil: set [ 
	^(set includes: self)
		ifTrue: [self]
		ifFalse: [self asExpression expandUntil: set]
]

{ #category : 'comparing' }
StMPolynomialX >> hash [

	| hash |
	hash := super hash.
	hash := hash bitXor: coeffs hash.
	^ hash
]

{ #category : 'testing' }
StMPolynomialX >> isZero [
	coeffs do: [:coeff | coeff isZero ifFalse: [^false]].
	^true
]

{ #category : 'accessing' }
StMPolynomialX >> order [
	^coeffs size - 1
]

{ #category : 'evaluating' }
StMPolynomialX >> partialDifferentiateWRT: variable [ 
	| dfuncdx dxdvar dcoeffsdvar |
	self == variable ifTrue: [^StMConstant with: 1].
	dfuncdx := self differentiateWRTx.
	dxdvar := x partialDifferentiateWRT: variable.
	dcoeffsdvar := self class with: x copy coeffs: (coeffs collect: [:coeff | coeff partialDifferentiateWRT: variable]).
	^(dfuncdx times: dxdvar)
		plus: dcoeffsdvar
]

{ #category : 'copying' }
StMPolynomialX >> postCopy [
	super postCopy.
	coeffs := coeffs collect: [:coeff | coeff copy]
]

{ #category : 'printing' }
StMPolynomialX >> printOn1: aStream [ 
	| coeffSize |
	coeffSize := coeffs size.
	coeffSize > 1 ifTrue: [aStream nextPut: $(].
	1 to: coeffSize
		do: 
			[:i | 
			i > 1 ifTrue: [aStream nextPutAll: ' + '].
			aStream print: (coeffs at: i).
			i > 1
				ifTrue: 
					[aStream nextPut: $*.
					aStream print: x].
			i > 2
				ifTrue: 
					[aStream nextPut: $^.
					aStream nextPutAll: (i - 1) asString]].
	coeffSize > 1 ifTrue: [aStream nextPut: $)]
]

{ #category : 'printing' }
StMPolynomialX >> printOn: aStream [

	aStream
		print: self class;
		nextPut: $(;
		print: x.
	coeffs do: [ :coeff |
		aStream
			nextPutAll: ', ';
			print: coeff ].
	aStream nextPut: $)
]

{ #category : 'evaluating' }
StMPolynomialX >> simplifyUntil: set [ 
	| xx copy newCoeffs |
	^(set includes: self)
		ifTrue: [self]
		ifFalse: 
			[xx := x simplifyUntil: set.
			newCoeffs := (coeffs collect: [:coeff | coeff simplifyUntil: set]) asOrderedCollection.
			[newCoeffs last isZero]
				whileTrue: [newCoeffs removeLast].
			copy := self class with: xx coeffs: newCoeffs.
			xx isConstant
				ifTrue: [StMConstant with: copy value]
				ifFalse: [copy]]
]

{ #category : 'changing' }
StMPolynomialX >> substitute: var1 with: var2 [ 
	| xx newCoeffs |
	^self = var1
		ifTrue: [var2]
		ifFalse: 
			[xx := x substitute: var1 with: var2.
			newCoeffs := coeffs collect: [:coeff | coeff substitute: var1 with: var2].
			self class with: xx coeffs: newCoeffs]
]

{ #category : 'evaluating' }
StMPolynomialX >> value [
	| xvalue xpower answer |
	xvalue := x value.
	xpower := 1.0.
	answer := 0.0.
	1 to: coeffs size
		do: 
			[:i | 
			answer := answer + ((coeffs at: i) value * xpower).
			xpower := xpower * xvalue].
	^answer
]

{ #category : 'initialize-release' }
StMPolynomialX >> x: arg coeffs: funcs [ 
	x := self conditionArgument: arg.
	coeffs := funcs collect: [:func | self conditionArgument: func]
]
