Class {
	#name : 'StMArcTan2',
	#superclass : 'StMFunctionXY',
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'accessing' }
StMArcTan2 class >> functionSymbol [
	^'arctan2'
]

{ #category : 'VisualWorks metadata' }
StMArcTan2 class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'evaluating' }
StMArcTan2 >> differentiateWRT: var [

	^ var isSequenceable
		  ifTrue: [ var collect: [ :vari | self differentiateWRT: vari ] ]
		  ifFalse: [
				  | arg dargdvar dfuncdarg |
				  self == var ifTrue: [ ^ StMConstant with: 1 ].
				  arg := y copy times: x copy reciprocal.
				  dargdvar := arg differentiateWRT: var.
				  dfuncdarg := ((arg raisedTo: 2) plus: 1) reciprocal.
				  dfuncdarg times: dargdvar ]
]

{ #category : 'evaluating' }
StMArcTan2 >> partialDifferentiateWRT: variable [ 
	| arg dargdvar dfuncdarg |
	self == variable ifTrue: [^StMConstant with: 1].
	arg := y copy times: x copy reciprocal.
	dargdvar := arg partialDifferentiateWRT: variable.
	dfuncdarg := ((arg raisedTo: 2)
				plus: 1) reciprocal.
	^dfuncdarg times: dargdvar
]

{ #category : 'evaluating' }
StMArcTan2 >> simplifyUntil: set [ 
	| xx yy copy |
	(set includes: self)
		ifTrue: [^self].
	xx := x simplifyUntil: set.
	yy := y simplifyUntil: set.
	copy := self class with: xx with: yy.
	xx isConstant
		ifTrue: [yy isConstant ifTrue: [^StMConstant with: copy value]]
		ifFalse: [yy isConstant ifTrue: [yy isZero ifTrue: [^StMConstant with: 0]]].
	^copy
]

{ #category : 'evaluating' }
StMArcTan2 >> value [
	^Double arcTanMpiTOpiY: y value overX: x value
]
