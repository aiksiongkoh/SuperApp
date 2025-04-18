Class {
	#name : 'GESpMatParPvPrecise',
	#superclass : 'GESpMatParPv',
	#category : 'StMath-StMathMatrixSolver',
	#package : 'StMath',
	#tag : 'StMathMatrixSolver'
}

{ #category : 'testing' }
GESpMatParPvPrecise class >> isAbstractClass [
	^false
]

{ #category : 'VisualWorks metadata' }
GESpMatParPvPrecise class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'pivoting' }
GESpMatParPvPrecise >> doPivoting: p [
	"Search from bottom to top."

	"Use scaling vector and partial pivoting with actual swapping of rows."

	"Check for singular pivot."

	"Criterion is largest pivot in column."

	| max rowPivot aip mag lookForFirstNonZeroInPivotCol i |
	rowPositionsOfNonZerosInPivotColumn reset.
	lookForFirstNonZeroInPivotCol := true.
	i := m.
	[ lookForFirstNonZeroInPivotCol ] whileTrue: [
		aip := (matrixA at: i) at: p.
		aip == nil
			ifTrue: [ i > p ifFalse: [ SingularMatrixError signal ] ]
			ifFalse: [
				markowitzPivotColCount := 0.
				mag := aip * (rowScalings at: i).
				mag < 0 ifTrue: [ mag := 0.0 - mag ].
				max := mag.
				rowPivot := i.
				lookForFirstNonZeroInPivotCol := false ].
		i := i - 1 ].
	[ i >= p ] whileTrue: [
		aip := (matrixA at: i) at: p.
		aip == nil ifFalse: [
			markowitzPivotColCount := markowitzPivotColCount + 1.
			mag := aip * (rowScalings at: i).
			mag < 0 ifTrue: [ mag := 0.0 - mag ].
			mag > max
				ifTrue: [
					max := mag.
					rowPositionsOfNonZerosInPivotColumn add: rowPivot.
					rowPivot := i ]
				ifFalse: [ rowPositionsOfNonZerosInPivotColumn add: i ] ].
		i := i - 1 ].
	p == rowPivot ifFalse: [
		matrixA swap: p with: rowPivot.
		rightHandSideB swap: p with: rowPivot.
		rowScalings swap: p with: rowPivot.
		rowOrder swap: p with: rowPivot.
		aip == nil ifFalse: [
			rowPositionsOfNonZerosInPivotColumn at: markowitzPivotColCount put: rowPivot ] ].
	pivotValues at: p put: max.
	max < singularPivotTolerance ifTrue: [ SingularMatrixError signal ]
]

{ #category : 'solution' }
GESpMatParPvPrecise >> preSolve: aMatrix with: aVector saveOriginal: saveOriginal [
	"A conditioned copy of aMatrix is solved."

	| rowi maxRowElement |
	(m == aMatrix nrow and: [ n == aMatrix ncol ]) ifFalse: [
		m := aMatrix nrow.
		n := aMatrix ncol.
		matrixA := StMSparseMatrix new: m.
		rowScalings := StMFullColumn new: m.
		pivotValues := StMFullColumn new: m.
		rowOrder := StMArray new: m.
		privateIndicesOfNonZerosInPivotRow := OrderedCollection new.
		rowPositionsOfNonZerosInPivotColumn := OrderedCollection new ].
	rightHandSideB := saveOriginal
		                  ifTrue: [ aVector copy ]
		                  ifFalse: [ aVector ].
	1 to: m do: [ :i |
		rowi := (aMatrix at: i) asSparseRow.
		maxRowElement := rowi maxElement.
		maxRowElement > 0 ifFalse: [ SingularMatrixError signal ].
		rowScalings at: i put: 1.0 / maxRowElement.
		matrixA at: i put: (rowi conditionedWithTol: singularPivotTolerance * maxRowElement).
		rowOrder at: i put: i ]
]
