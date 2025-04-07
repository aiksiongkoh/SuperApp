Class {
	#name : 'SymMbDPosICKineNewtonRaphson',
	#superclass : 'SymMbDAnyPosICNewtonRaphson',
	#category : 'StCAD-MbD-MbDSolver',
	#package : 'StCAD-MbD',
	#tag : 'MbDSolver'
}

{ #category : 'VisualWorks metadata' }
SymMbDPosICKineNewtonRaphson class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'initialize-release' }
SymMbDPosICKineNewtonRaphson >> assignEquationNumbers [
	"Equation order is q,s,u."

	| parts contactEndFrames uHolders constraints eqnNo |
	parts := system parts.
	contactEndFrames := system contactEndFrames.
	uHolders := system uHolders.
	constraints := system allConstraints.
	eqnNo := 1.
	parts do: 
			[:part | 
			part iqX: eqnNo.
			eqnNo := eqnNo + 3.
			part iqE: eqnNo.
			eqnNo := eqnNo + 4].
	contactEndFrames do: 
			[:endFrm | 
			endFrm is: eqnNo.
			eqnNo := eqnNo + endFrm sSize].
	uHolders do: 
			[:uHolder | 
			uHolder iu: eqnNo.
			eqnNo := eqnNo + 1].
	nqsu := eqnNo - 1.
	constraints do: 
			[:con | 
			con iG: eqnNo.
			eqnNo := eqnNo + 1].
	n := eqnNo - 1
]

{ #category : 'initialize-release' }
SymMbDPosICKineNewtonRaphson >> initializeGlobally [
	super initializeGlobally.
	iterMax := system iterMaxPosKine.
	dxTol := system errorTolPosKine
]

{ #category : 'solving' }
SymMbDPosICKineNewtonRaphson >> isConverged [
	^(dxNorms at: iterNo) < dxTol or: [self isConvergedToNumericalLimit]
]

{ #category : 'solving' }
SymMbDPosICKineNewtonRaphson >> logSingularMatrixMessage [
	system 
		logString: #'MbD: \Quasi kinematic solver has encountered a singular matrix.'
]

{ #category : 'solving' }
SymMbDPosICKineNewtonRaphson >> preRun [
	system logString: #'MbD: \Solving for quasi kinematic position.'.
	super preRun
]
