Class {
	#name : #MbDReactionForceMagIe,
	#superclass : #MbDReactionMag,
	#instVars : [
		'aFIe',
		'pFIepXI',
		'pFIepEI',
		'pFIepXJ',
		'pFIepEJ',
		'pFIeplam'
	],
	#category : #'StCAD-MbD-MbDReaction'
}

{ #category : #'VisualWorks metadata' }
MbDReactionForceMagIe class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #calc }
MbDReactionForceMagIe >> calcPostDynCorrectorIteration [
	| aFIeJtO uFIeJtO |
	aFIeJtO := joint aFIeJtO.
	aFIe := aFIeJtO length.
	aFIe = 0.0
		ifTrue: 
			[pFIepXI := StMFullRow new: 3.
			pFIepEI := StMFullRow new: 4.
			pFIepXJ := StMFullRow new: 3.
			pFIepEJ := StMFullRow new: 4.
			pFIeplam := StMSparseRow new]
		ifFalse: 
			[uFIeJtO := aFIeJtO times: 1.0 / aFIe.
			pFIepXI := uFIeJtO dot: joint pFIeJtOpXI.
			pFIepEI := uFIeJtO dot: joint pFIeJtOpEI.
			pFIepXJ := uFIeJtO dot: joint pFIeJtOpXJ.
			pFIepEJ := uFIeJtO dot: joint pFIeJtOpEJ.
			pFIeplam := uFIeJtO transpose timesSparseMatrix: joint pFIeJtOplam]
]

{ #category : #accessing }
MbDReactionForceMagIe >> isJointForce [
	^true
]

{ #category : #'input-output' }
MbDReactionForceMagIe >> postInput [
	aFIe := joint aFIeJtO length
]

{ #category : #accessing }
MbDReactionForceMagIe >> pvaluepEI [
	^pFIepEI
]

{ #category : #accessing }
MbDReactionForceMagIe >> pvaluepEJ [
	^pFIepEJ
]

{ #category : #accessing }
MbDReactionForceMagIe >> pvaluepXI [
	^pFIepXI
]

{ #category : #accessing }
MbDReactionForceMagIe >> pvaluepXJ [
	^pFIepXJ
]

{ #category : #accessing }
MbDReactionForceMagIe >> pvalueplam [
	^pFIeplam
]

{ #category : #accessing }
MbDReactionForceMagIe >> value [
	^aFIe
]
