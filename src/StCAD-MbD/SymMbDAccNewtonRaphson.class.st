Class {
	#name : 'SymMbDAccNewtonRaphson',
	#superclass : 'SymMbDSystemNewtonRaphson',
	#category : 'StCAD-MbD-MbDSolver',
	#package : 'StCAD-MbD',
	#tag : 'MbDSolver'
}

{ #category : 'solving' }
SymMbDAccNewtonRaphson >> askSystemToUpdate [
	system allDo: [:item | item postAccICIteration]
]

{ #category : 'initialize-release' }
SymMbDAccNewtonRaphson >> assignEquationNumbers [
	"protocol: #'initialize-release'"

	"Equation order is q,s,u,lamb,lam."

	| partFrames contactEndFrames uHolders constraints eqnNo |
	partFrames := system partFrames.
	contactEndFrames := system contactEndFrames.
	uHolders := system uHolders.
	constraints := system allConstraints.
	eqnNo := 1.
	partFrames do: [ :part |
		part iqX: eqnNo.
		eqnNo := eqnNo + 3.
		part iqE: eqnNo.
		eqnNo := eqnNo + 4 ].
	contactEndFrames do: [ :endFrm |
		endFrm is: eqnNo.
		eqnNo := eqnNo + endFrm sSize ].
	uHolders do: [ :uHolder |
		uHolder iu: eqnNo.
		eqnNo := eqnNo + 1 ].
	constraints do: [ :con |
		con iG: eqnNo.
		eqnNo := eqnNo + 1 ].
	n := eqnNo - 1
]

{ #category : 'solving' }
SymMbDAccNewtonRaphson >> fillPyPx [
	pypx zeroSelf.
	system allDo: [:item | item fillAccICIterJacob: pypx]
]

{ #category : 'solving' }
SymMbDAccNewtonRaphson >> fillY [
	y zeroSelf.
	system allDo: [:item | item fillAccICIterError: y]
]

{ #category : 'solving' }
SymMbDAccNewtonRaphson >> incrementIterNo [

	iterNo >= iterMax ifTrue: [
		system
			logString:
			#'MbD: \No convergence after %1 iterations. \A force function of joint reactions can cause this problem \if the function returns large values.'
			withArgument: iterNo printString.
		SimulationStoppingError signal ].
	iterNo := iterNo + 1
]

{ #category : 'initialize-release' }
SymMbDAccNewtonRaphson >> initializeGlobally [
	super initializeGlobally.
	system allDo: [:item | item fillqsuddotlam: x]
]

{ #category : 'solving' }
SymMbDAccNewtonRaphson >> logSingularMatrixMessage [
	system 
		logString: #'MbD: \Some parts with zero masses or moment of inertias have infinite accelerations. \Add masses and inertias to or properly constrain those parts.'
]

{ #category : 'solving' }
SymMbDAccNewtonRaphson >> passRootToSystem [
	system allDo: [:item | item setqsuddotlam: x]
]

{ #category : 'solving' }
SymMbDAccNewtonRaphson >> postRun [
	system allDo: [:item | item postAccIC]
]

{ #category : 'solving' }
SymMbDAccNewtonRaphson >> preRun [
	system allDo: [:item | item preAccIC]
]
