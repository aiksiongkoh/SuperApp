Class {
	#name : #GFDrawing,
	#superclass : #GFCompositeGO,
	#instVars : [
		'firstGO',
		'lastGO',
		'coordSystem',
		'displayGrid',
		'gridColor'
	],
	#category : #'GFST-Base-GFST'
}

{ #category : #'VisualWorks metadata' }
GFDrawing class >> visualWorksMetadata [

	^ #(
		'namespace' 'Polymorphic'
		'superclassNamespace' 'Polymorphic'
	)

]
