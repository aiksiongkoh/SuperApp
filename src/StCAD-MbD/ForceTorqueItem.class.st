Class {
	#name : 'ForceTorqueItem',
	#superclass : 'MbDItem',
	#category : 'StCAD-MbD-MbDForce',
	#package : 'StCAD-MbD',
	#tag : 'MbDForce'
}

{ #category : 'VisualWorks metadata' }
ForceTorqueItem class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'static' }
ForceTorqueItem >> fillStaticError: col [ 
	self fillDynError: col
]

{ #category : 'static' }
ForceTorqueItem >> fillStaticJacob: mat [ 
	self fillpFpy: mat
]

{ #category : 'accIC' }
ForceTorqueItem >> postAccICIteration [
	self calcPostDynCorrectorIteration
]

{ #category : 'collision' }
ForceTorqueItem >> postCollisionCorrectorIteration [
	self calcPostDynCorrectorIteration
]

{ #category : 'collision' }
ForceTorqueItem >> postCollisionPredictor [
	self calcPostDynCorrectorIteration
]

{ #category : 'initialize-release' }
ForceTorqueItem >> submitToSystem [
	self registerName.
	TheMbDSystem forTors add: self
]
