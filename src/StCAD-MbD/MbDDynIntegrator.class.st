Class {
	#name : 'MbDDynIntegrator',
	#superclass : 'MbDDAEIntegrator',
	#category : 'StCAD-MbD-MbDSolver',
	#package : 'StCAD-MbD',
	#tag : 'MbDSolver'
}

{ #category : 'VisualWorks metadata' }
MbDDynIntegrator class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'initialize-release' }
MbDDynIntegrator >> assignEquationNumbers [
	"Equation order is p,q,s,u,w,mubar,mu."

	| parts contactEndFrames uHolders constraints eqnNo |
	parts := system parts.
	contactEndFrames := system contactEndFrames.
	uHolders := system uHolders.
	constraints := system allConstraints.
	ncon := constraints size.
	eqnNo := 1.
	parts
		do: 
			[:part | 
			part ipX: eqnNo.
			eqnNo := eqnNo + 3.
			part ipE: eqnNo.
			eqnNo := eqnNo + 4].
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
MbDDynIntegrator >> checkForDiscontinuity [
	"Check for discontinuity in (tpast,t] or [t,tpast) if integrating 
	backward."

	| t tprevious tstartNew discontinuityTypes |
	t := integrator t.
	tprevious := integrator tprevious.
	tstartNew := (direction * t) nextLargerNumber / direction.
	system allDo: [:item | tstartNew := item checkForDynDiscontinuityBetween: tprevious and: tstartNew].
	direction * tstartNew > (direction * t)
		ifTrue: ["No discontinuity in step"
			^self]
		ifFalse: 
			[self checkForOutputThrough: tstartNew.
			self interpolateAt: tstartNew.
			system tstartPastsAddFirst: tstart.
			system tstart: tstartNew.
			system toutFirst: tout.
			discontinuityTypes := OrderedCollection new.
			system allDo: [:item | item discontinuityAt: tstartNew addTypeTo: discontinuityTypes].
			DiscontinuityError signalWith: discontinuityTypes]
]

{ #category : 'run' }
MbDDynIntegrator >> checkForOutputThrough: t [ 
	"Inclusive of t."

	| tlimit thereIsOutput yout ydotout yddotout y ydot |
	tlimit := t.
	thereIsOutput := false.
	direction * tend <= (direction * tlimit)
		ifTrue: 
			[integrator continue: false.
			tlimit := tend + (0.1 * direction * hout)].
	[direction * tout <= (direction * tlimit)]
		whileTrue: 
			[thereIsOutput := true.
			yout := integrator yDeriv: 0 at: tout.
			ydotout := integrator yDeriv: 1 at: tout.
			yddotout := integrator yDeriv: 2 at: tout.
			system time: tout.
			system
				allDo: 
					[:item | 
					item setpqsumu: yout.
					item setpqsumudot: ydotout.
					item setpqsumuddot: yddotout].
			self preDAEOutput.
			system output.
			tout := tout + (direction * hout)].
	thereIsOutput
		ifTrue: 
			["Reset system to integrator time."
			system time: integrator t.
			y := integrator y.
			ydot := integrator ydot.
			system
				allDo: 
					[:item | 
					item setpqsumu: y.
					item setpqsumudot: ydot].
			self postDAEOutput]
]

{ #category : 'run' }
MbDDynIntegrator >> fillF: col [ 
	system allDo: [:item | item fillDynError: col]
]

{ #category : 'run' }
MbDDynIntegrator >> fillY: aColumn [ 
	system allDo: [:item | item fillpqsumu: aColumn]
]

{ #category : 'run' }
MbDDynIntegrator >> fillYdot: aColumn [ 
	system allDo: [:item | item fillpqsumudot: aColumn]
]

{ #category : 'run' }
MbDDynIntegrator >> fillpFpy: matrix [ 
	system allDo: [:item | item fillpFpy: matrix]
]

{ #category : 'run' }
MbDDynIntegrator >> fillpFpydot: mat [ 
	system allDo: [:item | item fillpFpydot: mat]
]

{ #category : 'run' }
MbDDynIntegrator >> incrementTime: aDouble [ 
	system allDo: [:item | item storeDynState].
	system time: aDouble
]

{ #category : 'run' }
MbDDynIntegrator >> interpolateAt: tArg [ 
	"Interpolate for system state at tArg and leave system in that state."

	| yout ydotout yddotout |
	yout := integrator yDeriv: 0 at: tArg.
	ydotout := integrator yDeriv: 1 at: tArg.
	yddotout := integrator yDeriv: 2 at: tArg.
	system time: tArg.
	system
		allDo: 
			[:item | 
			item setpqsumu: yout.
			item setpqsumudot: ydotout.
			item setpqsumuddot: yddotout].
	system allDo: [:item | item simUpdateAll]
]

{ #category : 'accessing' }
MbDDynIntegrator >> iterMax [
	^system iterMaxDyn
]

{ #category : 'run' }
MbDDynIntegrator >> postDAECorrector [
	system allDo: [:item | item postDynCorrector]
]

{ #category : 'run' }
MbDDynIntegrator >> postDAECorrectorIteration [
	system allDo: [:item | item postDynCorrectorIteration]
]

{ #category : 'run' }
MbDDynIntegrator >> postDAEFirstStep [
	system allDo: [:item | item postDynFirstStep].
	integrator istep > 0 ifTrue: ["Noise make checking at the start unreliable."
		self checkForDiscontinuity].
	self checkForOutputThrough: integrator t
]

{ #category : 'run' }
MbDDynIntegrator >> postDAEOutput [
	system allDo: [:item | item postDynOutput]
]

{ #category : 'run' }
MbDDynIntegrator >> postDAEPredictor [
	system allDo: [:item | item postDynPredictor]
]

{ #category : 'run' }
MbDDynIntegrator >> postDAEStep [
	system allDo: [:item | item postDynStep].
	integrator istep > 0 ifTrue: ["Noise make checking at the start unreliable."
		self checkForDiscontinuity].
	self checkForOutputThrough: integrator t
]

{ #category : 'run' }
MbDDynIntegrator >> postRun [
	system allDo: [:item | item postDyn]
]

{ #category : 'run' }
MbDDynIntegrator >> preDAECorrector [
	system allDo: [:item | item preDynCorrector]
]

{ #category : 'run' }
MbDDynIntegrator >> preDAECorrectorIteration [
	system allDo: [:item | item preDynCorrectorIteration]
]

{ #category : 'run' }
MbDDynIntegrator >> preDAEFirstStep [
	system allDo: [:item | item preDynFirstStep]
]

{ #category : 'run' }
MbDDynIntegrator >> preDAEOutput [
	system allDo: [:item | item preDynOutput]
]

{ #category : 'run' }
MbDDynIntegrator >> preDAEPredictor [
	system allDo: [:item | item preDynPredictor]
]

{ #category : 'run' }
MbDDynIntegrator >> preDAEStep [
	system allDo: [:item | item preDynStep]
]

{ #category : 'run' }
MbDDynIntegrator >> preRun [
	system logString: #'MbD: \Starting dynamic analysis.'.
	system allDo: [:item | item preDyn]
]

{ #category : 'run' }
MbDDynIntegrator >> reportStats [
	"Do nothing."
]

{ #category : 'run' }
MbDDynIntegrator >> run [

	[
	[
	[ super run ]
		on: SingularMatrixError
		do: [ :ex |
			self logString: #'MbD: \Solver has encountered a singular matrix.'.
			self logString: #'MbD: \Check to see if a massless or a very low mass part is under constrained.'.
			self logString: #'MbD: \Check to see if the system is in a locked position.'.
			self logString: #'MbD: \Check to see if the error tolerance is too demanding.'.
			self logString: #'MbD: \Check to see if a curve-curve is about to have multiple contact points.'.
			SimulationStoppingError signal ] ]
		on: TooSmallStepSizeError
		do: [ :ex |
			self logString: #'MbD: \Step size is prevented from going below the user specified minimum.'.
			self logString: #'MbD: \Check to see if the system is in a locked position.'.
			self logString: #'MbD: \Check to see if a curve-curve is about to have multiple contact points.'.
			self logString: #'MbD: \If they are not, lower the permitted minimum step size.'.
			SimulationStoppingError signal ] ]
		on: TooManyTriesError
		do: [ :ex |
			self logString: #'MbD: \Check to see if the error tolerance is too demanding.'.
			SimulationStoppingError signal ]
]

{ #category : 'run' }
MbDDynIntegrator >> suggestSmallerOrAcceptFirstStepSize: hnew [ 
	| hnew2 |
	hnew2 := hnew.
	system allDo: [:item | hnew2 := item suggestSmallerOrAcceptDynFirstStepSize: hnew2].
"
	hnew2 > hmax
		ifTrue: 
			[hnew2 := hmax.
			self logString: #'StM: \Step size is at user specified maximum.'].
	hnew2 < hmin
		ifTrue: 
			[self logString: #'StM: \Step size %1 < %2 user specified minimum.' withArguments: (Array with: hnew2 asFloat printString with: hmin asFloat printString).
			TooSmallStepSizeError raiseSignal].
"
	^hnew2
]

{ #category : 'run' }
MbDDynIntegrator >> suggestSmallerOrAcceptStepSize: hnew [

	| hnew2 |
	hnew2 := hnew.
	system allDo: [ :item |
		hnew2 := item suggestSmallerOrAcceptDynStepSize: hnew2 ].
	hnew2 > hmax ifTrue: [
		hnew2 := hmax.
		self logString: #'StM: \Step size is at user specified maximum.' ].
	hnew2 < hmin ifTrue: [
		self
			logString: #'StM: \Step size %1 < %2 user specified minimum.'
			withArguments: (Array with: hnew2 asFloat printString with: hmin asFloat printString).
		TooSmallStepSizeError signal ].
	^ hnew2
]

{ #category : 'run' }
MbDDynIntegrator >> updateForDAECorrector [
	system allDo: [:item | item postDynCorrectorIteration]
]

{ #category : 'run' }
MbDDynIntegrator >> useDAEStepStats: stats [ 
	"Do nothing for now."
]

{ #category : 'run' }
MbDDynIntegrator >> useTrialStepStats: stats [ 
	system useDynTrialStepStats: stats
]

{ #category : 'accessing' }
MbDDynIntegrator >> y: aColumn [ 
	system allDo: [:item | item setpqsumu: aColumn]
]

{ #category : 'accessing' }
MbDDynIntegrator >> ydot: aColumn [ 
	system allDo: [:item | item setpqsumudot: aColumn]
]
