Class {
	#name : #'POSITIVE_LENGTH_MEASURE',
	#superclass : #Item,
	#instVars : [
		'length_measure'
	],
	#category : #'StCAD-STEP'
}

{ #category : #'VisualWorks metadata' }
POSITIVE_LENGTH_MEASURE class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
POSITIVE_LENGTH_MEASURE >> length_measure [
	^length_measure
]

{ #category : #accessing }
POSITIVE_LENGTH_MEASURE >> length_measure: anObject [
	length_measure := anObject
]
