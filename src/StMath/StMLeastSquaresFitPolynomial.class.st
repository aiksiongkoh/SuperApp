Class {
	#name : 'StMLeastSquaresFitPolynomial',
	#superclass : 'StMLeastSquaresFit',
	#instVars : [
		'order',
		'polynomial'
	],
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'VisualWorks metadata' }
StMLeastSquaresFitPolynomial class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'calc' }
StMLeastSquaresFitPolynomial >> calcCoeffs [
	| orderPlusOne twoOrder xspower xspowerSum matrix vector rowi power element coeffs |
	self conditionData.
	orderPlusOne := order + 1.
	twoOrder := 2 * order.
	xspower := StMFullMatrix new: twoOrder.
	xspower at: 1 put: xs.
	2 to: twoOrder do: [:i | xspower at: i put: (xs elementTimesElementOf: (xspower at: i - 1))].
	xspowerSum := StMFullColumn new: twoOrder.
	1 to: twoOrder do: [:i | xspowerSum at: i put: (xspower at: i) sumOfElements].
	matrix := StMFullMatrix new: orderPlusOne by: orderPlusOne.
	vector := StMFullColumn new: orderPlusOne.
	1 to: orderPlusOne
		do: 
			[:i | 
			rowi := matrix at: i.
			1 to: orderPlusOne
				do: 
					[:j | 
					power := i - 1 + (j - 1).
					element := power == 0
								ifTrue: [xs size asDouble]
								ifFalse: [xspowerSum at: power].
					rowi at: j put: element]].
	1 to: orderPlusOne
		do: 
			[:i | 
			element := i == 1
						ifTrue: [ys sumOfElements]
						ifFalse: [ys dot: (xspower at: i - 1)].
			vector at: i put: element].
	[coeffs := GEFullMatParPv new
				solve: matrix
				with: vector
				saveOriginal: false]
		on: SingularMatrixError do: [:ex | ex resume].
	polynomial := StMPolynomialX with: (x minus: xOffset)
				coeffs: coeffs
]

{ #category : 'calc' }
StMLeastSquaresFitPolynomial >> conditionData [
	"Shift origin to midpoint of xs to avoid ill conditioning."

	| minMax |
	xs size == ys size ifFalse: [self error: 'x series and y series must be of the same size.'].
	minMax := xs minAndMaxValues.
	xOffset := (minMax at: 1)
				+ (minMax at: 2) / 2.0.
	xs := xs minusNumber: xOffset
]

{ #category : 'calc' }
StMLeastSquaresFitPolynomial >> derivative: n at: xx [ 
	^polynomial derivative: n at: xx - xOffset
]

{ #category : 'evaluating' }
StMLeastSquaresFitPolynomial >> differentiateWRT: variable [ 
	^polynomial differentiateWRT: variable
]

{ #category : 'evaluating' }
StMLeastSquaresFitPolynomial >> partialDifferentiateWRT: variable [ 
	^polynomial partialDifferentiateWRT: variable
]

{ #category : 'changing' }
StMLeastSquaresFitPolynomial >> substitute: var1 with: var2 [ 
	| xx |
	^self = var1
		ifTrue: [var2]
		ifFalse: 
			[xx := x substitute: var1 with: var2.
			self class
				x: xx
				order: order
				xs: xs
				ys: ys]
]

{ #category : 'evaluating' }
StMLeastSquaresFitPolynomial >> value [
	^polynomial value
]

{ #category : 'evaluating' }
StMLeastSquaresFitPolynomial >> value: xx [ 
	^polynomial value: xx - xOffset
]

{ #category : 'accessing' }
StMLeastSquaresFitPolynomial >> x: arg [ 
	| xold |
	xold := x.
	super x: arg.
	polynomial := polynomial substitute: xold with: x
]

{ #category : 'initialize-release' }
StMLeastSquaresFitPolynomial >> x: arg order: integer xs: xarray ys: yarray [ 
	x := self conditionArgument: arg.
	xs := xarray.
	ys := yarray.
	order := integer asInteger.
	self calcCoeffs
]
