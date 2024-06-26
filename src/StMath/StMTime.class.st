Class {
	#name : 'StMTime',
	#superclass : 'StMIndependentVariable',
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'VisualWorks metadata' }
StMTime class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'initialize-release' }
StMTime >> initialize [
	super initialize.
	name := #t
]
