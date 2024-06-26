Class {
	#name : 'MatrixCroutDecomposition',
	#superclass : 'MatrixDecomposition',
	#category : 'StMath-StMathMatrixSolver',
	#package : 'StMath',
	#tag : 'StMathMatrixSolver'
}

{ #category : 'VisualWorks metadata' }
MatrixCroutDecomposition class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'solution' }
MatrixCroutDecomposition >> decompose: aMatrix saveOriginal: saveOriginal [ 
	self preSolve: aMatrix saveOriginal: saveOriginal.
	1 to: m
		do: 
			[:p | 
			self formLij: p.
			self doPivoting: p.
			self formUij: p]
]

{ #category : 'solution' }
MatrixCroutDecomposition >> forAndBackSub: aVector saveOriginal: saveOriginal [ 
	rightHandSideB := saveOriginal
				ifTrue: [aVector copy]
				ifFalse: [aVector].
	self applyRowOrderOnRightHandSideB.
	self forwardSubstituteIntoLD.
	self backSubstituteIntoU.
	^answerX
]
