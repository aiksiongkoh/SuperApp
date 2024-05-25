Class {
	#name : 'GEOPlane',
	#superclass : 'GEOAnyGraphic',
	#category : 'StCAD-Geo-GEO',
	#package : 'StCAD-Geo',
	#tag : 'GEO'
}

{ #category : 'VisualWorks metadata' }
GEOPlane class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : 'accessing' }
GEOPlane >> addMarker: geoMarker [ 
	geoMarker refFrame refFrame: refFrame.
	geoMarker guideFrame: refFrame.
	container addMarker: geoMarker
]

{ #category : 'testing' }
GEOPlane >> isPlanar [
	^true
]
