Class {
	#name : #GFDoubleBufferingGraphicsDisplaySystem,
	#superclass : #GFGraphicsDisplaySystem,
	#instVars : [
		'scratch',
		'pen'
	],
	#category : #'GFST-Base-GFST-GFInterface-GFDisplay'
}

{ #category : #'VisualWorks metadata' }
GFDoubleBufferingGraphicsDisplaySystem class >> visualWorksMetadata [

	^ #(
		'namespace' 'Polymorphic'
		'superclassNamespace' 'Polymorphic'
	)

]
