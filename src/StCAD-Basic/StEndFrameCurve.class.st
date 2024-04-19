Class {
	#name : #StEndFrameCurve,
	#superclass : #StEndFrames,
	#category : #'StCAD-Basic'
}

{ #category : #initialization }
StEndFrameCurve >> initialize [

	| s1 |
	s1 := StMDependentVariable name: #s1.	"Unknown function of time"
	s := StMFullColumn with: s1.
	super initialize.

]
