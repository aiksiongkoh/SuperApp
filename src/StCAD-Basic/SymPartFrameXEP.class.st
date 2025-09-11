"
The states are generalized coordinates and generalized momenta
qX = rapa
qE = Euler Parameters ap
pX = partial T / partial qXdot
pE = partial T / partial qEdot
"
Class {
	#name : 'SymPartFrameXEP',
	#superclass : 'SymPartFrame',
	#instVars : [
		'mX',
		'mE',
		'mEdot'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'as yet unclassified' }
SymPartFrameXEP >> vpos [

	^ pX
]

{ #category : 'as yet unclassified' }
SymPartFrameXEP >> vposdot [

	^ pXdot
]

{ #category : 'as yet unclassified' }
SymPartFrameXEP >> vrot [

	^ pE
]

{ #category : 'as yet unclassified' }
SymPartFrameXEP >> vrotdot [

	^ pEdot
]
