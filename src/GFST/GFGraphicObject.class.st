Class {
	#name : #GFGraphicObject,
	#superclass : #PsiEventModel,
	#instVars : [
		'container',
		'prev',
		'next'
	],
	#category : #'GFST-Base-GFST'
}

{ #category : #'VisualWorks metadata' }
GFGraphicObject class >> visualWorksMetadata [

	^ #(
		'namespace' 'Polymorphic'
		'superclassNamespace' 'Polymorphic'
	)

]
