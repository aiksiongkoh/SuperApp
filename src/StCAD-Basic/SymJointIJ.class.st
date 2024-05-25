Class {
	#name : 'SymJointIJ',
	#superclass : 'SymConstraintSetIJ',
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'initialization' }
SymJointIJ >> initializeLocally [

	constraints do: [ :con | con initializeLocally ]
]
