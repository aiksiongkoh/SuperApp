"
StMConstantParameter persists.
Cannot be absorbed by StMConstant.
"
Class {
	#name : 'StMConstantParameter',
	#superclass : 'StMConstant',
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'comparing' }
StMConstantParameter >> = anObject [

	^ super = anObject and: [ name = anObject name ]
]

{ #category : 'converting' }
StMConstantParameter >> asNumber [

	^ value asNumber
]

{ #category : 'testing' }
StMConstantParameter >> isConstant [

	^ false
]

{ #category : 'accessing' }
StMConstantParameter >> name [

	^ name
]

{ #category : 'printing' }
StMConstantParameter >> printOn: aStream [

	aStream
		print: name;
		nextPut: $(;
		print: value;
		nextPut: $)
]

{ #category : 'accessing' }
StMConstantParameter >> rhs: number [

	value := number
]

{ #category : 'evaluating' }
StMConstantParameter >> simplifyUntil: set [

	value ifNil: [ ^ self ].
	value isZero ifTrue: [ ^ StMConstant with: 0.0 ].
	^ self
]

{ #category : 'accessing' }
StMConstantParameter >> value [

	^ value ifNil: [ self ]
]

{ #category : 'private' }
StMConstantParameter >> value: arg [

	value := arg isConstant
		         ifTrue: [ arg ]
		         ifFalse: [ self error: 'Argument must be a constant.' ]
]
