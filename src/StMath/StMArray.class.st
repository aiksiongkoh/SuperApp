"
General like Array. Elements can store anything. This class encapsulate StM methods without affecting the base class Array.
"
Class {
	#name : 'StMArray',
	#superclass : 'Array',
	#type : 'variable',
	#category : 'StMath-StMathArray',
	#package : 'StMath',
	#tag : 'StMathArray'
}

{ #category : 'examples' }
StMArray class >> aaaa [
	"self halt. StMArray aaaa."

	| vector copy |
"	vector := StMFullColumn newWithElements: #(1.0 2.0 3.0 4.0)."
	vector := #($a 2.0 'aaaa' 4.0).
	copy := vector copy.
	copy at: 1 put: 11111.
	^copy = vector
]

{ #category : 'examples' }
StMArray class >> example0 [
	"self halt. self example0."

	| n vector |
	n := 10.
	vector := StMFullColumn new: n.
	vector size = n ifFalse: [self error: 'Check this.'].
	vector nrow = n ifFalse: [self error: 'Check this.'].
	vector ncol = 1 ifFalse: [self error: 'Check this.'].
	vector numberOfElements = n ifFalse: [self error: 'Check this.'].
	1 to: n do: [:i | vector at: i put: i asDouble].
	vector maxElement = n asDouble ifFalse: [self error: 'Check this.'].
	vector minAndMaxValues = (Array with: 1 with: n) ifFalse: [self error: 'Check this.'].
	vector sumOfElements = (vector inject: 0.0 into: [:sum :element | sum + element]) ifFalse: [self error: 'Check this.'].
	vector sumOfSquares = (vector inject: 0.0 into: [:ssq :element | ssq + (element * element)]) ifFalse: [self error: 'Check this.'].
	vector sumOfSquares = (vector sumOfElementsRaisedTo: 2) ifFalse: [self error: 'Check this.'].
	vector rootMeanSquare = (vector sumOfSquares / n) sqrt ifFalse: [self error: 'Check this.'].
	vector length = (vector normL: 2) ifFalse: [self error: 'Check this.']
]

{ #category : 'examples' }
StMArray class >> example0a [
	"self halt. self example0a."

	| vector vector2 vector3 |
	vector := StMFullColumn newWithElements: #(1.0 2.0 3.0 4.0).
	vector2 := StMFullColumn new: 4.
	vector2 at: 1 put: 1.0.
	vector2 at: 2 put: 2.0.
	vector2 at: 3 put: 3.0.
	vector2 at: 4 put: 4.0.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector3 := vector copy.
	vector2 = vector3 ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf isZero ifFalse: [self error: 'Check this.'].
	(vector3 magnifySelf: 0.0) isZero ifFalse: [self error: 'Check this.'].
	vector2 at: 1 putFullColumn: vector.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 equalFullColumn: vector.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 equalFullColumn: vector at: 1.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 at: 1 plusFullColumn: vector.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 equalSelfPlusFullColumn: vector.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 equalSelfPlusFullColumn: vector at: 1.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 at: 1 minusFullColumn: vector.
	vector2 = vector negated ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 equalSelfMinusFullColumn: vector.
	vector2 = vector negated ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 equalSelfMinusFullColumn: vector at: 1.
	vector2 = vector negated ifFalse: [self error: 'Check this.']
]

{ #category : 'examples' }
StMArray class >> example1 [
	"self halt. self example1."

	| vector vector2 vector3 |
	vector := StMFullColumn newWithElements: #(1.0 2.0 3.0 4.0).
	vector2 := StMFullColumn new: 4.
	vector2 at: 1 put: 1.0.
	vector2 at: 2 put: 2.0.
	vector2 at: 3 put: 3.0.
	vector2 at: 4 put: 4.0.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector3 := vector copy.
	vector2 = vector3 ifFalse: [self error: 'Check this.'].
	vector2 at: 1 putFullColumn: vector times: 0.0.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 at: 1 putFullColumn: vector times: 1.0.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 equalFullColumn: vector times: 0.0.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 equalFullColumn: vector times: 1.0.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 at: 1 plusFullColumn: vector times: 0.0.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 at: 1 plusFullColumn: vector times: 1.0.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 equalSelfPlusFullColumn: vector times: 0.0.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 equalSelfPlusFullColumn: vector times: 1.0.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 equalSelfTimes: 1.0 plusFullVector: vector times: 0.0.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 equalSelfTimes: 1.0 plusFullVector: vector times: 1.0.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 equalSelfTimes: 2.0 plusFullVector: vector times: -1.0.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 at: 1 minusFullColumn: vector times: 0.0.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 at: 1 minusFullColumn: vector times: -1.0.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 equalSelfMinusFullColumn: vector times: 0.0.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 equalSelfMinusFullColumn: vector times: -1.0.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 equalSelfTimes: 1.0 minusFullVector: vector times: 0.0.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 equalSelfTimes: 1.0 minusFullVector: vector times: 1.0.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 equalSelfTimes: 2.0 minusFullVector: vector times: -1.0.
	vector2 = vector ifFalse: [self error: 'Check this.']
]

{ #category : 'examples2' }
StMArray class >> example10 [
	"self halt. self example10."
	"#(0.5d 1.0 1.5d 2.0 1.0 2.0 3.0 4.0 5.0)"

	| vector vector2 dum |
	vector := StMFullColumn newWithElements: #(1.0 2.0 3.0 4.0).
	vector2 := StMFullColumn newWithElements: #(1.0 2.0 3.0 4.0 5.0).
	dum := StMFullColumn new: 9.
	dum at: 1 putFullColumn: vector.
	dum at: 5 putFullColumn: vector2.
	dum at: 1 putFullColumn: vector times: 1.0 / 2.0.
	dum at: 5 putFullColumn: vector2.
	dum at: 1 plusFullColumn: vector times: 1.0 / 2.0.
	dum at: 5 plusFullColumn: vector.
	dum at: 1 minusFullColumn: vector times: 1.0 / 2.0.
	dum at: 5 minusFullColumn: vector.
	^dum
]

{ #category : 'examples2' }
StMArray class >> example11 [
	"self halt. self example11."
	"#(2.0 3.0 4.0)"

	| vector vector2 dum |
	vector := StMFullColumn newWithElements: #(1.0 2.0 3.0 4.0).
	vector2 := StMFullColumn newWithElements: #(1.0 2.0 3.0 4.0 5.0).
	dum := StMFullColumn new: 3.
	dum equalFullColumn: vector at: 2.
	dum equalSelfPlusFullColumn: vector2 at: 2.
	dum equalSelfMinusFullColumn: vector2 at: 2.
	^dum
]

{ #category : 'examples2' }
StMArray class >> example11b [
	"self halt. self example11b."
	"#(22.0 32.0 42.0)"

	| matrix dum |
	matrix := StMFullMatrix newWithElements: #(#(11.0 12.0 13.0 14.0) #(21.0 22.0 23.0 24.0) #(31.0 32.0 33.0 34.0) #(41.0 42.0 43.0 44.0)).
	dum := StMFullColumn new: 3.
	dum equalFullMatrix: matrix at: 2 and: 2.
	dum equalSelfPlusFullMatrix: matrix at: 2 and: 2.
	dum equalSelfMinusFullMatrix: matrix at: 2 and: 2.
	^dum
]

{ #category : 'examples2' }
StMArray class >> example11d [
	"self halt. self example11d."
	"#(22.0 23.0 24.0)"

	| matrix dum |
	matrix := StMFullMatrix newWithElements: #(#(11.0 12.0 13.0 14.0) #(21.0 22.0 23.0 24.0) #(31.0 32.0 33.0 34.0) #(41.0 42.0 43.0 44.0)).
	dum := StMFullColumn new: 3.
	dum equalFullMatrix: matrix transpose at: 2 and: 2.
	dum equalSelfPlusFullMatrix: matrix transpose at: 2 and: 2.
	dum equalSelfMinusFullMatrix: matrix transpose at: 2 and: 2.
	^dum
]

{ #category : 'examples2' }
StMArray class >> example12 [
	"self halt. self example12."
	"StMFullMatrix(StMFullRow(-1.0 0.5d nil nil nil) StMFullRow(-2.0 1.0 nil nil nil) StMFullRow(-3.0 
	1.5d nil nil nil) StMFullRow(-4.0 2.0 nil nil nil) StMFullRow(-1.0 -2.0 -3.0 -4.0 nil))"

	| vector dum |
	vector := StMFullColumn newWithElements: #(1.0 2.0 3.0 4.0).
	dum := StMFullMatrix new: 5 by: 5.
	dum at: 1 and: 1 putFullColumn: vector.
	dum at: 1 and: 2 putFullColumn: (vector times: 1.0 / 2.0).
	dum at: 1 and: 1 putFullColumn: vector negated.
	dum at: 5 and: 1 putFullRow: vector transpose.
	dum at: 5 and: 1 putFullRow: (vector transpose times: 1.0 / 2.0).
	dum at: 5 and: 1 putFullRow: vector transpose negated.
	dum at: 1 and: 1 plusFullColumn: vector.
	dum at: 1 and: 1 plusFullColumn: (vector times: 1.0 / 2.0).
	dum at: 1 and: 1 plusFullColumn: vector negated.
	dum at: 5 and: 1 plusFullRow: vector transpose.
	dum at: 5 and: 1 plusFullRow: (vector transpose times: 1.0 / 2.0).
	dum at: 5 and: 1 plusFullRow: vector transpose negated.
	dum at: 1 and: 1 minusFullColumn: vector.
	dum at: 1 and: 1 minusFullColumn: (vector times: 1.0 / 2.0).
	dum at: 1 and: 1 minusFullColumn: vector negated.
	dum at: 5 and: 1 minusFullRow: vector transpose.
	dum at: 5 and: 1 minusFullRow: (vector transpose times: 1.0 / 2.0).
	dum at: 5 and: 1 minusFullRow: vector transpose negated.
	^dum
]

{ #category : 'examples2' }
StMArray class >> example12a [
	"self halt. self example12a."

	| matrix dum |
	matrix := StMFullMatrix newWithElements: #(#(11.0 12.0 13.0 14.0) #(21.0 22.0 23.0 24.0) #(31.0 32.0 33.0 34.0) #(41.0 42.0 43.0 44.0)).
	dum := StMFullMatrix new: 8 by: 8.
	dum at: 1 and: 1 putFullMatrix: matrix.
	dum at: 5 and: 5 putFullMatrix: (matrix times: 1.0 / 2.0).
	dum at: 1 and: 1 putFullMatrix: matrix negated.
	dum at: 5 and: 1 putFullMatrix: matrix transpose.
	dum at: 5 and: 1 putFullMatrix: (matrix transpose times: 1.0 / 2.0).
	dum at: 5 and: 1 putFullMatrix: matrix transpose negated.
	dum at: 1 and: 1 plusFullMatrix: matrix.
	dum at: 1 and: 1 plusFullMatrix: (matrix times: 1.0 / 2.0).
	dum at: 1 and: 1 plusFullMatrix: matrix negated.
	dum at: 5 and: 1 plusFullMatrix: matrix transpose.
	dum at: 5 and: 1 plusFullMatrix: (matrix transpose times: 1.0 / 2.0).
	dum at: 5 and: 1 plusFullMatrix: matrix transpose negated.
	dum at: 1 and: 1 minusFullMatrix: matrix.
	dum at: 1 and: 1 minusFullMatrix: (matrix times: 1.0 / 2.0).
	dum at: 1 and: 1 minusFullMatrix: matrix negated.
	dum at: 5 and: 1 minusFullMatrix: matrix transpose.
	dum at: 5 and: 1 minusFullMatrix: (matrix transpose times: 1.0 / 2.0).
	dum at: 5 and: 1 minusFullMatrix: matrix transpose negated.
	^dum
]

{ #category : 'examples2' }
StMArray class >> example13 [
	"self halt. self example13."

	| matrix dum |
	matrix := StMFullMatrix newWithElements: #(#(11.0 12.0 13.0 14.0) #(21.0 22.0 23.0 24.0) #(31.0 32.0 33.0 34.0) #(41.0 42.0 43.0 44.0)).
	dum := StMFullMatrix new: 3 by: 3.
	dum equalFullMatrix: matrix at: 1 and: 1.
	dum equalFullMatrix: (matrix times: 1.0 / 2.0) at: 1 and: 2.
	dum equalFullMatrix: matrix negated at: 1 and: 1.
	dum equalFullMatrix: matrix transpose at: 2 and: 1.
	dum equalSelfPlusFullMatrix: matrix at: 1 and: 1.
	dum equalSelfPlusFullMatrix: (matrix times: 1.0 / 2.0) at: 1 and: 1.
	dum equalSelfPlusFullMatrix: matrix negated at: 1 and: 1.
	dum equalSelfPlusFullMatrix: matrix transpose at: 2 and: 1.
	dum equalSelfMinusFullMatrix: matrix at: 2 and: 1.
	dum equalSelfMinusFullMatrix: (matrix times: 1.0 / 2.0) at: 1 and: 1.
	dum equalSelfMinusFullMatrix: matrix negated at: 1 and: 1.
	dum equalSelfMinusFullMatrix: matrix transpose at: 2 and: 1.
	^dum
]

{ #category : 'examples' }
StMArray class >> example2 [
	"self halt. self example2."

	| vector vector2 |
	vector := StMFullColumn newWithElements: #(1.0 2.0 3.0 4.0).
	vector2 := vector times: 1.0.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 := vector times: 0.0.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 := vector2 plusFullColumn: vector.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 := vector2 plusFullColumn: vector times: 0.0.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 := vector2 plusFullColumn: vector times: 1.0.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 := vector2 times: 0.0 plusFullColumn: vector.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 := vector2 times: 1.0 plusFullColumn: vector times: -1.0.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 := vector2 minusFullColumn: vector.
	vector2 = vector negated ifFalse: [self error: 'Check this.'].
	vector2 zeroSelf.
	vector2 := vector2 minusFullColumn: vector times: 0.0.
	vector2 isZero ifFalse: [self error: 'Check this.'].
	vector2 := vector2 minusFullColumn: vector times: -1.0.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 := vector2 times: 2.0 minusFullColumn: vector.
	vector2 = vector ifFalse: [self error: 'Check this.'].
	vector2 := vector2 times: 1.0 minusFullColumn: vector times: 1.0.
	vector2 isZero ifFalse: [self error: 'Check this.']
]

{ #category : 'examples' }
StMArray class >> example2a [
	"self halt. self example2a."
	"StMFullColumn(-5.5d -3.5d -1.5d 0.5d)"

	| fullCol fullCol2 dum |
	fullCol := StMFullColumn newWithElements: #(1.0 2.0 3.0 4.0).
	fullCol2 := StMFullColumn newWithElements: #(4.0 3.0 2.0 1.0).
	dum := (StMFullColumn zero: 4).
	dum := (fullCol times: 0.5)
				minusFullColumn: dum.
	dum := (fullCol2 times: 0.5)
				minusFullColumn: dum.
	dum := fullCol2 negated minusFullColumn: dum.
	^dum
]

{ #category : 'examples' }
StMArray class >> example2b [
	"self halt. self example2b."
	"StMFullColumn(-5.5d -3.5d -1.5d 0.5d)"

	| fullCol fullCol2 dum |
	fullCol := StMFullColumn newWithElements: #(1.0 2.0 3.0 4.0).
	fullCol2 := StMFullColumn newWithElements: #(4.0 3.0 2.0 1.0).
	dum := (StMFullColumn zero: 4).
	dum equalSelfPlusFullColumn: fullCol.
	dum equalSelfMinusFullColumn: fullCol.
	dum equalSelfPlusFullColumn: fullCol2 times: 2.0.
	dum equalSelfMinusFullColumn: fullCol2 times: 2.0.
	^dum
]

{ #category : 'examples' }
StMArray class >> example3 [
	"self halt. self example3."
	"84.720732530713d"

	| matrix matrix2 dum |
	matrix := StMFullMatrix newWithElements: #(#(11.0 12.0 13.0) #(21.0 22.0 23.0) #(31.0 32.0 33.0)).
	matrix2 := StMFullMatrix new: 3 by: 3.
	1 to: matrix2 nrow do: [:i | 1 to: matrix2 ncol do: [:j | matrix2 at: i and: j put: (matrix at: i and: j)]].
	matrix2 magnifySelf: 1.5.
	dum := 0.0.
	dum := matrix2 rootMeanSquare + dum.
	dum := matrix2 maxElement + dum.
	^dum
]

{ #category : 'examples3' }
StMArray class >> example31 [
	"self halt. self example31"
	"2 -1 3"

	| aA b |
	aA := StMSparseMatrix new: 3 by: 3.
	aA at: 1 and: 1 put: 2.0.
	aA at: 1 and: 2 put: -5.0.
	aA at: 1 and: 3 put: 1.0.
	aA at: 2 and: 1 put: -1.0.
	aA at: 2 and: 2 put: 3.0.
	aA at: 2 and: 3 put: -1.0.
	aA at: 3 and: 1 put: 3.0.
	aA at: 3 and: 2 put: -4.0.
	aA at: 3 and: 3 put: 2.0.
	b := StMFullColumn new: 3.
	b at: 1 put: 12.0.
	b at: 2 put: -8.0.
	b at: 3 put: 16.0
]

{ #category : 'examples' }
StMArray class >> example4 [
	"self halt. self example4."
	"#(#(181.5d 198.0 214.5d) #(346.5d 363.0 379.5d) #(511.5d 528.0 544.5d))"

	| matrix matrix2 dum |
	matrix := StMFullMatrix newWithElements: #(#(11.0 12.0 13.0) #(21.0 22.0 23.0) #(31.0 32.0 33.0)).
	matrix2 := StMFullMatrix newWithElements: #(#(110.0 120.0 130.0) #(210.0 220.0 230.0) #(310.0 320.0 330.0)).
	dum := StMFullMatrix newWithElements: #(#(0.0 0.0 0.0) #(0.0 0.0 0.0) #(0.0 0.0 0.0)).
	dum := ((matrix times: 1.0/ 2.0) plusFullMatrix: (matrix2 times: 1.0/ 2.0)) plusFullMatrix: dum.
	dum := ((matrix times: 1.0/ 2.0) plusFullMatrix: matrix2) plusFullMatrix: dum.
	dum := ((matrix times: 1.0/ 2.0) plusFullMatrix: matrix2 negated) plusFullMatrix: dum.
	dum := (matrix plusFullMatrix: (matrix2 times: 1.0/ 2.0)) plusFullMatrix: dum.
	dum := (matrix plusFullMatrix: matrix2) plusFullMatrix: dum.
	dum := (matrix plusFullMatrix: matrix2 negated) plusFullMatrix: dum.
	dum := (matrix negated plusFullMatrix: (matrix2 times: 1.0/ 2.0)) plusFullMatrix: dum.
	dum := (matrix negated plusFullMatrix: matrix2) plusFullMatrix: dum.
	dum := (matrix negated plusFullMatrix: matrix2 negated) plusFullMatrix: dum.
	^dum
]

{ #category : 'examples' }
StMArray class >> example4a [
	"self halt. self example4a."
	"#(#(-148.5 -162.0 -175.5) #(-283.5 -297.0 -310.5) #(-418.5 -432.0 -445.5))"

	| matrix matrix2 dum |
	matrix := StMFullMatrix newWithElements: #(#(11.0 12.0 13.0) #(21.0 22.0 23.0) #(31.0 32.0 33.0)).
	matrix2 := StMFullMatrix newWithElements: #(#(110.0 120.0 130.0) #(210.0 220.0 230.0) #(310.0 320.0 330.0)).
	dum := StMFullMatrix newWithElements: #(#(0.0 0.0 0.0) #(0.0 0.0 0.0) #(0.0 0.0 0.0)).
	dum := ((matrix times: 1.0/ 2.0) minusFullMatrix: (matrix2 times: 1.0/ 2.0)) plusFullMatrix: dum.
	dum := ((matrix times: 1.0/ 2.0) minusFullMatrix: matrix2) plusFullMatrix: dum.
	dum := ((matrix times: 1.0/ 2.0) minusFullMatrix: matrix2 negated) plusFullMatrix: dum.
	dum := (matrix minusFullMatrix: (matrix2 times: 1.0/ 2.0)) plusFullMatrix: dum.
	dum := (matrix minusFullMatrix: matrix2) plusFullMatrix: dum.
	dum := (matrix minusFullMatrix: matrix2 negated) plusFullMatrix: dum.
	dum := (matrix negated minusFullMatrix: (matrix2 times: 1.0/ 2.0)) plusFullMatrix: dum.
	dum := (matrix negated minusFullMatrix: matrix2) plusFullMatrix: dum.
	dum := (matrix negated minusFullMatrix: matrix2 negated) plusFullMatrix: dum.
	^dum
]

{ #category : 'examples' }
StMArray class >> example5 [
	"self halt. self example5."
	" StMFullMatrix(StMFullRow(227.33333333333 254.0 280.66666666667) StMFullRow(428.0 454.66666666667 481.33333333333) StMFullRow(628.66666666667 655.33333333333 682.0))"

	| matrix matrix2 matrix3 dum |
	matrix := StMFullMatrix newWithElements: #(#(11.0 12.0 13.0) #(21.0 22.0 23.0) #(31.0 32.0 33.0)).
	matrix2 := StMFullMatrix newWithElements: #(#(110.0 120.0 130.0) #(210.0 220.0 230.0) #(310.0 320.0 330.0)).
	matrix3 := matrix transpose.
	dum := StMFullMatrix newWithElements: #(#(0.0 0.0 0.0) #(0.0 0.0 0.0) #(0.0 0.0 0.0)).
	dum := ((matrix3 times: 1.0 / 3.0) plusFullMatrix: (matrix2 times: 1.0 / 3.0)) plusFullMatrix: dum.
	dum := (matrix2 plusFullMatrix: matrix3) plusFullMatrix: dum.
	dum := ((matrix3 times: 1.0 / 3.0) minusFullMatrix: (matrix2 times: 1.0 / 3.0)) plusFullMatrix: dum.
	dum := (matrix2 minusFullMatrix: matrix3) plusFullMatrix: dum.
	^dum
]

{ #category : 'examples' }
StMArray class >> example6 [
	"self halt. self example6."

	| vector matrix answer1 |
	vector := StMFullColumn newWithElements: #(1.0 2.0 3.0).
	matrix := StMFullMatrix newWithElements: #(#(11.0 12.0 13.0) #(21.0 22.0 23.0) #(31.0 32.0 33.0) #(41.0 42.0 43.0)).
	answer1 := matrix timesFullColumn: vector.
	vector := StMFullColumn newWithElements: #(1.0 2.0 3.0).
	matrix := StMFullMatrix newWithElements: #(#(11.0) #(21.0) #(31.0) #(41.0)).
	answer1 := matrix timesFullRow: vector transpose.
	vector := StMFullColumn newWithElements: #(1.0 2.0 3.0 4.0).
	matrix := StMFullMatrix newWithElements: #(#(11.0 12.0 13.0) #(21.0 22.0 23.0) #(31.0 32.0 33.0) #(41.0 42.0 43.0)).
	answer1 := matrix transpose timesFullColumn: vector.
	vector := StMFullColumn newWithElements: #(1.0 2.0 3.0).
	matrix := StMFullMatrix newWithElements: #(#(11.0 12.0 13.0)).
	answer1 := matrix transpose timesFullRow: vector transpose.
	^answer1
]

{ #category : 'examples' }
StMArray class >> example7 [
	"self halt. self example7."

	| vector vector2 answer1 |
	vector := StMFullColumn newWithElements: #(1.0 2.0 3.0).
	vector2 := StMFullColumn newWithElements: #(1 2 3 4).
	answer1 := vector2 timesFullColumn: vector.
	vector := StMFullColumn newWithElements: #(1.0 2.0 3.0).
	vector2 := StMFullColumn newWithElements: #(1 2 3 4).
	answer1 := vector2 timesFullRow: vector transpose.
	vector := StMFullColumn newWithElements: #(1.0 2.0 3.0 4.0).
	vector2 := StMFullColumn newWithElements: #(1 2 3 4).
	answer1 := vector2 transpose timesFullColumn: vector.
	vector := StMFullColumn newWithElements: #(1.0 2.0 3.0).
	vector2 := StMFullColumn newWithElements: #(1 2 3 4).
	answer1 := vector2 transpose timesFullRow: vector transpose.
	^answer1
]

{ #category : 'examples' }
StMArray class >> example8 [
	"self halt. self example8."

	| matrix matrix2 answer1 |
	matrix := StMFullMatrix newWithElements: #(#(11.0 12.0 13.0) #(21.0 22.0 23.0) #(31.0 32.0 33.0) #(41.0 42.0 43.0)).
	matrix2 := StMFullMatrix newWithElements: #(#(11.0 12.0 13.0) #(21.0 22.0 23.0) #(31.0 32.0 33.0)).
	answer1 := matrix timesFullMatrix: matrix2.
	matrix := StMFullMatrix newWithElements: #(#(11.0 12.0 13.0) #(21.0 22.0 23.0) #(31.0 32.0 33.0) #(41.0 42.0 43.0)).
	matrix2 := StMFullMatrix newWithElements: #(#(11.0 12.0 13.0) #(21.0 22.0 23.0) #(31.0 32.0 33.0) #(41.0 42.0 43.0)).
	answer1 := matrix timesFullMatrix: matrix2 transpose.
	matrix := StMFullMatrix newWithElements: #(#(11.0 12.0 13.0) #(21.0 22.0 23.0) #(31.0 32.0 33.0) #(41.0 42.0 43.0)).
	matrix2 := StMFullMatrix newWithElements: #(#(11.0 12.0 13.0) #(21.0 22.0 23.0) #(31.0 32.0 33.0) #(41.0 42.0 43.0)).
	answer1 := matrix transpose timesFullMatrix: matrix2.
	matrix := StMFullMatrix newWithElements: #(#(11.0 12.0 13.0) #(21.0 22.0 23.0) #(31.0 32.0 33.0)).
	matrix2 := StMFullMatrix newWithElements: #(#(11.0 12.0 13.0) #(21.0 22.0 23.0) #(31.0 32.0 33.0) #(41.0 42.0 43.0)).
	answer1 := matrix transpose timesFullMatrix: matrix2 transpose.
	^answer1
]

{ #category : 'examples' }
StMArray class >> example9 [
	"self halt. self example9."

	| vector matrix answer1 answer2 |
	vector := StMFullColumn newWithElements: #(1.0 2.0 3.0).
	matrix := StMFullMatrix newWithElements: #(#(11.0 12.0 13.0)).
	answer1 := vector timesFullMatrix: matrix.
	vector := StMFullColumn newWithElements: #(1.0 2.0 3.0).
	matrix := StMFullMatrix newWithElements: #(#(11.0) #(21.0) #(31.0) #(41.0)).
	answer1 := vector timesFullMatrix: matrix transpose.
	answer2 := vector timesTransposeFullMatrix: matrix.
	vector := StMFullColumn newWithElements: #(1.0 2.0 3.0 4.0).
	matrix := StMFullMatrix newWithElements: #(#(11.0 12.0 13.0) #(21.0 22.0 23.0) #(31.0 32.0 33.0) #(41.0 42.0 43.0)).
	answer1 := vector transpose timesFullMatrix: matrix.
	answer2 := vector transposeTimesFullMatrix: matrix.
	vector := StMFullColumn newWithElements: #(1.0 2.0 3.0).
	matrix := StMFullMatrix newWithElements: #(#(11.0 12.0 13.0)).
	answer1 := vector transpose timesFullMatrix: matrix transpose.
	^answer1
]

{ #category : 'instance creation' }
StMArray class >> newWithElements: aArray [ 
	| answer |
	answer := aArray shallowCopy.
	(answer isKindOf: StMArray)
		ifFalse: [answer := answer changeClassToThatOf: (self new: 0)].
	(answer at: 1) isFloat
		ifTrue: [1 to: answer size do: [:i | answer at: i put: (aArray at: i) asDouble]]
		ifFalse: [1 to: answer size do: [:i | answer at: i put: (self newWithElements: (aArray at: i))]].
	^answer
]

{ #category : 'accessing' }
StMArray class >> veryShortName [

	^ 'Arr'
]

{ #category : 'VisualWorks metadata' }
StMArray class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
	)

]

{ #category : 'instance creation' }
StMArray class >> zero: n [ 
	^(self new: n) zeroSelf
]

{ #category : 'instance creation' }
StMArray class >> zero: n unitAt: i [ 
	"StMFullColumn zero: 3 unitAt: 1"

	| answer |
	answer := self zero: n.
	answer at: i put: 1.0.
	^answer
]

{ #category : 'basic ops' }
StMArray >> * aNumber [ 
	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				* aNumber].
	^answer
]

{ #category : 'basic ops' }
StMArray >> + array [ 
	"No checking for speed. Assumes correct dimensions and type."

	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				+ (array at: i)].
	^answer
]

{ #category : 'basic ops' }
StMArray >> - array [ 
	"No checking for speed. Assumes correct dimensions and type."

	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				- (array at: i)].
	^answer
]

{ #category : 'basic ops' }
StMArray >> / aNumber [ 
	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				/ aNumber].
	^answer
]

{ #category : 'testing' }
StMArray >> < aStMArray [ 
	1 to: self size
		do: [:i | (self at: i) < (aStMArray at: i) ifFalse: [^false]].
	^true
]

{ #category : 'testing' }
StMArray >> <= aStMArray [ 
	1 to: self size
		do: [:i | (self at: i) <= (aStMArray at: i) ifFalse: [^false]].
	^true
]

{ #category : 'testing' }
StMArray >> = aObject [ 
	^self == aObject or: 
			[self class == aObject class and: 
					[self basicSize == aObject basicSize and: 
							[1 to: self size do: [:i | (self at: i) = (aObject at: i) ifFalse: [^false]].
							true]]]
]

{ #category : 'testing' }
StMArray >> > aStMArray [ 
	1 to: self size
		do: [:i | (self at: i) > (aStMArray at: i) ifFalse: [^false]].
	^true
]

{ #category : 'testing' }
StMArray >> >= aStMArray [ 
	1 to: self size
		do: [:i | (self at: i) >= (aStMArray at: i) ifFalse: [^false]].
	^true
]

{ #category : 'norms' }
StMArray >> addTo: cNumber [ 
	| selfAt1 |
	selfAt1 := self at: 1.
	^selfAt1 isFloat 
		ifTrue: [cNumber addAll: self]
		ifFalse: [1 to: self size do: [:i | (self at: i) addTo: cNumber]]
]

{ #category : 'basic ops' }
StMArray >> arrangeElementsAccordingTo: arrayOfOriginalPositions [ 
	| n answer elementi |
	n := self size.
	answer := self class new: n.
	1 to: n
		do: 
			[:i | 
			elementi := self at: (arrayOfOriginalPositions at: i).
			answer at: i put: elementi].
	^answer
]

{ #category : 'converting' }
StMArray >> asFullColumn [
	^self shallowCopy changeClassToThatOf: (StMFullColumn new: 0)
]

{ #category : 'converting' }
StMArray >> asFullMatrix [
	self subclassResponsibility
]

{ #category : 'converting' }
StMArray >> asFullRow [
	self subclassResponsibility
]

{ #category : 'converting' }
StMArray >> asSparseColumn [
	self subclassResponsibility
]

{ #category : 'converting' }
StMArray >> asSparseMatrix [
	self subclassResponsibility
]

{ #category : 'converting' }
StMArray >> asSparseRow [
	self subclassResponsibility
]

{ #category : 'converting' }
StMArray >> asSymbolic [

	^ self collect: [ :item | item asSymbolic ]
]

{ #category : 'converting' }
StMArray >> asValue [

	^ self collect: [ :e | e asValue ]
]

{ #category : 'ops on self' }
StMArray >> at: i times: aNumber [ 
	self at: i put: ((self at: i)
			times: aNumber)
]

{ #category : 'ops on self' }
StMArray >> conditionSelf [
	"Answer a self with insignificant elements set to zeros."

	| tol |
	tol := self maxElement * MachineAccuracy OfDouble.
	self conditionSelfWithTol: tol
]

{ #category : 'ops on self' }
StMArray >> conditionSelfVectorWithTol: tol [ 
	| element |
	1 to: self size
		do: 
			[:i | 
			element := self at: i.
			element < 0.0 ifTrue: [element := 0.0 - element].
			element < tol ifTrue: [self at: i put: 0.0]]
]

{ #category : 'ops on self' }
StMArray >> conditionSelfWithTol: tol [ 
	(self at: 1) isFloat
		ifTrue: [self conditionSelfVectorWithTol: tol]
		ifFalse: [1 to: self size do: [:i | (self at: i)
					conditionSelfWithTol: tol]]
]

{ #category : 'basic ops' }
StMArray >> conditioned [
	"Answer a fresh vector with insignificant elements set to zeros."

	^self copy conditionSelf
]

{ #category : 'basic ops' }
StMArray >> conditionedWithTol: tol [ 
	"Answer a fresh vector with insignificant elements set to zeros."

	^self copy conditionSelfWithTol: tol
]

{ #category : 'basic ops' }
StMArray >> differentiateWRT: aVar [ 
	^self collect: [:item | item differentiateWRT: aVar]
]

{ #category : 'basic ops' }
StMArray >> dot1: stmArray [ 
	"Either receiver or argument must be a one dimensional array."
	"Assume the same first dimensions."

	| array1D array answer |
	(self at: 1) isFloat
		ifTrue: 
			[array1D := self.
			array := stmArray]
		ifFalse: [(stmArray at: 1) isFloat
				ifTrue: 
					[array1D := stmArray.
					array := self]
				ifFalse: [self error: 'Dot product requires either receiver or argument to be one dimensional.']].
	answer := (array at: 1)
				* (array1D at: 1).
	answer isFloat
		ifTrue: [2 to: array1D size do: [:i | answer := answer + ((array at: i)
								* (array1D at: i))]]
		ifFalse: [2 to: array1D size do: [:i | answer equalSelfPlus: (array at: i)
						* (array1D at: i)]].
	^answer
]

{ #category : 'basic ops' }
StMArray >> dot: stmArray [
	"Either receiver or argument must be a one dimensional array."

	"Assume the same first dimensions."

	| array1D array answer |
	self is1D
		ifTrue: [
			array1D := self.
			array := stmArray ]
		ifFalse: [
			stmArray is1D
				ifTrue: [
					array1D := stmArray.
					array := self ]
				ifFalse: [
					self error:
						'Dot product requires either receiver or argument to be one dimensional.' ] ].
	answer := (array at: 1) * (array1D at: 1).
	(answer isCollection and: [ answer isSequenceable ])
		ifTrue: [
			2 to: array1D size do: [ :i |
			answer equalSelfPlus: (array at: i) * (array1D at: i) ] ]
		ifFalse: [
			2 to: array1D size do: [ :i |
			answer := answer + ((array at: i) * (array1D at: i)) ] ].
	^ answer
]

{ #category : 'accessing' }
StMArray >> elementClass [
	"Vector and Matrix are intended to store numbers of the same class."

	^Double
]

{ #category : 'basic ops' }
StMArray >> elementTimesElementOf: stmArray [ 
	"Element by element multiplication."

	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				* (stmArray at: i)].
	^answer
]

{ #category : 'ops on self' }
StMArray >> equal: stmArray [ 
	"Assume self and stmArray are same type and dimensions."

	(self at: 1) isFloat
		ifTrue: [1 to: self size do: [:i | self at: i put: (stmArray at: i)]]
		ifFalse: [1 to: self size do: [:i | (self at: i)
					equal: (stmArray at: i)]]
]

{ #category : 'ops on self' }
StMArray >> equal: stmArray at: ii1 [ 
	"Assume self and stmArray are same type and dimensions."

	(self at: 1) isFloat
		ifTrue: 
			[| iiOffset |
			iiOffset := ii1 - 1.
			1 to: self size do: [:i | self at: i put: (stmArray at: iiOffset + i)]]
		ifFalse: 
			[| iiOffset |
			iiOffset := ii1 - 1.
			1 to: self size do: [:i | (self at: i)
					equal: (stmArray at: iiOffset + i)]]
]

{ #category : 'ops on self' }
StMArray >> equal: stmArray at: ii1 and: jj1 [ 
	| iiOffset |
	iiOffset := ii1 - 1.
	1 to: self nrow do: [:i | (self at: i)
			equal: (stmArray at: iiOffset + i)
			at: jj1]
]

{ #category : 'ops on self' }
StMArray >> equal: stmArray times: number [ 
	"Assume self and stmArray are same type and dimensions."

	(self at: 1) isFloat
		ifTrue: [1 to: self size do: [:i | self at: i put: (stmArray at: i)
						* number]]
		ifFalse: [1 to: self size do: [:i | (self at: i)
					equal: (stmArray at: i)
					times: number]]
]

{ #category : 'comparing' }
StMArray >> equal: array tol: tol [
	"Assume self and stmArray are same type and dimensions."

	1 to: self size do: [ :i | ((self at: i) equal: (array at: i) tol: tol) ifFalse: [ ^ false ] ].
	^ true
]

{ #category : 'ops on self' }
StMArray >> equalSelfMinus: stmArray [ 
	"Assume self and stmArray are same type and dimensions."

	(self at: 1) isFloat
		ifTrue: [1 to: self size do: [:i | self at: i put: (self at: i)
						- (stmArray at: i)]]
		ifFalse: [1 to: self size do: [:i | (self at: i)
					equalSelfMinus: (stmArray at: i)]]
]

{ #category : 'ops on self' }
StMArray >> equalSelfMinus: stmArray at: ii1 [ 
	"Assume self and stmArray are same type and dimensions."

	(self at: 1) isFloat
		ifTrue: 
			[| iiOffset |
			iiOffset := ii1 - 1.
			1 to: self size do: [:i | self at: i put: (self at: i)
						- (stmArray at: iiOffset + i)]]
		ifFalse: 
			[| iiOffset |
			iiOffset := ii1 - 1.
			1 to: self size do: [:i | (self at: i)
					equalSelfMinus: (stmArray at: iiOffset + i)]]
]

{ #category : 'ops on self' }
StMArray >> equalSelfMinus: stmArray at: ii1 and: jj1 [ 
	| iiOffset |
	iiOffset := ii1 - 1.
	1 to: self nrow do: [:i | (self at: i)
			equalSelfMinus: (stmArray at: iiOffset + i)
			at: jj1]
]

{ #category : 'ops on self' }
StMArray >> equalSelfMinus: stmArray times: number [ 
	"Assume self and stmArray are same type and dimensions."

	self equalSelfPlus: stmArray times: number negated
]

{ #category : 'ops on self' }
StMArray >> equalSelfPlus: stmArray [ 
	"Assume self and stmArray are same type and dimensions."

	(self at: 1) isFloat
		ifTrue: [1 to: self size do: [:i | self at: i put: (self at: i)
						+ (stmArray at: i)]]
		ifFalse: [1 to: self size do: [:i | (self at: i)
					equalSelfPlus: (stmArray at: i)]]
]

{ #category : 'ops on self' }
StMArray >> equalSelfPlus: stmArray at: ii1 [ 
	"Assume self and stmArray are same type and dimensions."

	(self at: 1) isFloat
		ifTrue: 
			[| iiOffset |
			iiOffset := ii1 - 1.
			1 to: self size do: [:i | self at: i put: (self at: i)
						+ (stmArray at: iiOffset + i)]]
		ifFalse: 
			[| iiOffset |
			iiOffset := ii1 - 1.
			1 to: self size do: [:i | (self at: i)
					equalSelfPlus: (stmArray at: iiOffset + i)]]
]

{ #category : 'ops on self' }
StMArray >> equalSelfPlus: stmArray at: ii1 and: jj1 [ 
	| iiOffset |
	iiOffset := ii1 - 1.
	1 to: self nrow do: [:i | (self at: i)
			equalSelfPlus: (stmArray at: iiOffset + i)
			at: jj1]
]

{ #category : 'ops on self' }
StMArray >> equalSelfPlus: stmArray times: number [ 
	"Assume self and stmArray are same type and dimensions."

	(self at: 1) isFloat
		ifTrue: [1 to: self size do: [:i | self at: i put: (self at: i)
						+ ((stmArray at: i)
								* number)]]
		ifFalse: [1 to: self size do: [:i | (self at: i)
					equalSelfPlus: (stmArray at: i)
					times: number]]
]

{ #category : 'ops on self' }
StMArray >> equalSelfTimes: alpha minus: stmArray times: beta [ 
	self
		equalSelfTimes: alpha
		plus: stmArray
		times: beta negated
]

{ #category : 'ops on self' }
StMArray >> equalSelfTimes: alpha plus: stmArray times: beta [ 
	"Assume self and stmArray are same type and dimensions."
	"alpha and beta are numbers."

	(self at: 1) isFloat
		ifTrue: [1 to: self size do: [:i | self at: i put: (self at: i)
						* alpha + ((stmArray at: i)
							* beta)]]
		ifFalse: [1 to: self size do: [:i | (self at: i)
					equalSelfTimes: alpha
					plus: (stmArray at: i)
					times: beta]]
]

{ #category : 'testing' }
StMArray >> is1D [
	"^first isSequenceable not"

	| first |
	first := self at: 1.
	^first isFloat or: [first isSymbolic]
]

{ #category : 'testing' }
StMArray >> isZero [
	1 to: self size do: [:i | (self at: i) isZero ifFalse: [^false]].
	^true
]

{ #category : 'norms' }
StMArray >> length [
	"Euclidean norm."
	"Square root of the sum of squares."

	^self sumOfSquares sqrt
]

{ #category : 'ops on self' }
StMArray >> magnifySelf: aNumber [ 
	"Magnify every number in the receiver by aNumber."

	aNumber = 1 ifTrue: [^self].
	(self at: 1) isFloat
		ifTrue: [self magnifySelfVector: aNumber]
		ifFalse: [1 to: self size do: [:i | (self at: i)
					magnifySelf: aNumber]]
]

{ #category : 'ops on self' }
StMArray >> magnifySelfVector: aNumber [ 
	"Magnify every number in the receiver by aNumber."

	aNumber = 1 ifTrue: [^self].
	1 to: self size do: [:i | self at: i put: (self at: i)
				* aNumber]
]

{ #category : 'basic ops' }
StMArray >> max: array [ 
	| answer |
	answer := self shallowCopy.
	1 to: self size do: [:i | answer at: i put: ((self at: i)
				max: (array at: i))].
	^answer
]

{ #category : 'norms' }
StMArray >> maxElement [
	| selfAt1 |
	selfAt1 := self at: 1.
	^selfAt1 isFloat
		ifTrue: [self maxElementOfVector]
		ifFalse: 
			[| answer |
			answer := selfAt1 maxElement.
			2 to: self size
				do: 
					[:i | 
					| element |
					element := (self at: i) maxElement.
					answer < element ifTrue: [answer := element]].
			answer]
]

{ #category : 'norms' }
StMArray >> maxElementOfVector [
	| selfAt1 answer |
	selfAt1 := self at: 1.
	selfAt1 < 0.0 ifTrue: [selfAt1 := 0.0 - selfAt1].
	answer := selfAt1.
	2 to: self size
		do: 
			[:i | 
			| selfAti |
			selfAti := self at: i.
			selfAti < 0.0 ifTrue: [selfAti := 0.0 - selfAti].
			answer < selfAti ifTrue: [answer := selfAti]].
	^answer
]

{ #category : 'accessing' }
StMArray >> maxPrint [

	^ 50000
]

{ #category : 'basic ops' }
StMArray >> min: array [ 
	| answer |
	answer := self shallowCopy.
	1 to: self size do: [:i | answer at: i put: ((self at: i)
				min: (array at: i))].
	^answer
]

{ #category : 'norms' }
StMArray >> minAndMaxValues [
	| selfAt1 |
	selfAt1 := self at: 1.
	^selfAt1 isFloat
		ifTrue: [self minAndMaxValuesOfVector]
		ifFalse: 
			[| rowMinAndMaxValues min max |
			rowMinAndMaxValues := selfAt1 minAndMaxValues.
			min := rowMinAndMaxValues at: 1.
			max := rowMinAndMaxValues at: 2.
			2 to: self size
				do: 
					[:i | 
					| rowMin rowMax |
					rowMinAndMaxValues := (self at: i) minAndMaxValues.
					rowMin := rowMinAndMaxValues at: 1.
					rowMax := rowMinAndMaxValues at: 2.
					min < rowMin ifFalse: [min := rowMin].
					max > rowMax ifFalse: [max := rowMax]].
			Array with: min with: max]
]

{ #category : 'norms' }
StMArray >> minAndMaxValuesOfVector [
	"Answer array of min value and max value."

	| min max |
	min := self at: 1.
	max := min.
	2 to: self size
		do: 
			[:i | 
			| selfAti |
			selfAti := self at: i.
			min < selfAti ifFalse: [min := selfAti].
			max > selfAti ifFalse: [max := selfAti]].
	^Array with: min with: max
]

{ #category : 'accessing' }
StMArray >> minValue [

	| selfAt1 |
	selfAt1 := self at: 1.
	^selfAt1 isFloat
		ifTrue: [self minValueOfVector]
		ifFalse: 
			[| answer |
			answer := selfAt1 minValue.
			2 to: self size
				do: 
					[:i |
					| element |
					element := (self at: i) minValue.
					answer > element ifTrue: [answer := element]].
			answer]
]

{ #category : 'accessing' }
StMArray >> minValueOfVector [

	| answer |
	answer := self at: 1.
	2 to: self size
		do: 
			[:i |
			| selfAti |
			selfAti := self at: i.
			answer > selfAti ifTrue: [answer := selfAti]].
	^answer
]

{ #category : 'basic ops' }
StMArray >> minus: stmArray times: aNumber [ 
	^self plus: stmArray times: aNumber negated
]

{ #category : 'basic ops' }
StMArray >> minusNumber: aNumber [ 
	"Minus aNumber from each element."

	^self plusNumber: aNumber negated
]

{ #category : 'ops on self' }
StMArray >> mostNegativeSelf [
	(self at: 1) isSequenceable
		ifTrue: [1 to: self size do: [:i | (self at: i) mostNegativeSelf]]
		ifFalse: [self mostNegativeSelfOfVector]
]

{ #category : 'ops on self' }
StMArray >> mostNegativeSelfOfVector [
	| largestNegative |
	largestNegative := MachineAccuracy OfLargestDouble negated.
	1 to: self size do: [:i | self at: i put: largestNegative]
]

{ #category : 'ops on self' }
StMArray >> mostPositiveSelf [
	(self at: 1) isSequenceable
		ifTrue: [1 to: self size do: [:i | (self at: i) mostPositiveSelf]]
		ifFalse: [self mostPositiveSelfOfVector]
]

{ #category : 'ops on self' }
StMArray >> mostPositiveSelfOfVector [
	| largest |
	largest := MachineAccuracy OfLargestDouble.
	1 to: self size do: [:i | self at: i put: largest]
]

{ #category : 'basic ops' }
StMArray >> moveElementsToPositionsSpecifiedBy: arrayOfNewPositions [ 
	| n answer newi |
	n := self size.
	answer := self class new: n.
	1 to: n
		do: 
			[:i | 
			newi := arrayOfNewPositions at: i.
			answer at: newi put: (self at: i)].
	^answer
]

{ #category : 'ops on self' }
StMArray >> negateSelf [
	"Negate every number in the array."

	self magnifySelf: -1.0
]

{ #category : 'basic ops' }
StMArray >> negated [
	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i) negated].
	^answer
]

{ #category : 'accessing' }
StMArray >> numberClass [
	"Vector and Matrix are intended to store numbers of the same class."

	^Double
]

{ #category : 'accessing' }
StMArray >> numberOfElements [
	"Answer the number of elements in the full vector or matrix."

	self subclassResponsibility
]

{ #category : 'accessing' }
StMArray >> numberOfNonZeros [
	"Answer the number of non-zeros in the full vector or matrix."

	self subclassResponsibility
]

{ #category : 'norms' }
StMArray >> numberOfNumbers [
	| selfAt1 |
	selfAt1 := self at: 1.
	^selfAt1 isFloat 
		ifTrue: [self size]
		ifFalse: 
			[| sum |
			sum := selfAt1 numberOfNumbers.
			2 to: self size do: [:i | sum := sum + (self at: i) numberOfNumbers].
			sum]
]

{ #category : 'accessing' }
StMArray >> numberOfStorageLocations [
	"Answer the total number of numbers 'values' can hold."

	self subclassResponsibility
]

{ #category : 'accessing' }
StMArray >> numberOfStoredElements [
	"Answer the actual number of numbers 'values' is holding."

	self subclassResponsibility
]

{ #category : 'accessing' }
StMArray >> numberOfStoredNonZeros [
	"Vector or matrix must store all the non zeros."

	self numberOfNonZeros
]

{ #category : 'accessing' }
StMArray >> numberOfStoredZeros [
	"Answer the actual number of zeros 'values' is holding."

	self subclassResponsibility
]

{ #category : 'accessing' }
StMArray >> numberOfZeros [
	"Answer the number of zeros in the full vector or matrix."

	self subclassResponsibility
]

{ #category : 'basic ops' }
StMArray >> plus: stmArray times: aNumber [ 
	"No checking for speed. Assumes correct dimensions and type."

	| n answer |
	n := self size.
	answer := self class new: n.
	(self at: 1) isSequenceable
		ifTrue: [1 to: n do: [:i | answer at: i put: ((self at: i)
						plus: (stmArray at: i)
						times: aNumber)]]
		ifFalse: [1 to: n do: [:i | answer at: i put: (self at: i)
						+ ((stmArray at: i)
								* aNumber)]].
	^answer
]

{ #category : 'basic ops' }
StMArray >> plusNumber: aNumber [ 
	"Plus aNumber from each element."

	| n answer |
	n := self size.
	answer := self class new: n.
	(self at: 1) isSequenceable
		ifTrue: [1 to: n do: [:i | answer at: i put: ((self at: i)
						plusNumber: aNumber)]]
		ifFalse: [1 to: n do: [:i | answer at: i put: (self at: i)
						+ aNumber]].
	^answer
]

{ #category : 'testing' }
StMArray >> positive [
	1 to: self size do: [:i | (self at: i) positive ifFalse: [^false]].
	^true
]

{ #category : 'copying' }
StMArray >> postCopy [
	(self at: 1) isFloat ifFalse: [1 to: self size do: [:i | self at: i put: (self at: i) copy]]
]

{ #category : 'printing' }
StMArray >> printOn: aStream [ 
	"Append to the argument, aStream, the elements of the Array 
	enclosed by parentheses."

	| tooMany |
	tooMany := aStream position + self maxPrint.
	aStream
		nextPutAll: self class veryShortName;
		nextPutAll: '('.
	self do: 
			[:element | 
			(element isCollection and: [element isSequenceable]) ifTrue: [aStream cr].
			aStream position > tooMany 
				ifTrue: 
					[aStream nextPutAll: '...(more)...)'.
					^self].
			element printOn: aStream]
		separatedBy: [aStream space].
	aStream nextPut: $)
]

{ #category : 'basic ops' }
StMArray >> productFromDouble: aNumber [ 
	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				* aNumber].
	^answer
]

{ #category : 'basic ops' }
StMArray >> productFromInteger: aInteger [ 
	^self productFromDouble: aInteger asDouble
]

{ #category : 'basic ops' }
StMArray >> productFromSmallDouble: aNumber [ 
	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				* aNumber].
	^answer
]

{ #category : 'norms' }
StMArray >> rootMeanSquare [
	"(sumOfSquares / numberOfElements) sqrt"

	^(self sumOfSquares / self numberOfElements) sqrt
]

{ #category : 'basic ops' }
StMArray >> roundTo: aDouble [ 
	^self collect: [:arg | arg roundTo: aDouble]
]

{ #category : 'basic ops' }
StMArray >> rounded [
	^self collect: [:item | item rounded]
]

{ #category : 'ops on self' }
StMArray >> scaleSelfBy: aFullColumn [ 
	"Magnify every element in the receiver by corresponding element in aFullColumn."

	(self at: 1) isFloat 
		ifTrue: [1 to: self size do: [:i | self at: i times: (aFullColumn at: i)]]
		ifFalse: 
			[1 to: self size do: [:i | (self at: i) magnifySelf: (aFullColumn at: i)]]
]

{ #category : 'basic ops' }
StMArray >> simplified [
	^self collect: [:item | item simplified]
]

{ #category : 'evaluating' }
StMArray >> simplifyAll [

	^ self collect: [ :item | item simplifyAll ]
]

{ #category : 'accessing' }
StMArray >> standardDeviation [
	"
	sigma := sqrt(sum((x - xbar)^2)/n)
	sigma := sqrt(sum((x^2 - 2*x*xbar + xbar^2))/n)
	sigma := sqrt((sum(x^2) - sum(2*x*xbar) + sum(xbar^2))/n)
	sigma := sqrt((sum(x^2) - 2*sum(x)*xbar + n*xbar^2)/n)
	sigma := sqrt((sum(x^2) - 2*sum(x)^2/n + n*sum(x)^2/n^2)/n)
	sigma := sqrt((sum(x^2) - sum(x)^2/n)/n)
	sigma := sqrt((n*sum(x^2) - sum(x)^2)/n^2)
	"

	| n cNumber sum ssq aNumber |
	n := self numberOfNumbers.
	cNumber := (SortedCollection new: n) sortBlock: [:x :y | x abs <= y abs].
	self addTo: cNumber.
	sum := ssq := 0.0.
	1 to: n
		do: 
			[:i | 
			aNumber := cNumber at: i.
			sum := sum + aNumber.
			ssq := ssq + (aNumber * aNumber)].
	^((n * ssq - (sum * sum)) / (n * n)) sqrt
]

{ #category : 'norms' }
StMArray >> sumOfAbsElements [
	"Sum of all element abs values."

	| selfAt1 |
	selfAt1 := self at: 1.
	^selfAt1 isFloat
		ifTrue: [self sumOfAbsElementsOfVector]
		ifFalse: 
			[| sum |
			sum := selfAt1 sumOfAbsElements.
			2 to: self size do: [:i | sum := sum + (self at: i) sumOfAbsElements].
			sum]
]

{ #category : 'norms' }
StMArray >> sumOfAbsElementsOfVector [
	| sum selfAt1 |
	selfAt1 := self at: 1.
	sum := selfAt1 > 0.0
				ifTrue: [selfAt1]
				ifFalse: [0.0 - selfAt1].
	2 to: self size
		do: 
			[:i | 
			| selfAti |
			selfAti := self at: i.
			sum := selfAti > 0.0
						ifTrue: [sum + selfAti]
						ifFalse: [sum - selfAti]].
	^sum
]

{ #category : 'norms' }
StMArray >> sumOfElements [
	"Sum of all elements."

	| selfAt1 |
	selfAt1 := self at: 1.
	^selfAt1 isFloat
		ifTrue: [self sumOfElementsOfVector]
		ifFalse: 
			[| sum |
			sum := selfAt1 sumOfElements.
			2 to: self size do: [:i | sum := sum + (self at: i) sumOfElements].
			sum]
]

{ #category : 'norms' }
StMArray >> sumOfElementsOfVector [
	| sum |
	sum := self at: 1.
	2 to: self size do: [:i | sum := sum + (self at: i)].
	^sum
]

{ #category : 'norms' }
StMArray >> sumOfElementsOfVectorRaisedTo: number [ 
	"For each element abs it, raised it to the power of number."
	"Then sum them all."

	| selfAt1 sum |
	selfAt1 := self at: 1.
	selfAt1 < 0.0 ifTrue: [selfAt1 := 0.0 - selfAt1].
	sum := selfAt1 raisedTo: number.
	2 to: self size
		do: 
			[:i | 
			| selfAti |
			selfAti := self at: i.
			selfAti < 0.0 ifTrue: [selfAti := 0.0 - selfAti].
			sum := sum + (selfAti raisedTo: number)].
	^sum
]

{ #category : 'norms' }
StMArray >> sumOfElementsRaisedTo: number [ 
	"For each element abs it, raised it to the power of number."
	"Then sum them all."

	| selfAt1 |
	selfAt1 := self at: 1.
	^selfAt1 isFloat
		ifTrue: [self sumOfElementsOfVectorRaisedTo: number]
		ifFalse: 
			[| sum |
			sum := selfAt1 sumOfElementsRaisedTo: number.
			2 to: self size do: [:i | sum := sum + ((self at: i)
								sumOfElementsRaisedTo: number)].
			sum]
]

{ #category : 'norms' }
StMArray >> sumOfSquares [
	"Sum of squares of all elements."

	| selfAt1 |
	selfAt1 := self at: 1.
	^ selfAt1 isSequenceable not
		  ifTrue: [ self sumOfSquaresOfVector ]
		  ifFalse: [
			  | sum |
			  sum := selfAt1 sumOfSquares.
			  2 to: self size do: [ :i | sum := sum + (self at: i) sumOfSquares ].
			  sum ]
]

{ #category : 'norms' }
StMArray >> sumOfSquaresOfVector [
	"Sum of squares of all elements."

	| selfAt1 sum |
	selfAt1 := self at: 1.
	sum := selfAt1 * selfAt1.
	2 to: self size
		do: 
			[:i | 
			| selfAti |
			selfAti := self at: i.
			sum := sum + (selfAti * selfAti)].
	^sum
]

{ #category : 'basic ops' }
StMArray >> times: aNumber [ 
	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: ((self at: i)
				times: aNumber)].
	^answer
]

{ #category : 'basic ops' }
StMArray >> times: alpha minus: stmArray [ 
	"a*alpha - b."
	"Assume all checking of validity of this operation has been done."
	"Just evaluate quickly."

	| n answer |
	n := self size.
	answer := self class new: n.
	(self at: 1) isSequenceable
		ifTrue: [1 to: n do: [:i | answer at: i put: ((self at: i)
						times: alpha minus: (stmArray at: i))]]
		ifFalse: [1 to: n do: [:i | answer at: i put: (self at: i)
						* alpha - (stmArray at: i)]].
	^answer
]

{ #category : 'basic ops' }
StMArray >> times: beta minus: stmArray times: alpha [ 
	^self
		times: beta
		plus: stmArray
		times: alpha negated
]

{ #category : 'basic ops' }
StMArray >> times: alpha plus: stmArray [ 
	"a*alpha + b."
	"Assume all checking of validity of this operation has been done."
	"Just evaluate quickly."

	^stmArray plus: self times: alpha
]

{ #category : 'basic ops' }
StMArray >> times: beta plus: stmArray times: alpha [ 
	"a*alpha + b*beta = b*beta + a*alpha."
	"Assume all checking of validity of this operation has been done."
	"Just evaluate quickly."

	| n answer |
	n := self size.
	answer := self class new: n.
	(self at: 1) isSequenceable
		ifTrue: [1 to: n do: [:i | answer at: i put: ((self at: i)
						times: beta
						plus: (stmArray at: i)
						times: alpha)]]
		ifFalse: [1 to: n do: [:i | answer at: i put: (self at: i)
						* beta + ((stmArray at: i)
							* alpha)]].
	^answer
]

{ #category : 'basic ops' }
StMArray >> transpose [
	"Answer the transpose of self."

	self subclassResponsibility
]

{ #category : 'accessing' }
StMArray >> u [
	^self at: 1
]

{ #category : 'accessing' }
StMArray >> u: object [ 
	^self at: 1 put: object
]

{ #category : 'accessing' }
StMArray >> v [
	^self at: 2
]

{ #category : 'accessing' }
StMArray >> v: object [ 
	^self at: 2 put: object
]

{ #category : 'accessing' }
StMArray >> w [
	^self at: 3
]

{ #category : 'accessing' }
StMArray >> x [
	^self at: 1
]

{ #category : 'accessing' }
StMArray >> x: object [ 
	^self at: 1 put: object
]

{ #category : 'accessing' }
StMArray >> xy [

	^self copyFrom: 1 to: 2
]

{ #category : 'accessing' }
StMArray >> y [
	^self at: 2
]

{ #category : 'accessing' }
StMArray >> y: object [ 
	^self at: 2 put: object
]

{ #category : 'accessing' }
StMArray >> z [
	^self at: 3
]

{ #category : 'accessing' }
StMArray >> z: object [ 
	^self at: 3 put: object
]

{ #category : 'basic ops' }
StMArray >> zeroCopy [
	^(self at: 1) isFloat
		ifTrue: [self zeroCopyOfVector]
		ifFalse: 
			[| answer |
			answer := self shallowCopy.
			1 to: answer size do: [:i | answer at: i put: (answer at: i) zeroCopy].
			answer]
]

{ #category : 'basic ops' }
StMArray >> zeroCopyOfVector [
	| answer |
	answer := self shallowCopy.
	1 to: answer size do: [:i | answer at: i put: 0.0].
	^answer
]

{ #category : 'ops on self' }
StMArray >> zeroSelf [
	"Zero all stored numbers in array."

	(self at: 1) isCollection
		ifTrue: [1 to: self size do: [:i | (self at: i) zeroSelf]]
		ifFalse: [self zeroSelfOfVector]
]

{ #category : 'ops on self' }
StMArray >> zeroSelfOfVector [
	"Zero all stored numbers in array."

	1 to: self size do: [:i | self at: i put: 0.0]
]
