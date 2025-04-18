Class {
	#name : 'GESpMatParPvMarko',
	#superclass : 'GESpMatParPv',
	#category : 'StMath-StMathMatrixSolver',
	#package : 'StMath',
	#tag : 'StMathMatrixSolver'
}

{ #category : 'testing' }
GESpMatParPvMarko class >> isAbstractClass [
	^false
]

{ #category : 'VisualWorks metadata' }
GESpMatParPvMarko class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'pivoting' }
GESpMatParPvMarko >> doPivoting: p [
	"Search from bottom to top."

	"Check for singular pivot."

	"Do scaling. Do partial pivoting."

	"criterion := mag / (2.0d raisedTo: rowiCount)."

	| lookForFirstNonZeroInPivotCol i rowi aip mag max criterionMax rowPivot criterion |
	rowPositionsOfNonZerosInPivotColumn reset.
	lookForFirstNonZeroInPivotCol := true.
	i := m.
	[ lookForFirstNonZeroInPivotCol ] whileTrue: [
		rowi := matrixA at: i.
		aip := rowi at: p.
		aip == nil
			ifTrue: [ i > p ifFalse: [ SingularMatrixError signal ] ]
			ifFalse: [
				markowitzPivotColCount := 0.
				mag := aip * (rowScalings at: i).
				mag < 0 ifTrue: [ mag := 0.0 - mag ].
				max := mag.
				criterionMax := mag / (2.0 raisedTo: rowi tally).
				rowPivot := i.
				lookForFirstNonZeroInPivotCol := false ].
		i := i - 1 ].
	[ i >= p ] whileTrue: [
		rowi := matrixA at: i.
		aip := rowi at: p.
		aip == nil ifFalse: [
			markowitzPivotColCount := markowitzPivotColCount + 1.
			mag := aip * (rowScalings at: i).
			mag < 0 ifTrue: [ mag := 0.0 - mag ].
			criterion := mag / (2.0 raisedTo: rowi tally).
			criterion > criterionMax
				ifTrue: [
					max := mag.
					criterionMax := criterion.
					rowPositionsOfNonZerosInPivotColumn add: rowPivot.
					rowPivot := i ]
				ifFalse: [ rowPositionsOfNonZerosInPivotColumn add: i ] ].
		i := i - 1 ].
	p == rowPivot ifFalse: [
		matrixA swap: p with: rowPivot.
		rightHandSideB swap: p with: rowPivot.
		rowScalings swap: p with: rowPivot.
		aip == nil ifFalse: [
			rowPositionsOfNonZerosInPivotColumn at: markowitzPivotColCount put: rowPivot ] ].
	max < singularPivotTolerance ifTrue: [ SingularMatrixError raiseSignal ]
]

{ #category : 'solution' }
GESpMatParPvMarko >> preSolve: aMatrix with: aVector saveOriginal: saveOriginal [
	"Optimized for speed."

	| rowi maxRowElement |
	(m == aMatrix nrow and: [ n == aMatrix ncol ]) ifFalse: [
		m := aMatrix nrow.
		n := aMatrix ncol.
		matrixA := StMSparseMatrix new: m.
		rowScalings := StMFullColumn new: m.
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
		matrixA at: i put: (rowi conditionedWithTol: singularPivotTolerance * maxRowElement) ]
]
