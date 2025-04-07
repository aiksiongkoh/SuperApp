"
The states are generalized coordinates, linear velocity and angular velocity
qX = rapa
qE = Euler Parameters ap
vX = vapa
vOme = omeapa
"
Class {
	#name : 'SymPartFrameXEVOmeapa',
	#superclass : 'SymPartFrameXEVOme',
	#instVars : [
		'omeapa'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'as yet unclassified' }
SymPartFrameXEVOmeapa >> initialize [

	| vOmeapa1 vOmeapa2 vOmeapa3 |
	super initialize.
	vOmeapa1 := UnknownDependentVariable name: #vOmeapa1.
	vOmeapa2 := UnknownDependentVariable name: #vOmeapa2.
	vOmeapa3 := UnknownDependentVariable name: #vOmeapa3.
	vOmega := SymFullColumn with: vOmeapa1 with: vOmeapa2 with: vOmeapa3.
	omeapa := vOmega
]

{ #category : 'accessing' }
SymPartFrameXEVOmeapa >> pqdotpv [
	"qEdot := 0.5* aB transpose * omega_apa"

	^ qE aB transposeTimes: 0.5
]
