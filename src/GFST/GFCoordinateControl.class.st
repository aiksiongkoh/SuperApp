Class {
	#name : #GFCoordinateControl,
	#superclass : #Object,
	#instVars : [
		'logicalUnit',
		'origin',
		'axisDirection',
		'scale',
		'extent',
		'grid',
		'useGrid'
	],
	#category : #'GFST-Base-GFST-GFCoordinateSystem'
}

{ #category : #'VisualWorks metadata' }
GFCoordinateControl class >> visualWorksMetadata [

	^ #(
		'namespace' 'Polymorphic'
	)

]
