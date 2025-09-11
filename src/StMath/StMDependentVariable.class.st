"
The dependent variable is an unknown function of its argument x.
"
Class {
	#name : 'StMDependentVariable',
	#superclass : 'StMVariable',
	#instVars : [
		'x'
	],
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'binary storage' }
StMDependentVariable class >> binaryReaderBlockForVersion: oldVersion format: oldFormat [ 
	"Remove the instance variable 'value dependents x name'."
	"Remove the instance variable 'name value x'."

	oldVersion == nil
		ifTrue: 
			[| inst |
			inst := self basicNew.
			^
			[:oldObj | 
			| new |
			new := Array new: 3.
			new at: 1 put: (oldObj at: 4).
			new at: 2 put: (oldObj at: 1).
			new at: 3 put: (oldObj at: 3).
			oldObj become: new.
			oldObj changeClassToThatOf: inst]].
	^super binaryReaderBlockForVersion: oldVersion format: oldFormat
]

{ #category : 'VisualWorks metadata' }
StMDependentVariable class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'accessing' }
StMDependentVariable >> aIndependentVariable [
	^x aIndependentVariable
]

{ #category : 'evaluating' }
StMDependentVariable >> differentiateWRT: var [

	^ var isSequenceable
		  ifTrue: [ var collect: [ :vari | self differentiateWRT: vari ] ]
		  ifFalse: [
				  | dfdx dxdvar |
				  self == var ifTrue: [ ^ StMConstant with: 1 ].
				  x ifNil: [ ^ StMConstant with: 0 ].
				  dfdx := self differentiateWRTx.
				  dfdx isZero ifTrue: [ ^ StMConstant with: 0 ].
				  dxdvar := x differentiateWRT: var.
				  dxdvar isZero ifTrue: [ ^ StMConstant with: 0 ].
				  (dfdx times: dxdvar) simplified ]
]

{ #category : 'evaluating' }
StMDependentVariable >> differentiateWRTx [

	^ StMDifferentiatedVariable with: self wrts: (OrderedCollection with: x copy)
]

{ #category : 'accessing' }
StMDependentVariable >> independentVar [

	^ x independentVar
]

{ #category : 'printing' }
StMDependentVariable >> printOn: aStream [

	aStream nextPutAll: name.
	aStream nextPut: $(.
	aStream print: x.
	aStream nextPut: $,.
	aStream print: value.
	aStream nextPut: $)
]

{ #category : 'evaluating' }
StMDependentVariable >> simplifyUntil: set [

	x ifNotNil: [
		x := x simplifyUntil: set.
		x isZero ifTrue: [ ^ StMConstant with: 0.0 ] ]
]

{ #category : 'accessing' }
StMDependentVariable >> x [
	^ x
]

{ #category : 'accessing' }
StMDependentVariable >> x: arg [ 
	x := self conditionArgument: arg
]
