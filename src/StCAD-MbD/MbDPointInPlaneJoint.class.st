Class {
	#name : 'MbDPointInPlaneJoint',
	#superclass : 'MbDInPlaneJoint',
	#category : 'StCAD-MbD-MbDJoint',
	#package : 'StCAD-MbD',
	#tag : 'MbDJoint'
}

{ #category : 'VisualWorks metadata' }
MbDPointInPlaneJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'accessing' }
MbDPointInPlaneJoint >> classString [
	"Used to access the descriptive name of the joint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: InPlane Joint '
]

{ #category : 'initialize-release' }
MbDPointInPlaneJoint >> initializeGlobally [
	constraints isEmpty 
		ifTrue: 
			[self createTranslationConstraint.
			TheMbDSystem hasChanged: true]
		ifFalse: [super initializeGlobally]
]
