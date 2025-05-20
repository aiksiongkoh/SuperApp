Class {
	#name : 'SymEndFrame',
	#superclass : 'SymCartesianFrame',
	#instVars : [
		'aAOe',
		'rOeO',
		'omeOeO',
		'vOeO',
		'rmem',
		'aAme',
		'theme'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'accessing' }
SymEndFrame >> aAOe [

	^ aAOf
]

{ #category : 'accessing' }
SymEndFrame >> aAjOe: j [

	^ aAOe column: j
]

{ #category : 'accessing' }
SymEndFrame >> aAme [

	^ aAFf
]

{ #category : 'calc' }
SymEndFrame >> calcKine [

	rOeO := (self rOmO + (self aAOm timesFullColumn: rmem)) simplified.
	aAOe := (self aAOm timesFullMatrix: aAme) simplified.
	rOfO := rOeO.
	aAOf := aAOe
]

{ #category : 'accessing' }
SymEndFrame >> initVariables [

	| t block selffullName |
	t := self time.
	rmem do: [ :r | r x: t ].
	theme do: [ :the | the x: t ].
	selffullName := self fullName.
	block := [ :var |
	         | fullName |
	         fullName := String new writeStream
		                     nextPutAll: selffullName;
		                     nextPut: $/;
		                     nextPutAll: var name;
		                     contents.
	         var name: fullName asSymbol ].
	rmem do: block.
	theme do: block
]

{ #category : 'accessing' }
SymEndFrame >> markerFrame [

	^ sup
]

{ #category : 'accessing' }
SymEndFrame >> markerFrame: mkrFrm [

	sup := mkrFrm
]

{ #category : 'accessing' }
SymEndFrame >> omeOeO [

	^ omeOfO
]

{ #category : 'accessing' }
SymEndFrame >> omemem [

	self subclassResponsibility
]

{ #category : 'accessing' }
SymEndFrame >> ppriOeOpEpE: index [

	| qE riOeO ppriOeOpEpE priOeOpEi ppriOeOpEipE ppriOeOpEipEj |
	qE := self qE.
	qE ifNil: [ ppriOeOpEpE := nil ] ifNotNil: [
		riOeO := rOeO at: index.
		ppriOeOpEpE := SymFullMatrix new: 4 by: 4.
		1 to: 4 do: [ :i |
			priOeOpEi := riOeO differentiateWRT: (qE at: i).
			ppriOeOpEipE := ppriOeOpEpE at: i.
			1 to: 4 do: [ :j |
				ppriOeOpEipEj := priOeOpEi differentiateWRT: (qE at: j).
				ppriOeOpEipE at: j put: ppriOeOpEipEj ] ] ].
	^ ppriOeOpEpE
]

{ #category : 'accessing' }
SymEndFrame >> ppriOeOpEpt: index [

	^ nil
]

{ #category : 'accessing' }
SymEndFrame >> ppriOeOptpt: i [

	^ pprOfOptpt at: i
]

{ #category : 'accessing' }
SymEndFrame >> priOeOpE: index [

	| qE riOeO priOeOpE |
	self halt.
	qE := self qE.
	qE ifNil: [ priOeOpE := nil ] ifNotNil: [
		riOeO := rOeO at: index.
		priOeOpE := qE asFullColumn collect: [ :ei | riOeO differentiateWRT: ei ] ].
	^ priOeOpE
]

{ #category : 'accessing' }
SymEndFrame >> priOeOpX: index [

	| qX riOeO priOeOpX |
	qX := self qX.
	qX ifNil: [ priOeOpX := nil ] ifNotNil: [
		riOeO := rOeO at: index.
		priOeOpX := qX collect: [ :xi | riOeO differentiateWRT: xi ] ].
	^ priOeOpX
]

{ #category : 'accessing' }
SymEndFrame >> rOeO [

	^ rOfO
]

{ #category : 'accessing' }
SymEndFrame >> rmem [

	^ rmem
]

{ #category : 'accessing' }
SymEndFrame >> rmem: col [

	1 to: 3 do: [ :i | (rmem at: i) value: (col at: i) asSymbolic ]
]

{ #category : 'accessing' }
SymEndFrame >> theme: col [

	1 to: 3 do: [ :i | (theme at: i) value: (col at: i) ]
]

{ #category : 'accessing' }
SymEndFrame >> vOeO [

	^ vOfO
]
