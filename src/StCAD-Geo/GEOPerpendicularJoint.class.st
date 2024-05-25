Class {
	#name : 'GEOPerpendicularJoint',
	#superclass : 'GEOJoint',
	#category : 'StCAD-Geo-GEO',
	#package : 'StCAD-Geo',
	#tag : 'GEO'
}

{ #category : 'accessing' }
GEOPerpendicularJoint class >> mbdClass [
	^MbDPerpendicularJoint
]

{ #category : 'accessing' }
GEOPerpendicularJoint class >> nameString [
	^'PerpendicularJoint'
]

{ #category : 'VisualWorks metadata' }
GEOPerpendicularJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
