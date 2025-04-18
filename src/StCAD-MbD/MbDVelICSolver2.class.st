Class {
	#name : 'MbDVelICSolver2',
	#superclass : 'MbDVelSolver2',
	#instVars : [
		'nqsu'
	],
	#category : 'StCAD-MbD-MbDSolver',
	#package : 'StCAD-MbD',
	#tag : 'MbDSolver'
}

{ #category : 'VisualWorks metadata' }
MbDVelICSolver2 class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'initialize-release' }
MbDVelICSolver2 >> assignEquationNumbers [
	"Equation order is q,s,u,lamb,lam."

	| parts contactEndFrames uHolders constraints eqnNo |
	parts := system parts.
	contactEndFrames := system contactEndFrames.
	uHolders := system uHolders.
	constraints := system allConstraints.
	eqnNo := 1.
	parts
		do: 
			[:part | 
			part iqX: eqnNo.
			eqnNo := eqnNo + 3.
			part iqE: eqnNo.
			eqnNo := eqnNo + 4].
	contactEndFrames
		do: 
			[:endFrm | 
			endFrm is: eqnNo.
			eqnNo := eqnNo + endFrm sSize].
	uHolders
		do: 
			[:uHolder | 
			uHolder iu: eqnNo.
			eqnNo := eqnNo + 1].
	nqsu := eqnNo - 1.
	constraints
		do: 
			[:con | 
			con iG: eqnNo.
			eqnNo := eqnNo + 1].
	n := eqnNo - 1
]

{ #category : 'run' }
MbDVelICSolver2 >> run [
	system logString: #'MbD: \Solving for velocity initial conditions.'.
	self runBasic
]

{ #category : 'run' }
MbDVelICSolver2 >> runBasic [

	| qsudotOld qsudotWeights qsudotlam |
	self allDo: [ :item | item preVelIC ].
	self assignEquationNumbers.
	self allDo: [ :item | item useEquationNumbers ].
	qsudotOld := StMFullColumn new: nqsu.
	qsudotWeights := StMDiagonalMatrix new: nqsu.
	errorVector := StMFullColumn new: n.
	jacobian := StMSparseMatrix new: n by: n.
	self allDo: [ :item | item fillqsudot: qsudotOld ].
	self allDo: [ :item | item fillqsudotWeights: qsudotWeights ].
	errorVector zeroSelf.
	errorVector at: 1 plusFullColumn: (qsudotWeights timesFullColumn: qsudotOld).
	self allDo: [ :item | item fillVelICError: errorVector ].
	jacobian zeroSelf.
	jacobian at: 1 and: 1 plusDiagonalMatrix: qsudotWeights.
	self allDo: [ :item | item fillVelICJacob: jacobian ].
	matrixSolver := self matrixSolverClass new.
	qsudotlam := self solveEquations.
	self allDo: [ :item | item setqsudotlam: qsudotlam ].
	self allDo: [ :item | item postVelIC ]
]
