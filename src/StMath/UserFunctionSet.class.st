Class {
	#name : 'UserFunctionSet',
	#superclass : 'UserFunction',
	#instVars : [
		'parent',
		'current',
		'functions'
	],
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'VisualWorks metadata' }
UserFunctionSet class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'initialize-release' }
UserFunctionSet >> initialize [
	functions := Set new
]
