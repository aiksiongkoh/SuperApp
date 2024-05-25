Class {
	#name : 'GEOAngleIJ',
	#superclass : 'GEOFunctionIJ',
	#category : 'StCAD-Geo-GEO',
	#package : 'StCAD-Geo',
	#tag : 'GEO'
}

{ #category : 'VisualWorks metadata' }
GEOAngleIJ class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : 'accessing' }
GEOAngleIJ >> dimension [
	^'angle'
]

{ #category : 'DYN' }
GEOAngleIJ >> mbdUnit [
	^self mbdUnits angle
]
