Extension { #name : #StMFFTX }

{ #category : #'*StCAD-Geo-accessing' }
StMFFTX >> transformSeriesPosFreqOnly [
	| n fmin answer data nOver2 |
	n := xs size.
	nOver2 := n / 2.
	fmin := 1.0 / (n * delta).
	answer := StMArray new: nOver2 - 1.
	1 to: nOver2 - 1
		do: 
			[:i |
			data := GEOFourierTransformData new.
			data f: i * fmin.
			data aFx: (xs at: i + 1).
			data aFy: (ys at: i + 1).
			answer at: i put: data.].
	^answer.
]
