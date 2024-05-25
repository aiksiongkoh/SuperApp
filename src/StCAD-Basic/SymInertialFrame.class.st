"
InertialFrame is the root that contains everything
"
Class {
	#name : 'SymInertialFrame',
	#superclass : 'SymCartesianFrame',
	#instVars : [
		'symUnits',
		'time'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'adding' }
SymInertialFrame >> addAssemblyF: aStAssemblyFrame [ 
	subs add: aStAssemblyFrame.
	aStAssemblyFrame sup: self. 
]

{ #category : 'adding' }
SymInertialFrame >> addAssemblyFrm: assemblyFrame [

	subs add: assemblyFrame.
	assemblyFrame sup: self
]

{ #category : 'calc' }
SymInertialFrame >> calcAll [

	subs do: [ :sub | sub calcAll ]
]

{ #category : 'initialization' }
SymInertialFrame >> initialize [

	| rOOO aAOO |
	super initialize.
	time := StMIndependentVariable name: #t.
	rOOO := StMFullColumn with: 0.0 with: 0.0 with: 0.0.
	rFfF := rOOO asSymbolic.
	rOfO := rFfF.
	aAOO := StMFullMatrix identity: 3.
	aAFf := aAOO asSymbolic.
	aAOf := aAFf
]

{ #category : 'accessing' }
SymInertialFrame >> rOFO [

	^ StMFullColumn zero: 3
]

{ #category : 'run' }
SymInertialFrame >> runDYNAMIC [

	| assembly |
	assembly := self soleAssembly.
	assembly preMbDrun.
	assembly calcCharacteristicDimensions.
	[
	assembly initializeLocally.
	assembly initializeGlobally.
	assembly hasChanged ] whileTrue.
	assembly partsJointsMotionsForcesTorquesDo: [ :item | item postInput ].
	assembly outputFor: #INPUT.
	assembly runAllIC.
	assembly outputFor: #'INITIAL CONDITIONS'.
	assembly runBasicDynamic.
	assembly postMbDrun
]

{ #category : 'accessing' }
SymInertialFrame >> soleAssembly [

	[ subs size = 1 ] assert.
	^ subs first
]

{ #category : 'accessing' }
SymInertialFrame >> time [

	^ time
]
