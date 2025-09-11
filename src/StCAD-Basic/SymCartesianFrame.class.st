Class {
	#name : 'SymCartesianFrame',
	#superclass : 'SymCoordinateFrame',
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'calc' }
SymCartesianFrame >> aAOa [

	^ sup aAOa
]

{ #category : 'accessing' }
SymCartesianFrame >> aAddotOa [

	^ sup aAddotOa
]

{ #category : 'accessing' }
SymCartesianFrame >> aAdotOa [

	^ sup aAdotOa
]

{ #category : 'calc' }
SymCartesianFrame >> calcAll [

	self calcAllrOfO.
	self calcAllaAOf
]

{ #category : 'calc' }
SymCartesianFrame >> calcAllaAOf [

	| t |
	aAOf := (self aAOF timesFullMatrix: aAFf) simplified.
	t := self time.
	pAOfpt := aAOf differentiateWRT: t.
	ppAOfptpt := pAOfpt differentiateWRT: t
]

{ #category : 'calc' }
SymCartesianFrame >> calcAllrOfO [

	| t |
	rOfO := (self rOFO + (self aAOF timesFullColumn: rFfF)) simplified.
	t := self time.
	prOfOpt := rOfO differentiateWRT: t.
	pprOfOptpt := prOfOpt differentiateWRT: t
]

{ #category : 'accessing' }
SymCartesianFrame >> fullName [

	| stream |
	stream := WriteStream on: (String new: 256).
	self fullpath do: [ :node |
		(node respondsTo: #name) ifTrue: [
			node name isString ifTrue: [
				stream nextPut: $/.
				stream nextPutAll: node name ] ] ].
	^ stream contents
]

{ #category : 'accessing' }
SymCartesianFrame >> fullpath [

	| fullpath |
	fullpath := sup isNil
		            ifTrue: [ OrderedCollection new ]
		            ifFalse: [ sup fullpath ].
	fullpath add: self.
	^ fullpath
]

{ #category : 'testing' }
SymCartesianFrame >> isPartFrame [

	^ false
]

{ #category : 'accessing' }
SymCartesianFrame >> rOaO [

	^ sup rOaO
]
