Class {
	#name : 'ASMTItemIJ',
	#superclass : 'ASMTItem',
	#instVars : [
		'markerI',
		'markerJ',
		'dataSeries'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'DYN' }
ASMTItemIJ >> deleteMbD [

	super deleteMbD.
	markerI deleteMbD.
	markerJ deleteMbD
]

{ #category : 'initialization' }
ASMTItemIJ >> initialize [

	dataSeries := OrderedCollection new
]

{ #category : 'accessing' }
ASMTItemIJ >> markerI [

	^ markerI
]

{ #category : 'accessing' }
ASMTItemIJ >> markerI: anObject [

	markerI := anObject
]

{ #category : 'accessing' }
ASMTItemIJ >> markerJ [

	^ markerJ
]

{ #category : 'accessing' }
ASMTItemIJ >> markerJ: anObject [

	markerJ := anObject
]

{ #category : 'parsing' }
ASMTItemIJ >> parseMarkerI: lines [

	| markerName |
	[ lines removeFirst trim = 'MarkerI' ] assert.
	markerName := lines removeFirst trim.
	markerI := self findMarkerNamed: markerName
]

{ #category : 'parsing' }
ASMTItemIJ >> parseMarkerJ: lines [

	| markerName |
	[ lines removeFirst trim = 'MarkerJ' ] assert.
	markerName := lines removeFirst trim.
	markerJ := self findMarkerNamed: markerName
]
