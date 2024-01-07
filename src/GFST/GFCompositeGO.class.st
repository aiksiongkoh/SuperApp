Class {
	#name : #GFCompositeGO,
	#superclass : #GFGraphicObject,
	#instVars : [
		'displayBox',
		'graphicObjects',
		'visibleArea',
		'showVisibleArea',
		'visibleAreaLineColor'
	],
	#category : #'GFST-Base-GFST'
}

{ #category : #'VisualWorks metadata' }
GFCompositeGO class >> visualWorksMetadata [

	^ #(
		'namespace' 'Polymorphic'
		'superclassNamespace' 'Polymorphic'
	)

]
