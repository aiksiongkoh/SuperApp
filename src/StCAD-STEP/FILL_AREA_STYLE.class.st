Class {
	#name : #'FILL_AREA_STYLE',
	#superclass : #Item,
	#instVars : [
		'fill_styles'
	],
	#category : #'StCAD-STEP'
}

{ #category : #'VisualWorks metadata' }
FILL_AREA_STYLE class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
FILL_AREA_STYLE >> aColor [
	^fill_styles first aColor
]

{ #category : #accessing }
FILL_AREA_STYLE >> fill_styles [
	^fill_styles
]

{ #category : #accessing }
FILL_AREA_STYLE >> fill_styles: anObject [
	fill_styles := anObject
]
