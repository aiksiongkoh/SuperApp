Class {
	#name : #GFDrawingInterface,
	#superclass : #PsiEventModel,
	#instVars : [
		'palette',
		'selections',
		'handles',
		'drawing',
		'display',
		'hideHandles',
		'memento'
	],
	#category : #'GFST-Base-GFST-GFInterface'
}

{ #category : #'VisualWorks metadata' }
GFDrawingInterface class >> visualWorksMetadata [

	^ #(
		'namespace' 'Polymorphic'
		'superclassNamespace' 'Polymorphic'
	)

]
