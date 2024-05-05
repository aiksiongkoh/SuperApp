Class {
	#name : #StMFullRow,
	#superclass : #StMFullVector,
	#type : #variable,
	#category : #'StMath-StMathArray'
}

{ #category : #accessing }
StMFullRow class >> veryShortName [
	^'Row'
]

{ #category : #'VisualWorks metadata' }
StMFullRow class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #converting }
StMFullRow >> asFullRow [
	"Do nothing."
]

{ #category : #converting }
StMFullRow >> asSparseRow [
	| ncol answer |
	ncol := self ncol.
	answer := StMSparseRow new: ncol.
	1 to: ncol
		do: 
			[:i | 
			| ai |
			ai := self at: i.
			ai isZero ifFalse: [answer at: i put: ai]].
	^answer
]

{ #category : #'ops on self' }
StMFullRow >> at: i minusFullRow: aFullRow [ 
	super at: i minusFullVector: aFullRow
]

{ #category : #'ops on self' }
StMFullRow >> at: i minusFullRow: aFullRow times: aNumber [ 
	super
		at: i
		minusFullVector: aFullRow
		times: aNumber
]

{ #category : #'ops on self' }
StMFullRow >> at: i plusFullRow: aFullRow [ 
	super at: i plusFullVector: aFullRow
]

{ #category : #'ops on self' }
StMFullRow >> at: i plusFullRow: aFullRow times: aNumber [ 
	super
		at: i
		plusFullVector: aFullRow
		times: aNumber
]

{ #category : #'ops on self' }
StMFullRow >> at: j1 putFullRow: aFullRow [ 
	super at: j1 putFullVector: aFullRow
]

{ #category : #'ops on self' }
StMFullRow >> at: j1 putFullRow: aFullRow times: aNumber [ 
	super
		at: j1
		putFullVector: aFullRow
		times: aNumber
]

{ #category : #'ops on self' }
StMFullRow >> equalFullRow: aFullRow [ 
	super equalFullVector: aFullRow
]

{ #category : #'ops on self' }
StMFullRow >> equalFullRow: aFullRow at: j1 [ 
	super equalFullVector: aFullRow at: j1
]

{ #category : #'ops on self' }
StMFullRow >> equalFullRow: aFullRow times: aNumber [ 
	super equalFullVector: aFullRow times: aNumber
]

{ #category : #'ops on self' }
StMFullRow >> equalSelfMinusFullRow: aFullRow [ 
	super equalSelfMinusFullVector: aFullRow
]

{ #category : #'ops on self' }
StMFullRow >> equalSelfMinusFullRow: aFullRow at: jj1 [ 
	super equalSelfMinusFullVector: aFullRow at: jj1
]

{ #category : #'ops on self' }
StMFullRow >> equalSelfMinusFullRow: aFullRow times: aNumber [ 
	super equalSelfMinusFullVector: aFullRow times: aNumber
]

{ #category : #'ops on self' }
StMFullRow >> equalSelfMinusSparseRow: aSparseRow [ 
	super equalSelfMinusSparseVector: aSparseRow
]

{ #category : #'ops on self' }
StMFullRow >> equalSelfMinusSparseRow: aSparseRow times: aNumber [ 
	super equalSelfMinusSparseVector: aSparseRow times: aNumber
]

{ #category : #'ops on self' }
StMFullRow >> equalSelfPlusFullRow: aFullRow [ 
	super equalSelfPlusFullVector: aFullRow
]

{ #category : #'ops on self' }
StMFullRow >> equalSelfPlusFullRow: aFullRow at: jj1 [ 
	super equalSelfPlusFullVector: aFullRow at: jj1
]

{ #category : #'ops on self' }
StMFullRow >> equalSelfPlusFullRow: aFullRow times: aNumber [ 
	super equalSelfPlusFullVector: aFullRow times: aNumber
]

{ #category : #'ops on self' }
StMFullRow >> equalSelfPlusSparseRow: aSparseRow [ 
	super equalSelfPlusSparseVector: aSparseRow
]

{ #category : #'ops on self' }
StMFullRow >> equalSelfPlusSparseRow: aSparseRow times: aNumber [ 
	super equalSelfPlusSparseVector: aSparseRow times: aNumber
]

{ #category : #'ops on self' }
StMFullRow >> equalSelfTimes: alpha minusFullRow: aFullRow times: beta [ 
	super
		equalSelfTimes: alpha
		minusFullVector: aFullRow
		times: beta
]

{ #category : #'ops on self' }
StMFullRow >> equalSelfTimes: alpha plusFullRow: aFullRow times: beta [ 
	super
		equalSelfTimes: alpha
		plusFullVector: aFullRow
		times: beta
]

{ #category : #'basic ops' }
StMFullRow >> minusFullRow: aFullRow [ 
	^super minusFullVector: aFullRow
]

{ #category : #'basic ops' }
StMFullRow >> minusFullRow: aFullRow times: aNumber [ 
	^super minusFullVector: aFullRow times: aNumber
]

{ #category : #accessing }
StMFullRow >> ncol [
	"Answer the number of indexable fields in the receiver. This value is the 
	same as the largest legal subscript. Primitive is specified here to override 
	SequenceableCollection size."

	<primitive: 62>
	^self basicSize
]

{ #category : #accessing }
StMFullRow >> nrow [
	^1
]

{ #category : #'basic ops' }
StMFullRow >> plusFullRow: aFullRow [ 
	^super plusFullVector: aFullRow
]

{ #category : #'basic ops' }
StMFullRow >> plusFullRow: aFullRow times: aNumber [ 
	^super plusFullVector: aFullRow times: aNumber
]

{ #category : #'basic ops' }
StMFullRow >> times: alpha minusFullRow: aFullRow [ 
	^super times: alpha minusFullVector: aFullRow
]

{ #category : #'basic ops' }
StMFullRow >> times: beta minusFullRow: aFullRow times: alpha [ 
	^super
		times: beta
		minusFullVector: aFullRow
		times: alpha
]

{ #category : #'basic ops' }
StMFullRow >> times: alpha plusFullRow: aFullRow [ 
	^super times: alpha plusFullVector: aFullRow
]

{ #category : #'basic ops' }
StMFullRow >> times: beta plusFullRow: aFullRow times: alpha [ 
	^super
		times: beta
		plusFullVector: aFullRow
		times: alpha
]

{ #category : #'basic ops' }
StMFullRow >> timesFullColumn: aFullColumn [ 
	| answer |
	answer := (self at: 1)
				* (aFullColumn at: 1).
	2 to: self ncol do: [:j | answer := answer + ((self at: j)
						* (aFullColumn at: j))].
	^answer
]

{ #category : #'basic ops' }
StMFullRow >> timesFullMatrix: aFullMatrix [ 
	"Similar to inner dot product."

	| answer |
	answer := (aFullMatrix at: 1)
				times: (self at: 1).
	2 to: self ncol do: [:j | answer equalSelfPlusFullRow: (aFullMatrix at: j)
			times: (self at: j)].
	^answer
]

{ #category : #'basic ops' }
StMFullRow >> timesFullRow: aFullRow [ 
	self halt: 'Row times: Row is not a valid operation.'
]

{ #category : #'basic ops' }
StMFullRow >> timesSparseMatrix: aSparseMatrix [ 
	| answer |
	answer := self class new: aSparseMatrix ncol.
	answer zeroSelf.
	1 to: self ncol do: [:j | answer equalSelfPlusSparseRow: (aSparseMatrix at: j)
			times: (self at: j)].
	^answer
]

{ #category : #'basic ops' }
StMFullRow >> timesTransposeFullMatrix: aFullMatrix [ 
	"a*bT = a(1,j)b(k,j)"

	| ncol answer |
	ncol := aFullMatrix nrow.
	answer := StMFullRow new: ncol.
	1 to: ncol do: [:k | answer at: k put: (self dot: (aFullMatrix at: k))].
	^answer
]

{ #category : #'basic ops' }
StMFullRow >> timesTransposeSparseMatrix: aSparseMatrix [ 
	"a*bT = a(1,j)b(k,j)"

	| ncol answer |
	ncol := aSparseMatrix nrow.
	answer := StMFullRow new: ncol.
	1 to: ncol do: [:k | answer at: k put: ((aSparseMatrix at: k)
				dot: self)].
	^answer
]

{ #category : #'basic ops' }
StMFullRow >> transpose [
	"Return a row with the same elements."
	"This method is much faster than the obvious way."

	^self shallowCopy changeClassToThatOf: (StMFullColumn new: 0)
]

{ #category : #'basic ops' }
StMFullRow >> transposeTimesFullRow: aFullRow [ 
	"a*b = a(i)b(j)"

	| nrow answer |
	nrow := self ncol.
	answer := StMFullMatrix new: nrow.
	1 to: nrow do: [:i | answer at: i put: (aFullRow times: (self at: i))].
	^answer
]
