Class {
	#name : 'SymEndFrameSurface',
	#superclass : 'SymEndFrames',
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'initialization' }
SymEndFrameSurface >> initialize [

	| s1 s2 |
	s1 := UnknownDependentVariable name: #s1. "Unknown function of time"
	s2 := UnknownDependentVariable name: #s2.
	s := SymFullColumn with: s1 with: s2.
	super initialize
]
