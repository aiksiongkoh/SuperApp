"
AssemblyFrame is contained by InertialFrame.
AssemblyFrame contains PartFrame(s).
Its motion is prescribed as functions of time.
rOaO(rOaO1(t), rOaO2(t), rOaO3(t))
aAOa(the1x(t), the2y(t), the3z(t)) using Bryant angles
"
Class {
	#name : 'SymAssemblyFrame',
	#superclass : 'SymCartesianFrame',
	#instVars : [
		'time',
		'theOa',
		'joints',
		'motions',
		'fields',
		'hasChanged',
		'solver',
		'units',
		'aAOa',
		'omeOaO',
		'rOaO',
		'vOaO',
		'pAOapt',
		'prOaOpt',
		'forTors',
		'setsOfRedundantConstraints'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'calc' }
SymAssemblyFrame >> aAOa [

	^ aAOa
]

{ #category : 'accessing' }
SymAssemblyFrame >> aAOp [

	^ aAOa
]

{ #category : 'adding' }
SymAssemblyFrame >> addField: field [

	fields add: field.
	field sup: self
]

{ #category : 'adding' }
SymAssemblyFrame >> addJoint: joint [

	joints add: joint.
	joint sup: self
]

{ #category : 'adding' }
SymAssemblyFrame >> addMarkerFrm: markerFrm [

	subs add: markerFrm.
	markerFrm sup: self
]

{ #category : 'adding' }
SymAssemblyFrame >> addMotion: motion [

	motions add: motion.
	motion sup: self
]

{ #category : 'adding' }
SymAssemblyFrame >> addPartF: aStPartFrame [ 
	subs add: aStPartFrame.
	aStPartFrame sup: self
]

{ #category : 'adding' }
SymAssemblyFrame >> addPartFrm: partFrm [

	subs add: partFrm.
	partFrm sup: self
]

{ #category : 'accessing' }
SymAssemblyFrame >> allConstraints [

	| allConstraints |
	allConstraints := OrderedCollection new.
	self allDo: [ :item | item fillConstraints: allConstraints ].
	^ allConstraints
]

{ #category : 'enumerating' }
SymAssemblyFrame >> allDo: aBlock [

	| frames |
	frames := subs.
	frames do: aBlock.
	joints do: aBlock.
	motions do: aBlock.
	forTors do: aBlock.
	fields do: aBlock
]

{ #category : 'accessing' }
SymAssemblyFrame >> allRedundantConstraints [

	| allRedundantConstraints |
	allRedundantConstraints := OrderedCollection new.
	self allDo: [ :item | item fillRedundantConstraints: allRedundantConstraints ].
	^ allRedundantConstraints
]

{ #category : 'as yet unclassified' }
SymAssemblyFrame >> calcAllKE [
	"Do nothing."

	
]

{ #category : 'DYN' }
SymAssemblyFrame >> calcCharacteristicDimensions [
	"Avoid for now."

	
]

{ #category : 'as yet unclassified' }
SymAssemblyFrame >> calcKine [

	rOfO := rOaO.
	aAOf := aAOa
]

{ #category : 'accessing' }
SymAssemblyFrame >> contactEndFrames [

	| contactEndFrames |
	contactEndFrames := OrderedCollection new.
	self allDo: [ :joint | joint fillContactEndFrames: contactEndFrames ].
	^ contactEndFrames
]

{ #category : 'accessing' }
SymAssemblyFrame >> displacementConstraints [

	| dispConstraints |
	dispConstraints := OrderedCollection new.
	self allDo: [ :item | item fillDispConstraints: dispConstraints ].
	^ dispConstraints
]

{ #category : 'accessing' }
SymAssemblyFrame >> essentialConstraints2 [

	| essenConstraints |
	essenConstraints := OrderedCollection new.
	self allDo: [ :item | item fillEssenConstraints: essenConstraints ].
	^ essenConstraints
]

{ #category : 'accessing' }
SymAssemblyFrame >> forTors [

	^ forTors
]

{ #category : 'accessing' }
SymAssemblyFrame >> hasChanged [

	^ hasChanged
]

{ #category : 'testing' }
SymAssemblyFrame >> hasChanged: bool [

	hasChanged := bool
]

{ #category : 'accessing' }
SymAssemblyFrame >> initVariables [

	| t block selffullName |
	t := self time.
	rOaO do: [ :r | r x: t ].
	theOa do: [ :the | the x: t ].
	selffullName := self fullName.
	block := [ :var |
	         | fullName |
	         fullName := String new writeStream
		                     nextPutAll: selffullName;
		                     nextPut: $/;
		                     nextPutAll: var name;
		                     contents.
	         var name: fullName asSymbol ].
	rOaO do: block.
	theOa do: block
]

{ #category : 'initialization' }
SymAssemblyFrame >> initialize [

	| rOaO1 rOaO2 rOaO3 theOa1x theOa2y theOa3z |
	super initialize.
	units := Units new.
	time := StMIndependentVariable name: #t.
	rOaO1 := StMVariableParameter name: #rOaO1.
	rOaO2 := StMVariableParameter name: #rOaO2.
	rOaO3 := StMVariableParameter name: #rOaO3.
	rOaO := SymFullColumn with: rOaO1 with: rOaO2 with: rOaO3.
	theOa1x := StMVariableParameter name: #theOa1x.
	theOa2y := StMVariableParameter name: #theOa2y.
	theOa3z := StMVariableParameter name: #theOa3z.
	theOa := SymEulerAngles with: theOa1x with: theOa2y with: theOa3z.
	joints := OrderedCollection new.
	motions := OrderedCollection new.
	forTors := OrderedCollection new.
	fields := OrderedCollection new.
	solver := SymMbDSystemSolver new.
	solver system: self.
	setsOfRedundantConstraints := OrderedCollection new
]

{ #category : 'initialization' }
SymAssemblyFrame >> initializeLocally [

	hasChanged := false.
	self mbdTimeValue: solver startTime.
	self partsJointsMotionsForcesTorquesDo: [ :item |
		item initializeLocally ].
	solver initializeLocally
]

{ #category : 'accessing' }
SymAssemblyFrame >> iqE [

	^ nil
]

{ #category : 'accessing' }
SymAssemblyFrame >> iqX [

	^ nil
]

{ #category : 'accessing' }
SymAssemblyFrame >> ivE [

	^ nil
]

{ #category : 'accessing' }
SymAssemblyFrame >> ivOmega [

	^ nil
]

{ #category : 'accessing' }
SymAssemblyFrame >> ivX [

	^ nil
]

{ #category : 'accessing' }
SymAssemblyFrame >> jointsMotions [

	^ joints , motions
]

{ #category : 'accessing' }
SymAssemblyFrame >> maximumMass [

	| max |
	max := 0.0.
	self partFrames do: [ :pFrm | max := max max: pFrm mass ].
	^ max
]

{ #category : 'accessing' }
SymAssemblyFrame >> maximumMomentOfInertia [

	| max |
	max := 0.0.
	self partFrames do: [ :pFrm | pFrm aJpp do: [ :aJii | max := max max: aJii ] ].
	^ max
]

{ #category : 'dynamic' }
SymAssemblyFrame >> mbdTimeValue: double [

	self time value = double ifFalse: [ self time value: double ]
]

{ #category : 'run' }
SymAssemblyFrame >> needToRedoPosIC [

	| allRedunCons newSet |
	allRedunCons := self allRedundantConstraints.
	newSet := (allRedunCons collect: [ :i | i constraint name ]) asSortedCollection.
	newSet isEmpty ifTrue: [ ^ false ].
	(setsOfRedundantConstraints includes: newSet) ifTrue: [ "Same set of redundant constraints found."
		setsOfRedundantConstraints add: newSet.
		^ false ].
	setsOfRedundantConstraints size >= 2 ifTrue: [
		((setsOfRedundantConstraints collect: [ :set | set size ]) includes: newSet size) ifTrue: [ "Equal number of redundant constraints found."
			setsOfRedundantConstraints add: newSet.
			^ false ] ].
	setsOfRedundantConstraints add: newSet.
	allRedunCons do: [ :i | i activateConstraint ].
	^ true
]

{ #category : 'as yet unclassified' }
SymAssemblyFrame >> omeOaO [

	^ omeOaO
]

{ #category : 'accessing' }
SymAssemblyFrame >> omeOpO [

	^ omeOaO
]

{ #category : 'dynamic' }
SymAssemblyFrame >> outputFor: aString [
	"Do nothing for now."

	
]

{ #category : 'accessing' }
SymAssemblyFrame >> pAOapt [

	^ pAOapt
]

{ #category : 'accessing' }
SymAssemblyFrame >> pAOppE [

	^ nil
]

{ #category : 'accessing' }
SymAssemblyFrame >> pAOppt [

	^ pAOapt
]

{ #category : 'accessing' }
SymAssemblyFrame >> partFrames [

	| partFrames |
	partFrames := OrderedCollection new.
	subs do: [ :sub | sub fillPartFrames: partFrames ].
	^ partFrames
]

{ #category : 'accessing' }
SymAssemblyFrame >> parts [

	^ subs select: [ :item | item isPartFrame ]
]

{ #category : 'enumerating' }
SymAssemblyFrame >> partsJointsMotionsForcesTorquesDo: aBlock [

	| parts |
	parts := subs.
	parts do: aBlock.
	joints do: aBlock.
	motions do: aBlock.
	forcesTorques do: aBlock
]

{ #category : 'enumerating' }
SymAssemblyFrame >> partsJointsMotionsForcesTorquesFieldsDo: aBlock [

	| parts |
	parts := subs.
	parts do: aBlock.
	joints do: aBlock.
	motions do: aBlock.
	forcesTorques do: aBlock.
	fields do: aBlock
]

{ #category : 'accessing' }
SymAssemblyFrame >> perpendicularConstraints2 [

	| perpenConstraints |
	perpenConstraints := OrderedCollection new.
	self allDo: [ :joint | joint fillPerpenConstraints: perpenConstraints ].
	^ perpenConstraints
]

{ #category : 'input-output' }
SymAssemblyFrame >> postInput [

	self mbdTimeValue: solver startTime.
	self allDo: [ :item | item postInput ]
]

{ #category : 'accessing' }
SymAssemblyFrame >> ppAOppEpE [

	| zeroMat ppAOppEpE ppAOppEpEi |
	zeroMat :=SymFullMatrix zero: 3 by: 3.
	ppAOppEpE := SymFullMatrix new: 4 by: 4.
	1 to: 4 do: [ :i |
		ppAOppEpEi := ppAOppEpE at: i.
		1 to: 4 do: [ :j | ppAOppEpEi at: j put: zeroMat ] ].
	^ ppAOppEpE
]

{ #category : 'DYN' }
SymAssemblyFrame >> preMbDrun [

	body preMbDrun
]

{ #category : 'posIC' }
SymAssemblyFrame >> prePosIC [

	self allDo: [ :item | item prePosIC ]
]

{ #category : 'accessing' }
SymAssemblyFrame >> qE [

	^ nil
]

{ #category : 'accessing' }
SymAssemblyFrame >> qEddot [

	^ nil
]

{ #category : 'accessing' }
SymAssemblyFrame >> qEdot [

	^ nil
]

{ #category : 'accessing' }
SymAssemblyFrame >> qX [

	^ nil
]

{ #category : 'accessing' }
SymAssemblyFrame >> qXddot [

	^ nil
]

{ #category : 'accessing' }
SymAssemblyFrame >> qXdot [

	^ nil
]

{ #category : 'accessing' }
SymAssemblyFrame >> rOaO [

	^ rOaO
]

{ #category : 'accessing' }
SymAssemblyFrame >> rOaO: col [

	1 to: 3 do: [ :i | (rOaO at: i) rhs: (col at: i) asSymbolic ].
	rOaO := rOaO simplified.
	rFfF := rOaO
]

{ #category : 'accessing' }
SymAssemblyFrame >> rOpO [

	^ rOaO
]

{ #category : 'run' }
SymAssemblyFrame >> runAccIC [

	solver runAccIC
]

{ #category : 'run' }
SymAssemblyFrame >> runAllIC [
	"Redundant constraint removal is best when the system is assembled."

	| cDiscontinuity |
	[
	self runPosIC.
	"	self runPerturbedPosIC."
	[ self needToRedoPosIC ] whileTrue: [ self runPosIC ].
	self runVelIC.
	self runAccIC.
	cDiscontinuity := self cDiscontinuityAtIC.
	cDiscontinuity isEmpty not ] whileTrue: [
		(cDiscontinuity includes: #REBOUND) ifTrue: [
			self preCollision.
			self runCollisionDerivativeIC.
			self runBasicCollision ] ]
]

{ #category : 'run' }
SymAssemblyFrame >> runDYNAMIC [

	self preMbDrun.
	self calcCharacteristicDimensions.
	self postInput.
	self outputFor: #INPUT.
	self runAllIC.
	self outputFor: #'INITIAL CONDITIONS'.
	self runBasicDynamic.
	self postMbDrun
]

{ #category : 'run' }
SymAssemblyFrame >> runPosIC [

	solver runPosIC
]

{ #category : 'run' }
SymAssemblyFrame >> runVelIC [

	solver runVelIC
]

{ #category : 'accessing' }
SymAssemblyFrame >> sensors [

	^ OrderedCollection new
]

{ #category : 'accessing' }
SymAssemblyFrame >> solver [

	^ solver
]

{ #category : 'accessing' }
SymAssemblyFrame >> solver: anObject [

	solver := anObject
]

{ #category : 'accessing' }
SymAssemblyFrame >> theOa [

	^ theOa
]

{ #category : 'accessing' }
SymAssemblyFrame >> theOa: bryantAngles [

	1 to: 3 do: [ :i | (theOa at: i) rhs: (bryantAngles at: i) asSymbolic ].
	theOa := theOa simplified.
	aAOa := theOa aA.
	aAFf := aAOa
]

{ #category : 'accessing' }
SymAssemblyFrame >> time [

	^ time
]

{ #category : 'accessing' }
SymAssemblyFrame >> uHolders [

	^ OrderedCollection new
]

{ #category : 'accessing' }
SymAssemblyFrame >> units [

	^ units
]

{ #category : 'accessing' }
SymAssemblyFrame >> vOaO [

	^ vOaO
]

{ #category : 'accessing' }
SymAssemblyFrame >> vOpO [

	^ vOaO
]

{ #category : 'accessing' }
SymAssemblyFrame >> variables [

	^ OrderedCollection new
]
