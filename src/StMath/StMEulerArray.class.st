"
Subclasses encapsulate the behavior of Euler angles and Euler parameters.
"
Class {
	#name : 'StMEulerArray',
	#superclass : 'StMFullColumn',
	#type : 'variable',
	#category : 'StMath-StMathArray',
	#package : 'StMath',
	#tag : 'StMathArray'
}

{ #category : 'VisualWorks metadata' }
StMEulerArray class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'instance creation' }
StMEulerArray class >> zero: n [ 
	self shouldNotImplement
]

{ #category : 'converting' }
StMEulerArray >> asFullColumn [

	| m answer |
	m := self size.
	answer := StMFullColumn new: m.
	1 to: m do: [ :i | answer at: i put: (self at: i) ].
	^ answer
]

{ #category : 'converting' }
StMEulerArray >> asFullRow [

	| n answer |
	n := self size.
	answer := StMFullRow new: n.
	1 to: n do: [ :j | answer at: j put: (self at: j) ].
	^ answer
]

{ #category : 'basic ops' }
StMEulerArray >> transpose [
	"Return a row with the same elements."

	| n answer |
	n := self size.
	answer := StMFullRow new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)].
	^answer
]
