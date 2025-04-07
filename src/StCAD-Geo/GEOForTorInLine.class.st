Class {
	#name : 'GEOForTorInLine',
	#superclass : 'GEOForceTorqueItem',
	#instVars : [
		'tensionFunc',
		'twistFunc'
	],
	#category : 'StCAD-Geo-GEO',
	#package : 'StCAD-Geo',
	#tag : 'GEO'
}

{ #category : 'accessing' }
GEOForTorInLine class >> nameString [

	^ 'InLineForTor'
]

{ #category : 'VisualWorks metadata' }
GEOForTorInLine class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : 'DYN' }
GEOForTorInLine >> createMbD [

	| eFrmI eFrmJ mbdForTorInLine tension parser stack func twist |
	super createMbD.
	eFrmI := markerI mbdObject.
	eFrmJ := markerJ mbdObject.
	mbdForTorInLine := StCAD_MbD_ForTorInLine onFrmI: eFrmI andFrmJ: eFrmJ. "VW_TRANSLATION:StCAD.MbD.ForTorInLine:StCAD_MbD_ForTorInLine"
	mbdForTorInLine name: self fullName.
	tension := tensionFunc notNil
		           ifTrue: [
			           func := tensionFunc isUserFunction
				                   ifTrue: [
					                   parser := self functionParser.
					                   stack := parser parseUserFunction: tensionFunc notifying: nil ifFail: nil.
					                   stack last ]
				                   ifFalse: [ tensionFunc ].
			           (func / self mbdUnits force) createMbD simplified ]
		           ifFalse: [ nil ].
	mbdForTorInLine tension: tension.
	twist := twistFunc notNil
		         ifTrue: [
			         func := twistFunc isUserFunction
				                 ifTrue: [
					                 parser := self functionParser.
					                 stack := parser parseUserFunction: twistFunc notifying: nil ifFail: nil.
					                 stack last ]
				                 ifFalse: [ twistFunc ].
			         (func / self mbdUnits torque) createMbD simplified ]
		         ifFalse: [ nil ].
	mbdForTorInLine twist: twist.
	mbdForTorInLine submitToSystem.
	self mbdObject: mbdForTorInLine.
	[ mbdForTorInLine initializeLocally ]
		on: self messageNotUnderstoodSignal
		do: [ :ex |
			| sel |
			sel := ex parameter selector.
			sel == #isKineIJ
				ifTrue: [
					Dialog warn:
						'ForTor function cannot use a ''geoIJ'' that also uses marker I of a motion constraint.<n>Just create extra markers and geoIJs.'
							expandMacros.
					SimulationStoppingError signal ]
				ifFalse: [ ex pass ] ]
]

{ #category : 'accessing' }
GEOForTorInLine >> cut [
	container cutForTor: self.
	super cut
]

{ #category : 'testing' }
GEOForTorInLine >> isForce [
	^true
]

{ #category : 'testing' }
GEOForTorInLine >> isTorque [
	^false
]

{ #category : 'printing' }
GEOForTorInLine >> storeOn: aStream level: level [ 
	super storeOn: aStream level: level.
	aStream
		storeLevel: level + 1
		title: 'tension'
		object: tensionFunc.
	aStream
		storeLevel: level + 1
		title: 'twist'
		object: twistFunc
]

{ #category : 'DYN' }
GEOForTorInLine >> tension [
	| parser stack |
	^tensionFunc notNil
		ifTrue: [tensionFunc isUserFunction
				ifTrue: 
					[parser := self functionParser.
					stack := parser
								parseUserFunction: tensionFunc
								notifying: nil
								ifFail: nil.
					stack last]
				ifFalse: [tensionFunc]]
		ifFalse: [nil]
]

{ #category : 'accessing' }
GEOForTorInLine >> tensionFunc [
	^tensionFunc
]

{ #category : 'accessing' }
GEOForTorInLine >> tensionFunc: userFunc [ 
	tensionFunc := userFunc
]

{ #category : 'DYN' }
GEOForTorInLine >> twist [
	| parser stack |
	^twistFunc notNil
		ifTrue: [twistFunc isUserFunction
				ifTrue: 
					[parser := self functionParser.
					stack := parser
								parseUserFunction: twistFunc
								notifying: nil
								ifFail: nil.
					stack last]
				ifFalse: [twistFunc]]
		ifFalse: [nil]
]

{ #category : 'accessing' }
GEOForTorInLine >> twistFunc [
	^twistFunc
]

{ #category : 'accessing' }
GEOForTorInLine >> twistFunc: userFunc [ 
	twistFunc := userFunc
]

{ #category : 'accessing' }
GEOForTorInLine >> uncut [
	container addForTor: self
]

{ #category : 'DYN' }
GEOForTorInLine >> validateFormulas [
	self tension.
	self twist
]
