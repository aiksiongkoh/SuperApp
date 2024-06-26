Class {
	#name : 'MbDVelMagIecJec',
	#superclass : 'MbDKinematicDotIeJe',
	#instVars : [
		'vIeJe',
		'vIeJeO',
		'uvIeJeO'
	],
	#category : 'StCAD-MbD-MbDKinematicIJ',
	#package : 'StCAD-MbD',
	#tag : 'MbDKinematicIJ'
}

{ #category : 'VisualWorks metadata' }
MbDVelMagIecJec class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'instance creation' }
MbDVelMagIecJec class >> withFrmI: afrmI frmJ: afrmJ [ 
	| instance |
	self allSubclasses
		do: 
			[:subclass | 
			instance := subclass withFrmI: afrmI frmJ: afrmJ.
			instance notNil ifTrue: [^instance]]
]

{ #category : 'calc' }
MbDVelMagIecJec >> calcPostDynCorrectorIteration [
	vIeJeO := frmJ vOeO - frmI vOeO.
	vIeJe := vIeJeO length.
	uvIeJeO := vIeJe = 0
				ifTrue: [(StMFullColumn zero: 3)]
				ifFalse: [vIeJeO times: 1.0 / vIeJe]
]

{ #category : 'accessing' }
MbDVelMagIecJec >> value [
	^vIeJe
]
