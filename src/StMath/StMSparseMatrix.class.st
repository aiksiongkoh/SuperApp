"
SparseMatrix contains StMIdentityDictionary's.
"
Class {
	#name : #StMSparseMatrix,
	#superclass : #StMRowTypeMatrix,
	#type : #variable,
	#category : #'StMath-StMathArray'
}

{ #category : #'instance creation' }
StMSparseMatrix class >> newWithElements: a2DArray [ 
	^(StMFullMatrix newWithElements: a2DArray) asSparseMatrix
]

{ #category : #accessing }
StMSparseMatrix class >> veryShortName [
	^'SpMat'
]

{ #category : #'VisualWorks metadata' }
StMSparseMatrix class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #converting }
StMSparseMatrix >> asFullMatrix [
	| nrow answer |
	nrow := self nrow.
	answer := StMFullMatrix new: nrow.
	1 to: nrow do: [:i | answer at: i put: (self at: i) asFullRow].
	^answer
]

{ #category : #'instance creation' }
StMSparseMatrix >> by: secondSize [ 
	"Add second dimension to matrix. Used by new:by: only."

	| rowi |
	1 to: self nrow
		do: 
			[:i | 
			rowi := self secondDimensionClass new: (secondSize min: 7).
			rowi fullsize: secondSize.
			self at: i put: rowi]
]

{ #category : #accessing }
StMSparseMatrix >> matrixSolverClass [
	^GESpMatParPvMarkoFast
]

{ #category : #'basic ops' }
StMSparseMatrix >> minusSparseMatrix: aSparseMatrix [ 
	"a - b."
	"Assume all checking of validity of this operation has been done."
	"Just evaluate quickly."

	| answer |
	answer := self shallowCopy.
	1 to: answer nrow do: [:i | answer at: i put: ((answer at: i)
				minusSparseRow: (aSparseMatrix at: i))].
	^answer
]

{ #category : #'basic ops' }
StMSparseMatrix >> minusSparseMatrix: aSparseMatrix times: beta [ 
	"a - b."
	"Assume all checking of validity of this operation has been done."
	"Just evaluate quickly."

	| answer |
	answer := self shallowCopy.
	1 to: answer nrow do: [:i | answer at: i put: ((answer at: i)
				minusSparseRow: (aSparseMatrix at: i)
				times: beta)].
	^answer
]

{ #category : #'basic ops' }
StMSparseMatrix >> plusSparseMatrix: aSparseMatrix [ 
	"a + b."
	"Assume all checking of validity of this operation has been done."
	"Just evaluate quickly."

	| answer |
	answer := self shallowCopy.
	1 to: answer nrow do: [:i | answer at: i put: ((answer at: i)
				plusSparseRow: (aSparseMatrix at: i))].
	^answer
]

{ #category : #'basic ops' }
StMSparseMatrix >> plusSparseMatrix: aSparseMatrix times: beta [ 
	"a + b."
	"Assume all checking of validity of this operation has been done."
	"Just evaluate quickly."

	| answer |
	answer := self shallowCopy.
	1 to: answer nrow do: [:i | answer at: i put: ((answer at: i)
				plusSparseRow: (aSparseMatrix at: i)
				times: beta)].
	^answer
]

{ #category : #accessing }
StMSparseMatrix >> secondDimensionClass [
	^StMSparseRow
]

{ #category : #'basic ops' }
StMSparseMatrix >> times: alpha minusSparseMatrix: aSparseMatrix [ 
	"a*alpha + b."
	"Assume all checking of validity of this operation has been done."
	"Just evaluate quickly."

	| answer |
	answer := self shallowCopy.
	1 to: answer nrow do: [:i | answer at: i put: ((answer at: i)
				times: alpha minusSparseRow: (aSparseMatrix at: i))].
	^answer
]

{ #category : #'basic ops' }
StMSparseMatrix >> times: alpha minusSparseMatrix: aSparseMatrix times: beta [ 
	"a*alpha + b."
	"Assume all checking of validity of this operation has been done."
	"Just evaluate quickly."

	| answer |
	answer := self shallowCopy.
	1 to: answer nrow do: [:i | answer at: i put: ((answer at: i)
				times: alpha
				minusSparseRow: (aSparseMatrix at: i)
				times: beta)].
	^answer
]

{ #category : #'basic ops' }
StMSparseMatrix >> times: alpha plusSparseMatrix: aSparseMatrix [ 
	"a*alpha + b."
	"Assume all checking of validity of this operation has been done."
	"Just evaluate quickly."

	| answer |
	answer := self shallowCopy.
	1 to: answer nrow do: [:i | answer at: i put: ((answer at: i)
				times: alpha plusSparseRow: (aSparseMatrix at: i))].
	^answer
]

{ #category : #'basic ops' }
StMSparseMatrix >> times: alpha plusSparseMatrix: aSparseMatrix times: beta [ 
	"a*alpha + b."
	"Assume all checking of validity of this operation has been done."
	"Just evaluate quickly."

	| answer |
	answer := self shallowCopy.
	1 to: answer nrow do: [:i | answer at: i put: ((answer at: i)
				times: alpha
				plusSparseRow: (aSparseMatrix at: i)
				times: beta)].
	^answer
]

{ #category : #'basic ops' }
StMSparseMatrix >> transpose [
	"Returns a new Matrix which is the transpose of self."

	| nrow answer rowi |
	nrow := self nrow.
	answer := self class new: self ncol by: nrow.
	1 to: nrow
		do: 
			[:i | 
			rowi := self at: i.
			rowi keysAndValuesDo: [:j :value | answer
					at: j
					and: i
					put: value]].
	^answer
]
