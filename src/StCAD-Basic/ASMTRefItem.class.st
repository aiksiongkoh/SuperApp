Class {
	#name : 'ASMTRefItem',
	#superclass : 'ASMTSpatialItem',
	#instVars : [
		'markers'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'adding' }
ASMTRefItem >> addMarker: marker [

	markers add: marker.
	marker sup: self
]

{ #category : 'accessing' }
ASMTRefItem >> fillMarkerSet: markerSet [

	markerSet addAll: markers.
	^ markerSet
]

{ #category : 'accessing' }
ASMTRefItem >> fullPath [

	^ sup fullPath
]

{ #category : 'initialization' }
ASMTRefItem >> initialize [

	super initialize.
	markers := OrderedCollection new
]
