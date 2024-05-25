Class {
	#name : 'CADFunction',
	#superclass : 'StMExpressionX',
	#instVars : [
		'container'
	],
	#category : 'StCAD-UI-CAD',
	#package : 'StCAD-UI',
	#tag : 'CAD'
}

{ #category : 'VisualWorks metadata' }
CADFunction class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.UI'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'comparing' }
CADFunction >> = anObject [ 
	^self == anObject
]

{ #category : 'accessing' }
CADFunction >> aSup: aaSup [ 
	container := aaSup.
	^aaSup
]

{ #category : 'accessing' }
CADFunction >> container [
	^container
]

{ #category : 'accessing' }
CADFunction >> container: geoItem [ 
	container := geoItem
]

{ #category : 'copying' }
CADFunction >> copy [
	"A CADFunction is immutable so it is ok to reuse."
	"Do nothing."
]

{ #category : 'accessing' }
CADFunction >> dimension [
	self subclassResponsibility
]

{ #category : 'evaluating' }
CADFunction >> expandUntil: set [ 
	"Do nothing."
]

{ #category : 'evaluating' }
CADFunction >> simplifyUntil: set [ 
	"Do nothing."
]
