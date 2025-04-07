Class {
	#name : 'SymMbDSolver',
	#superclass : 'SymSolver',
	#instVars : [
		'system'
	],
	#category : 'StCAD-MbD-MbDSolver',
	#package : 'StCAD-MbD',
	#tag : 'MbDSolver'
}

{ #category : 'instance creation' }
SymMbDSolver class >> new [
	^super new initialize
]

{ #category : 'VisualWorks metadata' }
SymMbDSolver class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
	)

]

{ #category : 'enumerating' }
SymMbDSolver >> allDo: aBlock [

	system allDo: aBlock
]

{ #category : 'initialize-release' }
SymMbDSolver >> initialize [
]

{ #category : 'initialize-release' }
SymMbDSolver >> initializeGlobally [
]

{ #category : 'initialize-release' }
SymMbDSolver >> initializeLocally [
]
