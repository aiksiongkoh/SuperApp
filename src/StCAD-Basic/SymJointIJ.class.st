Class {
	#name : 'SymJointIJ',
	#superclass : 'SymConstraintSetIJ',
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'accessing' }
SymJointIJ >> constraintsReport [

	| dummy |
	dummy := constraints select: [ :con | con isRedundant ].
	dummy size > 0 ifTrue: [
		self
			logString: #'MbD: \%1 %2  has the following constraint(s) removed: '
			withArguments: (Array with: self classString with: self name).
		dummy do: [ :con | con logString: #'MbD: \    %1' withArgument: con classString ] ]
]

{ #category : 'initialization' }
SymJointIJ >> initializeLocally [

	constraints do: [ :con | con initializeLocally ]
]

{ #category : 'removing' }
SymJointIJ >> removeRedundantConstraints: redundantEqns [

	constraints do: [ :con | con removeRedundantConstraints: redundantEqns ]
]
