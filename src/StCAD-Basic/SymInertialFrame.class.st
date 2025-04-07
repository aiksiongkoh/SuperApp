"
InertialFrame is the root that contains everything
"
Class {
	#name : 'SymInertialFrame',
	#superclass : 'SymCartesianFrame',
	#instVars : [
		'rOOO',
		'aAOO',
		'vOOO',
		'omeOOO'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'accessing' }
SymInertialFrame >> aAOf [
	"aAOf := aAOO := aAFf"

	^ aAFf
]

{ #category : 'adding' }
SymInertialFrame >> addAssemblyF: aStAssemblyFrame [ 
	subs add: aStAssemblyFrame.
	aStAssemblyFrame sup: self. 
]

{ #category : 'adding' }
SymInertialFrame >> addAssemblyFrm: assemblyFrm [

	subs add: assemblyFrm.
	assemblyFrm sup: self
]

{ #category : 'as yet unclassified' }
SymInertialFrame >> assemblyFrms [

	^ subs
]

{ #category : 'calc' }
SymInertialFrame >> calcAll [

	subs do: [ :sub | sub calcAll ]
]

{ #category : 'initialization' }
SymInertialFrame >> initialize [

	| zeroVec |
	super initialize.
	zeroVec := SymFullColumn with: 0.0 with: 0.0 with: 0.0.
	rOOO := zeroVec asSymbolic.
	rFfF := rOOO.
	rOfO := rOOO.
	aAOO := (SymFullMatrix identity: 3) asSymbolic.
	aAFf := aAOO.
	aAOf := aAOO.
	vOOO := zeroVec asSymbolic.
	vOfO := vOOO.
	omeOOO := zeroVec asSymbolic.
	omeOfO := omeOOO
]

{ #category : 'accessing' }
SymInertialFrame >> rOFO [

	^ StMFullColumn zero: 3
]

{ #category : 'run' }
SymInertialFrame >> runDYNAMIC [

	self soleAssembly runDYNAMIC
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
