Class {
	#name : 'MbDVelKineSolver2',
	#superclass : 'MbDVelSolver2',
	#category : 'StCAD-MbD-MbDSolver',
	#package : 'StCAD-MbD',
	#tag : 'MbDSolver'
}

{ #category : 'VisualWorks metadata' }
MbDVelKineSolver2 class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'initialize-release' }
MbDVelKineSolver2 >> assignEquationNumbers [
	"Equation order is q,s,u."

	| parts contactEndFrames uHolders constraints varNo nvar eqnNo |
	parts := system parts.
	contactEndFrames := system contactEndFrames.
	uHolders := system uHolders.
	constraints := system allConstraints.
	varNo := 1.
	parts do: [ :part |
		part iqX: varNo.
		varNo := varNo + 3.
		part iqE: varNo.
		varNo := varNo + 4 ].
	contactEndFrames do: [ :endFrm |
		endFrm is: varNo.
		varNo := varNo + endFrm sSize ].
	uHolders do: [ :uHolder |
		uHolder iu: varNo.
		varNo := varNo + 1 ].
	nvar := varNo - 1.
	eqnNo := 1.
	constraints do: [ :con |
		con iG: eqnNo.
		eqnNo := eqnNo + 1 ].
	n := eqnNo - 1.
	n == nvar ifFalse: [ NotKinematicError signal ]
]

{ #category : 'run' }
MbDVelKineSolver2 >> run [
	| qsudot |
	system logString: #'MbD: \Solving for kinematic velocity.'.
	system allDo: [:item | item preVelIC].
	self assignEquationNumbers.
	system allDo: [:item | item useEquationNumbers].
	errorVector := StMFullColumn new: n.
	jacobian := StMSparseMatrix new: n by: n.
	errorVector zeroSelf.
	system allDo: [:item | item fillVelICError: errorVector].
	jacobian zeroSelf.
	system allDo: [:item | item fillPosKineJacob: jacobian].
	matrixSolver := self matrixSolverClass new.
	qsudot := self solveEquations.
	system allDo: [:item | item setqsudot: qsudot].
	system allDo: [:item | item postVelIC]
]
