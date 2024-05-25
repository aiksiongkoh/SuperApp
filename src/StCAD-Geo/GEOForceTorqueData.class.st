Class {
	#name : 'GEOForceTorqueData',
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
GEOForceTorqueData class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : 'accessing' }
GEOForceTorqueData >> aFIO [
	aFIO == nil ifTrue: [self aFIO: (StMFullColumn zero: 3)].
	^aFIO
]

{ #category : 'accessing' }
GEOForceTorqueData >> aFIO: col [ 
	aFIO := col
]

{ #category : 'accessing' }
GEOForceTorqueData >> aTIO [
	aTIO == nil ifTrue: [self aTIO: (StMFullColumn zero: 3)].
	^aTIO
]

{ #category : 'accessing' }
GEOForceTorqueData >> aTIO: col [ 
	aTIO := col
]

{ #category : 'accessing' }
GEOForceTorqueData >> asArray [
	| aStream |
	aStream := (Array new: 6) writeStream.
	aStream nextPutAll: self aFIO.
	aStream nextPutAll: self aTIO.
	^aStream contents
]

{ #category : 'initialize-release' }
GEOForceTorqueData >> initialize [
	"Do nothing."
]
