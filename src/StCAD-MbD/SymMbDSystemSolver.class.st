Class {
	#name : 'SymMbDSystemSolver',
	#superclass : 'SymMbDSolver',
	#instVars : [
		'parts',
		'jointsMotions',
		'sensors',
		'variables',
		'icTypeSolver',
		'setsOfRedundantConstraints',
		'errorTolPosKine',
		'errorTolAccKine',
		'iterMaxPosKine',
		'iterMaxAccKine',
		'basicIntegrator',
		'tstartPasts',
		'tstart',
		'hmin',
		'hmax',
		'tend',
		'toutFirst',
		'hout',
		'direction',
		'corAbsTol',
		'corRelTol',
		'intAbsTol',
		'intRelTol',
		'iterMaxDyn',
		'orderMax',
		'translationLimit',
		'rotationLimit',
		'forTors'
	],
	#category : 'StCAD-MbD-MbDSolver',
	#package : 'StCAD-MbD',
	#tag : 'MbDSolver'
}

{ #category : 'VisualWorks metadata' }
SymMbDSystemSolver class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'accessing' }
SymMbDSystemSolver >> allConstraints [
	^system allConstraints
]

{ #category : 'accessing' }
SymMbDSystemSolver >> allRedundantConstraints [
	^system allRedundantConstraints
]

{ #category : 'accessing' }
SymMbDSystemSolver >> contactEndFrames [
	^system contactEndFrames
]

{ #category : 'accessing' }
SymMbDSystemSolver >> corAbsTol: double [ 
	corAbsTol := double
]

{ #category : 'accessing' }
SymMbDSystemSolver >> corRelTol: double [ 
	corRelTol := double
]

{ #category : 'accessing' }
SymMbDSystemSolver >> correctorAbsoluteTolerance [
	^corAbsTol == nil
		ifTrue: [1.0d-6]
		ifFalse: [corAbsTol]
]

{ #category : 'accessing' }
SymMbDSystemSolver >> correctorRelativeTolerance [
	^corRelTol == nil
		ifTrue: [1.0d-6]
		ifFalse: [corRelTol]
]

{ #category : 'run' }
SymMbDSystemSolver >> discontinuityBlock [
	^
	[:ex | 
	"daeIntegrator should have found the transition point"

	"It has told system to change to the new topology."

	| discontinuityTypes |
	discontinuityTypes := ex parameter.
	(discontinuityTypes includes: #REBOUND) 
		ifTrue: 
			[self runAllIC.
			ex restart]
		ifFalse: 
			[(discontinuityTypes 
				contains: [:type | #(#LIFTOFF #BROKENJOINT) includes: type]) 
					ifTrue: 
						[self runAllIC.
						ex restart]
					ifFalse: 
						[(discontinuityTypes 
							contains: [:type | #(#TOUCHDOWN #PIECEWISEFORCE #PIECEWISEMOTION) includes: type]) 
								ifTrue: 
									[self runAllIC.
									ex restart]
								ifFalse: [self error: 'An unknown discontinuity has been found.']]]]
]

{ #category : 'accessing' }
SymMbDSystemSolver >> displacementConstraints [
	^system displacementConstraints
]

{ #category : 'accessing' }
SymMbDSystemSolver >> endTime [
	^tend
]

{ #category : 'accessing' }
SymMbDSystemSolver >> errorTol [
	^intRelTol == nil
		ifTrue: [1.0d-6]
		ifFalse: [intRelTol]
]

{ #category : 'accessing' }
SymMbDSystemSolver >> errorTol: double [ 
	errorTolPosKine := double.
	errorTolAccKine := double.
	corAbsTol := double.
	corRelTol := double.
	intAbsTol := double.
	intRelTol := double
]

{ #category : 'accessing' }
SymMbDSystemSolver >> errorTolAccKine [
	^errorTolAccKine == nil
		ifTrue: [1.0d-6]
		ifFalse: [errorTolAccKine]
]

{ #category : 'accessing' }
SymMbDSystemSolver >> errorTolAccKine: double [ 
	errorTolAccKine := double
]

{ #category : 'accessing' }
SymMbDSystemSolver >> errorTolPosKine [
	^errorTolPosKine == nil
		ifTrue: [1.0d-6]
		ifFalse: [errorTolPosKine]
]

{ #category : 'accessing' }
SymMbDSystemSolver >> errorTolPosKine: double [ 
	errorTolPosKine := double
]

{ #category : 'accessing' }
SymMbDSystemSolver >> essentialConstraints2 [
	^system essentialConstraints2
]

{ #category : 'accessing' }
SymMbDSystemSolver >> firstOutputTime [
	^toutFirst
]

{ #category : 'run' }
SymMbDSystemSolver >> followPart: aPart [ 
	self initializeLocally.
	self initializeGlobally.
	icTypeSolver := MbDDragPosICNewtonRaphson2 new.
	icTypeSolver dragPart: aPart.
	icTypeSolver system: self.
	icTypeSolver run
]

{ #category : 'accessing' }
SymMbDSystemSolver >> gSubC [
	^system gSubC
]

{ #category : 'accessing' }
SymMbDSystemSolver >> hmax [
	^hmax == nil
		ifTrue: [1.0]
		ifFalse: [hmax]
]

{ #category : 'accessing' }
SymMbDSystemSolver >> hmax: double [ 
	hmax := double
]

{ #category : 'accessing' }
SymMbDSystemSolver >> hmin [
	^hmin == nil
		ifTrue: [1.0d-9]
		ifFalse: [hmin]
]

{ #category : 'accessing' }
SymMbDSystemSolver >> hmin: double [ 
	hmin := double
]

{ #category : 'accessing' }
SymMbDSystemSolver >> hout [
	^hout == nil
		ifTrue: [direction * 0.1]
		ifFalse: [hout]
]

{ #category : 'accessing' }
SymMbDSystemSolver >> hout: double [ 
	hout := double
]

{ #category : 'initialize-release' }
SymMbDSystemSolver >> initialize [
	tstartPasts := OrderedCollection new
]

{ #category : 'initialize-release' }
SymMbDSystemSolver >> initializeGlobally [
	parts := system parts.
	jointsMotions := system jointsMotions.
	forTors := system forTors.
	sensors := system sensors.
	variables := system variables
]

{ #category : 'initialize-release' }
SymMbDSystemSolver >> initializeLocally [
	"Prepare for a new set of sets of redundant constraints."

	setsOfRedundantConstraints := OrderedCollection new.
	direction := tstart < tend
				ifTrue: [1.0]
				ifFalse: [-1.0].
	toutFirst == nil ifTrue: [toutFirst := tstart + (direction * hout)]
]

{ #category : 'accessing' }
SymMbDSystemSolver >> intAbsTol: double [ 
	intAbsTol := double
]

{ #category : 'accessing' }
SymMbDSystemSolver >> intRelTol: double [ 
	intRelTol := double
]

{ #category : 'accessing' }
SymMbDSystemSolver >> integrationAbsoluteTolerance [
	^intAbsTol == nil
		ifTrue: [1.0d-6]
		ifFalse: [intAbsTol]
]

{ #category : 'accessing' }
SymMbDSystemSolver >> integrationRelativeTolerance [
	^intRelTol == nil
		ifTrue: [1.0d-6]
		ifFalse: [intRelTol]
]

{ #category : 'accessing' }
SymMbDSystemSolver >> istep [
	^basicIntegrator istep
]

{ #category : 'accessing' }
SymMbDSystemSolver >> iterMaxAccKine [
	^iterMaxAccKine == nil
		ifTrue: [25]
		ifFalse: [iterMaxAccKine]
]

{ #category : 'accessing' }
SymMbDSystemSolver >> iterMaxAccKine: integer [ 
	iterMaxAccKine := integer
]

{ #category : 'accessing' }
SymMbDSystemSolver >> iterMaxDyn [
	^iterMaxDyn == nil
		ifTrue: [4]
		ifFalse: [iterMaxDyn]
]

{ #category : 'accessing' }
SymMbDSystemSolver >> iterMaxDyn: integer [ 
	iterMaxDyn := integer
]

{ #category : 'accessing' }
SymMbDSystemSolver >> iterMaxPosKine [
	^iterMaxPosKine == nil
		ifTrue: [25]
		ifFalse: [iterMaxPosKine]
]

{ #category : 'accessing' }
SymMbDSystemSolver >> iterMaxPosKine: integer [ 
	iterMaxPosKine := integer
]

{ #category : 'accessing' }
SymMbDSystemSolver >> jointsMotions [
	^jointsMotions
]

{ #category : 'output' }
SymMbDSystemSolver >> logString: string [ 
	system logString: string
]

{ #category : 'output' }
SymMbDSystemSolver >> logString: string withArgument: string1 [ 
	system logString: string withArgument: string1
]

{ #category : 'output' }
SymMbDSystemSolver >> logString: string withArguments: arrayOfStrings [ 
	system logString: string withArguments: arrayOfStrings
]

{ #category : 'accessing' }
SymMbDSystemSolver >> maxStepSize [
	^hmax == nil
		ifTrue: [1.0]
		ifFalse: [hmax]
]

{ #category : 'accessing' }
SymMbDSystemSolver >> minStepSize [
	^hmin == nil
		ifTrue: [1.0d-9]
		ifFalse: [hmin]
]

{ #category : 'run' }
SymMbDSystemSolver >> needToRedoPosIC [
	| allRedunCons newSet |
	allRedunCons := self allRedundantConstraints.
	newSet := (allRedunCons collect: [:i | i constraint name]) 
				asSortedCollection.
	newSet isEmpty ifTrue: [^false].
	(setsOfRedundantConstraints includes: newSet) 
		ifTrue: 
			["Same set of redundant constraints found."

			setsOfRedundantConstraints add: newSet.
			^false].
	setsOfRedundantConstraints size >= 2 
		ifTrue: 
			[((setsOfRedundantConstraints collect: [:set | set size]) 
				includes: newSet size) 
					ifTrue: 
						["Equal number of redundant constraints found."

						setsOfRedundantConstraints add: newSet.
						^false]].
	setsOfRedundantConstraints add: newSet.
	allRedunCons do: [:i | i activateConstraint].
	^true
]

{ #category : 'accessing' }
SymMbDSystemSolver >> neqn [
	"Let MbDDAEIntegrator subclasses calculate with assignEquationNumbers."

	^nil
]

{ #category : 'accessing' }
SymMbDSystemSolver >> opBDF [
	^basicIntegrator opBDF
]

{ #category : 'accessing' }
SymMbDSystemSolver >> orderMax [
	^orderMax == nil
		ifTrue: [5]
		ifFalse: [orderMax]
]

{ #category : 'accessing' }
SymMbDSystemSolver >> orderMax: integer [ 
	orderMax := integer
]

{ #category : 'output' }
SymMbDSystemSolver >> output [
	system outputFor: #DYNAMIC
]

{ #category : 'accessing' }
SymMbDSystemSolver >> outputStepSize [
	^hout == nil
		ifTrue: [direction * 0.1]
		ifFalse: [hout]
]

{ #category : 'accessing' }
SymMbDSystemSolver >> parJoiMotForTorSenVarDo: aBlock [ 
	parts do: aBlock.
	jointsMotions do: aBlock.
	forTors do: aBlock.
	sensors do: aBlock.
	variables do: aBlock
]

{ #category : 'accessing' }
SymMbDSystemSolver >> partFrames [

	^ system partFrames
]

{ #category : 'accessing' }
SymMbDSystemSolver >> parts [
	^parts
]

{ #category : 'accessing' }
SymMbDSystemSolver >> partsJointsMotionsForTorsSensorsDo: aBlock [ 
	parts do: aBlock.
	jointsMotions do: aBlock.
	forTors do: aBlock.
	sensors do: aBlock
]

{ #category : 'accessing' }
SymMbDSystemSolver >> perpendicularConstraints2 [
	^system perpendicularConstraints2
]

{ #category : 'run' }
SymMbDSystemSolver >> preCollision [
	"There should only be one MbDInCollisionCVCVJoint"

	| aMbDInCollisionCVCVJoint |
	aMbDInCollisionCVCVJoint := jointsMotions 
				detect: [:a | a isMemberOf: MbDInCollisionCVCVJoint].
	jointsMotions 
		do: [:a | a == aMbDInCollisionCVCVJoint ifFalse: [a becomeSeparatedCVCVJoint]]
]

{ #category : 'posIC' }
SymMbDSystemSolver >> prePosIC [

	system prePosIC
]

{ #category : 'accessing' }
SymMbDSystemSolver >> rotationLimit [
	^rotationLimit == nil
		ifTrue: [0.5]
		ifFalse: [rotationLimit]
]

{ #category : 'accessing' }
SymMbDSystemSolver >> rotationLimit: double [ 
	rotationLimit := double
]

{ #category : 'run' }
SymMbDSystemSolver >> runAccIC [

	icTypeSolver := SymMbDAccICNewtonRaphson new.
	icTypeSolver system: self.
	icTypeSolver run
]

{ #category : 'run' }
SymMbDSystemSolver >> runAccICKine [
	icTypeSolver := MbDAccICKineNewtonRaphson2 new.
	icTypeSolver system: self.
	icTypeSolver run
]

{ #category : 'run' }
SymMbDSystemSolver >> runAccKine [
	icTypeSolver := MbDAccKineNewtonRaphson2 new.
	icTypeSolver system: self.
	icTypeSolver run
]

{ #category : 'run' }
SymMbDSystemSolver >> runAllIC [
	"Redundant constraint removal is best when the system is assembled."

	| cDiscontinuity |
	
	[self initializeLocally.
	self initializeGlobally.
	self runPosIC.
	"	self runPerturbedPosIC."
	[self needToRedoPosIC] whileTrue: [self runPosIC].
	self runVelIC.
	self runAccIC.
	cDiscontinuity := system cDiscontinuityAtIC.
	cDiscontinuity isEmpty not] 
			whileTrue: 
				[(cDiscontinuity includes: #REBOUND) 
					ifTrue: 
						[self preCollision.
						self runCollisionDerivativeIC.
						self runBasicCollision]]
]

{ #category : 'run' }
SymMbDSystemSolver >> runBasicCollision [

	[ "Use a new StMDAEIntegrator each time to wipe out past history.""A specialized integrator for collision may be better."
	basicIntegrator := MbDCollisionIntegrator new.
	basicIntegrator system: self.
	basicIntegrator run.
	basicIntegrator := nil.
	Smalltalk garbageCollect ]
		on: DiscontinuityError
		do: [ :ex | "basicIntegrator should have found end of collision.""It has told system to change to the new topology."
			| discontinuityTypes |
			discontinuityTypes := ex parameter.
			(discontinuityTypes contains: [ :type | #( #LIFTOFF #TOUCHDOWN ) includes: type ])
				ifTrue: [
					basicIntegrator := nil.
					Smalltalk garbageCollect.
					ex return ]
				ifFalse: [
					self logString: #'MbD: \Unknown discontinuity found in collision.'.
					SimulationStoppingError signal ] ]
]

{ #category : 'run' }
SymMbDSystemSolver >> runBasicDynamic [
	
	[basicIntegrator := MbDDynIntegrator new.
	basicIntegrator system: self.
	basicIntegrator run] 
			on: DiscontinuityError
			do: self discontinuityBlock
]

{ #category : 'run' }
SymMbDSystemSolver >> runBasicKinematic [
	
	[basicIntegrator := MbDKineIntegrator new.
	basicIntegrator system: self.
	basicIntegrator run] 
			on: NotKinematicError
			do: [:ex | self runQuasiKinematic]
]

{ #category : 'run' }
SymMbDSystemSolver >> runBasicTransient [
	system logString: #'MbD: \Starting transient simulation.'.
	
	[
	[basicIntegrator := MbDKineIntegrator new.
	basicIntegrator system: self.
	basicIntegrator run] 
			on: NotKinematicError
			do: 
				[:ex | 
				basicIntegrator := MbDDynIntegrator new.
				basicIntegrator system: self.
				basicIntegrator run]] 
			on: DiscontinuityError
			do: self discontinuityBlock
]

{ #category : 'run' }
SymMbDSystemSolver >> runBasicTransient1 [
	| discontinuityTypes |
	system logString: #'MbD: \Starting transient simulation.'.
	[
	[basicIntegrator := MbDKineIntegrator new.	"	basicIntegrator := MbDDynIntegrator new."
	basicIntegrator system: self.
	basicIntegrator run]
		on: NotKinematicError
		do: 
			[:ex | 
			basicIntegrator := MbDDynIntegrator new.
			basicIntegrator system: self.
			basicIntegrator run]]
		on: DiscontinuityError
		do: 
			[:ex | 
			"daeIntegrator should have found the transition point"
			"It has told system to change to the new topology."
			discontinuityTypes := ex parameter.
			(discontinuityTypes includes: #REBOUND)
				ifTrue: 
					[self runPosICVelICCollisionDerivativeIC.
					self runBasicCollision.
					self runPosICVelICAccIC.
					ex restart]
				ifFalse: [(discontinuityTypes contains: [:type | #(#LIFTOFF #BROKENJOINT) includes: type])
						ifTrue: 
							[self runPosICTwiceVelICAccIC.
							ex restart]
						ifFalse: [(discontinuityTypes contains: [:type | #(#TOUCHDOWN #PIECEWISEFORCE #PIECEWISEMOTION) includes: type])
								ifTrue: 
									[self runPosICTwiceVelICAccICCheckDiscontinuity.
									ex restart]
								ifFalse: [self error: 'An unknown discontinuity has been found.']]]]
]

{ #category : 'run' }
SymMbDSystemSolver >> runCollisionDerivativeIC [
	icTypeSolver := MbDCollisionDerivativeICNewtonRaphson2 new.
	icTypeSolver system: self.
	icTypeSolver run
]

{ #category : 'run' }
SymMbDSystemSolver >> runPerturbedPosIC [
	icTypeSolver := MbDPerturbedPosICNewtonRaphson2 new.
	icTypeSolver system: self.
	icTypeSolver run
]

{ #category : 'run' }
SymMbDSystemSolver >> runPosIC [

	icTypeSolver := SymMbDPosICNewtonRaphson new.
	icTypeSolver system: self.
	icTypeSolver run
]

{ #category : 'run' }
SymMbDSystemSolver >> runPosICKine [

	icTypeSolver := SymMbDPosICKineNewtonRaphson new.
	icTypeSolver system: self.
	icTypeSolver run
]

{ #category : 'run' }
SymMbDSystemSolver >> runPosICTwiceVelICAccIC [
	"Redundant constraint removal is best when the system is assembled."

	self initializeLocally.
	self initializeGlobally.
"self runPosIC."
	self runPerturbedPosIC.
	[self needToRedoPosIC]
		whileTrue: [self runPosIC].
	self runVelIC.
	self runAccIC
]

{ #category : 'run' }
SymMbDSystemSolver >> runPosICTwiceVelICAccICCheckDiscontinuity [
	
	[self runPosICTwiceVelICAccIC.
	system hasDiscontinuityAtIC]
		whileTrue: [system allDo: [:item | item preICRestart]]
]

{ #category : 'run' }
SymMbDSystemSolver >> runPosICVelICAccIC [
	"Redundant constraint removal is best when the system is assembled."

	self initializeLocally.
	self initializeGlobally.
	self runPosIC.
	self runVelIC.
	self runAccIC
]

{ #category : 'run' }
SymMbDSystemSolver >> runPosICVelICCollisionDerivativeIC [
	"Redundant constraint removal is best when the system is assembled."

	self initializeLocally.
	self initializeGlobally.
	self runPosIC.
	self runVelIC.
	self runCollisionDerivativeIC
]

{ #category : 'run' }
SymMbDSystemSolver >> runPosKine [

	icTypeSolver := SymMbDPosKineNewtonRaphson new.
	icTypeSolver system: self.
	icTypeSolver run
]

{ #category : 'run' }
SymMbDSystemSolver >> runQuasiKinematic [
	
	[basicIntegrator := MbD_ICKineIntegrator new.
	basicIntegrator system: self.
	basicIntegrator run] 
			on: DiscontinuityError
			do: self discontinuityBlock
]

{ #category : 'run' }
SymMbDSystemSolver >> runQuasiStatic [
	
	[basicIntegrator := MbDQuasiStaticIntegrator new.
	basicIntegrator system: self.
	basicIntegrator run] 
			on: DiscontinuityError
			do: self discontinuityBlock
]

{ #category : 'run' }
SymMbDSystemSolver >> runQuasiStatic1 [
	| discontinuityTypes |
	system logString: #'MbD: \Starting quasi static analysis.'.
	[
	[basicIntegrator := MbDKineIntegrator new.
	basicIntegrator system: self.
	basicIntegrator run]
		on: NotKinematicError
		do: 
			[:ex | 
			basicIntegrator := MbDQuasiStaticIntegrator new.
			basicIntegrator system: self.
			basicIntegrator run]]
		on: DiscontinuityError
		do: 
			[:ex | 
			"daeIntegrator should have found the transition point"
			"It has told system to change to the new topology."
			discontinuityTypes := ex parameter.
			(discontinuityTypes includes: #REBOUND)
				ifTrue: 
					[self runPosICVelICCollisionDerivativeIC.
					self runBasicCollision.
					self runPosICVelICAccIC.
					ex restart]
				ifFalse: [(discontinuityTypes contains: [:type | #(#LIFTOFF #BROKENJOINT) includes: type])
						ifTrue: 
							[self runPosICTwiceVelICAccIC.
							ex restart]
						ifFalse: [(discontinuityTypes contains: [:type | #(#TOUCHDOWN #PIECEWISEFORCE #PIECEWISEMOTION) includes: type])
								ifTrue: 
									[self runPosICTwiceVelICAccICCheckDiscontinuity.
									ex restart]
								ifFalse: [self error: 'An unknown discontinuity has been found.']]]]
]

{ #category : 'run' }
SymMbDSystemSolver >> runStaticIC [
	icTypeSolver := MbDStaticICNewtonRaphson2 new.
	icTypeSolver system: self.
	icTypeSolver run
]

{ #category : 'run' }
SymMbDSystemSolver >> runVelIC [

	icTypeSolver := SymMbDVelICSolver new.
	icTypeSolver system: self.
	icTypeSolver run
]

{ #category : 'run' }
SymMbDSystemSolver >> runVelICKine [
	icTypeSolver := MbDVelICKineSolver2 new.
	icTypeSolver system: self.
	icTypeSolver run
]

{ #category : 'run' }
SymMbDSystemSolver >> runVelKine [
	icTypeSolver := MbDVelKineSolver2 new.
	icTypeSolver system: self.
	icTypeSolver run
]

{ #category : 'accessing' }
SymMbDSystemSolver >> startTime [
	^tstart == nil
		ifTrue: [0.0]
		ifFalse: [tstart]
]

{ #category : 'accessing' }
SymMbDSystemSolver >> system: object [ 
	system := object
]

{ #category : 'accessing' }
SymMbDSystemSolver >> tend [
	^tend == nil
		ifTrue: [1.0]
		ifFalse: [tend]
]

{ #category : 'accessing' }
SymMbDSystemSolver >> tend: double [ 
	tend := double
]

{ #category : 'accessing' }
SymMbDSystemSolver >> time [
	^basicIntegrator time
]

{ #category : 'accessing' }
SymMbDSystemSolver >> time: aDouble [ 
	^system mbdTimeValue: aDouble
]

{ #category : 'accessing' }
SymMbDSystemSolver >> toutFirst: tout [ 
	toutFirst := tout
]

{ #category : 'accessing' }
SymMbDSystemSolver >> translationLimit [
	^translationLimit == nil
		ifTrue: [1.0d10]
		ifFalse: [translationLimit]
]

{ #category : 'accessing' }
SymMbDSystemSolver >> translationLimit: double [ 
	translationLimit := double
]

{ #category : 'accessing' }
SymMbDSystemSolver >> tstart [
	^tstart == nil
		ifTrue: [0.0]
		ifFalse: [tstart]
]

{ #category : 'accessing' }
SymMbDSystemSolver >> tstart: double [ 
	tstart := double
]

{ #category : 'accessing' }
SymMbDSystemSolver >> tstartPasts [
	^tstartPasts
]

{ #category : 'accessing' }
SymMbDSystemSolver >> tstartPastsAddFirst: tstartPast [ 
	tstartPasts addFirst: tstartPast
]

{ #category : 'accessing' }
SymMbDSystemSolver >> uHolders [
	^system uHolders
]

{ #category : 'run' }
SymMbDSystemSolver >> useCollisionTrialStepStats: stats [ 
	system useCollisionTrialStepStats: stats
]

{ #category : 'run' }
SymMbDSystemSolver >> useDynTrialStepStats: stats [ 
	system useDynTrialStepStats: stats
]

{ #category : 'run' }
SymMbDSystemSolver >> useKineTrialStepStats: stats [ 
	system useKineTrialStepStats: stats
]
