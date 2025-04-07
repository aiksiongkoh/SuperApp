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

{ #category : 'accIC' }
SymPartFrameXEP >> fillAccICIterError: col [

	self halt.
	col at: iqX minusFullColumn: (mX timesFullColumn: qXddot).
	col at: iqE minusFullColumn: (mEdot timesFullColumn: qEdot).
	col at: iqE minusFullColumn: (mE timesFullColumn: qEddot).
	col at: iqE plusFullColumn: pTpE.

	subs do: [ :mkr | mkr fillAccICIterError: col ].
	aGeu fillAccICIterError: col.
	aGabs do: [ :con | con fillAccICIterError: col ]
]
