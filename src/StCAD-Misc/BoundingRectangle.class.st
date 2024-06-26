Class {
	#name : #BoundingRectangle,
	#superclass : #BoundingBox,
	#category : #'StCAD-Misc'
}

{ #category : #'VisualWorks metadata' }
BoundingRectangle class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Misc'
		'superclassNamespace' 'StCAD.Misc'
	)

]

{ #category : #'initialize-release' }
BoundingRectangle >> initialize [
	minCorner := StMFullColumn new: 2.
	maxCorner := StMFullColumn new: 2
]

{ #category : #'ops on self' }
BoundingRectangle >> uvShift: uvShift [ 
	minCorner equalSelfPlus: uvShift.
	maxCorner equalSelfPlus: uvShift
]
