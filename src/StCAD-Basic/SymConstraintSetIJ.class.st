Class {
	#name : 'SymConstraintSetIJ',
	#superclass : 'SymItemIJ',
	#instVars : [
		'constraints'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'adding' }
SymConstraintSetIJ >> addConstraint: constraintIJ [

	constraints add: constraintIJ.
	constraintIJ sup: self
]

{ #category : 'accIC' }
SymConstraintSetIJ >> fillAccICIterError: col [

	constraints do: [ :con | con fillAccICIterError: col ]
]

{ #category : 'accIC' }
SymConstraintSetIJ >> fillAccICIterJacob: mat [

	constraints do: [ :con | con fillAccICIterJacob: mat ]
]

{ #category : 'accessing' }
SymConstraintSetIJ >> fillConstraints: collection [

	constraints do: [ :con | con fillConstraints: collection ]
]

{ #category : 'accessing' }
SymConstraintSetIJ >> fillDispConstraints: collection [

	constraints do: [ :con | con fillDispConstraints: collection ]
]

{ #category : 'accessing' }
SymConstraintSetIJ >> fillEssenConstraints: collection [

	constraints do: [ :con | con fillEssenConstraints: collection ]
]

{ #category : 'accessing' }
SymConstraintSetIJ >> fillPerpenConstraints: collection [

	constraints do: [ :con | con fillPerpenConstraints: collection ]
]

{ #category : 'posIC' }
SymConstraintSetIJ >> fillPosICError: col [

	constraints do: [ :con | con fillPosICError: col ]
]

{ #category : 'posIC' }
SymConstraintSetIJ >> fillPosICJacob: mat [

	constraints do: [ :con | con fillPosICJacob: mat ]
]

{ #category : 'accessing' }
SymConstraintSetIJ >> fillRedundantConstraints: collection [

	constraints do: [ :con | con fillRedundantConstraints: collection ]
]

{ #category : 'velIC' }
SymConstraintSetIJ >> fillVelICError: col [

	constraints do: [ :con | con fillVelICError: col ]
]

{ #category : 'velIC' }
SymConstraintSetIJ >> fillVelICJacob: mat [

	constraints do: [ :con | con fillVelICJacob: mat ]
]

{ #category : 'accessing' }
SymConstraintSetIJ >> fillqsuddotlam: col [

	constraints do: [ :con | con fillqsuddotlam: col ]
]

{ #category : 'accessing' }
SymConstraintSetIJ >> fillqsulam: col [

	constraints do: [ :con | con fillqsulam: col ]
]

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

{ #category : 'accessing' }
SymConstraintSetIJ >> setVelICValues: col [

	constraints do: [ :con | con setVelICValues: col ]
]

{ #category : 'accessing' }
SymConstraintSetIJ >> setqsudotlam: col [

	constraints do: [ :con | con setqsudotlam: col ]
]

{ #category : 'accessing' }
SymConstraintSetIJ >> setqsulam: col [

	constraints do: [ :con | con setqsulam: col ]
]

{ #category : 'initialize-release' }
SymConstraintSetIJ >> useEquationNumbers [

	constraints do: [ :con | con useEquationNumbers ]
]

{ #category : 'initialize-release' }
SymConstraintSetIJ >> useVelICEqnNo [

	constraints do: [ :con | con useVelICEqnNo ]
]
