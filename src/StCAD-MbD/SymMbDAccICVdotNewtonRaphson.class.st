Class {
	#name : 'SymMbDAccICVdotNewtonRaphson',
	#superclass : 'SymMbDAccNewtonRaphson',
	#category : 'StCAD-MbD-MbDSolver',
	#package : 'StCAD-MbD',
	#tag : 'MbDSolver'
}

{ #category : 'initialize-release' }
SymMbDAccICVdotNewtonRaphson >> assignEquationNumbers [
	"Equation order is q,s,u,lamb,lam."

	| partFrames contactEndFrames uHolders constraints eqnNo |
	partFrames := system partFrames.
	contactEndFrames := system contactEndFrames.
	uHolders := system uHolders.
	constraints := system allConstraints.
	eqnNo := 1.
	partFrames do: [ :item | eqnNo := item assignVdotICEqnNum: eqnNo ].
	contactEndFrames do: [ :item | eqnNo := item assignVdotICEqnNum: eqnNo ].
	uHolders do: [ :item | eqnNo := item assignVdotICEqnNum: eqnNo ].
	constraints do: [ :item | eqnNo := item assignVdotICEqnNum: eqnNo ].
	n := eqnNo - 1
]

{ #category : 'solving' }
SymMbDAccICVdotNewtonRaphson >> fillPyPx [

	pypx zeroSelf.
	system allDo: [ :item | item fillAccICVdotIterJacob: pypx ]
]

{ #category : 'solving' }
SymMbDAccICVdotNewtonRaphson >> fillY [

	y zeroSelf.
	system allDo: [ :item | item fillAccICVdotIterError: y ]
]

{ #category : 'initialize-release' }
SymMbDAccICVdotNewtonRaphson >> initializeGlobally [

	super initializeGlobally.
	system allDo: [ :item | item fillvdotsuddotlam: x ]
]

{ #category : 'solving' }
SymMbDAccICVdotNewtonRaphson >> isConverged [

	^ self isConvergedToNumericalLimit
]

{ #category : 'solving' }
SymMbDAccICVdotNewtonRaphson >> passRootToSystem [

	system allDo: [ :item | item setvdotsuddotlam: x ]
]

{ #category : 'solving' }
SymMbDAccICVdotNewtonRaphson >> preRun [

	system logString: #'MbD: \Solving for acceleration initial conditions. (Vdot)'.
	super preRun
]
