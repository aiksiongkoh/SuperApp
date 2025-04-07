Class {
	#name : 'GEOForTorData',
	#superclass : 'GEOData',
	#instVars : [
		'aFIO',
		'aTIO'
	],
	#category : 'StCAD-Geo-GEO',
	#package : 'StCAD-Geo',
	#tag : 'GEO'
}

{ #category : 'VisualWorks metadata' }
GEOForTorData class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : 'accessing' }
GEOForTorData >> aFIO [
	aFIO == nil ifTrue: [self aFIO: (StMFullColumn zero: 3)].
	^aFIO
]

{ #category : 'accessing' }
GEOForTorData >> aFIO: col [ 
	aFIO := col
]

{ #category : 'accessing' }
GEOForTorData >> aTIO [
	aTIO == nil ifTrue: [self aTIO: (StMFullColumn zero: 3)].
	^aTIO
]

{ #category : 'accessing' }
GEOForTorData >> aTIO: col [ 
	aTIO := col
]

{ #category : 'accessing' }
GEOForTorData >> asArray [
	| aStream |
	aStream := (Array new: 6) writeStream.
	aStream nextPutAll: self aFIO.
	aStream nextPutAll: self aTIO.
	^aStream contents
]

{ #category : 'initialize-release' }
GEOForTorData >> initialize [
	"Do nothing."
]
