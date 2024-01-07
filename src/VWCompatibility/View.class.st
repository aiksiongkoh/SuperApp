Class {
	#name : #View,
	#superclass : #DependentPart,
	#instVars : [
		'controller'
	],
	#category : #VWCompatibility
}

{ #category : #'VisualWorks metadata' }
View class >> visualWorksMetadata [

	^ #(
		'namespace' 'UI'
		'superclassNamespace' 'Graphics'
	)

]
