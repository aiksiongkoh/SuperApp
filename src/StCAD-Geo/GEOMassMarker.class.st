Class {
	#name : 'GEOMassMarker',
	#superclass : 'GEOMarker',
	#instVars : [
		'mass',
		'aJppx',
		'aJppy',
		'aJppz',
		'density'
	],
	#category : 'StCAD-Geo-GEO',
	#package : 'StCAD-Geo',
	#tag : 'GEO'
}

{ #category : 'VisualWorks metadata' }
GEOMassMarker class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : 'accessing' }
GEOMassMarker >> aAPp [
	^refFrame aAFf
]

{ #category : 'accessing' }
GEOMassMarker >> aJppx [
	^aJppx == nil
		ifTrue: [0.0]
		ifFalse: [aJppx]
]

{ #category : 'accessing' }
GEOMassMarker >> aJppx: double [ 
	aJppx := double
]

{ #category : 'accessing' }
GEOMassMarker >> aJppy [
	^aJppy == nil
		ifTrue: [0.0]
		ifFalse: [aJppy]
]

{ #category : 'accessing' }
GEOMassMarker >> aJppy: double [ 
	aJppy := double
]

{ #category : 'accessing' }
GEOMassMarker >> aJppz [
	^aJppz == nil
		ifTrue: [0.0]
		ifFalse: [aJppz]
]

{ #category : 'accessing' }
GEOMassMarker >> aJppz: double [ 
	aJppz := double
]

{ #category : 'accessing' }
GEOMassMarker >> cut [
	Dialog warn: 'Not appropriate to cut the mass marker.'
]

{ #category : 'accessing' }
GEOMassMarker >> dataClass [
	^GEOTimePosVelAccDynData
]

{ #category : 'accessing' }
GEOMassMarker >> dataSeriesForChart [
	| answer |
	answer := super dataSeriesForChart.
	answer
		do: 
			[:data | 
			data rfpf: (StMFullColumn zero: 3).
			data aAfp: (StMFullMatrix identity: 3).
			data mass: mass.
			data aJpp: self mJpp].
	^answer
]

{ #category : 'accessing' }
GEOMassMarker >> density [
	^density == nil
		ifTrue: [0.0]
		ifFalse: [density]
]

{ #category : 'accessing' }
GEOMassMarker >> density: double [ 
	density := double
]

{ #category : 'testing' }
GEOMassMarker >> hasCentroid [
	^self anyPart hasCentroid
]

{ #category : 'initialize-release' }
GEOMassMarker >> initialize [
	super initialize.
	mass := 0.0.
	aJppx := 0.0.
	aJppy := 0.0.
	aJppz := 0.0.
	density := 0.0
]

{ #category : 'accessing' }
GEOMassMarker >> mJpp [
	^StMDiagonalMatrix
		with: self aJppx
		with: self aJppy
		with: self aJppz
]

{ #category : 'accessing' }
GEOMassMarker >> magnifySelf: aDouble [ 
	| sq |
	super magnifySelf: aDouble.
	sq := aDouble squared.
	aJppx := aJppx * sq.
	aJppy := aJppy * sq.
	aJppz := aJppz * sq
]

{ #category : 'accessing' }
GEOMassMarker >> mass [
	^mass == nil
		ifTrue: [0.0]
		ifFalse: [mass]
]

{ #category : 'accessing' }
GEOMassMarker >> mass: double [ 
	mass := double
]

{ #category : 'accessing' }
GEOMassMarker >> qEp [
	^refFrame aAOf mbdEulerParameters
]

{ #category : 'accessing' }
GEOMassMarker >> rOcmO [
	^refFrame rOfO
]

{ #category : 'accessing' }
GEOMassMarker >> rPcmP [
	^refFrame rFfF
]

{ #category : 'printing' }
GEOMassMarker >> storeOn: aStream level: level [ 
	aStream storeLevel: level title: 'PrincipalMassMarker'.
	aStream
		storeLevel: level + 1
		title: 'Name'
		object: self name.
	refFrame storeOn: aStream level: level + 1.
	aStream
		storeLevel: level + 1
		title: 'Mass'
		object: self mass.
	aStream
		storeLevel: level + 1
		title: 'MomentOfInertias'
		object: self mJpp.
	aStream
		storeLevel: level + 1
		title: 'Density'
		object: self density
]
