Class {
	#name : 'SymEndFrame',
	#superclass : 'SymCartesianFrame',
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'accessing' }
SymEndFrame >> aAOe [

	^ aAOf
]

{ #category : 'accessing' }
SymEndFrame >> aAme [

	^ aAFf
]

{ #category : 'calc' }
SymEndFrame >> calcAll [

	rOfO := self calcrOeO.
	aAOf := self calcaAOe.
	subs do: [ :sub | sub calcAll ]
]

{ #category : 'calc' }
SymEndFrame >> calcaAOe [

	^ sup aAOm timesFullMatrix: self aAme
]

{ #category : 'calc' }
SymEndFrame >> calcrOeO [

	^ sup rOmO + (sup aAOm timesFullColumn: self rmem)
]

{ #category : 'accessing' }
SymEndFrame >> rOeO [

	^ rOfO
]

{ #category : 'accessing' }
SymEndFrame >> rmem [

	^ rFfF
]
