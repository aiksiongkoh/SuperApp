Class {
	#name : 'MbDAnyPosICNewtonRaphson2',
	#superclass : 'MbDPosNewtonRaphson2',
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
MbDAnyPosICNewtonRaphson2 class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'initialize-release' }
MbDAnyPosICNewtonRaphson2 >> assignEquationNumbers [
	" *** This method was defined by StCAD.StMbD.MbDSystemNewtonRaphson2 as a subclass responsibility.
	Replace its body with a proper implementation. *** "

	self error: 'Subclass responsibility stub not reimplemented'
]

{ #category : 'initialize-release' }
MbDAnyPosICNewtonRaphson2 >> createVectorsAndMatrices [
	qsuOld := StMFullColumn new: nqsu.
	qsuWeights := StMDiagonalMatrix new: nqsu.
	super createVectorsAndMatrices
]

{ #category : 'solving' }
MbDAnyPosICNewtonRaphson2 >> fillPyPx [

	pypx zeroSelf.
	pypx at: 1 and: 1 minusDiagonalMatrix: qsuWeights.
	system allDo: [ :item | item fillPosICJacob: pypx ]
]

{ #category : 'solving' }
MbDAnyPosICNewtonRaphson2 >> fillY [

	| newMinusOld |
	newMinusOld := qsuOld negated.
	newMinusOld equalSelfPlusFullColumn: x at: 1.
	y zeroSelf.
	y at: 1 minusFullColumn: (qsuWeights timesFullColumn: newMinusOld).
	system allDo: [ :item | item fillPosICError: y ]
]

{ #category : 'initialize-release' }
MbDAnyPosICNewtonRaphson2 >> initialize [
	super initialize.
	nSingularMatrixError := 0
]

{ #category : 'initialize-release' }
MbDAnyPosICNewtonRaphson2 >> initializeGlobally [

	super initializeGlobally.
	system allDo: [ :item |
		item fillqsu: qsuOld.
		item fillqsuWeights: qsuWeights.
		item fillqsulam: x ]
]

{ #category : 'solving' }
MbDAnyPosICNewtonRaphson2 >> iterate [
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
MbDAnyPosICNewtonRaphson2 >> passRootToSystem [
	system allDo: [:item | item setqsulam: x]
]
