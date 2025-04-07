"
Make available the machine accuracy, machine precision, machine epsilon for everyone.
"
Class {
	#name : 'MachineAccuracy',
	#superclass : 'Object',
	#classVars : [
		'DoubleOneMinus4Epsilon',
		'DoubleOnePlus4Epsilon',
		'OfDouble',
		'OfDoubleTimesFour',
		'OfLargestDouble'
	],
	#category : 'StMath-StMathArraySpecial',
	#package : 'StMath',
	#tag : 'StMathArraySpecial'
}

{ #category : 'accessing' }
MachineAccuracy class >> DoubleOneMinus4Epsilon [
	^DoubleOneMinus4Epsilon
]

{ #category : 'accessing' }
MachineAccuracy class >> DoubleOnePlus4Epsilon [
	^DoubleOnePlus4Epsilon
]

{ #category : 'accessing' }
MachineAccuracy class >> FloatOneMinus4Epsilon [
	^FloatOneMinus4Epsilon
]

{ #category : 'accessing' }
MachineAccuracy class >> FloatOnePlus4Epsilon [
	^FloatOnePlus4Epsilon
]

{ #category : 'accessing' }
MachineAccuracy class >> OfDouble [
	^OfDouble
]

{ #category : 'accessing' }
MachineAccuracy class >> OfDoubleTimesFour [
	^OfDoubleTimesFour
]

{ #category : 'accessing' }
MachineAccuracy class >> OfFloat [
	^OfFloat
]

{ #category : 'accessing' }
MachineAccuracy class >> OfFloatTimesFour [
	^OfFloatTimesFour
]

{ #category : 'accessing' }
MachineAccuracy class >> OfLargestDouble [
	^OfLargestDouble
]

{ #category : 'class initialization' }
MachineAccuracy class >> initialize [
	"To be strictly correct, this should be run everytime the image is started."

	"MachineAccuracy initialize."

	Object removeDependent: self.
	Object addDependent: self.
	self setVariables
]

{ #category : 'class initialization' }
MachineAccuracy class >> initializeX [
	"To be strictly correct, this should be run everytime the image is started."

	"MachineAccuracy initialize."

	Smalltalk removeDependent: self.
	Smalltalk addDependent: self.
	self setVariables
]

{ #category : 'class initialization' }
MachineAccuracy class >> setDoubleVariables [
	"To be strictly correct, this should be run everytime the image is started."

	"MachineAccuracy initialize."

	| epsilon one two max |
	epsilon := Float one.
	one := Float one.
	two := one + one.
	max := Float one.

	[
	OfDouble := epsilon.
	epsilon := epsilon / two.
	one + epsilon > one ] whileTrue.
	OfDoubleTimesFour := two + two * OfDouble.
	DoubleOnePlus4Epsilon := one + OfDoubleTimesFour.
	DoubleOneMinus4Epsilon := one - OfDoubleTimesFour.

	[
	OfLargestDouble := max.
	max := two * max.
	max isInfinite ] whileFalse
]

{ #category : 'class initialization' }
MachineAccuracy class >> setFloatVariables [
	"To be strictly correct, this should be run everytime the image is started."
	"StMMachineAccuracy initialize."

	| epsilon unity two max |
	epsilon := Float unity.
	unity := Float unity.
	two := unity + unity.
	max := Float unity.
	
	[OfFloat := epsilon.
	epsilon := epsilon / two.
	unity + epsilon > unity] whileTrue.
	OfFloatTimesFour := two + two * OfFloat.
	FloatOnePlus4Epsilon := unity + OfFloatTimesFour.
	FloatOneMinus4Epsilon := unity - OfFloatTimesFour.
	
	[max := [two * max]
				on: RangeError do: [:ex | ex return: nil].
	max == nil ifFalse: [OfLargestFloat := max].
	max == nil] whileFalse
]

{ #category : 'class initialization' }
MachineAccuracy class >> setVariables [

	self setDoubleVariables
]

{ #category : 'class initialization' }
MachineAccuracy class >> update: anAspect with: arguments from: anObject [
	"Check for return from snapshot to install."

	(anObject == Smalltalk and: [ anAspect == #earlySystemInstallation ]) ifTrue: [
		self setVariables ]
]

{ #category : 'VisualWorks metadata' }
MachineAccuracy class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
	)

]
