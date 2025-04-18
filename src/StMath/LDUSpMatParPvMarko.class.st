Class {
	#name : 'LDUSpMatParPvMarko',
	#superclass : 'LDUSpMatParPv',
	#category : 'StMath-StMathMatrixSolver',
	#package : 'StMath',
	#tag : 'StMathMatrixSolver'
}

{ #category : 'testing' }
LDUSpMatParPvMarko class >> isAbstractClass [
	^false
]

{ #category : 'VisualWorks metadata' }
LDUSpMatParPvMarko class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'pivoting' }
LDUSpMatParPvMarko >> doPivoting: p [
	"Search from bottom to top."

	"Check for singular pivot."

	"Do scaling. Do partial pivoting."

	"criterion := mag / (2.0 raisedTo: rowiCount)."

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
		rowScalings swap: p with: rowPivot.
		rowOrder swap: p with: rowPivot.
		matrixL swap: p with: rowPivot.
		aip == nil ifFalse: [
			rowPositionsOfNonZerosInPivotColumn at: markowitzPivotColCount put: rowPivot ] ].
	max < singularPivotTolerance ifTrue: [ SingularMatrixError raiseSignal ]
]
