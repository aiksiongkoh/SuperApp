Class {
	#name : 'StMPower',
	#superclass : 'StMFunctionXY',
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'VisualWorks metadata' }
StMPower class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'instance creation' }
StMPower class >> with: base raisedTo: exponent [

	^ super new x: base y: exponent
]

{ #category : 'converting' }
StMPower >> asValue [

	^ x asValue raisedTo: y asValue
]

{ #category : 'StCAD-UI' }
StMPower >> cadStringOn: aStream [ 
	x cadStringOn: aStream.
	aStream nextPutAll: '^'.
	y cadStringOn: aStream
]

{ #category : 'evaluating' }
StMPower >> differentiateWRTx [
	| ycopy |
	ycopy := y copy.
	^ycopy times: (x copy raisedTo: (ycopy plus: -1)) simplified
]

{ #category : 'evaluating' }
StMPower >> differentiateWRTy [
	^(self copy times: (StMLn with: x copy)) simplified
]

{ #category : 'testing' }
StMPower >> isReciprocal [

	^ y = -1
]

{ #category : 'printing' }
StMPower >> printOn: aStream [

	aStream
		nextPut: $(;
		print: x;
		nextPut: $^;
		print: y;
		nextPut: $)
]

{ #category : 'evaluating' }
StMPower >> simplifyPower [

	y isConstant ifTrue: [ ^self ].
	self halt: 'Check this.'
]

{ #category : 'evaluating' }
StMPower >> simplifyUntil: set [

	| xx yy copy |
	(set includes: self) ifTrue: [ ^ self ].
	xx := x simplifyUntil: set.
	yy := y simplifyUntil: set.
	copy := self class with: xx with: yy.
	xx isConstant
		ifTrue: [
			xx isZero ifTrue: [ ^ StMConstant with: 0 ].
			xx isOne ifTrue: [ ^ StMConstant with: 1 ].
			yy isConstant ifTrue: [ ^ StMConstant with: copy value ] ]
		ifFalse: [
			yy isConstant ifTrue: [
				yy isZero ifTrue: [ ^ StMConstant with: 1 ].
				yy isOne ifTrue: [ ^ xx ].
				yy even ifTrue: [ xx isNegative ifTrue: [ ^ StMPower with: xx negated with: yy ] ] ] ].
	^ copy
]

{ #category : 'evaluating' }
StMPower >> value [
	^x value raisedTo: y value
]
