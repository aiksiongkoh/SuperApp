Class {
	#name : #MbDReactionTorqueMagIp,
	#superclass : #MbDReactionMag,
	#instVars : [
		'aTIp',
		'pTIppXI',
		'pTIppEI',
		'pTIppXJ',
		'pTIppEJ',
		'pTIpplam'
	],
	#category : #'StCAD-MbD-MbDReaction'
}

{ #category : #'VisualWorks metadata' }
MbDReactionTorqueMagIp class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #calc }
MbDReactionTorqueMagIp >> calcPostDynCorrectorIteration [
	| aTIeJtO uTIeJtO |
	aTIeJtO := joint aTIeJtO.
	aTIp := aTIeJtO length.
	aTIp = 0.0
		ifTrue: 
			[pTIppXI := StMFullRow new: 3.
			pTIppEI := StMFullRow new: 4.
			pTIppXJ := StMFullRow new: 3.
			pTIppEJ := StMFullRow new: 4.
			pTIpplam := StMSparseRow new]
		ifFalse: 
			[uTIeJtO := aTIeJtO times: 1.0 / aTIp.
			pTIppXI := uTIeJtO dot: joint pTIeJtOpXI.
			pTIppEI := uTIeJtO dot: joint pTIeJtOpEI.
			pTIppXJ := uTIeJtO dot: joint pTIeJtOpXJ.
			pTIppEJ := uTIeJtO dot: joint pTIeJtOpEJ.
			pTIpplam := uTIeJtO transpose timesSparseMatrix: joint pTIeJtOplam]
]

{ #category : #accessing }
MbDReactionTorqueMagIp >> isJointTorque [
	^true
]

{ #category : #'input-output' }
MbDReactionTorqueMagIp >> postInput [
	aTIp := joint aTIeJtO length
]

{ #category : #accessing }
MbDReactionTorqueMagIp >> pvaluepEI [
	^pTIppEI
]

{ #category : #accessing }
MbDReactionTorqueMagIp >> pvaluepEJ [
	^pTIppEJ
]

{ #category : #accessing }
MbDReactionTorqueMagIp >> pvaluepXI [
	^pTIppXI
]

{ #category : #accessing }
MbDReactionTorqueMagIp >> pvaluepXJ [
	^pTIppXJ
]

{ #category : #accessing }
MbDReactionTorqueMagIp >> pvalueplam [
	^pTIpplam
]

{ #category : #accessing }
MbDReactionTorqueMagIp >> value [
	^aTIp
]
