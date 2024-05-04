"
Subclasses encapsulate the behavior of Euler angles and Euler parameters.
"
Class {
	#name : #SymEulerArray,
	#superclass : #StMFullColumn,
	#type : #variable,
	#category : #'StCAD-Basic'
}

{ #category : #'VisualWorks metadata' }
SymEulerArray class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #'instance creation' }
SymEulerArray class >> zero: n [ 
	self shouldNotImplement
]

{ #category : #'basic ops' }
SymEulerArray >> transpose [
	"Return a row with the same elements."

	| n answer |
	n := self size.
	answer := StMFullRow new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)].
	^answer
]
