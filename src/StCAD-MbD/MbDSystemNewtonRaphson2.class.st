Class {
	#name : 'MbDSystemNewtonRaphson2',
	#superclass : 'VectorNewtonRaphson2',
	#category : 'StCAD-MbD-MbDSolver',
	#package : 'StCAD-MbD',
	#tag : 'MbDSolver'
}

{ #category : 'VisualWorks metadata' }
MbDSystemNewtonRaphson2 class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'initialize-release' }
MbDSystemNewtonRaphson2 >> assignEquationNumbers [
	self subclassResponsibility
]

{ #category : 'solving' }
MbDSystemNewtonRaphson2 >> calcdxNorm [
	super calcdxNorm.
	system logString: #'MbD: \Convergence = %1.' withArgument: dxNorm printString
]

{ #category : 'initialize-release' }
MbDSystemNewtonRaphson2 >> createVectorsAndMatrices [
	x := StMFullColumn new: n.
	y := StMFullColumn new: n.
	pypx := StMSparseMatrix new: n by: n
]

{ #category : 'solving' }
MbDSystemNewtonRaphson2 >> handleSingularMatrix [

	(matrixSolver isMemberOf: GESpMatParPvMarkoFast)
		ifTrue: [
			matrixSolver := GESpMatParPvPrecise new.
			self solveEquations ]
		ifFalse: [
			(matrixSolver isMemberOf: GESpMatParPvPrecise)
				ifTrue: [
					self logSingularMatrixMessage.
					SimulationStoppingError signal ]
				ifFalse: [ self halt: 'Check this.' ] ]
]

{ #category : 'initialize-release' }
MbDSystemNewtonRaphson2 >> initializeGlobally [
	self assignEquationNumbers.
	system 
		allDo: [:item | item useEquationNumbers].
	self createVectorsAndMatrices.
	matrixSolver := self matrixSolverClass new
]

{ #category : 'accessing' }
MbDSystemNewtonRaphson2 >> matrixSolverClass [
	^GESpMatParPvMarkoFast
]
