Class {
	#name : #MbDDistIeqcsJeqc,
	#superclass : #MbDDistIeqcJeqc,
	#instVars : [
		'sSizeI',
		'prIeJepsI',
		'pprIeJepXIpsI',
		'pprIeJepEIpsI',
		'pprIeJepXJpsI',
		'pprIeJepEJpsI',
		'pprIeJepsIpsI',
		'mprIeJeOpsIT',
		'sepDist',
		'newtonRaphson',
		's',
		'prIeJeps',
		'pprIeJepsps'
	],
	#category : #'StCAD-MbD-MbDKinematicIJ'
}

{ #category : #'VisualWorks metadata' }
MbDDistIeqcsJeqc class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : #'instance creation' }
MbDDistIeqcsJeqc class >> withFrmI: afrmI frmJ: afrmJ [ 
	^(afrmI isKindOf: MbDEndFrameqcs)
		& (afrmJ isMemberOf: MbDEndFrameqc)
		ifTrue: [self new withFrmI: afrmI frmJ: afrmJ]
		ifFalse: [nil]
]

{ #category : #calc }
MbDDistIeqcsJeqc >> calcLocalSeparationDistance [
	"When rIeJe is too small NewtonRaphson can have singularity."

	
	[[newtonRaphson run] on: SingularMatrixError
		do: 
			[:ex | 
			"Near perfect contact."

			ex return].
	sepDist := rIeJeO dot: frmI keO] 
			on: MaximumIterationError
			do: 
				[:ex | 
				"Solution not found."

				sepDist := 0.0.
				ex return]
]

{ #category : #calc }
MbDDistIeqcsJeqc >> calcPostLocalSepDistIteration [
	"rIeJeO has a unit fourth dimension added to avoid singularity when actual rIeJe = 0."

	rIeJeO := frmJ rOeO - frmI rOeO.
	rIeJe := (rIeJeO sumOfSquares + 1.0d) sqrt.
	self calcPrivate
]

{ #category : #calc }
MbDDistIeqcsJeqc >> calcPrivate [
	| mprIeJeOpsI mpprIeJeOpEIpsI mpprIeJeOpsIpsI pprIeJepXIipsI prIeJepXIi mprIeJeOipsI element pprIeJepEIipsI prIeJepEIi mpprIeJeOpEIipsI mprIeJeOpEIiT pprIeJepsIipsI prIeJepsIi mpprIeJeOpsIipsI mprIeJeOpsIiT pprIeJepXJipsI prIeJepXJi pprIeJepEJipsI prIeJepEJi prIeJeOpEJiT |
	super calcPrivate.
	rIeJe = 0.0 ifTrue: [^self].
	mprIeJeOpsI := frmI prOeOps.
	mprIeJeOpsIT := mprIeJeOpsI transpose.
	mpprIeJeOpEIpsI := frmI pprOeOpEps.
	mpprIeJeOpsIpsI := frmI pprOeOpsps.
	prIeJepsI := muIeJeO transpose timesFullMatrix: mprIeJeOpsI.
	1 to: 3
		do: 
			[:i | 
			pprIeJepXIipsI := pprIeJepXIpsI at: i.
			prIeJepXIi := prIeJepXI at: i.
			mprIeJeOipsI := mprIeJeOpsI at: i.
			1 to: sSizeI
				do: 
					[:j | 
					element := (mprIeJeOipsI at: j)
								- (prIeJepXIi * (prIeJepsI at: j)).
					pprIeJepXIipsI at: j put: element / rIeJe]].
	1 to: 4
		do: 
			[:i | 
			pprIeJepEIipsI := pprIeJepEIpsI at: i.
			prIeJepEIi := prIeJepEI at: i.
			mpprIeJeOpEIipsI := mpprIeJeOpEIpsI at: i.
			mprIeJeOpEIiT := mprIeJeOpEIT at: i.
			1 to: sSizeI
				do: 
					[:j | 
					element := (mprIeJeOpEIiT dot: (mprIeJeOpsIT at: j))
								- ((mpprIeJeOpEIipsI at: j)
										dot: rIeJeO) - (prIeJepEIi * (prIeJepsI at: j)).
					pprIeJepEIipsI at: j put: element / rIeJe]].
	1 to: 3
		do: 
			[:i | 
			pprIeJepXJipsI := pprIeJepXJpsI at: i.
			prIeJepXJi := prIeJepXJ at: i.
			mprIeJeOipsI := mprIeJeOpsI at: i.
			1 to: sSizeI
				do: 
					[:j | 
					element := (mprIeJeOipsI at: j)
								- (prIeJepXJi * (prIeJepsI at: j)).
					pprIeJepXJipsI at: j put: element / rIeJe]].
	1 to: 4
		do: 
			[:i | 
			pprIeJepEJipsI := pprIeJepEJpsI at: i.
			prIeJepEJi := prIeJepEJ at: i.
			prIeJeOpEJiT := prIeJeOpEJT at: i.
			1 to: sSizeI
				do: 
					[:j | 
					element := 0.0 - (prIeJeOpEJiT dot: (mprIeJeOpsIT at: j)) - (prIeJepEJi * (prIeJepsI at: j)).
					pprIeJepEJipsI at: j put: element / rIeJe]].
	1 to: sSizeI
		do: 
			[:i | 
			pprIeJepsIipsI := pprIeJepsIpsI at: i.
			prIeJepsIi := prIeJepsI at: i.
			mpprIeJeOpsIipsI := mpprIeJeOpsIpsI at: i.
			mprIeJeOpsIiT := mprIeJeOpsIT at: i.
			1 to: sSizeI
				do: 
					[:j | 
					element := (mprIeJeOpsIiT dot: (mprIeJeOpsIT at: j))
								- ((mpprIeJeOpsIipsI at: j)
										dot: rIeJeO) - (prIeJepsIi * (prIeJepsI at: j)).
					pprIeJepsIipsI at: j put: element / rIeJe]]
]

{ #category : #calc }
MbDDistIeqcsJeqc >> calcSeparationDistance [
	"Do coarse global search, then accurate local search."
	"Use original data points as discretization points."
	"Since J is just one point find its closest I point."

	| sIs rImIeIms rImJeIm minDistSq minusrIeJeIm distSq indexI |
	sIs := frmI ss.
	rImIeIms := frmI rmems.
	rImJeIm := frmI markerFrame rmemOFrOeO: frmJ rOeO.
	minDistSq := 1.0d300.
	1 to: rImIeIms size do: [:i | 
			minusrIeJeIm := (rImIeIms at: i) - rImJeIm.
			distSq := minusrIeJeIm sumOfSquares.
			minDistSq > distSq
				ifTrue: 
					[minDistSq := distSq.
					indexI := i]].
	frmI sNumber: (sIs at: indexI).
	self calcLocalSeparationDistance
]

{ #category : #'initialize-release' }
MbDDistIeqcsJeqc >> initialize [
	super initialize.
	newtonRaphson := MbDMinDistIeJeNewtonRaphson2 new.
	newtonRaphson system: self
]

{ #category : #'initialize-release' }
MbDDistIeqcsJeqc >> initializeGlobally [
	| sSize |
	sSize := sSizeI.
	s := StMFullColumn new: sSize.
	prIeJeps := StMFullColumn new: sSize.
	pprIeJepsps := StMFullMatrix new: sSize by: sSize
]

{ #category : #'initialize-release' }
MbDDistIeqcsJeqc >> initializeLocally [
	sSizeI := frmI sSize.
	prIeJepsI := StMFullRow new: sSizeI.
	pprIeJepXIpsI := StMFullMatrix new: 3 by: sSizeI.
	pprIeJepEIpsI := StMFullMatrix new: 4 by: sSizeI.
	pprIeJepXJpsI := StMFullMatrix new: 3 by: sSizeI.
	pprIeJepEJpsI := StMFullMatrix new: 4 by: sSizeI.
	pprIeJepsIpsI := StMFullMatrix new: sSizeI by: sSizeI
]

{ #category : #calc }
MbDDistIeqcsJeqc >> postLocalSepDistIteration [
	self setEndFramess.
	self endFramesCalc.
	self calcPostLocalSepDistIteration.
	prIeJeps at: 1 putFullColumn: prIeJepsI.
	pprIeJepsps
		at: 1
		and: 1
		putFullMatrix: pprIeJepsIpsI
]

{ #category : #accessing }
MbDDistIeqcsJeqc >> pprIeJepsps [
	^pprIeJepsps
]

{ #category : #accessing }
MbDDistIeqcsJeqc >> ppvaluepsIpsI [
	^pprIeJepsIpsI
]

{ #category : #accessing }
MbDDistIeqcsJeqc >> prIeJeps [
	^prIeJeps
]

{ #category : #accessing }
MbDDistIeqcsJeqc >> prIeJepsI [
	^prIeJepsI
]

{ #category : #calc }
MbDDistIeqcsJeqc >> preLocalSepDist [
	self endFramesCalc.
	self calcPostLocalSepDistIteration.
	s at: 1 putFullColumn: frmI s.
	prIeJeps at: 1 putFullColumn: prIeJepsI.
	pprIeJepsps at: 1 and: 1 putFullMatrix: pprIeJepsIpsI
]

{ #category : #accessing }
MbDDistIeqcsJeqc >> pvaluepsI [
	^prIeJepsI
]

{ #category : #accessing }
MbDDistIeqcsJeqc >> s [
	^s
]

{ #category : #accessing }
MbDDistIeqcsJeqc >> s: col [ 
	s := col
]

{ #category : #accessing }
MbDDistIeqcsJeqc >> separationDistance [
	^sepDist
]

{ #category : #accessing }
MbDDistIeqcsJeqc >> setEndFramess [
	frmI s equalFullColumn: s at: 1
]
