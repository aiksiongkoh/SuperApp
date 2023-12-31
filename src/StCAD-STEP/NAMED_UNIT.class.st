Class {
	#name : #'NAMED_UNIT',
	#superclass : #Item,
	#instVars : [
		'dimensions'
	],
	#category : #'StCAD-STEP'
}

{ #category : #'VisualWorks metadata' }
NAMED_UNIT class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #'As yet unclassified' }
NAMED_UNIT >> angleFactor [
	^dimensions ifNotNil: [dimensions angleFactor]
]

{ #category : #accessing }
NAMED_UNIT >> dimensions [
	^dimensions
]

{ #category : #accessing }
NAMED_UNIT >> dimensions: anObject [
	dimensions := anObject
]

{ #category : #'As yet unclassified' }
NAMED_UNIT >> lengthFactor [
	^dimensions ifNotNil: [dimensions lengthFactor]
]
