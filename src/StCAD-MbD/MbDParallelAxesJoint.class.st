Class {
	#name : 'MbDParallelAxesJoint',
	#superclass : 'MbDJoint',
	#category : 'StCAD-MbD-MbDJoint',
	#package : 'StCAD-MbD',
	#tag : 'MbDJoint'
}

{ #category : 'VisualWorks metadata' }
MbDParallelAxesJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'accessing' }
MbDParallelAxesJoint >> classString [
	"Used to access the descriptive name of the joint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: ParallelAxes Joint '
]

{ #category : 'initialize-release' }
MbDParallelAxesJoint >> initializeGlobally [
	constraints isEmpty
		ifTrue: 
			[self owns: (MbDDirectionCosineConstraintIJ withFrmI: frmI frmJ: frmJ axisI: 3 axisJ: 1).
			self owns: (MbDDirectionCosineConstraintIJ withFrmI: frmI frmJ: frmJ axisI: 3 axisJ: 2).
			TheMbDSystem hasChanged: true]
		ifFalse: [super initializeGlobally]
]
