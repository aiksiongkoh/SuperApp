Class {
	#name : 'SymAbsConstraint',
	#superclass : 'SymConstraint',
	#instVars : [
		'axis',
		'iqXminusOnePlusAxis'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'VisualWorks metadata' }
SymAbsConstraint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'accessing' }
SymAbsConstraint >> axis: aInteger [ 
	axis := aInteger
]

{ #category : 'calc' }
SymAbsConstraint >> calcPostDynCorrectorIteration [

	axis < 4
		ifTrue: [ aG := sup qX at: axis ]
		ifFalse: [ aG := sup qE at: axis - 3 ]
]

{ #category : 'accessing' }
SymAbsConstraint >> classString [
	"Used to access the descriptive name of the constraint."
	"Needed for multi-language."

	^TheMbDSystem getString: #'MbD: absolute constraint '
]

{ #category : 'accIC' }
SymAbsConstraint >> fillAccICIterError: col [

	| sum |
	col at: iqXminusOnePlusAxis plusNumber: lam.
	sum := axis <= 3
		       ifTrue: [ sup qXddot at: axis ]
		       ifFalse: [ sup qEddot at: axis - 3 ].
	col at: iG plusNumber: sum
]

{ #category : 'collision' }
SymAbsConstraint >> fillCollisionError: col [
	"lamDeriv is now PlamDeriv."

	"qEddot is now qEdotDeriv."

	| sum |
	col at: iqXminusOnePlusAxis plusNumber: lamDeriv.
	sum := axis <= 3
		       ifTrue: [ sup qXddot at: axis ]
		       ifFalse: [ sup qEddot at: axis - 3 ].
	col at: iG plusNumber: sum
]

{ #category : 'posIC' }
SymAbsConstraint >> fillPosICError: col [ 
	super fillPosICError: col.
	col at: iqXminusOnePlusAxis plusNumber: lam
]

{ #category : 'posIC' }
SymAbsConstraint >> fillPosICJacob: mat [ 
	mat at: iG and: iqXminusOnePlusAxis plusNumber: 1.0.
	mat at: iqXminusOnePlusAxis and: iG plusNumber: 1.0
]

{ #category : 'posIC' }
SymAbsConstraint >> fillPosKineJacob: mat [ 
	mat at: iG and: iqXminusOnePlusAxis plusNumber: 1.0
]

{ #category : 'velIC' }
SymAbsConstraint >> fillVelICJacob: mat [ 
	self fillPosICJacob: mat
]

{ #category : 'velIC' }
SymAbsConstraint >> fillVelKineJacob: mat [ 
	self fillPosKineJacob: mat
]

{ #category : 'dynamic' }
SymAbsConstraint >> fillpFpy: mat [ 
	mat
		at: iG
		and: iqXminusOnePlusAxis
		plusNumber: 1.0
]

{ #category : 'dynamic' }
SymAbsConstraint >> fillpFpydot: mat [ 
	mat
		at: iqXminusOnePlusAxis
		and: iG
		plusNumber: 1.0
]

{ #category : 'initialize-release' }
SymAbsConstraint >> useEquationNumbers [

	iqXminusOnePlusAxis := sup iqX - 1 + axis
]
