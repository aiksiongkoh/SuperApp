Class {
	#name : 'ForTorZero',
	#superclass : 'ForceTorqueItem',
	#category : 'StCAD-MbD-MbDForce',
	#package : 'StCAD-MbD',
	#tag : 'MbDForce'
}

{ #category : 'VisualWorks metadata' }
ForTorZero class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'input-output' }
ForTorZero >> aFTIeO [
	^(StMFullColumn zero: 3)
]

{ #category : 'input-output' }
ForTorZero >> calcPostDynCorrectorIteration [
	"Do nothing."
]
