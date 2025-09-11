"
InertialFrame is the root that contains everything
"
Class {
	#name : 'SymInertialFrame',
	#superclass : 'SymIndependentFrame',
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
	"Do nothing."

	
]

{ #category : 'initialization' }
SymInertialFrame >> initialize [

	| zeroVec rOOO aAOO vOOO |
	super initialize.
	zeroVec := SymFullColumn with: 0.0 with: 0.0 with: 0.0.
	rOOO := zeroVec asSymbolic.
	rFfF := rOOO.
	rOfO := rOOO.
	aAOO := (SymFullMatrix identity: 3) asSymbolic.
	aAFf := aAOO.
	aAOf := aAOO.
	vOOO := zeroVec asSymbolic.
	prOfOpt := vOOO.
	pAOfpt := (SymFullMatrix zero: 3 by: 3) asSymbolic
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
