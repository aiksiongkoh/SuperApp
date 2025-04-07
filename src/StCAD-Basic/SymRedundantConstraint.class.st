Class {
	#name : 'SymRedundantConstraint',
	#superclass : 'SymItem',
	#instVars : [
		'constraint'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'posIC' }
SymRedundantConstraint >> activateConstraint [

	| newSelf |
	newSelf := self constraint.
	self become: newSelf.
	^ true
]

{ #category : 'accessing' }
SymRedundantConstraint >> classString [

	^ constraint classString
]

{ #category : 'accessing' }
SymRedundantConstraint >> constraint [

	^ constraint
]

{ #category : 'accessing' }
SymRedundantConstraint >> constraint: con [

	constraint := con
]

{ #category : 'posIC' }
SymRedundantConstraint >> fillPosICJacob: mat [
	"Do nothing."

	
]

{ #category : 'accessing' }
SymRedundantConstraint >> fillRedundantConstraints: collection [

	collection add: self
]

{ #category : 'testing' }
SymRedundantConstraint >> isRedundant [

	^ true
]
