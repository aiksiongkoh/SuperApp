"
The states are generalized coordinates, linear velocity and angular velocity
qX = rapa
qE = Euler Parameters ap
vX = vapa
vOme = omeapp
"
Class {
	#name : 'SymPartFrameXEVOmeapp',
	#superclass : 'SymPartFrameXEVOme',
	#instVars : [
		'omeapp'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'as yet unclassified' }
SymPartFrameXEVOmeapp >> initialize [

	| vOmeapp1 vOmeapp2 vOmeapp3 |
	super initialize.
	vOmeapp1 := UnknownDependentVariable name: #vOmeapp1.
	vOmeapp2 := UnknownDependentVariable name: #vOmeapp2.
	vOmeapp3 := UnknownDependentVariable name: #vOmeapp3.
	vOmega := SymFullColumn with: vOmeapp1 with: vOmeapp2 with: vOmeapp3.
	omeapp := vOmega
]

{ #category : 'accessing' }
SymPartFrameXEVOmeapp >> pqdotpv [
	"qEdot := 0.5* aC transpose * omega_app"

	^ qE aC transposeTimes: 0.5
]
