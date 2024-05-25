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
		'theOa',
		'joints',
		'motions',
		'forcesTorques',
		'fields',
		'hasChanged',
		'solver',
		'units'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'accessing' }
SymAssemblyFrame >> aAOa [

	^ aAOf
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
SymAssemblyFrame >> addPartFrm: aStPartFrame [ 
	subs add: aStPartFrame.
	aStPartFrame sup: self
]

{ #category : 'calc' }
SymAssemblyFrame >> calcAll [

	rOfO := self calcrOaO.
	aAOf := self calcaAOa.
	subs do: [ :sub | sub calcAll ]
]

{ #category : 'DYN' }
SymAssemblyFrame >> calcCharacteristicDimensions [
	"Avoid for now."

	
]

{ #category : 'calc' }
SymAssemblyFrame >> calcaAOa [

	^ aAFf
]

{ #category : 'calc' }
SymAssemblyFrame >> calcrOaO [

	^ rFfF
]

{ #category : 'accessing' }
SymAssemblyFrame >> hasChanged [

	^ hasChanged
]

{ #category : 'testing' }
SymAssemblyFrame >> hasChanged: bool [

	hasChanged := bool
]

{ #category : 'initialization' }
SymAssemblyFrame >> initialize [

	| rOaO1 rOaO2 rOaO3 rOaO theOa1x theOa2y theOa3z aAOa |
	super initialize.
	rOaO1 := StMVariableParameter name: #rOaO1.
	rOaO2 := StMVariableParameter name: #rOaO2.
	rOaO3 := StMVariableParameter name: #rOaO3.
	rOaO := StMFullColumn with: rOaO1 with: rOaO2 with: rOaO3.
	rFfF := rOaO simplified.
	theOa1x := StMVariableParameter name: #theOa1x.
	theOa2y := StMVariableParameter name: #theOa2y.
	theOa3z := StMVariableParameter name: #theOa3z.
	theOa := SymEulerAngles with: theOa1x with: theOa2y with: theOa3z.
	aAOa := theOa
		        calc;
		        aA.
	aAFf := aAOa simplified.
	joints := OrderedCollection new.
	motions := OrderedCollection new.
	forcesTorques := OrderedCollection new.
	fields := OrderedCollection new.
	solver := MbDSystemSolver2 new.
	solver system: self
]

{ #category : 'initialization' }
SymAssemblyFrame >> initializeLocally [

	hasChanged := false.
	self mbdTimeValue: solver startTime.
	self partsJointsMotionsForcesTorquesDo: [ :item |
		item initializeLocally ].
	solver initializeLocally
]

{ #category : 'dynamic' }
SymAssemblyFrame >> mbdTimeValue: double [

	self time value = double ifFalse: [ self time value: double ]
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

{ #category : 'DYN' }
SymAssemblyFrame >> preMbDrun [

	body preMbDrun
]

{ #category : 'accessing' }
SymAssemblyFrame >> rOaO [

	^ rOfO
]

{ #category : 'run' }
SymAssemblyFrame >> runDYNAMIC [

	self preMbDrun.
	self calcCharacteristicDimensions.
	[
	self initializeLocally.
	self initializeGlobally.
	self hasChanged ] whileTrue.
	self partsJointsMotionsForcesTorquesDo: [ :item | item postInput ].
	self outputFor: #INPUT.
	self runAllIC.
	self outputFor: #'INITIAL CONDITIONS'.
	self runBasicDynamic.
	self postMbDrun
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
SymAssemblyFrame >> sup: inertialFrm [

	| t |
	super sup: inertialFrm.
	t := self time.
	rFfF do: [ :r | r x: t ].
	theOa do: [ :the | the x: t ]
]

{ #category : 'accessing' }
SymAssemblyFrame >> theOa [

	^ theOa
]

{ #category : 'accessing' }
SymAssemblyFrame >> theOa: anObject [

	theOa := anObject
]
