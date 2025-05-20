"
Subclasses encapsulate the behavior of Euler angles and Euler parameters.
"
Class {
	#name : 'SymEulerArray',
	#superclass : 'StMFullColumn',
	#type : 'variable',
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'VisualWorks metadata' }
SymEulerArray class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'instance creation' }
SymEulerArray class >> zero: n [ 
	self shouldNotImplement
]

{ #category : 'converting' }
SymEulerArray >> asFullColumn [

	| m answer |
	m := self size.
	answer := StMFullColumn new: m.
	1 to: m do: [ :i | answer at: i put: (self at: i) ].
	^ answer
]

{ #category : 'converting' }
SymEulerArray >> asFullRow [

	| n answer |
	n := self size.
	answer := StMFullRow new: n.
	1 to: n do: [ :j | answer at: j put: (self at: j) ].
	^ answer
]

{ #category : 'accessing' }
SymEulerArray >> at: i put: object [

	super at: i put: object asSymbolic
]

{ #category : 'ops on self' }
SymEulerArray >> equalFullColumn: aFullColumn at: ii1 [

	| iiOffset |
	iiOffset := ii1 - 1.
	1 to: self size do: [ :i | (self at: i) value: (aFullColumn at: iiOffset + i) ]
]

{ #category : 'accessing' }
SymEulerArray >> independentVar [

	^ self do: [ :each | each independentVar ifNotNil: [ :var | ^ var ] ]
]

{ #category : 'basic ops' }
SymEulerArray >> transpose [
	"Return a row with the same elements."

	| n answer |
	n := self size.
	answer := SymFullRow new: n.
	1 to: n do: [ :i | answer at: i put: (self at: i) ].
	^ answer
]
