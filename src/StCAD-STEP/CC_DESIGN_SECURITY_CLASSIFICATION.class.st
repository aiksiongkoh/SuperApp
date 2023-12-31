Class {
	#name : #'CC_DESIGN_SECURITY_CLASSIFICATION',
	#superclass : #Item,
	#instVars : [
		'aEntity',
		'cEntity'
	],
	#category : #'StCAD-STEP'
}

{ #category : #'VisualWorks metadata' }
CC_DESIGN_SECURITY_CLASSIFICATION class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI.STEP'
		'superclassNamespace' 'StCAD.UI.STEP'
	)

]

{ #category : #accessing }
CC_DESIGN_SECURITY_CLASSIFICATION >> aEntity [
	^aEntity
]

{ #category : #accessing }
CC_DESIGN_SECURITY_CLASSIFICATION >> aEntity: anObject [
	aEntity := anObject
]

{ #category : #accessing }
CC_DESIGN_SECURITY_CLASSIFICATION >> cEntity [
	^cEntity
]

{ #category : #accessing }
CC_DESIGN_SECURITY_CLASSIFICATION >> cEntity: anObject [
	cEntity := anObject
]
