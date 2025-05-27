Class {
	#name : 'SymVectorNewtonRaphson',
	#superclass : 'SymNewtonRaphson',
	#instVars : [
		'matrixSolver',
		'n'
	],
	#category : 'StCAD-MbD-MbDSolver',
	#package : 'StCAD-MbD',
	#tag : 'MbDSolver'
}

{ #category : 'solving' }
SymVectorNewtonRaphson >> basicSolveEquations [
"	self toDebugTxtShowContextFrom: 1 to: 100."
	dx := matrixSolver 
				solve: pypx
				with: y negated
				saveOriginal: false
]

{ #category : 'solving' }
SymVectorNewtonRaphson >> calcdxNorm [
	"Subclasses can modify calculation of dxNorm."

	dxNorm := dx rootMeanSquare
]

{ #category : 'solving' }
SymVectorNewtonRaphson >> calcyNorm [
	"Subclasses can modify calculation of yNorm."

	yNorm := 0.5 * y sumOfSquares
]

{ #category : 'solving' }
SymVectorNewtonRaphson >> dxEqualdxTimeslam [
	dx magnifySelf: lam.
	super dxEqualdxTimeslam
]

{ #category : 'solving' }
SymVectorNewtonRaphson >> fillPyPx [
	system fillJacobian: pypx
]

{ #category : 'solving' }
SymVectorNewtonRaphson >> fillY [
	system fillErrorVector: y
]

{ #category : 'solving' }
SymVectorNewtonRaphson >> handleSingularMatrix [
	self error: 'Singular matrix encountered.'
]

{ #category : 'initialize-release' }
SymVectorNewtonRaphson >> initializeGlobally [
	system fillVarVector: x
]

{ #category : 'solving' }
SymVectorNewtonRaphson >> isConverged [

	^ (dxNorms at: iterNo) < dxTol or: [ self isConvergedToNumericalLimit ]
]

{ #category : 'accessing' }
SymVectorNewtonRaphson >> matrixSolver: matSolver [ 
	matrixSolver := matSolver
]

{ #category : 'accessing' }
SymVectorNewtonRaphson >> matrixSolverClass [
	^GEFullMatParPv
]

{ #category : 'printing' }
SymVectorNewtonRaphson >> printOn: aStream [
	"Append to the argument, aStream, a sequence of characters that
	identifies the receiver."

	aStream
		nextPut: $a;
		nextPutAll: self class name;
		nextPut: $(;
		nextPutAll: 'n = ';
		print: n;
		nextPutAll: ', iterNo = ';
		print: iterNo;
		nextPutAll: ', dxNorm = ';
		print: dxNorm;
		nextPut: $)
]

{ #category : 'accessing' }
SymVectorNewtonRaphson >> pypx: mat [ 
	pypx := mat
]

{ #category : 'solving' }
SymVectorNewtonRaphson >> solveEquations [
	[self basicSolveEquations] on: SingularMatrixError
		do: [:ex | self handleSingularMatrix]
]

{ #category : 'accessing' }
SymVectorNewtonRaphson >> x: col [ 
	x := col asFullColumn
]

{ #category : 'solving' }
SymVectorNewtonRaphson >> xEqualxoldPlusdx [
	x := xold plusFullColumn: dx
]

{ #category : 'solving' }
SymVectorNewtonRaphson >> xEqualxoldPlusdxTimeslam [
	x := xold plusFullColumn: dx times: lam
]

{ #category : 'accessing' }
SymVectorNewtonRaphson >> y: col [ 
	y := col asFullColumn
]
