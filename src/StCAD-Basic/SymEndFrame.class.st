Class {
	#name : 'SymEndFrame',
	#superclass : 'SymDependentFrame',
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'accessing' }
SymEndFrame >> aAOe [

	^ aAOf
]

{ #category : 'accessing' }
SymEndFrame >> aAjOe: j [

	^ aAOf column: j
]

{ #category : 'accessing' }
SymEndFrame >> aAme [

	^ aAFf
]

{ #category : 'accessing' }
SymEndFrame >> initVariables [

	| t block selffullName |
	t := self time.
	rFfF do: [ :r | r x: t ].
	selffullName := self fullName.
	block := [ :var |
		         | fullName |
		         fullName := String new writeStream
			                     nextPutAll: selffullName;
			                     nextPut: $/;
			                     nextPutAll: var name;
			                     contents.
		         var name: fullName asSymbol ].
	rFfF do: block
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

	^ self omeOfO
]

{ #category : 'accessing' }
SymEndFrame >> omemem [

	self subclassResponsibility
]

{ #category : 'accessing' }
SymEndFrame >> ppriOeOpEpE: index [

	| qE rOeO riOeO ppriOeOpEpE priOeOpEi ppriOeOpEipE ppriOeOpEipEj |
	rOeO := rOfO.
	qE := self qE.
	^ qE ifNotNil: [
			  riOeO := rOeO at: index.
			  ppriOeOpEpE := SymFullMatrix new: 4 by: 4.
			  1 to: 4 do: [ :i |
					  priOeOpEi := (riOeO differentiateWRT: (qE at: i)) simplified.
					  ppriOeOpEipE := ppriOeOpEpE at: i.
					  1 to: 4 do: [ :j |
							  ppriOeOpEipEj := priOeOpEi differentiateWRT: (qE at: j).
							  ppriOeOpEipE at: j put: ppriOeOpEipEj simplified ] ].
			  ppriOeOpEpE ]
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

	| qE rOeO |
	rOeO := rFfF.
	qE := self qE.
	^ qE ifNotNil: [ (rOeO at: index) differentiateWRT: qE asFullColumn ]
]

{ #category : 'accessing' }
SymEndFrame >> priOeOpX: index [

	| qX rOeO |
	rOeO := rFfF.
	qX := self qX.
	^ qX ifNotNil: [ (rOeO at: index) differentiateWRT: qX asFullColumn ]
]

{ #category : 'accessing' }
SymEndFrame >> rOeO [

	^ rOfO
]

{ #category : 'accessing' }
SymEndFrame >> rmem [

	^ rFfF
]

{ #category : 'accessing' }
SymEndFrame >> rmem: col [

	self rFfF: col
]

{ #category : 'accessing' }
SymEndFrame >> theme: col [

	1 to: 3 do: [ :i | (theFf at: i) rhs: (col at: i) ].
	theFf := theFf simplified
]

{ #category : 'accessing' }
SymEndFrame >> vOeO [

	^ prOfOpt
]
