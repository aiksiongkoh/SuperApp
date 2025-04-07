Class {
	#name : 'SymMbDAnyPosICNewtonRaphson',
	#superclass : 'SymMbDPosNewtonRaphson',
	#instVars : [
		'nqsu',
		'qsuOld',
		'qsuWeights',
		'nSingularMatrixError'
	],
	#category : 'StCAD-MbD-My Classes',
	#package : 'StCAD-MbD',
	#tag : 'My Classes'
}

{ #category : 'VisualWorks metadata' }
SymMbDAnyPosICNewtonRaphson class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'initialize-release' }
SymMbDAnyPosICNewtonRaphson >> assignEquationNumbers [
	" *** This method was defined by StCAD.StMbD.MbDSystemNewtonRaphson2 as a subclass responsibility.
	Replace its body with a proper implementation. *** "

	self error: 'Subclass responsibility stub not reimplemented'
]

{ #category : 'initialize-release' }
SymMbDAnyPosICNewtonRaphson >> createVectorsAndMatrices [
	qsuOld := StMFullColumn new: nqsu.
	qsuWeights := StMDiagonalMatrix new: nqsu.
	super createVectorsAndMatrices
]

{ #category : 'solving' }
SymMbDAnyPosICNewtonRaphson >> fillPyPx [

	pypx zeroSelf.
	pypx at: 1 and: 1 minusDiagonalMatrix: qsuWeights.
	system allDo: [ :item | item fillPosICJacob: pypx ]
]

{ #category : 'solving' }
SymMbDAnyPosICNewtonRaphson >> fillY [

	| newMinusOld |
	newMinusOld := qsuOld negated.
	newMinusOld equalSelfPlusFullColumn: x at: 1.
	y zeroSelf.
	y at: 1 minusFullColumn: (qsuWeights timesFullColumn: newMinusOld).
	system allDo: [ :item | item fillPosICError: y ]
]

{ #category : 'initialize-release' }
SymMbDAnyPosICNewtonRaphson >> initialize [
	super initialize.
	nSingularMatrixError := 0
]

{ #category : 'initialize-release' }
SymMbDAnyPosICNewtonRaphson >> initializeGlobally [

	super initializeGlobally.
	system allDo: [ :item |
		item fillqsu: qsuOld.
		item fillqsuWeights: qsuWeights.
		item fillqsulam: x ]
]

{ #category : 'solving' }
SymMbDAnyPosICNewtonRaphson >> iterate [
	"
	Do not skip matrix solution even when yNorm is very small. 
	This avoids unexpected behaviors when convergence is still 
	possible. 
	
	Do not skip redundant constraint removal even when yNorm is 
	zero. 
	"

	iterNo := 0.
	self fillY.
	self calcyNorm.
	yNorms add: yNorm.

	[
	self incrementIterNo.
	self fillPyPx.
	self solveEquations.
	self calcDXNormImproveRootCalcYNorm.
	self isConverged ] whileFalse
]

{ #category : 'solving' }
SymMbDAnyPosICNewtonRaphson >> passRootToSystem [
	system allDo: [:item | item setqsulam: x]
]
