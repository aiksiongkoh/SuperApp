Class {
	#name : 'SymMbDVelICSolver',
	#superclass : 'SymMbDVelSolver',
	#instVars : [
		'nqsu'
	],
	#category : 'StCAD-MbD-MbDSolver',
	#package : 'StCAD-MbD',
	#tag : 'MbDSolver'
}

{ #category : 'VisualWorks metadata' }
SymMbDVelICSolver class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'initialize-release' }
SymMbDVelICSolver >> assignEquationNumbers [
	"Equation order is q,s,u,lamb,lam."

	| partFrames contactEndFrames uHolders constraints eqnNo |
	partFrames := system partFrames.
	contactEndFrames := system contactEndFrames.
	uHolders := system uHolders.
	constraints := system allConstraints.
	eqnNo := 1.
	partFrames do: [ :item | eqnNo := item assignVelICEqnNum: eqnNo ].
	contactEndFrames do: [ :item | eqnNo := item assignVelICEqnNum: eqnNo ].
	uHolders do: [ :item | eqnNo := item assignVelICEqnNum: eqnNo ].
	nqsu := eqnNo - 1.
	constraints do: [ :item | eqnNo := item assignVelICEqnNum: eqnNo ].
	n := eqnNo - 1
]

{ #category : 'run' }
SymMbDVelICSolver >> run [
	system logString: #'MbD: \Solving for velocity initial conditions.'.
	self runBasic
]

{ #category : 'run' }
SymMbDVelICSolver >> runBasic [

	| qsudotlam |
	self allDo: [ :item | item preVelIC ].
	self assignEquationNumbers.
	self allDo: [ :item | item useVelICEqnNo ].
	errorVector := StMFullColumn new: n.
	jacobian := StMSparseMatrix new: n by: n.
	errorVector zeroSelf.
	self allDo: [ :item | item fillVelICError: errorVector ].
	jacobian zeroSelf.
	self allDo: [ :item | item fillVelICJacob: jacobian ].
	matrixSolver := self matrixSolverClass new.
	qsudotlam := self solveEquations.
	self allDo: [ :item | item setVelICValues: qsudotlam ].
	self allDo: [ :item | item postVelIC ]
]
