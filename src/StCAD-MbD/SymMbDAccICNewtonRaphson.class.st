Class {
	#name : 'SymMbDAccICNewtonRaphson',
	#superclass : 'SymMbDAccNewtonRaphson',
	#category : 'StCAD-MbD-MbDSolver',
	#package : 'StCAD-MbD',
	#tag : 'MbDSolver'
}

{ #category : 'initialize-release' }
SymMbDAccICNewtonRaphson >> assignEquationNumbers [
	"Equation order is q,s,u,lamb,lam."

	| partFrames contactEndFrames uHolders constraints eqnNo |
	partFrames := system partFrames.
	contactEndFrames := system contactEndFrames.
	uHolders := system uHolders.
	constraints := system allConstraints.
	eqnNo := 1.
	partFrames do: [ :item | eqnNo := item assignAccICEqnNum: eqnNo ].
	contactEndFrames do: [ :item | eqnNo := item assignAccICEqnNum: eqnNo ].
	uHolders do: [ :item | eqnNo := item assignAccICEqnNum: eqnNo ].
	constraints do: [ :item | eqnNo := item assignAccICEqnNum: eqnNo ].
	n := eqnNo - 1
]

{ #category : 'initialize-release' }
SymMbDAccICNewtonRaphson >> initializeGlobally [

	super initializeGlobally.
	system allDo: [ :item | item fillqsuddotlam: x ]
]

{ #category : 'solving' }
SymMbDAccICNewtonRaphson >> isConverged [

	^ self isConvergedToNumericalLimit
]

{ #category : 'solving' }
SymMbDAccICNewtonRaphson >> preRun [

	system logString: #'MbD: \Solving for acceleration initial conditions.'.
	super preRun
]
