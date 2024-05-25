Class {
	#name : 'StMTestingGeneralSplineX',
	#superclass : 'StMGeneralSplineX',
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'examples' }
StMTestingGeneralSplineX class >> example2 [
	"self example2"

	"Closed curve. Best to use odd order."

	| x order xs ys |
	x := StMIndependentVariable new.
	order := 4.
	xs := StMArray 
				newWithElements: #(0.0 1.0 2.0 3.0 4.0 5.0 6.0 7.0 8.0 9.0 10.0 11.0 12.0 13.0 14.0 15.0).
	ys := StMArray 
				newWithElements: #(0.0 1.0 2.0 3.0 4.0 5.0 6.0 7.0 7.0 6.0 5.0 4.0 3.0 2.0 1.0 0.0).
	^self 
		with: x
		order: order
		xs: xs
		ys: ys
]

{ #category : 'examples' }
StMTestingGeneralSplineX class >> example4 [
	"self example4"

	"Open antisymmetric curve. Even order maintains the antisymmetry beyond the first and last points."

	"Beware of wiggles in between nodes. Even order seems to be particularly bad!"

	| x order xs ys |
	x := StMIndependentVariable new.
	order := 4.
	xs := StMArray 
				newWithElements: #(-0.5 -0.4 -0.3 -0.2 -0.1 0.0 0.1 0.2 0.3 0.4 0.5).
	ys := StMArray 
				newWithElements: #(-23200 -12800 -8700 -5800 -2900 0 2900 5800 8700 12800 23200).
	^self 
		with: x
		order: order
		xs: xs
		ys: ys
]

{ #category : 'VisualWorks metadata' }
StMTestingGeneralSplineX class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'calculation' }
StMTestingGeneralSplineX >> computeDerivatives [
	"See derivation in 9spline.doc."

	degree = 0 
		ifTrue: [self changeClassToThatOf: StMZeroDegreeSplineX basicNew]
		ifFalse: 
			[| n p np matrix bvector y1 hs zero hmax derivsVector hmaxpowers |
			n := xs size.
			p := degree.
			np := n * p.
			matrix := StMSparseMatrix new: np by: np.
			bvector := StMFullColumn new: np.
			y1 := ys at: 1.
			(y1 isKindOf: Array) 
				ifTrue: [zero := (y1 class new: y1 size) atAllPut: Double zero]
				ifFalse: [zero := y1 class zero].
			bvector atAllPut: zero.
			hs := StMFullColumn new: np - 1.
			hmax := 0.0.
			1 to: n - 1
				do: 
					[:i | 
					| h |
					h := (xs at: i + 1) - (xs at: i).
					hmax := hmax max: h abs.
					hs at: i put: h].
			1 to: n - 1
				do: 
					[:i | 
					| offset hbar dum |
					offset := (i - 1) * p.
					hbar := (hs at: i) / hmax.
					2 to: p
						do: 
							[:j | 
							matrix 
								at: offset + j
								and: offset + j - 1
								put: 1.0.
							matrix 
								at: offset + j
								and: offset + j - 1 + p
								put: -1.0].
					dum := 1.0.
					1 to: p
						do: 
							[:j | 
							dum := dum * hbar / j.
							j to: p
								do: 
									[:k | 
									matrix 
										at: offset + k - j + 1
										and: offset + k
										put: dum]].
					bvector at: offset + 1 put: (ys at: i + 1) - (ys at: i)].
			self isCyclic 
				ifTrue: 
					[0 to: p - 1
						do: 
							[:j | 
							matrix 
								at: np - j
								and: np - j
								put: 1.0.
							matrix 
								at: np - j
								and: p - j
								put: -1.0]]
				ifFalse: 
					["Zero out higher derivatives at node n and node 1 to get the p end equations."

					| count npass |
					count := 0.
					npass := 0.
					[count < p] whileTrue: 
							[count < p 
								ifTrue: 
									[matrix 
										at: np - count
										and: np - npass
										put: 1.0.
									count := count + 1].
							count < p 
								ifTrue: 
									[matrix 
										at: np - count
										and: p - npass
										put: 1.0.
									count := count + 1].
							npass := npass + 1]].
			derivsVector := GESpMatParPvMarkoFast new 
						solve: matrix
						with: bvector
						saveOriginal: false.
			derivs := StMFullMatrix new: n by: p.
			hmaxpowers := StMFullColumn new: p.
			1 to: p do: [:j | hmaxpowers at: j put: (hmax raisedTo: j)].
			1 to: n
				do: 
					[:i | 
					| derivsi |
					derivsi := derivs at: i.
					derivsi equalFullRow: derivsVector at: (i - 1) * p + 1.
					1 to: p do: [:j | derivsi at: j put: (derivsi at: j) / (hmaxpowers at: j)]]]
]

{ #category : 'calculation' }
StMTestingGeneralSplineX >> computeDerivativesGood [
	"See derivation in 9spline.doc."

	| xs ys |
	degree = 0 
		ifTrue: [self changeClassToThatOf: StMZeroDegreeSplineX basicNew]
		ifFalse: 
			[| n p np matrix bvector y1 hs zero hmax derivsVector hmaxpowers |
			n := xs size.
			p := degree.
			np := n * p.
			matrix := StMSparseMatrix new: np by: np.
			bvector := StMFullColumn new: np.
			y1 := ys at: 1.
			(y1 isKindOf: Array) 
				ifTrue: [zero := (y1 class new: y1 size) atAllPut: Double zero]
				ifFalse: [zero := y1 class zero].
			bvector atAllPut: zero.
			hs := StMFullColumn new: np - 1.
			hmax := 0.0.
			1 to: n - 1
				do: 
					[:i | 
					| h |
					h := (xs at: i + 1) - (xs at: i).
					hmax := hmax max: h abs.
					hs at: i put: h].
			1 to: n - 1
				do: 
					[:i | 
					| offset hbar dum |
					offset := (i - 1) * p.
					hbar := (hs at: i) / hmax.
					2 to: p
						do: 
							[:j | 
							matrix 
								at: offset + j
								and: offset + j - 1
								put: 1.0.
							matrix 
								at: offset + j
								and: offset + j - 1 + p
								put: -1.0].
					dum := 1.0.
					1 to: p
						do: 
							[:j | 
							dum := dum * hbar / j.
							j to: p
								do: 
									[:k | 
									matrix 
										at: offset + k - j + 1
										and: offset + k
										put: dum]].
					bvector at: offset + 1 put: (ys at: i + 1) - (ys at: i)].
			self isCyclic 
				ifTrue: 
					[0 to: p - 1
						do: 
							[:j | 
							matrix 
								at: np - j
								and: np - j
								put: 1.0.
							matrix 
								at: np - j
								and: p - j
								put: -1.0]]
				ifFalse: 
					["Zero out higher derivatives at node n and node 1 to get the p end equations."

					| count npass |
					count := 0.
					npass := 0.
					[count < p] whileTrue: 
							[count < p 
								ifTrue: 
									[matrix 
										at: np - count
										and: np - npass
										put: 1.0.
									count := count + 1].
							count < p 
								ifTrue: 
									[matrix 
										at: np - count
										and: p - npass
										put: 1.0.
									count := count + 1].
							npass := npass + 1]].
			derivsVector := GESpMatParPvMarkoFast new 
						solve: matrix
						with: bvector
						saveOriginal: false.
			derivs := StMFullMatrix new: n by: p.
			hmaxpowers := StMFullColumn new: p.
			1 to: p do: [:j | hmaxpowers at: j put: (hmax raisedTo: p)].
			1 to: n
				do: 
					[:i | 
					| derivsi |
					derivsi := derivs at: i.
					derivsi equalFullRow: derivsVector at: (i - 1) * p + 1.
					1 to: p do: [:j | derivsi at: j put: (derivsi at: j) / (hmaxpowers at: j)]]]
]
