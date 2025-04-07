Class {
	#name : 'StMInverseOfSpectralDensity',
	#superclass : 'StMDataXYFunctionX',
	#instVars : [
		'deriveOrder',
		'nfreq',
		'freqMax',
		'freqScale',
		'densityScale',
		'seed',
		'spline'
	],
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'accessing' }
StMInverseOfSpectralDensity class >> functionSymbol [
	^'invSD'
]

{ #category : 'accessing' }
StMInverseOfSpectralDensity class >> functionTemplate [
	^self functionSymbol 
		, '(time, derivOrderOfSpectrum, nfreq, freqMax, freqScale, densityScale, seed, freq1, den1, freq2, den2, ...)'
]

{ #category : 'VisualWorks metadata' }
StMInverseOfSpectralDensity class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'accessing' }
StMInverseOfSpectralDensity >> arguments: array [ 
	| n |
	x := array at: 1.
	deriveOrder := (array at: 2) value.
	nfreq := (array at: 3) value.
	freqMax := (array at: 4) value asDouble.
	freqScale := (array at: 5) value.
	densityScale := (array at: 6) value.
	seed := (array at: 7) value.
	n := (array size - 7) / 2.
	xs := Array new: n.
	ys := Array new: n.
	1 to: n
		do: 
			[:i | 
			xs at: i put: (array at: 2 * i + 6) value asDouble.
			ys at: i put: (array at: 2 * i + 7) value asDouble].
	self computeSpline
]

{ #category : 'calculation' }
StMInverseOfSpectralDensity >> computeSpline [
	| splineSD df reals ims random twopi f amp phase real im ii fourier timeSeries ts xxs xs ys |
	splineSD := StMGeneralSplineX 
				with: x
				order: 1
				xs: (xs collect: [:element | element perform: freqScale])
				ys: (ys collect: [:element | element perform: densityScale]).
	nfreq := 2 raisedTo: (nfreq log: 2) rounded asInteger.
	df := freqMax / nfreq.
	reals := StMArray new: 2 * nfreq.
	ims := StMArray new: 2 * nfreq.
	random := Random new.
	random seed: seed.
	twopi := 2.0 * Double pi.
	"Zero at zero frequency."
	reals at: 1 put: 0.0.
	ims at: 1 put: 0.0.
	1 to: nfreq - 1
		do: 
			[:i | 
			f := i * df.
			amp := splineSD y: (f perform: freqScale).
			amp := densityScale == #log ifTrue: [10.0 raisedTo: amp] ifFalse: [amp].
			amp := (amp / 2) sqrt.
			amp := amp / (twopi * f raisedTo: deriveOrder).
			phase := twopi * random next.
			reals at: i + 1 put: amp * phase cos.
			ims at: i + 1 put: amp * phase sin].
	"Zero at maximum frequency."
	reals at: nfreq + 1 put: 0.0.
	ims at: nfreq + 1 put: 0.0.
	1 to: nfreq - 1
		do: 
			[:i | 
			real := reals at: i + 1.
			im := ims at: i + 1.
			ii := 2 * nfreq - i + 1.
			"Assume the time function wiil be real."
			reals at: ii put: real.
			ims at: ii put: 0.0 - im].
	fourier := fourier := StMFFTX new.
	fourier 
		xs: reals
		ys: ims
		delta: df.
	fourier inverse.
	timeSeries := fourier cyclicInverseSeries.
	ts := timeSeries collect: [:element | element f].
	xxs := timeSeries collect: [:element | element aFx].
	spline := StMGeneralSplineX 
				with: x
				order: 5
				xs: ts
				ys: xxs
]

{ #category : 'evaluating' }
StMInverseOfSpectralDensity >> differentiateWRTx [
	^spline differentiateWRTx
]

{ #category : 'comparing' }
StMInverseOfSpectralDensity >> hash [

	| hash |
	hash := super hash.
	hash := hash bitXor: densityScale hash.
	hash := hash bitXor: deriveOrder hash.
	hash := hash bitXor: freqMax hash.
	hash := hash bitXor: freqScale hash.
	hash := hash bitXor: nfreq hash.
	hash := hash bitXor: seed hash.
	hash := hash bitXor: spline hash.
	^ hash
]

{ #category : 'evaluating' }
StMInverseOfSpectralDensity >> value [
	^spline value
]
