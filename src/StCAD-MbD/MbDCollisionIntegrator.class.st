Class {
	#name : 'MbDCollisionIntegrator',
	#superclass : 'MbDDAEIntegrator',
	#category : 'StCAD-MbD-MbDSolver',
	#package : 'StCAD-MbD',
	#tag : 'MbDSolver'
}

{ #category : 'VisualWorks metadata' }
MbDCollisionIntegrator class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'initialize-release' }
MbDCollisionIntegrator >> assignEquationNumbers [
	"Equation order is qdot, sdot, udot, Plambar, Plam."
	"Collision is pure ODE."
	"ncon is not needed."

	| parts contactEndFrames uHolders constraints eqnNo |
	parts := system parts.
	contactEndFrames := system contactEndFrames.
	uHolders := system uHolders.
	constraints := system allConstraints.
	eqnNo := 1.
	parts
		do: 
			[:part | 
			part iqX: eqnNo.
			eqnNo := eqnNo + 3.
			part iqE: eqnNo.
			eqnNo := eqnNo + 4].
	contactEndFrames
		do: 
			[:endFrm | 
			endFrm is: eqnNo.
			eqnNo := eqnNo + endFrm sSize].
	uHolders
		do: 
			[:uHolder | 
			uHolder iu: eqnNo.
			eqnNo := eqnNo + 1].
	constraints
		do: 
			[:con | 
			con iG: eqnNo.
			eqnNo := eqnNo + 1].
	neqn := eqnNo - 1
]

