Class {
	#name : #StEndFrameSurface,
	#superclass : #StEndFrames,
	#category : #'StCAD-Basic'
}

{ #category : #initialization }
StEndFrameSurface >> initialize [

	| s1 s2 |
	s1 := StMDependentVariable name: #s1.	"Unknown function of time"
	s2 := StMDependentVariable name: #s2.
	s := StMFullColumn with: s1 with: s2.
	super initialize.

]
