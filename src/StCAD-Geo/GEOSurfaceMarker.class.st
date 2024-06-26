Class {
	#name : 'GEOSurfaceMarker',
	#superclass : 'GEOAnyMarker',
	#instVars : [
		's',
		'rFfFSurface'
	],
	#category : 'StCAD-Geo-GEO',
	#package : 'StCAD-Geo',
	#tag : 'GEO'
}

{ #category : 'accessing' }
GEOSurfaceMarker class >> nameString [
	^'SurfaceMarker'
]

{ #category : 'instance creation' }
GEOSurfaceMarker class >> newOnFace: face [ 
	^super new face: face
]

{ #category : 'VisualWorks metadata' }
GEOSurfaceMarker class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : 'accessing' }
GEOSurfaceMarker >> aAeqnfat: col [ 
	| prmemps tem1 tem2 iem kem jem aAme |
	prmemps := rFfFSurface pvalueps: col.
	tem1 := prmemps column: 1.
	tem2 := prmemps column: 2.
	iem := tem1 normalizeSelf.
	kem := (iem cross: tem2) normalizeSelf.
	jem := kem cross: iem.
	aAme := StMFullMatrix new: 3 by: 3.
	(aAme at: 1) at: 1 put: (iem at: 1); at: 2 put: (jem at: 1); at: 3 put: (kem at: 1).
	(aAme at: 2) at: 1 put: (iem at: 2); at: 2 put: (jem at: 2); at: 3 put: (kem at: 2).
	(aAme at: 3) at: 1 put: (iem at: 3); at: 2 put: (jem at: 3); at: 3 put: (kem at: 3).
	^aAme
]

{ #category : 'accessing' }
GEOSurfaceMarker >> aApm [
	| aAPp aAPm |
	aAPp := self anyPart aAPp.
	aAPm := refFrame refFrame aAFf.
	^aAPp transposeTimesFullMatrix: aAPm
]

{ #category : 'rendering' }
GEOSurfaceMarker >> basicRenderOn: aRenderingContext [ 
	super renderOn: aRenderingContext
]

{ #category : 'DYN' }
GEOSurfaceMarker >> canUpdateForFrame: integer [ 
	^[(self dataSeries at: integer) notNil]
		on: Object subscriptOutOfBoundsSignal do: [:ex | ex return: false]
]

{ #category : 'DYN' }
GEOSurfaceMarker >> createMbD [
	| sSize mkr eFrm |
	sSize := 2.
	self dataSeries: OrderedCollection new.
	self discontinuities: OrderedCollection new.
	mkr := MbDMarkerFrame new.
	mkr isOn: self anyPart mbdObject partFrame.
	mkr rpmp: self rpmp / self mbdUnits length.
	mkr aApm: self aApm.
	eFrm := MbDEndFrameqcs new.
	eFrm name: self fullName.
	eFrm isOn: mkr.
	eFrm rmemBlk: rFfFSurface / self mbdUnits length.
	eFrm sSize: sSize.
	eFrm s: (StMFullColumn zero: sSize).
	eFrm sdot: (StMFullColumn zero: sSize).
	eFrm submitToSystem.
	self mbdObject: eFrm
]

{ #category : 'accessing' }
GEOSurfaceMarker >> cut [
	container cutMarker: self.
	rFfFSurface refFrame cut.
	self triggerEvent: #release
]

{ #category : 'accessing' }
GEOSurfaceMarker >> dataClass [
	^GEORelPosVelAccData
]

{ #category : 'DYN' }
GEOSurfaceMarker >> dataFromCurrentState [
	| answer |
	answer := GEOSSdotSddotData new.
	answer s: s.
	answer sdot: (StMArray zero: 2).
	answer sddot: (StMArray zero: 2).
	^answer
]

{ #category : 'printing' }
GEOSurfaceMarker >> dataFromCurrentStatePOV [
	"
	reqnfeqn := eqn y: s.
	rPfP := rPeqnP + aAPeqn*reqnfeqn.
	rOfO := rOPO + aAOP*rPfP.
	aAeqnf := self aAeqnf.
	aAPf := aAPeqn * aAeqnf.
	aAOf := aAOP * aAPf.
	"

	| markerFrame eqnFrame partFrame rPeqnP aAPeqn partData markerData rOPO aAOP vOPO omeOPO aOPO alpOPO reqnfeqn aAeqnf rPfP aAPf rPfO scol |
	markerFrame := self refFrame.
	eqnFrame := markerFrame refFrame.
	partFrame := eqnFrame refFrame.
	rPeqnP := eqnFrame rFfF.
	aAPeqn := eqnFrame aAFf.
	partData := partFrame body dataFromCurrentState.
	markerData := self dataClass new.
	markerData time: self geoTime value.
	rOPO := partData rOfO.
	aAOP := partData aAOf.
	vOPO := partData vOfO.
	omeOPO := partData omeOfO.
	aOPO := partData aOfO.
	alpOPO := partData alpOfO.
	scol := StMFullColumn with: s.
	reqnfeqn := self rFfFat: scol.
	aAeqnf := self aAeqnfat: scol.
	rPfP := rPeqnP + (aAPeqn timesFullColumn: reqnfeqn).
	aAPf := aAPeqn timesFullMatrix: aAeqnf.
	rPfO := aAOP timesFullColumn: rPfP.
	markerData rOfO: rOPO + rPfO.
	markerData aAOf: (aAOP timesFullMatrix: aAPf).
	markerData vOfO: vOPO + (omeOPO cross: rPfO).
	markerData omeOfO: omeOPO.
	markerData 
		aOfO: aOPO + (alpOPO cross: rPfO) + (omeOPO cross: (omeOPO cross: rPfO)).
	markerData alpOfO: alpOPO.
	^markerData
]

{ #category : 'DYN' }
GEOSurfaceMarker >> dataFromMbD [
	| mbdTime mbdItem answer |
	mbdTime := self mbdUnits time.
	mbdItem := self mbdObject.
	answer := GEOSSdotSddotData new.
	answer s: mbdItem s copy.
	answer sdot: mbdItem sdot copy / mbdTime.
	answer sddot: mbdItem sddot copy / (mbdTime * mbdTime).
	^answer
]

{ #category : 'accessing' }
GEOSurfaceMarker >> dataSeriesForChart [
	"
	reqnfeqn := eqn y: s.
	rPfP := rPeqnP + aAPeqn*reqnfeqn.
	rOfO := rOPO + aAOP*rPfP.
	aAeqnf := self aAeqnf.
	aAPf := aAPeqn * aAeqnf.
	aAOf := aAOP * aAPf.
	Only the material point velocity and accelerations are calculated. Not the contact point in space.
	"

	| markerFrame eqnFrame rPeqnP aAPeqn timeSeries partDataSeries dataSeries index markerData rOPO aAOP vOPO omeOPO aOPO alpOPO reqnfeqn aAeqnf rPfP aAPf rPfO zero |
	markerFrame := self refFrame.
	eqnFrame := markerFrame refFrame.
	rPeqnP := eqnFrame rFfF.
	aAPeqn := eqnFrame aAFf.
	timeSeries := self interface timeSeries.
	^timeSeries notNil 
		ifTrue: 
			[partDataSeries := container dataSeries.
			dataSeries := self dataSeries.
			index := 0.
			partDataSeries collect: 
					[:partData | 
					index := index + 1.
					markerData := self dataClass new.
					markerData time: (timeSeries at: index).
					rOPO := partData rOfO.
					aAOP := partData aAOf.
					vOPO := partData vOfO.
					omeOPO := partData omeOfO.
					aOPO := partData aOfO.
					alpOPO := partData alpOfO.
					reqnfeqn := self rFfFat: (dataSeries at: index) s.
					aAeqnf := self aAeqnfat: (dataSeries at: index) s.
					rPfP := rPeqnP + (aAPeqn timesFullColumn: reqnfeqn).
					aAPf := aAPeqn timesFullMatrix: aAeqnf.
					rPfO := aAOP timesFullColumn: rPfP.
					markerData rFfF: reqnfeqn.
					markerData aAFf: aAeqnf.
					zero := (StMFullColumn zero: 3).
					markerData vFfF: zero.
					markerData omeFfF: zero.
					markerData aFfF: zero.
					markerData alpFfF: zero.
					markerData rOfO: rOPO + rPfO.
					markerData aAOf: (aAOP timesFullMatrix: aAPf).
					markerData vOfO: vOPO + (omeOPO cross: rPfO).
					markerData omeOfO: omeOPO.
					markerData 
						aOfO: aOPO + (alpOPO cross: rPfO) + (omeOPO cross: (omeOPO cross: rPfO)).
					markerData alpOfO: alpOPO]]
		ifFalse: [Array new]
]

{ #category : 'accessing' }
GEOSurfaceMarker >> face: face [ 
	| interface name polyline rFpointsF sSeries |
	interface := face interface.
	name := interface promptUserForMarkerNameIn: face part.
	self name: name.
	polyline := face polyline.
	rFpointsF := polyline rfpointsf.
	sSeries := Interval
				from: -1.0
				to: 1.0
				by: 2.0 / (rFpointsF size - 1).
	rFfFSurface rfpfEqn: (StMGeneralSplineX
			with: StMIndependentVariable new
			order: 5
			xs: sSeries
			ys: rFpointsF).
	self s: -1.0.
	face addSurfaceMarker: self.
	interface createUpdateSelectGOfor: self
]

{ #category : 'testing' }
GEOSurfaceMarker >> isCutable [
	^false
]

{ #category : 'initialize-release' }
GEOSurfaceMarker >> preSave [
	super preSave.
	rFfFSurface preSave
]

{ #category : 'accessing' }
GEOSurfaceMarker >> rFfFSurface [
	^rFfFSurface
]

{ #category : 'accessing' }
GEOSurfaceMarker >> rFfFat: col [ 
	^rFfFSurface rfpfEqn value: col
]

{ #category : 'rendering' }
GEOSurfaceMarker >> renderOn: aRenderingContext [ 
	rFfFSurface renderOn: aRenderingContext withSurfaceMarker: self
]

{ #category : 'accessing' }
GEOSurfaceMarker >> rpmp [
	| anyPart rPmP rPpP aAPp |
	anyPart := self anyPart.
	rPmP := refFrame refFrame rFfF.
	rPpP := anyPart rPcmP.
	aAPp := anyPart aAPp.
	^aAPp transposeTimesFullColumn: (rPmP minusFullColumn: rPpP)
]

{ #category : 'accessing' }
GEOSurfaceMarker >> s [
	^s
]

{ #category : 'accessing' }
GEOSurfaceMarker >> s: col [ 
	| rFfF prmemps tem1 tem2 iem kem jem aAFf |
	s := col.
	rFfF := rFfFSurface value: s.
	prmemps := rFfFSurface pvalueps: s.
	tem1 := prmemps column: 1.
	tem2 := prmemps column: 2.
	iem := tem1 normalizeSelf.
	kem := (iem cross: tem2) normalizeSelf.
	jem := kem cross: iem.
	aAFf := StMFullMatrix new: 3 by: 3.
	(aAFf at: 1) at: 1 put: (iem at: 1); at: 2 put: (jem at: 1); at: 3 put: (kem at: 1).
	(aAFf at: 2) at: 1 put: (iem at: 2); at: 2 put: (jem at: 2); at: 3 put: (kem at: 2).
	(aAFf at: 3) at: 1 put: (iem at: 3); at: 2 put: (jem at: 3); at: 3 put: (kem at: 3).
	refFrame quietlyrFfF: rFfF aAFf: aAFf
]

{ #category : 'accessing' }
GEOSurfaceMarker >> sets: col [ 
	s := col
]

{ #category : 'DYN' }
GEOSurfaceMarker >> storeInputState [
	| data |
	data := self dataFromCurrentState.
	self inputData: data
]

{ #category : 'printing' }
GEOSurfaceMarker >> storeOn: aStream level: level [ 
	aStream storeLevel: level title: 'RefSurface'.
	rFfFSurface refFrame storeOn: aStream level: level + 1.
	rFfFSurface rfpfEqn storeOn: aStream level: level + 1.
	aStream storeLevel: level + 1 title: 'SurfaceMarkers'.
	aStream storeLevel: level + 2 title: 'SurfaceMarker'.
	aStream
		storeLevel: level + 3
		title: 'Name'
		object: self name.
	aStream
		storeLevel: level + 3
		title: 's'
		object: s
]

{ #category : 'printing' }
GEOSurfaceMarker >> storePOVdatCurrentOn: aStream [
	| dataSeries fullNamePOV series |
	dataSeries := Array with: self dataFromCurrentStatePOV.
	fullNamePOV := self fullNamePOV.
	series := dataSeries collect: [:data | data rOfO.].
	aStream storePOVTitle: fullNamePOV , '_X'
		series: (series collect: [:data | data at: 1.]).
	aStream storePOVTitle: fullNamePOV , '_Y'
		series: (series collect: [:data | data at: 2.]).
	aStream storePOVTitle: fullNamePOV , '_Z'
		series: (series collect: [:data | data at: 3.]).
	series := dataSeries
				collect: [:data | GEOEulerAngleszyx fromA: data aAOf.].
	aStream storePOVTitle: fullNamePOV , '_RotX'
		series: (series collect: [:data | (data at: 3) radiansToDegrees.]).
	aStream storePOVTitle: fullNamePOV , '_RotY'
		series: (series collect: [:data | (data at: 2) radiansToDegrees.]).
	aStream storePOVTitle: fullNamePOV , '_RotZ'
		series: (series collect: [:data | (data at: 1) radiansToDegrees.]).
	series := dataSeries collect: [:data | data vOfO.].
	aStream storePOVTitle: fullNamePOV , '_VX'
		series: (series collect: [:data | data at: 1.]).
	aStream storePOVTitle: fullNamePOV , '_VY'
		series: (series collect: [:data | data at: 2.]).
	aStream storePOVTitle: fullNamePOV , '_VZ'
		series: (series collect: [:data | data at: 3.]).
	series := dataSeries collect: [:data | data omeOfO.].
	aStream storePOVTitle: fullNamePOV , '_OmegaX'
		series: (series collect: [:data | (data at: 1) radiansToDegrees.]).
	aStream storePOVTitle: fullNamePOV , '_OmegaY'
		series: (series collect: [:data | (data at: 2) radiansToDegrees.]).
	aStream storePOVTitle: fullNamePOV , '_OmegaZ'
		series: (series collect: [:data | (data at: 3) radiansToDegrees.]).
	series := dataSeries collect: [:data | data aOfO.].
	aStream storePOVTitle: fullNamePOV , '_AX'
		series: (series collect: [:data | data at: 1.]).
	aStream storePOVTitle: fullNamePOV , '_AY'
		series: (series collect: [:data | data at: 2.]).
	aStream storePOVTitle: fullNamePOV , '_AZ'
		series: (series collect: [:data | data at: 3.]).
	series := dataSeries collect: [:data | data alpOfO.].
	aStream storePOVTitle: fullNamePOV , '_AlphaX'
		series: (series collect: [:data | (data at: 1) radiansToDegrees.]).
	aStream storePOVTitle: fullNamePOV , '_AlphaY'
		series: (series collect: [:data | (data at: 2) radiansToDegrees.]).
	aStream storePOVTitle: fullNamePOV , '_AlphaZ'
		series: (series collect: [:data | (data at: 3) radiansToDegrees.]).
]

{ #category : 'accessing' }
GEOSurfaceMarker >> uncut [
	rFfFSurface refFrame uncut.
	container uncutMarker: self
]

{ #category : 'DYN' }
GEOSurfaceMarker >> updateForFrame: integer [ 
	| data |
	data := self dataSeries at: integer.
	self s: data s
]

{ #category : 'DYN' }
GEOSurfaceMarker >> updateFromInitiallyAssembledState [
	| dataSeries data |
	dataSeries := self dataSeries.
	dataSeries notNil 
		ifTrue: 
			[data := dataSeries at: 1.
			data notNil ifTrue: [self s: data s]]
]

{ #category : 'DYN' }
GEOSurfaceMarker >> updateFromInputState [
	| data |
	data := self inputData.
	data notNil ifTrue: [self s: data s]
]

{ #category : 'DYN' }
GEOSurfaceMarker >> updateFromMbD [
	| data |
	data := self dataFromMbD.
	self dataSeries add: data.
	self s: data s
]
