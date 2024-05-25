"
FFT does not account for step size, delta. Fourier Transform does.
Given f(t), the Fourier Tranform F(f)
F(f) := delta*FFT(f(t)).
f(t) := FFT(F(f))/(N*delta)

Instance Variables:
	delta	<Object>	description of delta


"
Class {
	#name : 'StMFFTX',
	#superclass : 'StMFFT',
	#instVars : [
		'delta'
	],
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'examples' }
StMFFTX class >> example1 [
	"self halt. self example1."

	"0000 0001 0010 0011 0100 0101 0110 0111 1000 1001 1010 1011 1100 1101 1110 1111"

	"0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15"

	"0 8 4 12 2 10 6 14 1 9 5 13 3 11 7 15"

	| fft |
	fft := self new.
	fft xs: (StMArray 
				newWithElements: #(0.0 1.0 2.0 3.0 4.0 5.0 6.0 7.0 8.0 9.0 10.0 11.0 12.0 13.0 14.0 15.0)).
	fft ys: (StMArray 
				newWithElements: #(0.0 1.0 2.0 3.0 4.0 5.0 6.0 7.0 8.0 9.0 10.0 11.0 12.0 13.0 14.0 15.0)).
	fft doBitReversedOrder
]

{ #category : 'examples' }
StMFFTX class >> example2 [
	"self halt. self example2."

	| fft n dt df |
	fft := self new.
	fft 
		xs: (StMArray newWithElements: #(1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0)).
	fft 
		ys: (StMArray newWithElements: #(1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0)).
	n := fft size.
	dt := 0.1.
	fft delta: dt.
	fft transform.
	df := 1 / (n * dt).
	fft delta: df.
	fft inverse
]

{ #category : 'examples' }
StMFFTX class >> example3 [
	"self halt. self example3."

	| fft n dt df |
	fft := self new.
	fft xs: (StMArray 
				newWithElements: #(1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)).
	fft ys: (StMArray 
				newWithElements: #(1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)).
	n := fft size.
	dt := 0.1.
	fft delta: dt.
	fft transform.
	df := 1 / (n * dt).
	fft delta: df.
	fft inverse
]

{ #category : 'examples' }
StMFFTX class >> example4 [
	"self halt. self example4."

	"This is a real and even function. The transform is real and even."

	"Even means h(k) = h(N-k) using zero index."

	| fft n dt df |
	fft := self new.
	fft xs: (StMArray 
				newWithElements: #(0.0 1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 1.0)).
	fft ys: (StMArray 
				newWithElements: #(0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)).
	n := fft size.
	dt := 0.1.
	fft delta: dt.
	fft transform.
	df := 1 / (n * dt).
	fft delta: df.
	fft inverse
]

{ #category : 'examples' }
StMFFTX class >> example5 [
	"self halt. self example5."

	"This is a real, periodic function. The transform is real."

	| fft n dt df |
	fft := self new.
	fft xs: (StMArray 
				newWithElements: #(1.0 1.0 0.0 0.0 0.0 0.0 0.0 0.0 1.0 1.0 0.0 0.0 0.0 0.0 0.0 0.0 1.0 1.0 0.0 0.0 0.0 0.0 0.0 0.0 1.0 1.0 0.0 0.0 0.0 0.0 0.0 0.0)).
	fft ys: (StMArray 
				newWithElements: #(0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)).
	n := fft size.
	dt := 0.1.
	fft delta: dt.
	fft transform.
	df := 1 / (n * dt).
	fft delta: df.
	fft inverse
]

{ #category : 'examples' }
StMFFTX class >> example6 [
	"self halt. self example6."

	| fft dt |
	fft := self new.
	fft 
		xs: (StMArray newWithElements: #(1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0)).
	fft 
		ys: (StMArray newWithElements: #(0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)).
	dt := 0.2.
	fft delta: dt.
	fft transform.
	fft xs: (StMArray 
				newWithElements: #(1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0)).
	fft ys: (StMArray 
				newWithElements: #(0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)).
	dt := 0.1.
	fft delta: dt.
	fft transform
]

{ #category : 'VisualWorks metadata' }
StMFFTX class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'accessing' }
StMFFTX >> cyclicInverseSeries [
	| n dt answer |
	n := xs size.
	dt := 1.0 / (n * delta).
	answer := super cyclicSeries.
	1 to: n + 1 do: [:i | (answer at: i) f: (i - 1) * dt].
	^answer
]

{ #category : 'accessing' }
StMFFTX >> delta: del [ 
	delta := del abs asDouble
]

{ #category : 'calc' }
StMFFTX >> inverse [
	self FFTsign: -1 times: delta
]

{ #category : 'accessing' }
StMFFTX >> inverseSeries [
	| n dt answer |
	n := xs size.
	dt := 1.0 / (n * delta).
	answer := super series.
	1 to: n do: [:i | (answer at: i) f: (i - 1) * dt].
	^answer
]

{ #category : 'calc' }
StMFFTX >> transform [
	self FFTsign: 1 times: delta
]

{ #category : 'accessing' }
StMFFTX >> transformSeries [
	| n nOver2 fmin answer |
	n := xs size.
	nOver2 := n / 2.
	fmin := 1.0 / (n * delta).
	answer := super series.
	1 to: n
		do: 
			[:i | 
			i <= nOver2 
				ifTrue: [(answer at: i) f: (i - 1) * fmin]
				ifFalse: [(answer at: i) f: (i - 1 - n) * fmin]].
	^answer
]

{ #category : 'accessing' }
StMFFTX >> xs: xarray ys: yarray delta: del [ 
	super xs: xarray ys: yarray.
	delta := del abs asDouble
]
