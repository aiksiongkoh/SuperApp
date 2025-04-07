Class {
	#name : 'SymConstantGravity',
	#superclass : 'SymItem',
	#instVars : [
		'gXYZ'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'accIC' }
SymConstantGravity >> fillAccICIterError: col [

	self partFrames do: [ :partFrm | col at: partFrm iqX plusFullColumn: (gXYZ times: partFrm m) ]
]

{ #category : 'accessing' }
SymConstantGravity >> gXYZ [

	^ gXYZ
]

{ #category : 'accessing' }
SymConstantGravity >> gXYZ: anObject [

	gXYZ := anObject
]
