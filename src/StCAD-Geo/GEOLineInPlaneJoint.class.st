Class {
	#name : 'GEOLineInPlaneJoint',
	#superclass : 'GEOInPlaneJoint',
	#category : 'StCAD-Geo-GEO',
	#package : 'StCAD-Geo',
	#tag : 'GEO'
}

{ #category : 'accessing' }
GEOLineInPlaneJoint class >> mbdClass [
	^MbDLineInPlaneJoint
]

{ #category : 'accessing' }
GEOLineInPlaneJoint class >> nameString [
	^'LineInPlaneJoint'
]

{ #category : 'VisualWorks metadata' }
GEOLineInPlaneJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
