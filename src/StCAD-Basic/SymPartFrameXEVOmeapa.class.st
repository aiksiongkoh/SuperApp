"
The states are generalized coordinates, linear velocity and angular velocity
qX = rapa
qE = Euler Parameters ap
vX = vapa = qXdot
vOmega = omegaapa = 2\*[aBap]\*qEdot

rOpO = rOaO + [aAOa]\*rapa
vOpO = vOaO + [aAdotOa]\*rapa + [aAOa]\*vapa
vdotOpO = vdotOaO + [aAddotOa]\*rapa + 2*[aAdotOa]\*vapa + [aAOa]\*vdotapa
omegaOpp = [aAapT]\*[aAOaT]\*omegaOaO + [aAapT]\*omegaapa = [aAapT]\*[aAOaT]\*omegaOaO + 2\*[aCap]\*qEdot
omegadotOpp = [aAdotapT]\*[aAOaT]\*omegaOaO + [aAapT]\*[aAdotOaT]\*omegaOaO + [aAapT]\*[aAOaT]\*omegadotOaO + [aAdotapT]\*omegaapa + [aAapT]\*omegadotapa

Kinetic Energy
KE = (1/2)mass\*vOpOT\*vOpO + (1/2)omegaOppT\*[aJpp]\*omegaOpp
General Momenta
pX = pTpqXdot = [pvapapqXdot]\*[pvOpOpvapa]\*pTpvOpO = 1 \* [aAOa] \* mass\*vOpO
pE = pTpqEdot = [pomegaOpp_pqEdot]\*pTpomegaOpp = 2[aCapT] \* [aJpp]\*omegaOpp
Momenta velocity
pXdot = ppXpt = [aAdotOa]\* mass\*vOpO + [aAOa] \* mass\*vdotOpO
pEdot = ppEpt = 2[aCdotapT]\*[aJpp]\*omegaOpp + 2[aCapT]\*[aJpp]\*omegadotOpp

Lagrange equations
M = -pdot + pTpq + Qq + pGbarTpqdot*lambdabar + pGTpq*lambda 
ppXdotpvdotX
"
Class {
	#name : 'SymPartFrameXEVOmeapa',
	#superclass : 'SymPartFrameXEVOme',
	#instVars : [
		'vdotapa',
		'omedotapa'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'accessing' }
SymPartFrameXEVOmeapa >> aVrot [
	"qrotdot := aVrot * vrot"

	^ self aB transpose times: 0.5
]

{ #category : 'accessing' }
SymPartFrameXEVOmeapa >> aVrotdot [

	^ self aB transposeTimesFullMatrix: vOmega skewMatrix times: -0.25
]

{ #category : 'calc' }
SymPartFrameXEVOmeapa >> calcMomenta [

	| pE123 t |
	pX := (self aAOa timesFullColumn: vOpO times: mass) simplified.
	pE := ((self aCap transposeTimesDiagonalMatrix: aJpp)
		       timesFullColumn: omeOpp
		       times: 2.0) simplified.
	pE123 := pE copyFrom: 1 to: 3.
	t := self time.
	pXdot := (pX differentiateWRT: t) simplified.
	"pXdot := mass*(aAdotOa*vOpO + aAOa*vdotOpO)"
	pEdot123 := (pE123 differentiateWRT: t) simplified.
	"pEdot := aBTap*omeTildeapa*aAap*aJpp*omeOpp + 2*aCTap*aJpp*omedotOpp"
	ppXpvX := (pX differentiateWRT: vX) simplified.
	"ppXpvX := mass*aAOa*aAOa"
	ppE123pvOmega := (pE123 differentiateWRT: vOmega) simplified.
	"ppEpvOmega := 2*aCTap*aJpp*aATap"
	^ self
]

{ #category : 'calc' }
SymPartFrameXEVOmeapa >> calcomeOpp [

	omeOpp := self aAap transposeTimesFullColumn:
		          (self aAOa transposeTimesFullColumn: self omeOaO)
		          + self omeapa
]

{ #category : 'accIC' }
SymPartFrameXEVOmeapa >> fillAccICVdotIterJacob: mat [

	mat at: ivX and: ivX minusFullMatrix: ppXpvX asNumber.
	mat at: ivOmega and: ivOmega minusFullMatrix: ppE123pvOmega asNumber.
	subs do: [ :mkr | mkr fillAccICVdotIterJacob: mat ].
	aGeu fillAccICVdotIterJacob: mat
]

{ #category : 'initialization' }
SymPartFrameXEVOmeapa >> initialize [

	| vOmeapa1 vOmeapa2 vOmeapa3 |
	super initialize.
	vOmeapa1 := UnknownDependentVariable name: #vOmeapa1.
	vOmeapa2 := UnknownDependentVariable name: #vOmeapa2.
	vOmeapa3 := UnknownDependentVariable name: #vOmeapa3.
	vOmega := SymFullColumn with: vOmeapa1 with: vOmeapa2 with: vOmeapa3.
	vOmegadot := SymFullColumn with: 0.0 with: 0.0 with: 0.0
]

{ #category : 'accessing' }
SymPartFrameXEVOmeapa >> omeapa [

	^ vOmega
]

{ #category : 'as yet unclassified' }
SymPartFrameXEVOmeapa >> omedotOpO [

	| omedotOpO |
	omedotOpO := self omedotOaO
	             + (self aAdotOa timesFullColumn: self omeapa)
	             + (self aAOa timesFullColumn: self omedotapa).
	^ omedotOpO
]

{ #category : 'accessing' }
SymPartFrameXEVOmeapa >> omedotapa [

	^ vOmegadot
]

{ #category : 'accessing' }
SymPartFrameXEVOmeapa >> pqdotpv [
	"qEdot := 0.5* aB transpose * omega_apa"

	^ qE aB transposeTimes: 0.5
]
