Class {
	#name : #DataForceTorque,
	#superclass : #Data,
	#instVars : [
		'aFIO',
		'aTIO'
	],
	#category : #'StCAD-Misc'
}

{ #category : #'VisualWorks metadata' }
DataForceTorque class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Misc'
		'superclassNamespace' 'StCAD.Misc'
	)

]

{ #category : #accessing }
DataForceTorque >> aFIO [
	aFIO == nil ifTrue: [self aFIO: (StMFullColumn zero: 3)].
	^aFIO
]

{ #category : #accessing }
DataForceTorque >> aFIO: col [ 
	aFIO := col
]

{ #category : #accessing }
DataForceTorque >> aTIO [
	aTIO == nil ifTrue: [self aTIO: (StMFullColumn zero: 3)].
	^aTIO
]

{ #category : #accessing }
DataForceTorque >> aTIO: col [ 
	aTIO := col
]

{ #category : #'initialize-release' }
DataForceTorque >> initialize [
	"Do nothing."
]
