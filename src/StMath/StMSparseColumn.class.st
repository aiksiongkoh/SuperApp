Class {
	#name : 'StMSparseColumn',
	#superclass : 'StMSparseVector',
	#type : 'variable',
	#category : 'StMath-StMathArray',
	#package : 'StMath',
	#tag : 'StMathArray'
}

{ #category : 'VisualWorks metadata' }
StMSparseColumn class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'ops on self -' }
StMSparseColumn >> at: i minusFullColumn: aFullColumn [ 
	^super at: i minusFullVector: aFullColumn
]

{ #category : 'ops on self -' }
StMSparseColumn >> at: i minusFullColumn: aFullColumn times: aNumber [ 
	^super
		at: i
		minusFullVector: aFullColumn
		times: aNumber
]

{ #category : 'ops on self -' }
StMSparseColumn >> at: i1 minusSparseColumn: aSparseColumn [ 
	super at: i1 minusSparseVector: aSparseColumn
]

{ #category : 'ops on self +' }
StMSparseColumn >> at: i plusFullColumn: aFullColumn [ 
	^super at: i plusFullVector: aFullColumn
]

{ #category : 'ops on self +' }
StMSparseColumn >> at: i plusFullColumn: aFullColumn times: aNumber [ 
	^super
		at: i
		plusFullVector: aFullColumn
		times: aNumber
]

{ #category : 'ops on self +' }
StMSparseColumn >> at: i1 plusSparseColumn: aSparseColumn [ 
	super at: i1 plusSparseVector: aSparseColumn
]

{ #category : 'ops on self' }
StMSparseColumn >> at: i1 putFullColumn: aFullColumn [ 
	super at: i1 putFullVector: aFullColumn
]

{ #category : 'ops on self' }
StMSparseColumn >> at: i1 putFullColumn: aFullColumn times: number [ 
	super
		at: i1
		putFullVector: aFullColumn
		times: number
]

{ #category : 'ops on self -' }
StMSparseColumn >> equalSelfMinusSparseColumn: aSparseColumn [ 
	super equalSelfMinusSparseVector: aSparseColumn
]

{ #category : 'ops on self -' }
StMSparseColumn >> equalSelfMinusSparseColumn: aSparseColumn times: aNumber [ 
	super equalSelfMinusSparseVector: aSparseColumn times: aNumber
]

{ #category : 'ops on self +' }
StMSparseColumn >> equalSelfPlusSparseColumn: aSparseColumn [ 
	super equalSelfPlusSparseVector: aSparseColumn
]

{ #category : 'ops on self +' }
StMSparseColumn >> equalSelfPlusSparseColumn: aSparseColumn times: aNumber [ 
	super equalSelfPlusSparseVector: aSparseColumn times: aNumber
]

{ #category : 'basic ops -' }
StMSparseColumn >> minusSparseColumn: aSparseColumn [ 
	^super minusSparseVector: aSparseColumn
]

{ #category : 'accessing' }
StMSparseColumn >> ncol [
	^1
]

{ #category : 'accessing' }
StMSparseColumn >> nrow [
	"Answer the number of elements in the full vector or matrix."

	^fullsize
]

{ #category : 'basic ops +' }
StMSparseColumn >> plusSparseColumn: aSparseColumn [ 
	^super plusSparseVector: aSparseColumn
]

{ #category : 'basic ops -' }
StMSparseColumn >> times: alpha minusSparseColumn: aSparseColumn [ 
	^super times: alpha minusSparseVector: aSparseColumn
]

{ #category : 'basic ops +' }
StMSparseColumn >> times: alpha plusSparseColumn: aSparseColumn [ 
	^super times: alpha plusSparseVector: aSparseColumn
]

{ #category : 'basic ops' }
StMSparseColumn >> transpose [
	"Return a row with the same elements."
	"This method is much faster than the obvious way."

	^self copy changeClassToThatOf: (StMSparseRow new: 0)
]
