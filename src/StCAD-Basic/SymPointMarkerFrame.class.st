Class {
	#name : 'SymPointMarkerFrame',
	#superclass : 'SymMarkerFrame',
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'calc' }
SymPointMarkerFrame >> calcPostDynCorrectorIteration [

	
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
