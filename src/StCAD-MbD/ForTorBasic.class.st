Class {
	#name : 'ForTorBasic',
	#superclass : 'ForceTorqueItem',
	#instVars : [
		'parent',
		'endFrame',
		'iqE'
	],
	#category : 'StCAD-MbD-MbDForce',
	#package : 'StCAD-MbD',
	#tag : 'MbDForce'
}

{ #category : 'VisualWorks metadata' }
ForTorBasic class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'accessing' }
ForTorBasic >> endFrame: eFrm [ 
	endFrame := eFrm
]

{ #category : 'accessing' }
ForTorBasic >> endFrame: aFrmJ followEndFrame: aFrmI [ 
	endFrame := aFrmJ followEndFrame: aFrmI
]

{ #category : 'accessing' }
ForTorBasic >> parent: actionOrReaction [ 
	parent := actionOrReaction
]

{ #category : 'initialize-release' }
ForTorBasic >> useEquationNumbers [
	iqE := endFrame partFrame iqE
]
