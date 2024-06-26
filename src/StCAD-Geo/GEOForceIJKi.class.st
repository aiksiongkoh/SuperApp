Class {
	#name : 'GEOForceIJKi',
	#superclass : 'GEOFunctionIJKi',
	#category : 'StCAD-Geo-GEO',
	#package : 'StCAD-Geo',
	#tag : 'GEO'
}

{ #category : 'VisualWorks metadata' }
GEOForceIJKi class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : 'accessing' }
GEOForceIJKi >> dimension [
	^'force'
]

{ #category : 'DYN' }
GEOForceIJKi >> mbdUnit [
	^self mbdUnits force
]
