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
