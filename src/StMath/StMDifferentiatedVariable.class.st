"
x is the variable to be differentiated.
wrt := 'with respect to'.

Instance Variables:

wrt	<OrderedCollection>	stores the differential variables in order of differentiation use.
"
Class {
	#name : 'StMDifferentiatedVariable',
	#superclass : 'StMDependentVariable',
	#instVars : [
		'wrts',
		'derivative'
	],
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'binary storage' }
StMDifferentiatedVariable class >> binaryReaderBlockForVersion: oldVersion format: oldFormat [ 
	"Remove the instance variable 'value dependents x name wrts'."
	"Remove the instance variable 'name value x wrts'."

	oldVersion == nil
		ifTrue: 
			[| inst |
			inst := self basicNew.
			^
			[:oldObj | 
			| new |
			new := Array new: 4.
			new at: 1 put: (oldObj at: 4).
			new at: 2 put: (oldObj at: 1).
			new at: 3 put: (oldObj at: 3).
			new at: 4 put: (oldObj at: 5).
			oldObj become: new.
			oldObj changeClassToThatOf: inst]].
	^super binaryReaderBlockForVersion: oldVersion format: oldFormat
]

{ #category : 'VisualWorks metadata' }
StMDifferentiatedVariable class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'instance creation' }
StMDifferentiatedVariable class >> with: var wrts: derivs [ 
	^super new x: var wrts: derivs
]

{ #category : 'comparing' }
StMDifferentiatedVariable >> = anObject [

	^ self == anObject or: [
		  self class == anObject class and: [ x = anObject x and: [ wrts = anObject wrts ] ] ]
]

{ #category : 'converting' }
StMDifferentiatedVariable >> asValue [

	^ (x isMemberOf: UnknownDependentVariable)
		  ifTrue: [ value ifNil: [ 0.0 ] ifNotNil: [ value asValue ] ]
		  ifFalse: [
			  (x isMemberOf: StMVariableParameter)
				  ifTrue: [ derivative asValue ]
				  ifFalse: [ self halt ] ]
]

{ #category : 'copying' }
StMDifferentiatedVariable >> copy [
	^self shallowCopy postCopy
]

{ #category : 'evaluating' }
StMDifferentiatedVariable >> differentiateWRT: variable [

	^ variable isIndependentVariable
		  ifTrue: [
			  self copy
				  wrtsAdd: variable copy;
				  yourself ]
		  ifFalse: [ StMConstant with: 0.0 ]
]

{ #category : 'evaluating' }
StMDifferentiatedVariable >> differentiateWRTx [

	| xcopy answer |
	self halt.
	xcopy := x copy.
	answer := self class new.
	answer x: xcopy.
	wrts do: [ :wrt | answer wrtsAdd: wrt ].
	answer wrtsAdd: xcopy.
	^ answer
]

{ #category : 'initialize-release' }
StMDifferentiatedVariable >> initialize [
	super initialize.
	wrts := OrderedCollection new
]

{ #category : 'copying' }
StMDifferentiatedVariable >> postCopy [
	x := x copy.
	wrts := wrts collect: [:a | a copy]
]

{ #category : 'printing' }
StMDifferentiatedVariable >> printOn: aStream [

	aStream nextPutAll: 'diff('.
	aStream print: x.
	aStream nextPutAll: ' wrt '.
	wrts do: [ :wrt | aStream print: wrt ] separatedBy: [ aStream nextPut: $, ].
	aStream nextPut: $)
]

{ #category : 'changing' }
StMDifferentiatedVariable >> substitute: var1 with: var2 [

	| xx wrts2 |
	self halt.
	^ self = var1
		  ifTrue: [ var2 ]
		  ifFalse: [
			  xx := x substitute: var1 with: var2.
			  wrts2 := wrts collect: [ :wrt | wrt substitute: var1 with: var2 ].
			  self class with: xx wrts: wrts2 ]
]

{ #category : 'accessing' }
StMDifferentiatedVariable >> wrts [

	^ wrts
]

{ #category : 'accessing' }
StMDifferentiatedVariable >> wrtsAdd: variable [

	| var |
	var := self conditionArgument: variable.
	wrts add: var.
	derivative
		ifNil: [
			(x isMemberOf: StMVariableParameter)
				ifTrue: [ derivative := x rhs differentiateWRT: var ]
				ifFalse: [ [ x isMemberOf: UnknownDependentVariable ] assert ] ]
		ifNotNil: [ derivative := derivative differentiateWRT: var ]
]

{ #category : 'accessing' }
StMDifferentiatedVariable >> x: arg [

	| xold |
	self halt.
	xold := x.
	super x: arg.
	wrts := wrts collect: [ :wrt | wrt substitute: xold with: x ]
]

{ #category : 'initialize-release' }
StMDifferentiatedVariable >> x: var wrts: derivs [

	x := self conditionArgument: var.
	derivs do: [ :deriv | self wrtsAdd: deriv ]
]
