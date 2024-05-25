Class {
	#name : 'SymConstraintSetIJ',
	#superclass : 'SymItemIJ',
	#instVars : [
		'constraints'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'initialization' }
SymConstraintSetIJ >> initialize [
	constraints := OrderedCollection new
]

{ #category : 'initialization' }
SymConstraintSetIJ >> initializeGlobally [

	constraints do: [ :con | con initializeGlobally ]
]

{ #category : 'initialization' }
SymConstraintSetIJ >> initializeLocally [

	constraints do: [ :con | con initializeLocally ]
]
