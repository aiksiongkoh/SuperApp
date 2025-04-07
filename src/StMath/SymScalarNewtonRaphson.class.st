Class {
	#name : 'SymScalarNewtonRaphson',
	#superclass : 'SymNewtonRaphson',
	#category : 'StMath-StMathNewtonRaphson',
	#package : 'StMath',
	#tag : 'StMathNewtonRaphson'
}

{ #category : 'VisualWorks metadata' }
SymScalarNewtonRaphson class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'solving' }
SymScalarNewtonRaphson >> calcdxNorm [
	"Subclasses can modify calculation of dxNorm."

	dxNorm := dx abs
]

{ #category : 'solving' }
SymScalarNewtonRaphson >> calcyNorm [
	"Subclasses can modify calculation of yNorm."

	yNorm := 0.5 * y * y
]

{ #category : 'solving' }
SymScalarNewtonRaphson >> dxEqualdxTimeslam [
	dx := dx * lam.
	super dxEqualdxTimeslam
]

{ #category : 'solving' }
SymScalarNewtonRaphson >> fillPyPx [
	pypx := system pypx
]

{ #category : 'solving' }
SymScalarNewtonRaphson >> fillY [
	y := system y
]

{ #category : 'initialize-release' }
SymScalarNewtonRaphson >> initializeGlobally [
	x := system x
]

{ #category : 'solving' }
SymScalarNewtonRaphson >> solveEquations [
	dx := 0.0 - y / pypx
]

{ #category : 'solving' }
SymScalarNewtonRaphson >> xEqualxoldPlusdx [
	x := xold + dx
]

{ #category : 'solving' }
SymScalarNewtonRaphson >> xEqualxoldPlusdxTimeslam [
	x := xold + (dx * lam)
]
