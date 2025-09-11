Class {
	#name : 'SymConstraint',
	#superclass : 'SymItem',
	#instVars : [
		'iG',
		'aG',
		'lam',
		'mu',
		'lamDeriv'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'as yet unclassified' }
SymConstraint >> assignVdotICEqnNum: i [

	iG := i.
	^ i + 1
]

{ #category : 'ops' }
SymConstraint >> assignVelICEqnNum: eqnNo [

	self iG: eqnNo.
	^ eqnNo + 1
]

{ #category : 'posIC' }
SymConstraint >> becomeRedundantConstraint [

	| newSelf |
	iG := nil.
	newSelf := SymRedundantConstraint new.
	self become: newSelf.
	self constraint: newSelf
]

{ #category : 'calc' }
SymConstraint >> calcAll [

	lam := 0.0.
	self calcG
]

{ #category : 'calc' }
SymConstraint >> calcG [

	self subclassResponsibility
]

{ #category : 'accIC' }
SymConstraint >> fillAccICIterJacob: mat [
	"Same as velIC."

	self fillVelICJacob: mat
]

{ #category : 'accessing' }
SymConstraint >> fillConstraints: collection [

	collection add: self
]

{ #category : 'accessing' }
SymConstraint >> fillDispConstraints: collection [

	self type == #displacement ifTrue: [ collection add: self ]
]

{ #category : 'accessing' }
SymConstraint >> fillEssenConstraints: collection [

	self type == #essential ifTrue: [ collection add: self ]
]

{ #category : 'accessing' }
SymConstraint >> fillPerpenConstraints: collection [

	self type == #perpendicular ifTrue: [ collection add: self ]
]

{ #category : 'posIC' }
SymConstraint >> fillPosICError: col [

	col at: iG plusNumber: aG asNumber
]

{ #category : 'accessing' }
SymConstraint >> fillRedundantConstraints: collection [
	"Do nothing."

	
]

{ #category : 'accessing' }
SymConstraint >> fillqsuddotlam: col [

	col at: iG put: lam
]

{ #category : 'accessing' }
SymConstraint >> fillqsulam: col [

	col at: iG put: lam
]

{ #category : 'accessing' }
SymConstraint >> iG [

	^ iG
]

{ #category : 'accessing' }
SymConstraint >> iG: eqnNo [

	iG := eqnNo
]

{ #category : 'initialization' }
SymConstraint >> initialize [
	"Get unique name."

	name := self identityHash
]

{ #category : 'testing' }
SymConstraint >> isRedundant [

	^ false
]

{ #category : 'input-output' }
SymConstraint >> postInput [

	lam := 0.0.
	iG := nil.
	super postInput
]

{ #category : 'posIC' }
SymConstraint >> prePosIC [

	lam := 0.0.
	iG := nil.
	super prePosIC
]

{ #category : 'removing' }
SymConstraint >> removeRedundantConstraints: redundantEqns [

	(redundantEqns includes: iG) ifTrue: [ self becomeRedundantConstraint ]
]

{ #category : 'accessing' }
SymConstraint >> setVelICValues: col [

	lam := col at: iG
]

{ #category : 'accessing' }
SymConstraint >> setqsudotlam: col [

	lam := col at: iG
]

{ #category : 'accessing' }
SymConstraint >> setqsulam: col [

	lam := col at: iG
]

{ #category : 'accessing' }
SymConstraint >> type [

	^ #essential
]
