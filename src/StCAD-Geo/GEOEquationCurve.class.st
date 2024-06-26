Class {
	#name : 'GEOEquationCurve',
	#superclass : 'GEOCurve',
	#instVars : [
		'rfpfEqn'
	],
	#category : 'StCAD-Geo-GEO',
	#package : 'StCAD-Geo',
	#tag : 'GEO'
}

{ #category : 'VisualWorks metadata' }
GEOEquationCurve class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : 'accessing' }
GEOEquationCurve >> renderOn: aRenderingContext withCurveMarker: aCurveMarker [ 
	aRenderingContext pushTransformation: refFrame aMFf
		while: 
			["aRenderingContext paint: self paint"

			aRenderingContext displayLines: rfpfEqn ys.
			aCurveMarker basicRenderOn: aRenderingContext]
]

{ #category : 'accessing' }
GEOEquationCurve >> rfpfEqn [
	^rfpfEqn
]

{ #category : 'accessing' }
GEOEquationCurve >> rfpfEqn: eqn [ 
	rfpfEqn := eqn
]

{ #category : 'accessing' }
GEOEquationCurve >> rfpointsf [
	| nseg ds rfpointsf s |
	nseg := 256.
	ds := 2.0 / nseg.
	rfpointsf := StMArray new: nseg + 1.
	1 to: nseg
		do: 
			[:i | 
			s := -1.0 + (i - 1 * ds).
			rfpointsf at: i put: (rfpfEqn y: s)].
	rfpointsf at: nseg + 1 put: (rfpointsf at: 1).
	^rfpointsf
]
