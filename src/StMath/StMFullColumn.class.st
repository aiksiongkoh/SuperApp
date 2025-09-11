Class {
	#name : 'StMFullColumn',
	#superclass : 'StMFullVector',
	#type : 'variable',
	#category : 'StMath-StMathArray',
	#package : 'StMath',
	#tag : 'StMathArray'
}

{ #category : 'instance creation' }
StMFullColumn class >> fromCollection: aCollection aBlock: aBlock [ 
	| size aFullColumn |
	size := aCollection size.
	aFullColumn := self new: size.
	1 to: size
		do: [:i | aFullColumn at: i put: (aBlock value: (aCollection at: i))].
	^aFullColumn
]

{ #category : 'accessing' }
StMFullColumn class >> veryShortName [
	^'Col'
]

{ #category : 'VisualWorks metadata' }
StMFullColumn class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'converting' }
StMFullColumn >> asFullColumn [

	^self
]

{ #category : 'converting' }
StMFullColumn >> asFullRow [
	^self shallowCopy changeClassToThatOf: (StMFullRow new: 0)
]

{ #category : 'converting' }
StMFullColumn >> asZeroColumn [
	^ZeroColumn new: self nrow
]

{ #category : 'ops on self' }
StMFullColumn >> at: i minusFullColumn: aFullColumn [ 
	super at: i minusFullVector: aFullColumn
]

{ #category : 'ops on self' }
StMFullColumn >> at: i minusFullColumn: aFullColumn times: aNumber [ 
	super
		at: i
		minusFullVector: aFullColumn
		times: aNumber
]

{ #category : 'ops on self' }
StMFullColumn >> at: i plusFullColumn: aFullColumn [ 
	super at: i plusFullVector: aFullColumn
]

{ #category : 'ops on self' }
StMFullColumn >> at: i plusFullColumn: aFullColumn times: aNumber [ 
	super
		at: i
		plusFullVector: aFullColumn
		times: aNumber
]

{ #category : 'ops on self' }
StMFullColumn >> at: i plusTransposeFullRow: aFullRow times: aNumber [

	[ aFullRow isMemberOf: StMFullRow ] assert.
	super at: i plusFullVector: aFullRow times: aNumber
]

{ #category : 'ops on self' }
StMFullColumn >> at: i1 putFullColumn: aFullColumn [ 
	super at: i1 putFullVector: aFullColumn
]

{ #category : 'ops on self' }
StMFullColumn >> at: i1 putFullColumn: aFullColumn times: aNumber [ 
	super
		at: i1
		putFullVector: aFullColumn
		times: aNumber
]

{ #category : 'comparing' }
StMFullColumn >> equal: aArray tol: tol [ 
	"Equal to within a box of side 2*tol."

	| n answer i |
	n := self size.
	answer := true.
	i := 1.
	
	[((self at: i) equal: (aArray at: i) tol: tol) ifFalse: [answer := false].
	answer and: 
			[i := i + 1.
			i <= n]] 
			whileTrue.
	^answer
]

{ #category : 'comparing' }
StMFullColumn >> equal: aArray tolBox: tol [ 
	"Equal to within a box of side 2*tol."

	| n answer i |
	n := self size.
	answer := true.
	i := 1.
	
	[((self at: i) equal: (aArray at: i) tol: tol) ifFalse: [answer := false].
	answer and: 
			[i := i + 1.
			i <= n]] 
			whileTrue.
	^answer
]

{ #category : 'comparing' }
StMFullColumn >> equal: aFullColumn tolRadius: tol [ 
	^(self minusFullColumn: aFullColumn) length <= tol
]

{ #category : 'ops on self' }
StMFullColumn >> equalFullColumn: aFullColumn [ 
	super equalFullVector: aFullColumn
]

{ #category : 'ops on self' }
StMFullColumn >> equalFullColumn: aFullColumn at: ii1 [ 
	super equalFullVector: aFullColumn at: ii1
]

{ #category : 'ops on self' }
StMFullColumn >> equalFullColumn: aFullColumn times: aNumber [ 
	super equalFullVector: aFullColumn times: aNumber
]

{ #category : 'ops on self' }
StMFullColumn >> equalFullMatrix: aFullMatrix at: ii1 and: jj1 [ 
	| iiOffset |
	iiOffset := ii1 - 1.
	1 to: self size do: [:i | self at: i put: (aFullMatrix at: iiOffset + i and: jj1)]
]

{ #category : 'ops on self' }
StMFullColumn >> equalSelfMinusFullColumn: aFullColumn [ 
	super equalSelfMinusFullVector: aFullColumn
]

{ #category : 'ops on self' }
StMFullColumn >> equalSelfMinusFullColumn: aFullColumn at: ii1 [ 
	super equalSelfMinusFullVector: aFullColumn at: ii1
]

{ #category : 'ops on self' }
StMFullColumn >> equalSelfMinusFullColumn: aFullColumn times: aNumber [ 
	super equalSelfMinusFullVector: aFullColumn times: aNumber
]

{ #category : 'ops on self' }
StMFullColumn >> equalSelfMinusFullMatrix: aFullMatrix at: ii1 and: jj1 [ 
	| iiOffset |
	iiOffset := ii1 - 1.
	1 to: self size do: [:i | self at: i put: (self at: i)
				- (aFullMatrix at: iiOffset + i and: jj1)]
]

{ #category : 'ops on self' }
StMFullColumn >> equalSelfMinusSparseColumn: aSparseColumn [ 
	super equalSelfMinusSparseVector: aSparseColumn
]

{ #category : 'ops on self' }
StMFullColumn >> equalSelfMinusSparseColumn: aSparseColumn times: aNumber [ 
	super equalSelfMinusSparseVector: aSparseColumn times: aNumber
]

{ #category : 'ops on self' }
StMFullColumn >> equalSelfPlusFullColumn: aFullColumn [ 
	super equalSelfPlusFullVector: aFullColumn
]

{ #category : 'ops on self' }
StMFullColumn >> equalSelfPlusFullColumn: aFullColumn at: ii1 [ 
	super equalSelfPlusFullVector: aFullColumn at: ii1
]

{ #category : 'ops on self' }
StMFullColumn >> equalSelfPlusFullColumn: aFullColumn times: aNumber [ 
	super equalSelfPlusFullVector: aFullColumn times: aNumber
]

{ #category : 'ops on self' }
StMFullColumn >> equalSelfPlusFullMatrix: aFullMatrix at: ii1 and: jj1 [ 
	| iiOffset |
	iiOffset := ii1 - 1.
	1 to: self size do: [:i | self at: i put: (self at: i)
				+ (aFullMatrix at: iiOffset + i and: jj1)]
]

{ #category : 'ops on self' }
StMFullColumn >> equalSelfPlusSparseColumn: aSparseColumn [ 
	super equalSelfPlusSparseVector: aSparseColumn
]

{ #category : 'ops on self' }
StMFullColumn >> equalSelfPlusSparseColumn: aSparseColumn times: aNumber [ 
	super equalSelfPlusSparseVector: aSparseColumn times: aNumber
]

{ #category : 'ops on self' }
StMFullColumn >> equalSelfTimes: alpha minusFullColumn: aFullColumn times: beta [ 
	super
		equalSelfTimes: alpha
		minusFullVector: aFullColumn
		times: beta
]

{ #category : 'ops on self' }
StMFullColumn >> equalSelfTimes: alpha plusFullColumn: aFullColumn times: beta [ 
	super
		equalSelfTimes: alpha
		plusFullVector: aFullColumn
		times: beta
]

{ #category : 'as yet unclassified' }
StMFullColumn >> extendTo: col factor: factor [

	^ self times: 1.0 - factor plusFullColumn: col times: factor
]

{ #category : 'ops on self' }
StMFullColumn >> fitSelfInBox: aBoundingBox [ 
	aBoundingBox isDefined 
		ifTrue: 
			[aBoundingBox origin: (self min: aBoundingBox minCorner)
				corner: (self max: aBoundingBox maxCorner)]
		ifFalse: [aBoundingBox origin: self copy corner: self copy]
]

{ #category : 'basic ops' }
StMFullColumn >> minusFullColumn: aFullColumn [ 
	^super minusFullVector: aFullColumn
]

{ #category : 'basic ops' }
StMFullColumn >> minusFullColumn: aFullColumn times: aNumber [ 
	^super minusFullVector: aFullColumn times: aNumber
]

{ #category : 'accessing' }
StMFullColumn >> ncol [
	^1
]

{ #category : 'accessing' }
StMFullColumn >> nrow [
	"Answer the number of indexable fields in the receiver. This value is the 
	same as the largest legal subscript. Primitive is specified here to override 
	SequenceableCollection size."

	<primitive: 62>
	^self basicSize
]

{ #category : 'basic ops' }
StMFullColumn >> plusFullColumn: aFullColumn [ 
	^super plusFullVector: aFullColumn
]

{ #category : 'basic ops' }
StMFullColumn >> plusFullColumn: aFullColumn times: aNumber [ 
	^super plusFullVector: aFullColumn times: aNumber
]

{ #category : 'basic ops' }
StMFullColumn >> times: beta minusFullColumn: aFullColumn [ 
	^super times: beta minusFullVector: aFullColumn
]

{ #category : 'basic ops' }
StMFullColumn >> times: beta minusFullColumn: aFullColumn times: alpha [ 
	^super
		times: beta
		minusFullVector: aFullColumn
		times: alpha
]

{ #category : 'basic ops' }
StMFullColumn >> times: alpha plusFullColumn: aFullColumn [ 
	^super times: alpha plusFullVector: aFullColumn
]

{ #category : 'basic ops' }
StMFullColumn >> times: beta plusFullColumn: aFullColumn times: alpha [ 
	^super
		times: beta
		plusFullVector: aFullColumn
		times: alpha
]

{ #category : 'basic ops' }
StMFullColumn >> timesFullColumn: aFullColumn [ 
	self halt: 'Column times: Column is not a valid operation.'
]

{ #category : 'basic ops' }
StMFullColumn >> timesFullMatrix: aFullMatrix [ 
	"a*b = a(i)b(1,j)"

	^aFullMatrix nrow == 1
		ifTrue: [self timesFullRow: (aFullMatrix at: 1)]
		ifFalse: [self error: 'StM: Incompatible row size.']
]

{ #category : 'basic ops' }
StMFullColumn >> timesFullRow: aFullRow [ 
	"a*b = a(i)b(j)"

	| nrow answer |
	nrow := self nrow.
	answer := StMFullMatrix new: nrow.
	1 to: nrow do: [:i | answer at: i put: (aFullRow times: (self at: i))].
	^answer
]

{ #category : 'basic ops' }
StMFullColumn >> timesFullRow: aFullRow times: double [ 
	"a*b*scalar = a(i)b(j)*scalar"

	| nrow answer |
	nrow := self nrow.
	answer := StMFullMatrix new: nrow.
	1 to: nrow
		do: [:i | answer at: i put: (aFullRow times: double * (self at: i)) asFullRow].
	^answer
]

{ #category : 'basic ops' }
StMFullColumn >> timesSparseMatrix: aSparseMatrix [ 
	"a*b = a(i)b(1,j)"

	^aSparseMatrix nrow == 1
		ifTrue: [self timesSparseRow: (aSparseMatrix at: 1)]
		ifFalse: [self error: 'StM: Incompatible row size.']
]

{ #category : 'basic ops' }
StMFullColumn >> timesSparseRow: aSparseRow [ 
	"a*b = a(i)b(j)"

	| nrow answer |
	nrow := self nrow.
	answer := StMSparseMatrix new: nrow.
	1 to: nrow do: [:i | answer at: i put: (aSparseRow times: (self at: i))].
	^answer
]

{ #category : 'basic ops' }
StMFullColumn >> timesSparseRow: aSparseRow times: double [ 
	"a*b*scalar = a(i)b(j)*scalar"

	| nrow answer |
	nrow := self nrow.
	answer := StMSparseMatrix new: nrow.
	1 to: nrow do: [:i | answer at: i put: (aSparseRow times: double * (self at: i))].
	^answer
]

{ #category : 'basic ops' }
StMFullColumn >> timesTransposeFullColumn: aFullColumn [ 
	"a*bT = a(i)b(j)"

	^self timesFullRow: aFullColumn transpose
]

{ #category : 'basic ops' }
StMFullColumn >> timesTransposeFullMatrix: aFullMatrix [ 
	"a*bT = a(i)b(j,1)"

	^self timesTransposeFullColumn: aFullMatrix asFullColumn
]

{ #category : 'basic ops' }
StMFullColumn >> timesTransposeSparseColumn: aSparseColumn [ 
	"a*bT = a(i)b(j)"

	^self timesSparseRow: aSparseColumn transpose
]

{ #category : 'basic ops' }
StMFullColumn >> timesTransposeSparseMatrix: aSparseMatrix [ 
	"a*bT = a(i)b(j,1)"

	^self timesTransposeSparseColumn: aSparseMatrix asSparseColumn
]

{ #category : 'basic ops' }
StMFullColumn >> transpose [
	"Return a row with the same elements."

	^ StMFullRow withAll: self
]

{ #category : 'basic ops' }
StMFullColumn >> transposeTimesFullColumn: aFullColumn [ 
	"colT*col = row*col."

	^self dot: aFullColumn
]

{ #category : 'basic ops' }
StMFullColumn >> transposeTimesFullMatrix: aFullMatrix [
	"a_i(col) * b_ij(mat) := c_j(row)"

	"self transpose timesFullMatrix: aFullMatrix"

	| a b c |
	a := self.
	b := aFullMatrix.
	c := StMFullRow new: b ncol.
	1 to: c ncol do: [ :j |
			| sum |
			sum := 0.0.
			1 to: a nrow do: [ :i |
			sum := sum + ((a at: i) * (b at: i and: j)) ].
			c at: j put: sum ].
	^ c
]

{ #category : 'basic ops' }
StMFullColumn >> transposeTimesSparseMatrix: aSparseMatrix [ 
	^self transpose timesSparseMatrix: aSparseMatrix
]

{ #category : 'accessing' }
StMFullColumn >> value [

	^self
]

{ #category : 'converting' }
StMFullColumn >> value: x [ 
	"self is a column of block formulas."
	"Return evaluation at x."

	| nrow answer |
	nrow := self nrow.
	answer := StMFullColumn new: nrow.
	1 to: nrow do: [:i | answer at: i put: ((self at: i)
				value: x)].
	^answer
]
