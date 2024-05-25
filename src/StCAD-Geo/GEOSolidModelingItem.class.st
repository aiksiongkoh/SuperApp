Class {
	#name : 'GEOSolidModelingItem',
	#superclass : 'GEOContainedItem',
	#category : 'StCAD-Geo-GEO',
	#package : 'StCAD-Geo',
	#tag : 'GEO'
}

{ #category : 'VisualWorks metadata' }
GEOSolidModelingItem class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : 'accessing' }
GEOSolidModelingItem >> rDfD [
	^container rDfD
]
