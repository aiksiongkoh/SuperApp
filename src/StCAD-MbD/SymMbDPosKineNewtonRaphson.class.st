Class {
	#name : 'SymMbDPosKineNewtonRaphson',
	#superclass : 'SymMbDPosNewtonRaphson',
	#category : 'StCAD-MbD-MbDSolver',
	#package : 'StCAD-MbD',
	#tag : 'MbDSolver'
}

{ #category : 'VisualWorks metadata' }
SymMbDPosKineNewtonRaphson class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'initialize-release' }
SymMbDPosKineNewtonRaphson >> assignEquationNumbers [
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
	n == nvar ifFalse: [
		system logString: #'MbD: \SYSTEM IS NOT PURE KINEMATIC.'.
		NotKinematicError signal ]
]

{ #category : 'solving' }
SymMbDPosKineNewtonRaphson >> fillPyPx [
	pypx zeroSelf.
	system allDo: [:item | item fillPosKineJacob: pypx]
]

{ #category : 'solving' }
SymMbDPosKineNewtonRaphson >> fillY [
	y zeroSelf.
	system allDo: [:item | item fillPosKineError: y]
]

{ #category : 'initialize-release' }
SymMbDPosKineNewtonRaphson >> initializeGlobally [
	super initializeGlobally.
	system allDo: [:item | item fillqsu: x].
	iterMax := system iterMaxPosKine.
	dxTol := system errorTolPosKine
]

{ #category : 'solving' }
SymMbDPosKineNewtonRaphson >> logSingularMatrixMessage [
	system 
		logString: #'MbD: \Kinematic solver has encountered a singular matrix.'
]

{ #category : 'solving' }
SymMbDPosKineNewtonRaphson >> passRootToSystem [
	system allDo: [:item | item setqsu: x]
]

{ #category : 'solving' }
SymMbDPosKineNewtonRaphson >> preRun [
	system logString: #'MbD: \Solving for kinematic position.'.
	system allDo: [:item | item prePosKine]
]
