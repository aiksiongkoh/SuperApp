Class {
	#name : #GFConnectionHandle,
	#superclass : #GFHandle,
	#instVars : [
		'findTargetAction',
		'targetPositionAction',
		'locatorGenerationAction',
		'connectedAction',
		'connectAction'
	],
	#category : #'GFST-Base-GFST-GFHandles'
}

{ #category : #'VisualWorks metadata' }
GFConnectionHandle class >> visualWorksMetadata [

	^ #(
		'namespace' 'Polymorphic'
		'superclassNamespace' 'Polymorphic'
	)

]
