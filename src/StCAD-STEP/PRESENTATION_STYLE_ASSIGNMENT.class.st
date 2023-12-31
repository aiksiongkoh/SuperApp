Class {
	#name : #'PRESENTATION_STYLE_ASSIGNMENT',
	#superclass : #Item,
	#instVars : [
		'styles'
	],
	#category : #'StCAD-STEP'
}

{ #category : #'VisualWorks metadata' }
PRESENTATION_STYLE_ASSIGNMENT class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
PRESENTATION_STYLE_ASSIGNMENT >> aColor [
	^styles first aColor
]

{ #category : #accessing }
PRESENTATION_STYLE_ASSIGNMENT >> styles [
	^styles
]

{ #category : #accessing }
PRESENTATION_STYLE_ASSIGNMENT >> styles: anObject [
	styles := anObject
]
