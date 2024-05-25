Class {
	#name : 'GEOFunction',
	#superclass : 'CADFunction',
	#category : 'StCAD-Geo-GEO',
	#package : 'StCAD-Geo',
	#tag : 'GEO'
}

{ #category : 'VisualWorks metadata' }
GEOFunction class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.UI'
	)

]

{ #category : 'DYN' }
GEOFunction >> createMbD [
	self subclassResponsibility
]

{ #category : 'accessing' }
GEOFunction >> geoTime [
	^container == nil
		ifTrue: [nil]
		ifFalse: [container geoTime]
]

{ #category : 'accessing' }
GEOFunction >> interface [
	container == nil ifTrue: [^nil].
	^container interface
]

{ #category : 'accessing' }
GEOFunction >> mbdUnits [
	^container == nil
		ifTrue: [nil]
		ifFalse: [container mbdUnits]
]
