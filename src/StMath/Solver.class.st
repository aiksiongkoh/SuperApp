"
messages	<IdentityDictionary> Stores messages to be passed out for various conditions encountered. Initialized by the user.
	statistics	<IdentityDictionary> Stores statistics of the solution process.
"
Class {
	#name : 'Solver',
	#superclass : 'StMNumeric',
	#instVars : [
		'statistics'
	],
	#category : 'StMath-StMathMatrixSolver',
	#package : 'StMath',
	#tag : 'StMathMatrixSolver'
}

{ #category : 'instance creation' }
Solver class >> new [
	^super new initialize
]

{ #category : 'VisualWorks metadata' }
Solver class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
	)

]

{ #category : 'initialize-release' }
Solver >> initialize [
	"Do nothing."
]

{ #category : 'initialize-release' }
Solver >> initializeGlobally [
	self subclassResponsibility
]

{ #category : 'initialize-release' }
Solver >> initializeLocally [
	"Default is do nothing."
]
