Class {
	#name : 'GEOdAngleIJy',
	#superclass : 'GEOAngleIJ',
	#category : 'StCAD-Geo-GEO',
	#package : 'StCAD-Geo',
	#tag : 'GEO'
}

{ #category : 'accessing' }
GEOdAngleIJy class >> functionSymbol [
	^'dAngleIJy'
]

{ #category : 'VisualWorks metadata' }
GEOdAngleIJy class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : 'accessing' }
GEOdAngleIJy >> dataSeries [
	^geoIJ dataSeriesForChart collect: [:kineIkineJ | kineIkineJ bryantIJ2]
]

{ #category : 'DYN' }
GEOdAngleIJy >> mbdClass [
	^MbDSmallAngleyIecJec
]
