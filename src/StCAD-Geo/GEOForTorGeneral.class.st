Class {
	#name : 'GEOForTorGeneral',
	#superclass : 'GEOForceTorqueItem',
	#instVars : [
		'markerK',
		'aFIeKe',
		'aTIeKe'
	],
	#category : 'StCAD-Geo-GEO',
	#package : 'StCAD-Geo',
	#tag : 'GEO'
}

{ #category : 'accessing' }
GEOForTorGeneral class >> nameString [

	^ 'GeneralForTor'
]

{ #category : 'VisualWorks metadata' }
GEOForTorGeneral class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : 'accessing' }
GEOForTorGeneral >> aFIeKe [
	^aFIeKe
]

{ #category : 'accessing' }
GEOForTorGeneral >> aFIeKe: col [ 
	aFIeKe := col
]

{ #category : 'DYN' }
GEOForTorGeneral >> aFIeKeFunc [
	| aFIeKeFunc aFIeKei aFIeKeiFunc parser stack func |
	aFIeKeFunc := StMFullColumn new: 3.
	1 to: 3
		do: 
			[:i | 
			aFIeKei := aFIeKe at: i.
			aFIeKei notNil
				ifTrue: 
					[aFIeKeiFunc := aFIeKei isUserFunction
								ifTrue: 
									[parser := self functionParser.
									stack := parser
												parseUserFunction: aFIeKei
												notifying: nil
												ifFail: nil.
									func := stack last.
									func]
								ifFalse: [aFIeKei].
					aFIeKeFunc at: i put: aFIeKeiFunc]].
	^aFIeKeFunc
]

{ #category : 'accessing' }
GEOForTorGeneral >> aMarkerK [
	^markerK
]

{ #category : 'accessing' }
GEOForTorGeneral >> aMarkerK: markerk [ 
	markerK := markerk
]

{ #category : 'accessing' }
GEOForTorGeneral >> aTIeKe [
	^aTIeKe
]

{ #category : 'accessing' }
GEOForTorGeneral >> aTIeKe: col [ 
	aTIeKe := col
]

{ #category : 'DYN' }
GEOForTorGeneral >> aTIeKeFunc [
	| aTIeKeFunc aTIeKei aTIeKeiFunc parser stack func |
	aTIeKeFunc := StMFullColumn new: 3.
	1 to: 3
		do: 
			[:i | 
			aTIeKei := aTIeKe at: i.
			aTIeKei notNil
				ifTrue: 
					[aTIeKeiFunc := aTIeKei isUserFunction
								ifTrue: 
									[parser := self functionParser.
									stack := parser
												parseUserFunction: aTIeKei
												notifying: nil
												ifFail: nil.
									func := stack last.
									func]
								ifFalse: [aTIeKei].
					aTIeKeFunc at: i put: aTIeKeiFunc]].
	^aTIeKeFunc
]

{ #category : 'DYN' }
GEOForTorGeneral >> createMbD [

	| eFrmI eFrmJ mbdForce efrmK aFIeKeFunc aFIeKei aFIeKeiFunc parser stack func aTIeKeFunc aTIeKei aTIeKeiFunc |
	super createMbD.
	eFrmI := markerI mbdObject.
	eFrmJ := markerJ mbdObject.
	mbdForce := markerK == #O
		            ifTrue: [
			            StCAD_MbD_ForTorGeneral onFrmI: eFrmI andFrmJ: eFrmJ "VW_TRANSLATION:StCAD.MbD.ForTorGeneral:StCAD_MbD_ForTorGeneral" ]
		            ifFalse: [
			            efrmK := markerK == #J
				                     ifTrue: [ eFrmJ ]
				                     ifFalse: [ eFrmI ].
			            StCAD_MbD_ForTorGeneral onFrmI: eFrmI andFrmJ: eFrmJ wrtFrmK: efrmK ].
	mbdForce name: self fullName.
	aFIeKeFunc := StMFullColumn new: 3.
	1 to: 3 do: [ :i |
		aFIeKei := aFIeKe at: i.
		aFIeKei notNil ifTrue: [
			aFIeKeiFunc := aFIeKei isUserFunction
				               ifTrue: [
					               parser := self functionParser.
					               stack := parser parseUserFunction: aFIeKei notifying: nil ifFail: nil.
					               func := stack last.
					               func ]
				               ifFalse: [ aFIeKei ].
			aFIeKeiFunc := (aFIeKeiFunc / self mbdUnits force) createMbD simplified.
			aFIeKeFunc at: i put: aFIeKeiFunc ] ].
	mbdForce forceFunctions: aFIeKeFunc.
	aTIeKeFunc := StMFullColumn new: 3.
	1 to: 3 do: [ :i |
		aTIeKei := aTIeKe at: i.
		aTIeKei notNil ifTrue: [
			aTIeKeiFunc := aTIeKei isUserFunction
				               ifTrue: [
					               parser := self functionParser.
					               stack := parser parseUserFunction: aTIeKei notifying: nil ifFail: nil.
					               func := stack last.
					               func ]
				               ifFalse: [ aTIeKei ].
			aTIeKeiFunc := (aTIeKeiFunc / self mbdUnits torque) createMbD simplified.
			aTIeKeFunc at: i put: aTIeKeiFunc ] ].
	mbdForce torqueFunctions: aTIeKeFunc.
	mbdForce submitToSystem.
	self mbdObject: mbdForce.
	[ mbdForce initializeLocally ]
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
GEOForTorGeneral >> cut [
	container cutForTor: self.
	super cut
]

{ #category : 'initialize-release' }
GEOForTorGeneral >> initialize [
	markerK := #I.
	aFIeKe := StMFullColumn new: 3.
	aTIeKe := StMFullColumn new: 3
]

{ #category : 'testing' }
GEOForTorGeneral >> isForce [
	^true
]

{ #category : 'testing' }
GEOForTorGeneral >> isTorque [
	^true
]

{ #category : 'accessing' }
GEOForTorGeneral >> markerK [
	^markerK
]

{ #category : 'accessing' }
GEOForTorGeneral >> markerK: markerk [ 
	markerK := markerk
]

{ #category : 'printing' }
GEOForTorGeneral >> storeOn: aStream level: level [ 
	super storeOn: aStream level: level.
	aStream
		storeLevel: level + 1
		title: 'FxOnI'
		object: (aFIeKe at: 1).
	aStream
		storeLevel: level + 1
		title: 'FyOnI'
		object: (aFIeKe at: 2).
	aStream
		storeLevel: level + 1
		title: 'FzOnI'
		object: (aFIeKe at: 3).
	aStream
		storeLevel: level + 1
		title: 'TxOnI'
		object: (aTIeKe at: 1).
	aStream
		storeLevel: level + 1
		title: 'TyOnI'
		object: (aTIeKe at: 2).
	aStream
		storeLevel: level + 1
		title: 'TzOnI'
		object: (aTIeKe at: 3).
	aStream
		storeLevel: level + 1
		title: 'MarkerK'
		object: (markerK notNil
				ifTrue: [markerK]
				ifFalse: [#I])
]

{ #category : 'accessing' }
GEOForTorGeneral >> uncut [
	container addForTor: self
]

{ #category : 'DYN' }
GEOForTorGeneral >> validateFormulas [
	self aFIeKeFunc.
	self aTIeKeFunc
]
