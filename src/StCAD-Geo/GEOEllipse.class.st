Class {
	#name : 'GEOEllipse',
	#superclass : 'GEOCurve',
	#instVars : [
		'xRadius',
		'yRadius'
	],
	#category : 'StCAD-Geo-GEO',
	#package : 'StCAD-Geo',
	#tag : 'GEO'
}

{ #category : 'instance creation' }
GEOEllipse class >> origin: origin xRadius: xr yRadius: yr [ 
	^super new
		origin: origin
		xRadius: xr
		yRadius: yr
]

{ #category : 'VisualWorks metadata' }
GEOEllipse class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : 'testing' }
GEOEllipse >> isClosed [
	^true
]

{ #category : 'accessing' }
GEOEllipse >> maxCorner: rSmaxS [ 
	| rSoriginS rOriginMaxF rOriginMaxf |
	rSoriginS := refFrame rFfF.
	rOriginMaxF := rSmaxS - rSoriginS.
	rOriginMaxf := refFrame aAFf transposeTimesFullColumn: rOriginMaxF.
	xRadius := rOriginMaxf at: 1.
	yRadius := rOriginMaxf at: 2.
	self changed
]

{ #category : 'accessing' }
GEOEllipse >> origin: col [ 
	refFrame rFfF: col.
	self changed
]

{ #category : 'accessing' }
GEOEllipse >> origin: col xRadius: xr yRadius: yr [ 
	refFrame rFfF: col.
	xRadius := xr.
	yRadius := yr.
	self changed
]

{ #category : 'accessing' }
GEOEllipse >> rfpointsf [
	| nseg rfpointsf angle xi yi dangle |
	nseg := 16.
	dangle := 2 * Double pi / nseg.
	rfpointsf := StMArray new: nseg + 1.
	1 to: nseg
		do: 
			[:i | 
			angle := i - 1 * dangle.
			xi := xRadius * angle cos.
			yi := yRadius * angle sin.
			rfpointsf at: i put: (StMFullColumn
					with: xi
					with: yi
					with: 0.0)].
	rfpointsf at: nseg + 1 put: (rfpointsf at: 1).
	^rfpointsf
]

{ #category : 'printing' }
GEOEllipse >> storeOn: aStream level: level [ 
	aStream storeLevel: level title: 'Ellipse'.
	self refFrame store2DOn: aStream level: level + 1.
	aStream
		storeLevel: level + 1
		title: 'xRadius'
		object: xRadius.
	aStream
		storeLevel: level + 1
		title: 'yRadius'
		object: yRadius
]

{ #category : 'accessing' }
GEOEllipse >> xRadius [
	^xRadius
]

{ #category : 'accessing' }
GEOEllipse >> xRadius: xr yRadius: yr [ 
	xRadius := xr max: 0.0.
	yRadius := yr max: 0.0.
	self changed
]

{ #category : 'accessing' }
GEOEllipse >> yRadius [
	^yRadius
]
