Class {
	#name : 'GEOSSdotSddotData',
	#superclass : 'GEOData',
	#instVars : [
		's',
		'sdot',
		'sddot'
	],
	#category : 'StCAD-Geo-GEO',
	#package : 'StCAD-Geo',
	#tag : 'GEO'
}

{ #category : 'VisualWorks metadata' }
GEOSSdotSddotData class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : 'initialize-release' }
GEOSSdotSddotData >> initialize [
	"Do nothing."
]

{ #category : 'accessing' }
GEOSSdotSddotData >> s [
	^s
]

{ #category : 'accessing' }
GEOSSdotSddotData >> s: col [ 
	s := col
]

{ #category : 'accessing' }
GEOSSdotSddotData >> sddot [
	^sddot
]

{ #category : 'accessing' }
GEOSSdotSddotData >> sddot: col [ 
	sddot := col
]

{ #category : 'accessing' }
GEOSSdotSddotData >> sdot [
	^sdot
]

{ #category : 'accessing' }
GEOSSdotSddotData >> sdot: col [ 
	sdot := col
]
