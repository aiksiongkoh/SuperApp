Class {
	#name : 'CroutFullMatParPv',
	#superclass : 'CroutFullMat',
	#category : 'StMath-StMathMatrixSolver',
	#package : 'StMath',
	#tag : 'StMathMatrixSolver'
}

{ #category : 'testing' }
CroutFullMatParPv class >> isAbstractClass [
	^false
]

{ #category : 'VisualWorks metadata' }
CroutFullMatParPv class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'pivoting' }
CroutFullMatParPv >> doPivoting: p [
	"Use scalings. Do row pivoting."

	| app max rowPivot aip mag |
	app := (matrixA at: p) at: p.
	max := app * (rowScalings at: p).
	max < 0 ifTrue: [ max := 0.0 - max ].
	rowPivot := p.
	p + 1 to: m do: [ :i |
		aip := (matrixA at: i) at: p.
		aip = 0 ifFalse: [
			mag := aip * (rowScalings at: i).
			mag < 0 ifTrue: [ mag := 0.0 - mag ].
			mag > max ifTrue: [
				max := mag.
				rowPivot := i ] ] ].
	p == rowPivot ifFalse: [
		matrixA swap: p with: rowPivot.
		rowScalings swap: p with: rowPivot.
		rowOrder swap: p with: rowPivot ].
	pivotValues at: p put: max.
	max < singularPivotTolerance ifTrue: [ SingularMatrixError signal ]
]
