Class {
	#name : 'GEOPointInLineJoint',
	#superclass : 'GEOInLineJoint',
	#category : 'StCAD-Geo-GEO',
	#package : 'StCAD-Geo',
	#tag : 'GEO'
}

{ #category : 'accessing' }
GEOPointInLineJoint class >> mbdClass [
	^MbDPointInLineJoint
]

{ #category : 'accessing' }
GEOPointInLineJoint class >> nameString [
	^'PointInLineJoint'
]

{ #category : 'VisualWorks metadata' }
GEOPointInLineJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
