Class {
	#name : 'ASMTRefFrame',
	#superclass : 'ASMTSpatialItem',
	#instVars : [
		'markers'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'adding' }
ASMTRefFrame >> addMarker: marker [

	markers add: marker.
	marker sup: self
]

{ #category : 'accessing' }
ASMTRefFrame >> fillMarkerSet: markerSet [

	markerSet addAll: markers.
	^ markerSet
]

{ #category : 'accessing' }
ASMTRefFrame >> fullPath [

	^ sup fullPath
]

{ #category : 'initialization' }
ASMTRefFrame >> initialize [

	super initialize.
	markers := OrderedCollection new
]

{ #category : 'accessing' }
ASMTRefFrame >> principalMassFrame [

	^ sup principalMassFrame
]
