Class {
	#name : #PLACEMENT,
	#superclass : #'GEOMETRIC_REPRESENTATION_ITEM',
	#instVars : [
		'location'
	],
	#category : #'StCAD-STEP'
}

{ #category : #'VisualWorks metadata' }
PLACEMENT class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
PLACEMENT >> location [
	^location
]

{ #category : #accessing }
PLACEMENT >> location: anObject [
	location := anObject
]

{ #category : #accessing }
PLACEMENT >> rFfF [

	^ location
		  ifNil: [ 
			  StCAD_Math_FullColumn with: 0.0 with: 0.0 with: 0.0 "VW_TRANSLATION:StCAD.Math.FullColumn:StCAD_Math_FullColumn" ]
		  ifNotNil: [ location aPoint ]
]