{ #category : 'run' }
MbDCollisionIntegrator >> changeTime: aDouble [ 
	"Do nothing."
]

{ #category : 'run' }
MbDCollisionIntegrator >> checkForDiscontinuity [
	"Check for discontinuity in (tpast,t] or [t,tpast) if integrating 
	backward."
	"t is now impulse."

	| t tprevious tstartNew discontinuityTypes |
	t := integrator t.
	tprevious := integrator tprevious.
	tstartNew := (direction * t) nextLargerNumber / direction.
	system allDo: [:item | tstartNew := item checkForCollisionDiscontinuityBetween: tprevious and: tstartNew].
	direction * tstartNew > (direction * t)
		ifTrue: ["No discontinuity in step"
			^self]
		ifFalse: 
			[self interpolateAt: tstartNew.
			discontinuityTypes := OrderedCollection new.
			system allDo: [:item | item discontinuityAt: tstartNew addTypeTo: discontinuityTypes].
			DiscontinuityError signalWith: discontinuityTypes]
]

{ #category : 'run' }
MbDCollisionIntegrator >> fillF: col [ 
	system allDo: [:item | item fillCollisionError: col]
]

{ #category : 'run' }
MbDCollisionIntegrator >> fillY: aColumn [ 
	"Plam is impulse like."

	system allDo: [:item | item fillqsudotPlam: aColumn]
]

{ #category : 'run' }
MbDCollisionIntegrator >> fillYdot: aColumn [ 
	system allDo: [:item | item fillqsudotPlamDeriv: aColumn]
]

{ #category : 'run' }
MbDCollisionIntegrator >> fillpFpy: matrix [
	"system partsJointsMotionsForTorsDo: [:item | item fillCollisionpFpy: matrix]"

	"Collision is pure ODE."

	"Do nothing."

	
]

{ #category : 'run' }
MbDCollisionIntegrator >> fillpFpydot: matrix [ 
	system allDo: [:item | item fillCollisionpFpydot: matrix]
]

{ #category : 'run' }
MbDCollisionIntegrator >> incrementTime: aDouble [ 
	"For collision, time is actually normal impulse."

	system allDo: [:item | item storeCollisionState].
	system allDo: [:item | item normalImpulse: aDouble]
]

{ #category : 'initialize-release' }
MbDCollisionIntegrator >> initializeGlobally [
	"t is now normalImpulse."

	super initializeGlobally.
	tstart := 0.0.
	self hout: 1.0d100.
	hmax := 1.0d100.
	hmin := MachineAccuracy OfDoubleTimesFour.
	tout := direction * 1.0d100.
	tend := direction * 1.0d100
]

{ #category : 'accessing' }
MbDCollisionIntegrator >> integrationAbsoluteTolerance [
	"Collision is pure ODE."

	^self correctorAbsoluteTolerance
]

{ #category : 'accessing' }
MbDCollisionIntegrator >> integrationRelativeTolerance [
	"Collision is pure ODE."

	^self correctorRelativeTolerance
]

{ #category : 'run' }
MbDCollisionIntegrator >> interpolateAt: impulse [ 
	"Interpolate for system state at impulse and leave system in that state."

	| yout ydotout |
	yout := integrator yDeriv: 0 at: impulse.
	ydotout := integrator yDeriv: 1 at: impulse.
	system
		allDo: 
			[:item | 
			item normalImpulse: impulse.
			item setqsudotPlam: yout.
			item setqsudotPlamDeriv: ydotout].
	system allDo: [:item | item simUpdateAll]
]

{ #category : 'accessing' }
MbDCollisionIntegrator >> iterMax [
	^4
]

{ #category : 'run' }
MbDCollisionIntegrator >> postDAECorrector [
	system allDo: [:item | item postCollisionCorrector]
]

{ #category : 'run' }
MbDCollisionIntegrator >> postDAECorrectorIteration [
	system allDo: [:item | item postCollisionCorrectorIteration]
]

{ #category : 'run' }
MbDCollisionIntegrator >> postDAEFirstStep [
	system allDo: [:item | item postCollisionStep].
	integrator istep > 0 ifTrue: ["Noise make checking at the start unreliable."
		self checkForDiscontinuity]
]

{ #category : 'run' }
MbDCollisionIntegrator >> postDAEOutput [
	"Do nothing."
]

{ #category : 'run' }
MbDCollisionIntegrator >> postDAEPredictor [
	system allDo: [:item | item postCollisionPredictor]
]

{ #category : 'run' }
MbDCollisionIntegrator >> postDAEStep [
	system allDo: [:item | item postCollisionStep].
	integrator istep > 0 ifTrue: ["Noise make checking at the start unreliable."
		self checkForDiscontinuity]
]

{ #category : 'run' }
MbDCollisionIntegrator >> postRun [
	system allDo: [:item | item postCollision]
]

{ #category : 'run' }
MbDCollisionIntegrator >> preDAECorrector [
	system allDo: [:item | item preCollisionCorrector]
]

{ #category : 'run' }
MbDCollisionIntegrator >> preDAECorrectorIteration [
	system allDo: [:item | item preCollisionCorrectorIteration]
]

{ #category : 'run' }
MbDCollisionIntegrator >> preDAEFirstStep [
	system allDo: [:item | item preCollisionStep]
]

{ #category : 'run' }
MbDCollisionIntegrator >> preDAEOutput [
	"Do nothing."
]

{ #category : 'run' }
MbDCollisionIntegrator >> preDAEPredictor [
	system allDo: [:item | item preCollisionPredictor]
]

{ #category : 'run' }
MbDCollisionIntegrator >> preDAEStep [
	system allDo: [:item | item preCollisionStep]
]

{ #category : 'run' }
MbDCollisionIntegrator >> preRun [
	system logString: #'MbD: \Starting collision analysis.'.
	system allDo: [:item | item preCollision]
]

{ #category : 'run' }
MbDCollisionIntegrator >> reportStats [
	self halt: 'check this.'.
	"Do nothing."
]

{ #category : 'run' }
MbDCollisionIntegrator >> suggestSmallerOrAcceptFirstStepSize: hnew [ 
	| hnew2 |
	hnew2 := hnew.
	system allDo: [:item | hnew2 := item suggestSmallerOrAcceptCollisionFirstStepSize: hnew2].
	^hnew2 min: 1.0
]

{ #category : 'run' }
MbDCollisionIntegrator >> suggestSmallerOrAcceptStepSize: hnew [ 
	| hnew2 |
	hnew2 := hnew.
	system allDo: [:item | hnew2 := item suggestSmallerOrAcceptCollisionStepSize: hnew2].
	^hnew2
]

{ #category : 'run' }
MbDCollisionIntegrator >> updateForDAECorrector [
	system allDo: [:item | item postCollisionCorrectorIteration]
]

{ #category : 'run' }
MbDCollisionIntegrator >> useDAEStepStats: stats [ 
	"Do nothing for now."
]

{ #category : 'run' }
MbDCollisionIntegrator >> useTrialStepStats: stats [ 
	system useCollisionTrialStepStats: stats
]

{ #category : 'accessing' }
MbDCollisionIntegrator >> y: aColumn [ 
	system allDo: [:item | item setqsudotPlam: aColumn]
]

{ #category : 'accessing' }
MbDCollisionIntegrator >> ydot: aColumn [ 
	system allDo: [:item | item setqsudotPlamDeriv: aColumn]
]
