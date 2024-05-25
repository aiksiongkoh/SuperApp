Class {
	#name : 'GEODormantFeature',
	#superclass : 'GEOFeatureDecorator',
	#category : 'StCAD-Geo-GEO',
	#package : 'StCAD-Geo',
	#tag : 'GEO'
}

{ #category : 'VisualWorks metadata' }
GEODormantFeature class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : 'accessing' }
GEODormantFeature >> becomeActive [
	| newSelf |
	newSelf := self feature.
	self become: newSelf
]

{ #category : 'accessing' }
GEODormantFeature >> feature [
	^feature
]
