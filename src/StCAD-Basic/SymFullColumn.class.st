Class {
	#name : 'SymFullColumn',
	#superclass : 'StMFullColumn',
	#type : 'variable',
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'ops on self' }
SymFullColumn >> equalFullColumn: aFullColumn at: ii1 [

	| iiOffset |
	iiOffset := ii1 - 1.
	1 to: self size do: [ :i | (self at: i) value: (aFullColumn at: iiOffset + i) ]
]

{ #category : 'as yet unclassified' }
SymFullColumn >> skewMatrix [
	"skewMatrix is related to angular velocity and cross product."

	self size == 3
		ifTrue: [
				| skewMatrix c1 c2 c3 |
				skewMatrix := SymFullMatrix new: 3 by: 3.
				c1 := self at: 1.
				c2 := self at: 2.
				c3 := self at: 3.
				skewMatrix at: 1 and: 1 put: 0.0.
				skewMatrix at: 2 and: 2 put: 0.0.
				skewMatrix at: 3 and: 3 put: 0.0.
				skewMatrix at: 2 and: 3 put: 0.0 - c1.
				skewMatrix at: 1 and: 3 put: c2.
				skewMatrix at: 1 and: 2 put: 0.0 - c3.
				skewMatrix at: 2 and: 1 put: c3.
				skewMatrix at: 3 and: 1 put: 0.0 - c2.
				skewMatrix at: 3 and: 2 put: c1.
				^ skewMatrix ]
		ifFalse: [ self error: 'Column is not of dimension 3.' ]
]
