Class {
	#name : 'MbDPerpendicularJoint',
	#superclass : 'MbDJoint',
	#category : 'StCAD-MbD-MbDJoint',
	#package : 'StCAD-MbD',
	#tag : 'MbDJoint'
}

{ #category : 'VisualWorks metadata' }
MbDPerpendicularJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'accessing' }
MbDPerpendicularJoint >> classString [
	"Used to access the descriptive name of the joint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: Perpendicular Joint '
]

{ #category : 'initialize-release' }
MbDPerpendicularJoint >> initializeGlobally [
	constraints isEmpty
		ifTrue: 
			[self owns: (MbDDirectionCosineConstraintIJ withFrmI: frmI frmJ: frmJ axisI: 3 axisJ: 3).
			TheMbDSystem hasChanged: true]
		ifFalse: [super initializeGlobally]
]
