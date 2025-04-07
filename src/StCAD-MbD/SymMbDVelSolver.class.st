Class {
	#name : 'SymMbDVelSolver',
	#superclass : 'SymMbDSolver',
	#instVars : [
		'n',
		'errorVector',
		'jacobian',
		'matrixSolver'
	],
	#category : 'StCAD-MbD-MbDSolver',
	#package : 'StCAD-MbD',
	#tag : 'MbDSolver'
}

{ #category : 'VisualWorks metadata' }
SymMbDVelSolver class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'run' }
SymMbDVelSolver >> basicSolveEquations [
	^matrixSolver 
		solve: jacobian
		with: errorVector
		saveOriginal: true
]

{ #category : 'run' }
SymMbDVelSolver >> handleSingularMatrix [

	^ (matrixSolver isMemberOf: GESpMatParPvMarkoFast)
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

{ #category : 'run' }
SymMbDVelSolver >> logSingularMatrixMessage [
	system 
		logString: #'MbD: \Velocity solver has encountered a singular matrix.'
]

{ #category : 'accessing' }
SymMbDVelSolver >> matrixSolverClass [
	"It is not safe to use StMGESpMatParPvMarkoFast3 because unstable answer can result when the matrix is large. Since velocity calculation is not iterative, the time cost is low."

	^GESpMatParPvPrecise
]

{ #category : 'run' }
SymMbDVelSolver >> solveEquations [
	^[self basicSolveEquations] on: SingularMatrixError
		do: [:ex | ex return: self handleSingularMatrix]
]

{ #category : 'accessing' }
SymMbDVelSolver >> system: object [ 
	system := object
]
