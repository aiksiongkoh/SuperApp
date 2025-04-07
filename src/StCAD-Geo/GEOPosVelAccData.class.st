Class {
	#name : 'GEOPosVelAccData',
	#superclass : 'GEOData',
	#instVars : [
		'rOfO',
		'aAOf',
		'vOfO',
		'omeOfO',
		'aOfO',
		'alpOfO'
	],
	#category : 'StCAD-Geo-GEO',
	#package : 'StCAD-Geo',
	#tag : 'GEO'
}

{ #category : 'VisualWorks metadata' }
GEOPosVelAccData class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : 'accessing' }
GEOPosVelAccData >> aAOf [
	aAOf == nil ifTrue: [self aAOf: (StMFullMatrix identity: 3)].
	^aAOf
]

{ #category : 'accessing' }
GEOPosVelAccData >> aAOf: mat [ 
	aAOf := mat
]

{ #category : 'accessing' }
GEOPosVelAccData >> aOfO [
	aOfO == nil ifTrue: [self aOfO: (StMFullColumn zero: 3)].
	^aOfO
]

{ #category : 'accessing' }
GEOPosVelAccData >> aOfO: col [ 
	aOfO := col
]

{ #category : 'accessing' }
GEOPosVelAccData >> alpOfO [
	alpOfO == nil ifTrue: [self alpOfO: (StMFullColumn zero: 3)].
	^alpOfO
]

{ #category : 'accessing' }
GEOPosVelAccData >> alpOfO: col [ 
	alpOfO := col
]

{ #category : 'accessing' }
GEOPosVelAccData >> asArray [
	| aStream |
	aStream := (Array new: 19) writeStream.
	aStream nextPutAll: self rOfO.
	aStream nextPutAll: self aAOf stmEulerParameters.
	aStream nextPutAll: self vOfO.
	aStream nextPutAll: self omeOfO.
	aStream nextPutAll: self aOfO.
	aStream nextPutAll: self alpOfO.
	^aStream contents
]

{ #category : 'initialize-release' }
GEOPosVelAccData >> initialize [
	"Do nothing."
]

{ #category : 'ops on self' }
GEOPosVelAccData >> magnifySelf: aDouble [ 
	rOfO ifNotNil: [rOfO magnifySelf: aDouble].
	vOfO ifNotNil: [vOfO magnifySelf: aDouble].
	aOfO ifNotNil: [aOfO magnifySelf: aDouble]
]

{ #category : 'accessing' }
GEOPosVelAccData >> omeOfO [
	omeOfO == nil ifTrue: [self omeOfO: (StMFullColumn zero: 3)].
	^omeOfO
]

{ #category : 'accessing' }
GEOPosVelAccData >> omeOfO: col [ 
	omeOfO := col
]

{ #category : 'accessing' }
GEOPosVelAccData >> rOfO [
	rOfO == nil ifTrue: [self rOfO: (StMFullColumn zero: 3)].
	^rOfO
]

{ #category : 'accessing' }
GEOPosVelAccData >> rOfO: col [ 
	rOfO := col
]

{ #category : 'ops on self' }
GEOPosVelAccData >> translateBy: shiftXYZ [ 
	self rOfO: rOfO + shiftXYZ
]

{ #category : 'accessing' }
GEOPosVelAccData >> vOfO [
	vOfO == nil ifTrue: [self vOfO: (StMFullColumn zero: 3)].
	^vOfO
]

{ #category : 'accessing' }
GEOPosVelAccData >> vOfO: col [ 
	vOfO := col
]

{ #category : 'ops on self' }
GEOPosVelAccData >> zeroSelf [
	rOfO := (StMFullColumn zero: 3).
	aAOf := (StMFullMatrix identity: 3).
	vOfO := (StMFullColumn zero: 3).
	omeOfO := (StMFullColumn zero: 3).
	aOfO := (StMFullColumn zero: 3).
	alpOfO := (StMFullColumn zero: 3)
]
