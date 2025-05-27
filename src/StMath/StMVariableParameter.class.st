"
Variable Parameter is a known function (rhs) of independent variable (x).
"
Class {
	#name : 'StMVariableParameter',
	#superclass : 'StMDependentVariable',
	#instVars : [
		'rhs'
	],
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'VisualWorks metadata' }
StMVariableParameter class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'converting' }
StMVariableParameter >> asNumber [

	^ rhs ifNotNil: [ rhs asNumber ] ifNil: [ super asNumber ]
]

{ #category : 'converting' }
StMVariableParameter >> asValue [

	^ rhs ifNotNil: [ rhs asValue ] ifNil: [ super asValue ]
]

{ #category : 'evaluating' }
StMVariableParameter >> differentiateWRTx [

	| newSelf |
	newSelf := self simplified.
	^ newSelf isZero
		  ifTrue: [ StMConstant with: 0.0 ]
		  ifFalse: [ StMDifferentiatedVariable with: self wrts: (OrderedCollection with: x copy) ]
]

{ #category : 'initialization' }
StMVariableParameter >> initialize [

	rhs := StMConstant with: 0.0
]

{ #category : 'printing' }
StMVariableParameter >> printOn: aStream [

	aStream nextPutAll: name.
	aStream nextPut: $(.
	aStream print: x.
	aStream nextPut: $,.
	aStream print: rhs.
	aStream nextPut: $,.
	aStream print: value.
	aStream nextPut: $)
]

{ #category : 'accessing' }
StMVariableParameter >> rhs [

	^ rhs
]

{ #category : 'accessing' }
StMVariableParameter >> rhs: expression [

	rhs := expression
]

{ #category : 'evaluating' }
StMVariableParameter >> simplifyUntil: set [

	[ x isNil or: [ x isIndependentVariable ] ] assert.
	rhs ifNotNil: [
		rhs := rhs simplifyUntil: set.
		rhs isZero ifTrue: [
			rhs isConstant ifFalse: [
				self halt.
				rhs := StMConstant with: 0.0 ] ] ]
]
