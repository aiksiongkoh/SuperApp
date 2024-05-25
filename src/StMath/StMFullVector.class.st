"
Stores doubles only.
"
Class {
	#name : 'StMFullVector',
	#superclass : 'StMArray',
	#type : 'variable',
	#category : 'StMath-StMathArray',
	#package : 'StMath',
	#tag : 'StMathArray'
}

{ #category : 'instance creation' }
StMFullVector class >> fromCollection: aCollection aBlock: aBlock [ 
	| size aFullColumn |
	size := aCollection size.
	aFullColumn := self new: size.
	1 to: size
		do: [:i | aFullColumn at: i put: (aBlock value: (aCollection at: i))].
	^aFullColumn
]

{ #category : 'instance creation' }
StMFullVector class >> ofOrdinalsSize: n [ 
	"aVector filled with 1 to n in order."

	^(super new: n) fillWithOrdinals
]

{ #category : 'VisualWorks metadata' }
StMFullVector class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'instance creation' }
StMFullVector class >> with: firstObject with: secondObject with1: thirdObject [ 
	"For debugging only"

	| newCollection length |
	newCollection := self new: 3.
	newCollection at: 1 put: firstObject.
	newCollection at: 2 put: secondObject.
	newCollection at: 3 put: thirdObject.
	firstObject isFloat 
		ifTrue: 
			[length := newCollection length.
			length = 1 ifTrue: [self halt]].
	^newCollection
]

{ #category : 'ops on self' }
StMFullVector >> at: i1 minusFullVector: aFullVector [ 
	| iOffset i |
	iOffset := i1 - 1.
	1 to: aFullVector size
		do: 
			[:ii | 
			i := iOffset + ii.
			self at: i put: (self at: i)
					- (aFullVector at: ii)]
]

{ #category : 'ops on self' }
StMFullVector >> at: i1 minusFullVector: aFullVector times: aNumber [ 
	| iOffset i |
	iOffset := i1 - 1.
	1 to: aFullVector size
		do: 
			[:ii | 
			i := iOffset + ii.
			self at: i put: (self at: i)
					- ((aFullVector at: ii)
							* aNumber)]
]

{ #category : 'ops on self' }
StMFullVector >> at: i minusNumber: aNumber [ 
	self at: i put: (self at: i) - aNumber
]

{ #category : 'ops on self' }
StMFullVector >> at: i1 plusFullVector: aFullVector [ 
	| iOffset i |
	iOffset := i1 - 1.
	1 to: aFullVector size
		do: 
			[:ii | 
			i := iOffset + ii.
			self at: i put: (self at: i)
					+ (aFullVector at: ii)]
]

{ #category : 'ops on self' }
StMFullVector >> at: i1 plusFullVector: aFullVector times: aNumber [ 
	| iOffset i |
	iOffset := i1 - 1.
	1 to: aFullVector size
		do: 
			[:ii | 
			i := iOffset + ii.
			self at: i put: (self at: i)
					+ ((aFullVector at: ii)
							* aNumber)]
]

{ #category : 'ops on self' }
StMFullVector >> at: i plusNumber: aNumber [ 
	self at: i put: (self at: i) + aNumber
]

{ #category : 'ops on self' }
StMFullVector >> at: i1 putFullVector: aFullVector [ 
	| iOffset |
	iOffset := i1 - 1.
	1 to: aFullVector size do: [:ii | self at: iOffset + ii put: (aFullVector at: ii)]
]

{ #category : 'ops on self' }
StMFullVector >> at: i1 putFullVector: aFullVector times: number [ 
	| iOffset |
	iOffset := i1 - 1.
	1 to: aFullVector size do: [:ii | self at: iOffset + ii put: (aFullVector at: ii)
				* number]
]

{ #category : 'ops on self' }
StMFullVector >> at: i times: aNumber [ 
	^self at: i put: (self at: i)
			* aNumber
]

{ #category : 'basic ops' }
StMFullVector >> cross: aVector [ 
	| a1 a2 a3 b1 b2 b3 answer |
	a1 := self at: 1.
	a2 := self at: 2.
	a3 := self at: 3.
	b1 := aVector at: 1.
	b2 := aVector at: 2.
	b3 := aVector at: 3.
	answer := self class new: 3.
	answer at: 1 put: a2 * b3 - (a3 * b2).
	answer at: 2 put: a3 * b1 - (a1 * b3).
	answer at: 3 put: a1 * b2 - (a2 * b1).
	^answer
]

{ #category : 'ops on self' }
StMFullVector >> equalFullVector: aFullVector [ 
	1 to: self size do: [:i | self at: i put: (aFullVector at: i)]
]

{ #category : 'ops on self' }
StMFullVector >> equalFullVector: aFullVector at: ii1 [ 
	| iiOffset |
	iiOffset := ii1 - 1.
	1 to: self size do: [:i | self at: i put: (aFullVector at: iiOffset + i)]
]

{ #category : 'ops on self' }
StMFullVector >> equalFullVector: aFullVector times: aNumber [ 
	1 to: self size do: [:i | self at: i put: (aFullVector at: i)
				* aNumber]
]

{ #category : 'ops on self' }
StMFullVector >> equalSelfMinusFullVector: aFullVector [ 
	1 to: self size do: [:i | self at: i put: (self at: i)
				- (aFullVector at: i)]
]

{ #category : 'ops on self' }
StMFullVector >> equalSelfMinusFullVector: aFullVector at: ii1 [ 
	| iiOffset |
	iiOffset := ii1 - 1.
	1 to: self size do: [:i | self at: i put: (self at: i)
				- (aFullVector at: iiOffset + i)]
]

{ #category : 'ops on self' }
StMFullVector >> equalSelfMinusFullVector: aFullVector times: aNumber [ 
	1 to: self size do: [:i | self at: i put: (self at: i)
				- ((aFullVector at: i)
						* aNumber)]
]

{ #category : 'ops on self' }
StMFullVector >> equalSelfMinusSparseVector: aSparseVector [ 
	aSparseVector keysAndValuesDo: [:i :value | self at: i put: (self at: i)
				- value]
]

{ #category : 'ops on self' }
StMFullVector >> equalSelfMinusSparseVector: aSparseVector times: aNumber [ 
	aSparseVector keysAndValuesDo: [:i :value | self at: i put: (self at: i)
				- (value * aNumber)]
]

{ #category : 'ops on self' }
StMFullVector >> equalSelfPlusFullVector: aFullVector [ 
	1 to: self size do: [:i | self at: i put: (self at: i)
				+ (aFullVector at: i)]
]

{ #category : 'ops on self' }
StMFullVector >> equalSelfPlusFullVector: aFullVector at: ii1 [ 
	| iiOffset |
	iiOffset := ii1 - 1.
	1 to: self size do: [:i | self at: i put: (self at: i)
				+ (aFullVector at: iiOffset + i)]
]

{ #category : 'ops on self' }
StMFullVector >> equalSelfPlusFullVector: aFullVector times: aNumber [ 
	1 to: self size do: [:i | self at: i put: (self at: i)
				+ ((aFullVector at: i)
						* aNumber)]
]

{ #category : 'ops on self' }
StMFullVector >> equalSelfPlusSparseVector: aSparseVector [ 
	aSparseVector keysAndValuesDo: [:i :value | self at: i put: (self at: i)
				+ value]
]

{ #category : 'ops on self' }
StMFullVector >> equalSelfPlusSparseVector: aSparseVector times: aNumber [ 
	aSparseVector keysAndValuesDo: [:i :value | self at: i put: (self at: i)
				+ (value * aNumber)]
]

{ #category : 'ops on self' }
StMFullVector >> equalSelfTimes: alpha minusFullVector: aFullVector times: beta [ 
	1 to: self size do: [:i | self at: i put: (self at: i)
				* alpha - ((aFullVector at: i)
					* beta)]
]

{ #category : 'ops on self' }
StMFullVector >> equalSelfTimes: alpha plusFullVector: aFullVector times: beta [ 
	1 to: self size do: [:i | self at: i put: (self at: i)
				* alpha + ((aFullVector at: i)
					* beta)]
]

{ #category : 'ops on self' }
StMFullVector >> fillWithOrdinals [
	1 to: self size do: [:i | self at: i put: i]
]

{ #category : 'testing' }
StMFullVector >> iMax [
	"Answer the index of the largest element."

	| answer iMax |
	answer := self at: 1.
	iMax := 1.
	2 to: self size
		do: 
			[:i | 
			| dum |
			dum := self at: i.
			dum > answer
				ifTrue: 
					[answer := dum.
					iMax := i]].
	^iMax
]

{ #category : 'testing' }
StMFullVector >> iMin [
	"Answer the index of the smallest element."

	| answer iMin |
	answer := self at: 1.
	iMin := 1.
	2 to: self size
		do: 
			[:i | 
			| dum |
			dum := self at: i.
			dum < answer
				ifTrue: 
					[answer := dum.
					iMin := i]].
	^iMin
]

{ #category : 'testing' }
StMFullVector >> isDecreasing [
	"Test if elements are monotonically decreasing."

	^self isDecreasingIfExceptionsAreLessThan: Number zero
]

{ #category : 'testing' }
StMFullVector >> isDecreasingIfExceptionsAreLessThan: tol [ 
	"Test if elements are decreasing."
	"Ok if spoilers are less than tol."

	| next |
	next := self at: 1.
	2 to: self size do: [:i | 
			| previous |
			previous := next.
			next := self at: i.
			next < previous ifFalse: [next - previous < tol ifFalse: [^false]]].
	^true
]

{ #category : 'testing' }
StMFullVector >> isIncreasing [
	"Test if elements are monotonically increasing."

	^self isIncreasingIfExceptionsAreLessThan: Number zero
]

{ #category : 'testing' }
StMFullVector >> isIncreasingIfExceptionsAreLessThan: tol [ 
	"Test if elements are increasing."
	"Ok if spoilers are less than tol."

	| next |
	next := self at: 1.
	2 to: self size do: [:i | 
			| previous |
			previous := next.
			next := self at: i.
			next > previous ifFalse: [previous - next < tol ifFalse: [^false]]].
	^true
]

{ #category : 'basic ops' }
StMFullVector >> minusFullVector: aFullVector [ 
	"No checking for speed. Assumes correct dimensions and type."

	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				- (aFullVector at: i)].
	^answer
]

{ #category : 'basic ops' }
StMFullVector >> minusFullVector: aFullVector times: number [ 
	"No checking for speed. Assumes correct dimensions and type."

	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				- ((aFullVector at: i)
						* number)].
	^answer
]

{ #category : 'basic ops' }
StMFullVector >> minusNumber: aNumber [ 
	"Minus aNumber from each element."
	"Answer new vector."

	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				- aNumber].
	^answer
]

{ #category : 'norms' }
StMFullVector >> normL: number [ 
	^(self sumOfElementsRaisedTo: number)
		raisedTo: number reciprocal
]

{ #category : 'ops on self' }
StMFullVector >> normalizeSelf [
	| length |
	length := self length.
	length = 0 ifTrue: [self error: 'StM: Inappropriate to normalize a null vector.'].
	self magnifySelf: 1.0 / length
]

{ #category : 'accessing' }
StMFullVector >> normalized [
	| answer |
	answer := self copy.
	answer normalizeSelf.
	^answer
]

{ #category : 'accessing' }
StMFullVector >> numberOfElements [
	"Borrowed from size."

	<primitive: 62>
	^self basicSize
]

{ #category : 'printing' }
StMFullVector >> outputOnFile: aString [ 
	| writeStream aij aijString |
	writeStream := aString asFilename writeStream.
	1 to: self size
		do: 
			[:i | 
			aij := self at: i.
			aij == nil ifTrue: [aij := 0.0].
			aijString := aij printString.
			aijString last == $d
				ifTrue: [aijString replaceAll: $d with: Character space]
				ifFalse: [aijString replaceAll: $d with: $e].
			writeStream nextPutAll: aijString.
			writeStream cr].
	writeStream flush; close
]

{ #category : 'basic ops' }
StMFullVector >> plusFullVector: aFullVector [ 
	"No checking for speed. Assumes correct dimensions and type."

	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				+ (aFullVector at: i)].
	^answer
]

{ #category : 'basic ops' }
StMFullVector >> plusFullVector: aFullVector times: number [ 
	"No checking for speed. Assumes correct dimensions and type."

	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				+ ((aFullVector at: i)
						* number)].
	^answer
]

{ #category : 'basic ops' }
StMFullVector >> plusNumber: aNumber [ 
	"Plus aNumber from each element."
	"Answer new vector."

	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				+ aNumber].
	^answer
]

{ #category : 'norms' }
StMFullVector >> rootMeanSquareWeighted: weights [ 
	"Note that the vector is scaled by the weights before the rms."

	| n vector |
	n := self size.
	vector := self class new: n.
	1 to: n do: [:i | vector at: i put: (self at: i)
				* (weights at: i)].
	^vector rootMeanSquare
]

{ #category : 'basic ops' }
StMFullVector >> scaledWith: scalingVector forRows: i1 to: i2 [ 
	"Return self scaled with scaling vector."

	i1 to: i2 do: [:i | self at: i put: (self at: i)
				* (scalingVector at: i)]
]

{ #category : 'basic ops' }
StMFullVector >> tildeMatrix [
	"tildeMatrix is related to angular velocity and cross product."

	self size == 3
		ifTrue: 
			[| tilde c1 c2 c3 |
			tilde := StMFullMatrix new: 3 by: 3.
			c1 := self at: 1.
			c2 := self at: 2.
			c3 := self at: 3.
			tilde at: 1 and: 1 put: 0.0.
			tilde at: 2 and: 2 put: 0.0.
			tilde at: 3 and: 3 put: 0.0.
			tilde at: 2 and: 3 put: 0.0 - c1.
			tilde at: 1 and: 3 put: c2.
			tilde at: 1 and: 2 put: 0.0 - c3.
			tilde at: 2 and: 1 put: c3.
			tilde at: 3 and: 1 put: 0.0 - c2.
			tilde at: 3 and: 2 put: c1.
			^tilde]
		ifFalse: [self error: 'Column is not of dimension 3.']
]

{ #category : 'basic ops' }
StMFullVector >> times: aNumber [ 
	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				* aNumber].
	^answer
]

{ #category : 'basic ops' }
StMFullVector >> times: alpha minusFullVector: aFullVector [ 
	"a*alpha + b."
	"Assume all checking of validity of this operation has been done."
	"Just evaluate quickly."

	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				* alpha - (aFullVector at: i)].
	^answer
]

{ #category : 'basic ops' }
StMFullVector >> times: beta minusFullVector: aFullVector times: alpha [ 
	"a*alpha + b*beta = b*beta + a*alpha."
	"Assume all checking of validity of this operation has been done."
	"Just evaluate quickly."

	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				* beta - ((aFullVector at: i)
					* alpha)].
	^answer
]

{ #category : 'basic ops' }
StMFullVector >> times: alpha plusFullVector: aFullVector [ 
	"a*alpha + b."
	"Assume all checking of validity of this operation has been done."
	"Just evaluate quickly."

	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				* alpha + (aFullVector at: i)].
	^answer
]

{ #category : 'basic ops' }
StMFullVector >> times: beta plusFullVector: aFullVector times: alpha [ 
	"a*alpha + b*beta = b*beta + a*alpha."
	"Assume all checking of validity of this operation has been done."
	"Just evaluate quickly."

	| n answer |
	n := self size.
	answer := self class new: n.
	1 to: n do: [:i | answer at: i put: (self at: i)
				* beta + ((aFullVector at: i)
					* alpha)].
	^answer
]

{ #category : 'testing' }
StMFullVector >> validateElements [
	"Check that all elements are real numbers."

	1 to: self size do: [:i | (self at: i) isFloat ifFalse: [self error: 'StM: Elements of Vector should be real numbers.']]
]
