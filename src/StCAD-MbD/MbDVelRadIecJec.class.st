"
Radial velocity of Je wrt Ie.
"
Class {
	#name : 'MbDVelRadIecJec',
	#superclass : 'MbDKinematicDotIeJe',
	#instVars : [
		'rIeJe',
		'rIeJeO',
		'uIeJeO',
		'vIeJe',
		'vIeJeO'
	],
	#category : 'StCAD-MbD-MbDKinematicIJ',
	#package : 'StCAD-MbD',
	#tag : 'MbDKinematicIJ'
}

{ #category : 'VisualWorks metadata' }
MbDVelRadIecJec class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'instance creation' }
MbDVelRadIecJec class >> withFrmI: afrmI frmJ: afrmJ [ 
	| instance |
	self allSubclasses
		do: 
			[:subclass | 
			instance := subclass withFrmI: afrmI frmJ: afrmJ.
			instance notNil ifTrue: [^instance]]
]

{ #category : 'calc' }
MbDVelRadIecJec >> calcPostDynCorrectorIteration [
	rIeJeO := frmJ rOeO - frmI rOeO.
	rIeJe := rIeJeO length.
	rIeJe = 0.0 ifTrue: [^self].
	uIeJeO := rIeJeO times: 1.0 / rIeJe.
	vIeJeO := frmJ vOeO - frmI vOeO.
	vIeJe := vIeJeO dot: uIeJeO
]

{ #category : 'accessing' }
MbDVelRadIecJec >> value [
	^vIeJe
]
