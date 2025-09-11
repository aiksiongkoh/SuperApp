"
Cartesian frame not dependent on unknown states.
It is a function of time only.
"
Class {
	#name : 'SymIndependentFrame',
	#superclass : 'SymCartesianFrame',
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'accessing' }
SymIndependentFrame >> aAOp [

	^ sup aAOp
]

{ #category : 'accessing' }
SymIndependentFrame >> iqE [

	^ nil
]

{ #category : 'accessing' }
SymIndependentFrame >> iqX [

	^ nil
]

{ #category : 'accessing' }
SymIndependentFrame >> qE [

	^ nil
]

{ #category : 'accessing' }
SymIndependentFrame >> qX [

	^ nil
]

{ #category : 'accessing' }
SymIndependentFrame >> rOpO [

	^ sup rOpO
]
