Class {
	#name : 'ASMTAssembly',
	#superclass : 'ASMTRefContainer',
	#instVars : [
		'filepath',
		'notes',
		'units',
		'time',
		'parts',
		'joints',
		'motions',
		'kinematicIJs',
		'forcesTorques',
		'fields',
		'simulationParameters',
		'animationParameters',
		'itimes',
		'timesAtDiscontinuities',
		'timeSeries'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'parsing' }
ASMTAssembly class >> parseFile: filepath [

	| assembly |
	assembly := self new.
	assembly parseFile: filepath.
	^ assembly
]

{ #category : 'parsing' }
ASMTAssembly class >> runDynFile: filepath [

	| assembly |
	assembly := self new.
	assembly runDynFile: filepath.
	^ assembly
]

{ #category : 'accessing' }
ASMTAssembly >> aAOF [

	^ StMDiagonalMatrix new: 3 withAll: 1.0
]

{ #category : 'adding' }
ASMTAssembly >> addAnimationParameters: aniPara [

	animationParameters := aniPara.
	aniPara sup: self
]

{ #category : 'adding' }
ASMTAssembly >> addGravity: grav [

	fields add: grav.
	grav sup: self
]

{ #category : 'adding' }
ASMTAssembly >> addJoint: joint [

	joints add: joint.
	joint sup: self
]

{ #category : 'adding' }
ASMTAssembly >> addMotion: motion [

	motions add: motion.
	motion sup: self
]

{ #category : 'adding' }
ASMTAssembly >> addPart: part [

	parts add: part.
	part sup: self
]

{ #category : 'adding' }
ASMTAssembly >> addSimulationParameters: simPara [

	simulationParameters := simPara.
	simPara sup: self
]

{ #category : 'accessing' }
ASMTAssembly >> allJoints [

	^ joints
]

{ #category : 'accessing' }
ASMTAssembly >> allMarkers [

	| markerSet |
	markerSet := Set new.
	refs do: [ :ref | ref fillMarkerSet: markerSet ].
	parts do: [ :prt | prt fillMarkerSet: markerSet ].
	^ markerSet
]

{ #category : 'DYN' }
ASMTAssembly >> createMbD [

	| mbdSysSolver simPara |
	super createMbD.
	time createMbD.
	parts asSortedCollection: [ :a :b | a name <= b name ].
	joints asSortedCollection: [ :a :b | a name <= b name ].
	motions asSortedCollection: [ :a :b | a name <= b name ].
	kinematicIJs asSortedCollection: [ :a :b | a name <= b name ].
	forcesTorques asSortedCollection: [ :a :b | a name <= b name ].
	fields asSortedCollection: [ :a :b | a name <= b name ].
	parts do: [ :item | item createMbD ].
	joints do: [ :item | item createMbD ].
	motions do: [ :item | item createMbD ].
	kinematicIJs do: [ :item | item createMbD ].
	forcesTorques do: [ :item | item createMbD ].
	fields do: [ :item | item createMbD ].
	mbdSysSolver := mbdObject mbdSystemSolver.
	simPara := simulationParameters.
	mbdSysSolver errorTolPosKine: simPara errorTolPosKine.
	mbdSysSolver errorTolAccKine: simPara errorTolAccKine.
	mbdSysSolver iterMaxPosKine: simPara iterMaxPosKine.
	mbdSysSolver iterMaxAccKine: simPara iterMaxAccKine.
	mbdSysSolver tstart: simPara tstart / units time.
	mbdSysSolver tend: simPara tend / units time.
	mbdSysSolver hmin: simPara hmin / units time.
	mbdSysSolver hmax: simPara hmax / units time.
	mbdSysSolver hout: simPara hout / units time.
	mbdSysSolver corAbsTol: simPara corAbsTol.
	mbdSysSolver corRelTol: simPara corRelTol.
	mbdSysSolver intAbsTol: simPara intAbsTol.
	mbdSysSolver intRelTol: simPara intRelTol.
	mbdSysSolver iterMaxDyn: simPara iterMaxDyn.
	mbdSysSolver orderMax: simPara orderMax.
	mbdSysSolver translationLimit:
		simPara translationLimit / units length.
	mbdSysSolver rotationLimit: simPara rotationLimit
]

{ #category : 'MbD' }
ASMTAssembly >> createMbDin: mbdInertialFrm [
	"Create MbD in SI units"

	| mbdAssemblyFrm mbdTime mbdSysSolver simPara |
	mbdAssemblyFrm := SymAssemblyFrame new.
	self mbdObject: mbdAssemblyFrm.
	mbdAssemblyFrm name: self name.
	mbdTime := mbdInertialFrm time.
	mbdAssemblyFrm rFfF do: [ :r | r x: mbdTime ].
	mbdAssemblyFrm theOa do: [ :the | the x: mbdTime ].
	mbdInertialFrm addAssemblyFrm: mbdAssemblyFrm.
	time createMbDin: mbdInertialFrm.
	parts asSortedCollection: [ :a :b | a name <= b name ].
	joints asSortedCollection: [ :a :b | a name <= b name ].
	motions asSortedCollection: [ :a :b | a name <= b name ].
	kinematicIJs asSortedCollection: [ :a :b | a name <= b name ].
	forcesTorques asSortedCollection: [ :a :b | a name <= b name ].
	fields asSortedCollection: [ :a :b | a name <= b name ].
	parts do: [ :item | item createMbDin: mbdAssemblyFrm ].
	joints do: [ :item | item createMbDin: mbdAssemblyFrm ].
	motions do: [ :item | item createMbDin: mbdAssemblyFrm ].
	kinematicIJs do: [ :item | item createMbDin: mbdAssemblyFrm ].
	forcesTorques do: [ :item | item createMbDin: mbdAssemblyFrm ].
	fields do: [ :item | item createMbDin: mbdAssemblyFrm ].
	mbdSysSolver := mbdAssemblyFrm solver.
	simPara := simulationParameters.
	mbdSysSolver errorTolPosKine: simPara errorTolPosKine.
	mbdSysSolver errorTolAccKine: simPara errorTolAccKine.
	mbdSysSolver iterMaxPosKine: simPara iterMaxPosKine.
	mbdSysSolver iterMaxAccKine: simPara iterMaxAccKine.
	mbdSysSolver tstart: simPara tstart * units time.
	mbdSysSolver tend: simPara tend * units time.
	mbdSysSolver hmin: simPara hmin * units time.
	mbdSysSolver hmax: simPara hmax * units time.
	mbdSysSolver hout: simPara hout * units time.
	mbdSysSolver corAbsTol: simPara corAbsTol.
	mbdSysSolver corRelTol: simPara corRelTol.
	mbdSysSolver intAbsTol: simPara intAbsTol.
	mbdSysSolver intRelTol: simPara intRelTol.
	mbdSysSolver iterMaxDyn: simPara iterMaxDyn.
	mbdSysSolver orderMax: simPara orderMax.
	mbdSysSolver translationLimit:
		simPara translationLimit * units length.
	mbdSysSolver rotationLimit: simPara rotationLimit
]

{ #category : 'DYN' }
ASMTAssembly >> deleteMbD [

	super deleteMbD.
	time deleteMbD.
	parts do: [ :item | item deleteMbD ].
	joints do: [ :item | item deleteMbD ].
	motions do: [ :item | item deleteMbD ].
	kinematicIJs do: [ :item | item deleteMbD ].
	forcesTorques do: [ :item | item deleteMbD ].
	fields do: [ :item | item deleteMbD ]
]

{ #category : 'initialization' }
ASMTAssembly >> initialize [
	"asmtNum*asmtUnit = siNum*siUnit = mbdNum*mbdUnit"

	super initialize.
	units := Units new.
	time := ASMTTime new.
	time container: self.
	parts := OrderedCollection new.
	joints := OrderedCollection new.
	motions := OrderedCollection new.
	kinematicIJs := OrderedCollection new.
	forcesTorques := OrderedCollection new.
	joints := OrderedCollection new.
	fields := OrderedCollection new.
	timesAtDiscontinuities := OrderedCollection new.
	timeSeries := OrderedCollection new
]

{ #category : 'accessing' }
ASMTAssembly >> mbdObject: mbdAssemblyFrm [

	super mbdObject: mbdAssemblyFrm.
	mbdAssemblyFrm body: self
]

{ #category : 'accessing' }
ASMTAssembly >> omeOFO [

	^ StMFullColumn zero: 3
]

{ #category : 'parsing' }
ASMTAssembly >> parseASMT: lines [

	| name position3D rotationMatrix velocity3D omega3D |
	[ lines removeFirst = 'Assembly' ] assert.
	[ lines removeFirst = '	Notes' ] assert.
	lines removeFirst.
	self parseName: lines.
	self parsePosition3D: lines.
	self parseRotationMatrix: lines.
	self parseVelocity3D: lines.
	self parseOmega3D: lines.
	self parseRefPoints: lines.
	self parseRefCurves: lines.
	self parseRefSurfaces: lines.
	self parseParts: lines.
	self parseKinematicIJs: lines.
	self parseConstraintSets: lines.
	self parseForceTorques: lines.
	self parseConstantGravity: lines.
	self parseSimulationParameters: lines.
	self parseAnimationParameters: lines.
	self parseTimeSeries: lines.
	self parseAssemblySeries: lines.
	self parsePartSeries: lines.
	self parseJointSeries: lines.
	self parseMotionSeries: lines.
	self parseForceTorqueSeries: lines
]

{ #category : 'parsing' }
ASMTAssembly >> parseAnimationParameters: lines [

	| simPara |
	simPara := ASMTAnimationParameters new.
	self addAnimationParameters: simPara.
	simPara parseASMT: lines
]

{ #category : 'parsing' }
ASMTAssembly >> parseAssemblySeries: lines [

	| tokens partName |
	tokens := lines removeFirst substrings.
	[ tokens first = 'AssemblySeries' ] assert.
	partName := tokens second.
	[ self fullName = partName ] assert.
	self parseXs: lines.
	self parseYs: lines.
	self parseZs: lines.
	self parseBryantxs: lines.
	self parseBryantys: lines.
	self parseBryantzs: lines.
	self parseVXs: lines.
	self parseVYs: lines.
	self parseVZs: lines.
	self parseOmegaXs: lines.
	self parseOmegaYs: lines.
	self parseOmegaZs: lines.
	self parseAXs: lines.
	self parseAYs: lines.
	self parseAZs: lines.
	self parseAlphaXs: lines.
	self parseAlphaYs: lines.
	self parseAlphaZs: lines
]

{ #category : 'parsing' }
ASMTAssembly >> parseConstantGravity: lines [

	| gravity |
	gravity := ASMTConstantGravity new.
	self addGravity: gravity.
	gravity parseASMT: lines
]

{ #category : 'parsing' }
ASMTAssembly >> parseConstraintSets: lines [

	| continue type |
	[ lines removeFirst trim = 'ConstraintSets' ] assert.
	continue := true.
	[ continue ] whileTrue: [
		type := lines first trim.
		type = 'Joints'
			ifTrue: [ self parseJoints: lines ]
			ifFalse: [
				type = 'Motions'
					ifTrue: [ self parseMotions: lines ]
					ifFalse: [
						type = 'GeneralConstraintSets'
							ifTrue: [ self parseGeneralConstraintSets: lines ]
							ifFalse: [ continue := false ] ] ] ]
]

{ #category : 'parsing' }
ASMTAssembly >> parseFile: filepath [

	| stream line lines str |
	stream := ZnFastLineReader on: filepath asFileReference readStream.
	[
	lines := OrderedCollection new.
	[ stream atEnd ] whileFalse: [
		line := stream nextLine.
		lines add: line ] ] ensure: [ stream close ].
	str := 'freeCAD: 3D CAD with Motion Simulation  by  askoh.com'.
	[ lines removeFirst = str ] assert.
	self parseASMT: lines
]

{ #category : 'parsing' }
ASMTAssembly >> parseForceTorqueSeries: lines [

	| continue tokens forTorName forTor |
	continue := true.
	[ lines notEmpty and: [ continue ] ] whileTrue: [
		tokens := lines first substrings.
		('*ForceTorqueSeries' match: tokens first)
			ifTrue: [
				forTorName := tokens second.
				forTor := forcesTorques detect: [ :jt | jt fullName = forTorName ].
				forTor parseForceTorqueSeries: lines ]
			ifFalse: [ continue := false ] ]
]

{ #category : 'parsing' }
ASMTAssembly >> parseForceTorques: lines [

	[ lines removeFirst trim = 'ForceTorques' ] assert.
	[ lines first trim = 'ForceTorque' ] whileTrue: [
		self parseForceTorque: lines ]
]

{ #category : 'parsing' }
ASMTAssembly >> parseGeneralConstraintSets: lines [

	[ lines removeFirst trim = 'GeneralConstraintSets' ] assert.
	[ lines first trim = 'GeneralConstraintSet' ] whileTrue: [
		self parseGeneralConstraintSet: lines ]
]

{ #category : 'parsing' }
ASMTAssembly >> parseJointSeries: lines [

	| continue tokens jointName joint |
	continue := true.
	[ lines notEmpty and: [ continue ] ] whileTrue: [
		tokens := lines first substrings.
		('*JointSeries' match: tokens first)
			ifTrue: [
				jointName := tokens second.
				joint := joints detect: [ :jt | jt fullName = jointName ].
				joint parseJointSeries: lines ]
			ifFalse: [ continue := false ] ]
]

{ #category : 'parsing' }
ASMTAssembly >> parseJoints: lines [

	| continue type joint |
	[ lines removeFirst trim = 'Joints' ] assert.
	continue := true.
	[ continue ] whileTrue: [
		type := lines first trim.
		joint := nil.
		type = 'RevoluteJoint' ifTrue: [ joint := ASMTRevoluteJoint new ].
		type = 'CylindricalJoint' ifTrue: [
			joint := ASMTCylindricalJoint new ].
		joint
			ifNil: [
				[ ('*joint' match: type) not ] assert.
				continue := false ]
			ifNotNil: [
				self addJoint: joint.
				joint parseASMT: lines ] ]
]

{ #category : 'parsing' }
ASMTAssembly >> parseKinematicIJs: lines [

	[ lines removeFirst trim = 'KinematicIJs' ] assert.
	[ lines first trim = 'KinematicIJ' ] whileTrue: [
		self parseKinematicIJ: lines ]
]

{ #category : 'parsing' }
ASMTAssembly >> parseMotionSeries: lines [

	| continue tokens motionName motion |
	continue := true.
	[ lines notEmpty and: [ continue ] ] whileTrue: [
		tokens := lines first substrings.
		('*MotionSeries' match: tokens first)
			ifTrue: [
				motionName := tokens second.
				motion := motions detect: [ :mo | mo fullName = motionName ].
				motion parseMotionSeries: lines ]
			ifFalse: [ continue := false ] ]
]

{ #category : 'parsing' }
ASMTAssembly >> parseMotions: lines [

	| continue type motion |
	[ lines removeFirst trim = 'Motions' ] assert.
	continue := true.
	[ continue ] whileTrue: [
		type := lines first trim.
		motion := nil.
		type = 'RotationalMotion' ifTrue: [
			motion := ASMTRotationalMotion new ].
		type = 'TranslationalMotion' ifTrue: [
			motion := ASMTTranslationalMotion new ].
		motion
			ifNil: [
				[ ('*motion' match: type) not ] assert.
				continue := false ]
			ifNotNil: [
				self addMotion: motion.
				motion parseASMT: lines ] ]
]

{ #category : 'parsing' }
ASMTAssembly >> parsePart: lines [

	| part |
	part := ASMTPart new.
	self addPart: part.
	part parseASMT: lines
]

{ #category : 'parsing' }
ASMTAssembly >> parsePartSeries: lines [

	| continue tokens partName part |
	continue := true.
	[ lines notEmpty and: [ continue ] ] whileTrue: [
		tokens := lines first substrings.
		'PartSeries' = tokens first
			ifTrue: [
				partName := tokens second.
				part := parts detect: [ :prt | prt fullName = partName ].
				part parsePartSeries: lines ]
			ifFalse: [ continue := false ] ]
]

{ #category : 'parsing' }
ASMTAssembly >> parseParts: lines [

	[ lines removeFirst trim = 'Parts' ] assert.
	[ lines first trim = 'Part' ] whileTrue: [
		self parsePart: lines ]
]

{ #category : 'parsing' }
ASMTAssembly >> parseSimulationParameters: lines [

	| simPara |
	simPara := ASMTSimulationParameters new.
	self addSimulationParameters: simPara.
	simPara parseASMT: lines
]

{ #category : 'parsing' }
ASMTAssembly >> parseTimeSeries: lines [

	| tokens |
	[ lines removeFirst trim = 'TimeSeries' ] assert.
	tokens := lines removeFirst substrings.
	[ tokens first trim = 'Number' ] assert.
	[ tokens second trim = 'Input' ] assert.
	tokens := lines removeFirst substrings asOrderedCollection.
	[ tokens removeFirst trim = 'Time' ] assert.
	itimes := OrderedCollection ofSize: tokens size.
	[ tokens first trim = 'Input' ] assert.
	itimes at: 1 put: tokens removeFirst trim.
	2 to: tokens size do: [ :i |
	itimes at: i put: (Float readFrom: tokens removeFirst trim) ]
]

{ #category : 'DYN' }
ASMTAssembly >> preMbDrun [

	"Do nothing."
]

{ #category : 'accessing' }
ASMTAssembly >> rOFO [

	^ StMFullColumn zero: 3
]

{ #category : 'accessing' }
ASMTAssembly >> root [

	^ self
]

{ #category : 'run' }
ASMTAssembly >> runDYNAMIC [

	| inertialFrm |
	inertialFrm := SymInertialFrame new.
	self createMbDin: inertialFrm.
	inertialFrm runDYNAMIC
]

{ #category : 'parsing' }
ASMTAssembly >> runDynFile: filepath [

	self parseFile: filepath.
	self runDYNAMIC
]

{ #category : 'accessing' }
ASMTAssembly >> units [

	^ units
]

{ #category : 'accessing' }
ASMTAssembly >> units: anObject [

	units := anObject
]

{ #category : 'accessing' }
ASMTAssembly >> vOFO [

	^ StMFullColumn zero: 3
]
