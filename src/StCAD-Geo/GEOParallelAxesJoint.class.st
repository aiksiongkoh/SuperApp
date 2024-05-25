Class {
	#name : 'GEOParallelAxesJoint',
	#superclass : 'GEOJoint',
	#category : 'StCAD-Geo-GEO',
	#package : 'StCAD-Geo',
	#tag : 'GEO'
}

{ #category : 'accessing' }
GEOParallelAxesJoint class >> mbdClass [
	^MbDParallelAxesJoint
]

{ #category : 'accessing' }
GEOParallelAxesJoint class >> nameString [
	^'ParallelAxesJoint'
]

{ #category : 'VisualWorks metadata' }
GEOParallelAxesJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]
