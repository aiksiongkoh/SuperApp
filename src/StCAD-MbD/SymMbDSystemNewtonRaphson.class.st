Class {
	#name : 'SymMbDSystemNewtonRaphson',
	#superclass : 'SymVectorNewtonRaphson',
	#category : 'StCAD-MbD-MbDSolver',
	#package : 'StCAD-MbD',
	#tag : 'MbDSolver'
}

{ #category : 'VisualWorks metadata' }
SymMbDSystemNewtonRaphson class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'enumerating' }
SymMbDSystemNewtonRaphson >> allDo: aBlock [

	system allDo: aBlock
]

{ #category : 'initialize-release' }
SymMbDSystemNewtonRaphson >> assignEquationNumbers [
	self subclassResponsibility
]

{ #category : 'solving' }
SymMbDSystemNewtonRaphson >> calcdxNorm [
	super calcdxNorm.
	system logString: #'MbD: \Convergence = %1.' withArgument: dxNorm printString
]

{ #category : 'initialize-release' }
SymMbDSystemNewtonRaphson >> createVectorsAndMatrices [
	x := StMFullColumn new: n.
	y := StMFullColumn new: n.
	pypx := StMSparseMatrix new: n by: n
]

{ #category : 'solving' }
SymMbDSystemNewtonRaphson >> handleSingularMatrix [

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
SymMbDSystemNewtonRaphson >> initializeGlobally [
	self assignEquationNumbers.
	system 
		allDo: [:item | item useEquationNumbers].
	self createVectorsAndMatrices.
	matrixSolver := self matrixSolverClass new
]

{ #category : 'accessing' }
SymMbDSystemNewtonRaphson >> matrixSolverClass [
	^GESpMatParPvMarkoFast
]
