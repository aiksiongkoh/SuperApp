Class {
	#name : 'SymPointMarkerFrame',
	#superclass : 'SymMarkerFrame',
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'calc' }
SymPointMarkerFrame >> calcPostDynCorrectorIteration [

	
]

{ #category : 'calc' }
SymPointMarkerFrame >> calcomeOmO [

	^ sup omeOpO
]

{ #category : 'accessing' }
SymPointMarkerFrame >> calcvOmO [

	^ sup vOpO + (sup pAOppt timesFullColumn: self rpmp)
]

{ #category : 'accessing' }
SymPointMarkerFrame >> omeOmO [

	^ omeOmO
]

{ #category : 'accessing' }
SymPointMarkerFrame >> omepmp [
	self shouldBeImplemented.
]

{ #category : 'accessing' }
SymPointMarkerFrame >> pAOmpt [

	| time |
	time := self time.
	^ aAOf collect: [ :row | row collect: [ :aij | (aij differentiateWRT: time) simplified ] ]
]

{ #category : 'accessing' }
SymPointMarkerFrame >> vOmO [

	^ vOfO
]
