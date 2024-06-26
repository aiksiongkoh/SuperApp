Class {
	#name : 'MbDVelCompIeqcJeqcO',
	#superclass : 'MbDVelCompIeqcJecO',
	#instVars : [
		'pvIeJeOipEJ',
		'pvIeJeOipXdotJ',
		'pvIeJeOipEdotJ'
	],
	#category : 'StCAD-MbD-MbDKinematicIJ',
	#package : 'StCAD-MbD',
	#tag : 'MbDKinematicIJ'
}

{ #category : 'VisualWorks metadata' }
MbDVelCompIeqcJeqcO class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'instance creation' }
MbDVelCompIeqcJeqcO class >> withFrmI: afrmI frmJ: afrmJ axis: aaxis [ 
	^(afrmI isMemberOf: MbDEndFrameqc)
		& (afrmJ isMemberOf: MbDEndFrameqc)
		ifTrue: [self new
				withFrmI: afrmI
				frmJ: afrmJ
				axis: aaxis]
		ifFalse: [nil]
]

{ #category : 'calc' }
MbDVelCompIeqcJeqcO >> calcPostDynCorrectorIteration [
	super calcPostDynCorrectorIteration.
	pvIeJeOipEJ := frmJ pvOeOpE at: axis.
	pvIeJeOipEdotJ := frmJ pvOeOpEdot at: axis
]

{ #category : 'initialize-release' }
MbDVelCompIeqcJeqcO >> initialize [
	super initialize.
	pvIeJeOipEJ := StMFullRow new: 4.
	pvIeJeOipXdotJ := StMFullRow new: 3.
	pvIeJeOipEdotJ := StMFullRow new: 4
]

{ #category : 'initialize-release' }
MbDVelCompIeqcJeqcO >> initializeLocally [
	super initializeLocally.
	pvIeJeOipXdotJ := (StMFullRow zero: 3).
	pvIeJeOipXdotJ at: axis put: 1.0
]

{ #category : 'accessing' }
MbDVelCompIeqcJeqcO >> pvaluepEJ [
	^pvIeJeOipEJ
]

{ #category : 'accessing' }
MbDVelCompIeqcJeqcO >> pvaluepEdotJ [
	^pvIeJeOipEdotJ
]

{ #category : 'accessing' }
MbDVelCompIeqcJeqcO >> pvaluepXdotJ [
	^pvIeJeOipXdotJ
]
