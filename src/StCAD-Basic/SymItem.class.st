Class {
	#name : 'SymItem',
	#superclass : 'Object',
	#instVars : [
		'name',
		'sup'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'accessing' }
SymItem >> aB [

	^ sup aB
]

{ #category : 'examples' }
SymItem >> aaaa [

	^ self
]

{ #category : 'examples' }
SymItem >> aaaaa [

	^ self
]

{ #category : 'examples' }
SymItem >> aaaaaa [

	^ self
]

{ #category : 'ops' }
SymItem >> assignAccICEqnNum: eqnNo [

	^ eqnNo
]

{ #category : 'ops' }
SymItem >> assignVelICEqnNum: eqnNo [

	^ eqnNo
]

{ #category : 'calc' }
SymItem >> calcAll [

	self subclassResponsibility
]

{ #category : 'accessing' }
SymItem >> classString [

	^ self className
]

{ #category : 'accessing' }
SymItem >> constraintsReport [
	"Do nothing."

	
]

{ #category : 'examples' }
SymItem >> d [

	^ self
]

{ #category : 'accIC' }
SymItem >> fillAccICIterError: col [
	"Do nothing."

	
]

{ #category : 'accIC' }
SymItem >> fillAccICIterJacob: mat [
	"Do nothing."

	
]

{ #category : 'posIC' }
SymItem >> fillAccICVdotIterError: col [
	"Default is do nothing."

	
]

{ #category : 'as yet unclassified' }
SymItem >> fillAccICVdotIterJacob: mat [
	"Do nothing."

	
]

{ #category : 'accessing' }
SymItem >> fillConstraints: collection [
	"Do nothing."

	
]

{ #category : 'accessing' }
SymItem >> fillContactEndFrames: collection [
	"Do nothing."

	
]

{ #category : 'accessing' }
SymItem >> fillDispConstraints: collection [
	"Do nothing."

	
]

{ #category : 'accessing' }
SymItem >> fillEssenConstraints: aCollection [
	"Do nothing."

	
]

{ #category : 'accessing' }
SymItem >> fillPartFrames: aCollection [
	"Do nothing."

	
]

{ #category : 'accessing' }
SymItem >> fillPerpenConstraints: collection [
	"Do nothing."

	
]

{ #category : 'posIC' }
SymItem >> fillPosICError: col [
	"Default is do nothing."

	
]

{ #category : 'posIC' }
SymItem >> fillPosICJacob: mat [
	"Default is do nothing."

	
]

{ #category : 'accessing' }
SymItem >> fillRedundantConstraints: aCollection [
	"Do nothing."

	
]

{ #category : 'velIC' }
SymItem >> fillVelICError: col [
	"Default is do nothing."

	
]

{ #category : 'velIC' }
SymItem >> fillVelICJacob: mat [
	"Default is do nothing."

	
]

{ #category : 'ops' }
SymItem >> fillVelICWeights: col [
	"Do nothing."

	
]

{ #category : 'accessing' }
SymItem >> fillqsu: collection [
	"Do nothing."

	
]

{ #category : 'accessing' }
SymItem >> fillqsuWeights: collection [
	"Do nothing."

	
]

{ #category : 'accessing' }
SymItem >> fillqsuddotlam: col [
	"Default is do nothing."

	
]

{ #category : 'accessing' }
SymItem >> fillqsudot: col [
	"Default is do nothing."

	
]

{ #category : 'accessing' }
SymItem >> fillqsudotWeights: col [
	"Default is do nothing."

	
]

{ #category : 'accessing' }
SymItem >> fillqsulam: collection [
	"Do nothing."

	
]

{ #category : 'as yet unclassified' }
SymItem >> fillvdotsuddotlam: col [

	self fillqsuddotlam: col
]

{ #category : 'testing' }
SymItem >> hasChanged [

	^ sup hasChanged
]

{ #category : 'testing' }
SymItem >> hasChanged: bool [

	^ sup hasChanged: bool
]

{ #category : 'accessing' }
SymItem >> initVariables [
	"Do nothing."

	
]

{ #category : 'initialization' }
SymItem >> initializeGlobally [

	self shouldNotImplement
]

{ #category : 'initialization' }
SymItem >> initializeLocally [
	"Assume that the independent instance variables are already set."

	"Initialize all constant dependent instance variables using local objects only."

	"Default is do nothing."

	
]

{ #category : 'output' }
SymItem >> logString: aString [

	Transcript
		show: aString;
		cr
]

{ #category : 'output' }
SymItem >> logString: string withArgument: string1 [

	Transcript
		show: (string mbdMessage expandWithArgument: string1);
		cr
]

{ #category : 'output' }
SymItem >> logString: string withArguments: arrayOfStrings [

	Transcript
		show: (string mbdMessage expandWithArguments: arrayOfStrings);
		cr
]

{ #category : 'accessing' }
SymItem >> name [

	^ name
]

{ #category : 'accessing' }
SymItem >> name: string [

	name := string
]

{ #category : 'accessing' }
SymItem >> owner: aSym [

	sup := aSym
]

{ #category : 'accessing' }
SymItem >> part [

	^ sup part
]

{ #category : 'accessing' }
SymItem >> partFrames [

	^ sup partFrames
]

{ #category : 'input-output' }
SymItem >> postInput [

	self initVariables.
	self calcAll
]

{ #category : 'posIC' }
SymItem >> postPosIC [
	"Do nothing."

	
]

{ #category : 'posIC' }
SymItem >> postPosICIteration [
	"Do nothing."

	
]

{ #category : 'velIC' }
SymItem >> postVelIC [
	"Do nothing."

	
]

{ #category : 'accessing' }
SymItem >> pqdotpv [

	^ sup pqdotpv
]

{ #category : 'accIC' }
SymItem >> preAccIC [
	"Do nothing."

	
]

{ #category : 'posIC' }
SymItem >> prePosIC [
	"Do nothing."

	
]

{ #category : 'velIC' }
SymItem >> preVelIC [
	"Do nothing."

	
]

{ #category : 'accessing' }
SymItem >> qEddot [

	^ sup qEddot
]

{ #category : 'accessing' }
SymItem >> qEdot [

	^ sup qEdot
]

{ #category : 'accessing' }
SymItem >> qXddot [

	^ sup qXddot
]

{ #category : 'accessing' }
SymItem >> qXdot [

	^ sup qXdot
]

{ #category : 'removing' }
SymItem >> removeRedundantConstraints: redundantEqns [
	"Do nothing."

	
]

{ #category : 'initialization' }
SymItem >> setVelICValues: col [
	"Do nothing."

	
]

{ #category : 'accessing' }
SymItem >> setqsu: collection [
	"Do nothing."

	
]

{ #category : 'accessing' }
SymItem >> setqsudotlam: col [
	"Default is do nothing."

	
]

{ #category : 'accessing' }
SymItem >> setqsulam: aCollection [
	"Do nothing."

	
]

{ #category : 'accessing' }
SymItem >> sup [

	^ sup
]

{ #category : 'accessing' }
SymItem >> sup: owner [
	"Keep this method simple. Use to connect components in assembly only."

	sup := owner
]

{ #category : 'accessing' }
SymItem >> time [

	^ sup time
]

{ #category : 'accessing' }
SymItem >> useEquationNumbers [
	"Do nothing."

	
]

{ #category : 'ops' }
SymItem >> useVelICEqnNo [
	"Do nothing."

	
]
