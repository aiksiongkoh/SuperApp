Class {
	#name : 'SymEndFrameCurve',
	#superclass : 'SymEndFrames',
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'initialization' }
SymEndFrameCurve >> initialize [

	| s1 |
	s1 := StMDependentVariable name: #s1.	"Unknown function of time"
	s := StMFullColumn with: s1.
	super initialize.

]
