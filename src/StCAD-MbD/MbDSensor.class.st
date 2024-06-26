Class {
	#name : 'MbDSensor',
	#superclass : 'MbDItem',
	#instVars : [
		'sensorBlk',
		'triggerValue',
		'tol',
		'action'
	],
	#category : 'StCAD-MbD-MbDBasic',
	#package : 'StCAD-MbD',
	#tag : 'MbDBasic'
}

{ #category : 'VisualWorks metadata' }
MbDSensor class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'accessing' }
MbDSensor >> action: symbol [ 
	action := symbol
]

{ #category : 'accessing' }
MbDSensor >> sensorBlk: block [ 
	sensorBlk := block
]

{ #category : 'initialize-release' }
MbDSensor >> submitToSystem [
	self registerName.
	TheMbDSystem sensors add: self
]

{ #category : 'accessing' }
MbDSensor >> tol: double [ 
	tol := double
]

{ #category : 'accessing' }
MbDSensor >> triggerValue: double [ 
	triggerValue := double
]
