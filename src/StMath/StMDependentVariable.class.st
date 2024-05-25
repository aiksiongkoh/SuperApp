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
StMDependentVariable >> differentiateWRT: variable [ 
	| dfdx dxdvar |
	self == variable ifTrue: [^StMConstant with: 1].
	dfdx := self differentiateWRTx.
	dxdvar := x differentiateWRT: variable.
	^dfdx times: dxdvar
]

{ #category : 'evaluating' }
StMDependentVariable >> differentiateWRTx [
	^StMDifferentiatedVariable with: self wrts: (OrderedCollection with: x copy)
]

{ #category : 'printing' }
StMDependentVariable >> printOn: aStream [ 
	aStream nextPutAll: name.
	aStream nextPut: $(.
	aStream print: x.
	aStream nextPut: $)
]

{ #category : 'accessing' }
StMDependentVariable >> x: arg [ 
	x := self conditionArgument: arg
]
