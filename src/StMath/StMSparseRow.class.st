Class {
	#name : 'StMSparseRow',
	#superclass : 'StMSparseVector',
	#type : 'variable',
	#category : 'StMath-StMathArray',
	#package : 'StMath',
	#tag : 'StMathArray'
}

{ #category : 'VisualWorks metadata' }
StMSparseRow class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'converting' }
StMSparseRow >> asFullRow [
	| answer key |
	answer := StMFullRow new: self ncol.
	answer zeroSelf.
	1 to: self basicSize do: [:index | (key := self basicAt: index) == nil ifFalse: [answer at: key put: (valueArray at: index)]].
	^answer
]

{ #category : 'converting' }
StMSparseRow >> asSparseRow [
	^self
]

{ #category : 'ops on self -' }
StMSparseRow >> at: i minusFullRow: aFullRow [ 
	super at: i minusFullVector: aFullRow
]

{ #category : 'ops on self -' }
StMSparseRow >> at: i minusFullRow: aFullRow times: aNumber [ 
	^super
		at: i
		minusFullVector: aFullRow
		times: aNumber
]

{ #category : 'ops on self -' }
StMSparseRow >> at: i1 minusSparseRow: aSparseRow [ 
	super at: i1 minusSparseVector: aSparseRow
]

{ #category : 'ops on self +' }
StMSparseRow >> at: i plusFullRow: aFullRow [ 
	^super at: i plusFullVector: aFullRow
]

{ #category : 'ops on self +' }
StMSparseRow >> at: i plusFullRow: aFullRow times: aNumber [ 
	^super
		at: i
		plusFullVector: aFullRow
		times: aNumber
]

{ #category : 'ops on self +' }
StMSparseRow >> at: i1 plusSparseRow: aSparseRow [ 
	super at: i1 plusSparseVector: aSparseRow
]

{ #category : 'ops on self' }
StMSparseRow >> at: i1 putFullRow: aFullRow [ 
	super at: i1 putFullVector: aFullRow
]

{ #category : 'ops on self' }
StMSparseRow >> at: i1 putFullRow: aFullRow times: number [ 
	super
		at: i1
		putFullVector: aFullRow
		times: number
]

{ #category : 'ops on self -' }
StMSparseRow >> equalSelfMinusSparseRow: aSparseRow [ 
	super equalSelfMinusSparseVector: aSparseRow
]

{ #category : 'ops on self -' }
StMSparseRow >> equalSelfMinusSparseRow: aSparseRow times: aNumber [ 
	super equalSelfMinusSparseVector: aSparseRow times: aNumber
]

{ #category : 'ops on self +' }
StMSparseRow >> equalSelfPlusSparseRow: aSparseRow [ 
	super equalSelfPlusSparseVector: aSparseRow
]

{ #category : 'ops on self +' }
StMSparseRow >> equalSelfPlusSparseRow: aSparseRow times: aNumber [ 
	super equalSelfPlusSparseVector: aSparseRow times: aNumber
]

{ #category : 'basic ops -' }
StMSparseRow >> minusSparseRow: aSparseRow [ 
	^super minusSparseVector: aSparseRow
]

{ #category : 'basic ops -' }
StMSparseRow >> minusSparseRow: aSparseRow times: beta [ 
	^super minusSparseVector: aSparseRow times: beta
]

{ #category : 'accessing' }
StMSparseRow >> ncol [
	"Answer the number of elements in the full vector or matrix."

	^fullsize
]

{ #category : 'accessing' }
StMSparseRow >> nrow [
	^1
]

{ #category : 'basic ops +' }
StMSparseRow >> plusSparseRow: aSparseRow [ 
	^super plusSparseVector: aSparseRow
]

{ #category : 'basic ops +' }
StMSparseRow >> plusSparseRow: aSparseRow times: beta [ 
	^super plusSparseVector: aSparseRow times: beta
]

{ #category : 'basic ops -' }
StMSparseRow >> times: alpha minusSparseRow: aSparseRow [ 
	^super times: alpha minusSparseVector: aSparseRow
]

{ #category : 'basic ops -' }
StMSparseRow >> times: alpha minusSparseRow: aSparseRow times: beta [ 
	^super
		times: alpha
		minusSparseVector: aSparseRow
		times: beta
]

{ #category : 'basic ops +' }
StMSparseRow >> times: alpha plusSparseRow: aSparseRow [ 
	^super times: alpha plusSparseVector: aSparseRow
]

{ #category : 'basic ops +' }
StMSparseRow >> times: alpha plusSparseRow: aSparseRow times: beta [ 
	^super
		times: alpha
		plusSparseVector: aSparseRow
		times: beta
]

{ #category : 'basic ops *' }
StMSparseRow >> timesFullColumn: aFullColumn [ 
	| answer key |
	answer := 0.0.
	1 to: self basicSize
		do: 
			[:index | 
			key := self basicAt: index.
			key == nil ifFalse: [answer := answer + ((valueArray at: index)
								* (aFullColumn at: key))]].
	^answer
]

{ #category : 'basic ops *' }
StMSparseRow >> timesFullMatrix: aFullMatrix [ 
	"Similar to inner dot product."

	| aFullRow answer i |
	aFullRow := aFullMatrix at: 1.
	answer := aFullRow class new: aFullRow size withAll: 0.0.
	1 to: self basicSize
		do: 
			[:index | 
			i := self basicAt: index.
			i == nil ifFalse: [answer equalSelfPlusFullRow: (aFullMatrix at: i)
					times: (valueArray at: index)]].
	^answer
]

{ #category : 'basic ops *' }
StMSparseRow >> timesSparseMatrix: aSparseMatrix [ 
	"Similar to inner dot product."

	| aSparseRow answer i |
	aSparseRow := aSparseMatrix at: 1.
	answer := aSparseRow class new: aSparseRow ncol.
	1 to: self basicSize
		do: 
			[:index | 
			i := self basicAt: index.
			i == nil ifFalse: [answer equalSelfPlusSparseRow: (aSparseMatrix at: i)
					times: (valueArray at: index)]].
	^answer
]

{ #category : 'basic ops *' }
StMSparseRow >> timesTransposeSparseMatrix: aSparseMatrix [ 
	"a*bT = a(1,j)b(k,j)"

	| ncol answer ak |
	ncol := aSparseMatrix nrow.
	answer := StMSparseRow new: ncol.
	1 to: ncol
		do: 
			[:k | 
			ak := (aSparseMatrix at: k)
						dot: self.
			ak isZero ifFalse: [answer at: k put: ak]].
	^answer
]

{ #category : 'basic ops' }
StMSparseRow >> transpose [
	"Return a row with the same elements."
	"This method is much faster than the obvious way."

	^self copy changeClassToThatOf: (StMSparseColumn new: 0)
]
