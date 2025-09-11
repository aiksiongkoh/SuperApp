Class {
	#name : 'SymPrincipalMassFrame',
	#superclass : 'SymDependentFrame',
	#instVars : [
		'mass',
		'aJpp',
		'density'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'accessing' }
SymPrincipalMassFrame >> aJpp [

	^ aJpp
]

{ #category : 'accessing' }
SymPrincipalMassFrame >> aJpp: diagMat [

	aJpp := diagMat asSymbolic
]

{ #category : 'accessing' }
SymPrincipalMassFrame >> density [

	^ density
]

{ #category : 'accessing' }
SymPrincipalMassFrame >> density: anObject [

	density := anObject
]

{ #category : 'accessing' }
SymPrincipalMassFrame >> mass [

	^ mass
]

{ #category : 'accessing' }
SymPrincipalMassFrame >> mass: m [

	mass := m asSymbolic
]
