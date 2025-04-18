"
Used by SparseMatrix. The second dimension size (size2) is stored in SparseMatrix and not by individual IdentityDictionarys.
"
Class {
	#name : 'StMSparseVector',
	#superclass : 'VWIdentityDictionary',
	#type : 'variable',
	#instVars : [
		'fullsize'
	],
	#category : 'StMath-StMathArray',
	#package : 'StMath',
	#tag : 'StMathArray'
}

{ #category : 'instance creation' }
StMSparseVector class >> new: aInteger [ 
	^(super new: aInteger)
		fullsize: aInteger
]

{ #category : 'VisualWorks metadata' }
StMSparseVector class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
	)

]

{ #category : 'basic ops *' }
StMSparseVector >> * aNumber [ 
	| answer |
	answer := self copy.
	^answer magnifySelf: aNumber
]

{ #category : 'testing' }
StMSparseVector >> = otherCollection [ 
	"Answer whether the two sparse vectors are equal even in structure."

	| basicSize |
	self species == otherCollection species ifFalse: [^false].
	self tally = otherCollection tally ifFalse: [^false].
	self numberOfElements = otherCollection numberOfElements ifFalse: [^false].
	(basicSize := self basicSize) = otherCollection basicSize ifFalse: [^false].
	1 to: basicSize do: [:index | (self at: index)
			= (otherCollection at: index) ifFalse: [^false]].
	self valueArray = otherCollection valueArray ifFalse: [^false].
	^true
]

{ #category : 'accessing' }
StMSparseVector >> at2: key [ 
	"Behaves like IdentityDictionary>at: but specialized for numbers."

	| length index continue value |
	length := self basicSize.
	index := key \\ length + 1.
	continue := true.
	
	[| probe |
	probe := self basicAt: index.
	probe == nil
		ifTrue: 
			[value := nil.
			continue := false]
		ifFalse: [probe == key
				ifTrue: 
					[value := valueArray at: index.
					continue := false]
				ifFalse: [(index := index + 1) > length ifTrue: [index := 1]]].
	continue] whileTrue.
	^value
]

{ #category : 'accessing' }
StMSparseVector >> at: key [ 
	"Behaves like IdentityDictionary>at: but specialized for numbers."

	| length index |
	length := self basicSize.
	index := key \\ length + 1.
	[true]
		whileTrue: 
			[| probe |
			probe := self basicAt: index.
			probe == nil
				ifTrue: [^nil]
				ifFalse: [probe == key
						ifTrue: [^valueArray at: index]
						ifFalse: [(index := index + 1) > length ifTrue: [index := 1]]]]
]

{ #category : 'ops on self -' }
StMSparseVector >> at: i minusFullVector: aFullVector [ 
	| iOffset |
	iOffset := i - 1.
	1 to: aFullVector size do: [:ii | self at: iOffset + ii minusNumber: (aFullVector at: ii)]
]

{ #category : 'ops on self -' }
StMSparseVector >> at: i minusFullVector: aFullVector times: aNumber [ 
	| iOffset |
	iOffset := i - 1.
	1 to: aFullVector size do: [:ii | self at: iOffset + ii minusNumber: (aFullVector at: ii)
				* aNumber]
]

{ #category : 'ops on self -' }
StMSparseVector >> at: key minusNumber: aNumber [ 
	"Efficient method for row at: key put: ((row at: key) + aNumber)"

	| length index answer |
	length := self basicSize.
	index := key \\ length + 1.
	[true]
		whileTrue: 
			[| probe |
			probe := self basicAt: index.
			probe == nil
				ifTrue: 
					[tally := tally + 1.
					self basicAt: index put: key.
					valueArray at: index put: 0.0 - aNumber.
					length - tally <= (length // 4) ifTrue: [self grow].
					^aNumber]
				ifFalse: [probe == key
						ifTrue: 
							[answer := (valueArray at: index)
										- aNumber.
							valueArray at: index put: answer.
							^aNumber]
						ifFalse: [(index := index + 1) > length ifTrue: [index := 1]]]]
]

{ #category : 'ops on self -' }
StMSparseVector >> at: i1 minusSparseVector: aSparseVector [ 
	| ioffset |
	ioffset := i1 - 1.
	aSparseVector keysAndValuesDo: [:ii :value | self at: ioffset + ii minusNumber: value]
]

{ #category : 'ops on self +' }
StMSparseVector >> at: i plusFullVector: aFullVector [ 
	| iOffset |
	iOffset := i - 1.
	1 to: aFullVector size do: [:ii | self at: iOffset + ii plusNumber: (aFullVector at: ii)]
]

{ #category : 'ops on self +' }
StMSparseVector >> at: i plusFullVector: aFullVector times: aNumber [ 
	| iOffset |
	iOffset := i - 1.
	1 to: aFullVector size do: [:ii | self at: iOffset + ii plusNumber: (aFullVector at: ii)
				* aNumber]
]

{ #category : 'ops on self +' }
StMSparseVector >> at: key plusNumber: aNumber [ 
	"Efficient method for row at: key put: ((row at: key) + aNumber)"

	| length index answer |
	length := self basicSize.
	index := key \\ length + 1.
	[true]
		whileTrue: 
			[| probe |
			probe := self basicAt: index.
			probe == nil
				ifTrue: 
					[tally := tally + 1.
					self basicAt: index put: key.
					valueArray at: index put: aNumber.
					length - tally <= (length // 4) ifTrue: [self grow].
					^aNumber]
				ifFalse: [probe == key
						ifTrue: 
							[answer := (valueArray at: index)
										+ aNumber.
							valueArray at: index put: answer.
							^aNumber]
						ifFalse: [(index := index + 1) > length ifTrue: [index := 1]]]]
]

{ #category : 'ops on self +' }
StMSparseVector >> at: i1 plusSparseVector: aSparseVector [ 
	| ioffset |
	ioffset := i1 - 1.
	aSparseVector keysAndValuesDo: [:ii :value | self at: ioffset + ii plusNumber: value]
]

{ #category : 'accessing' }
StMSparseVector >> at: key put: aNumber [ 
	"Behaves like IdentityDictionary>at:put: but specialized for numbers."

	| length index |
	length := self basicSize.
	index := key \\ length + 1.
	[true]
		whileTrue: 
			[| probe |
			probe := self basicAt: index.
			probe == nil
				ifTrue: 
					[tally := tally + 1.
					self basicAt: index put: key.
					valueArray at: index put: aNumber.
					length - tally <= (length // 4) ifTrue: [self grow].
					^aNumber]
				ifFalse: [probe == key
						ifTrue: 
							[valueArray at: index put: aNumber.
							^aNumber]
						ifFalse: [(index := index + 1) > length ifTrue: [index := 1]]]]
]

{ #category : 'ops on self' }
StMSparseVector >> at: i putFullVector: aFullVector [ 
	| iOffset |
	iOffset := i - 1.
	1 to: aFullVector size do: [:ii | self at: iOffset + ii put: (aFullVector at: ii)]
]

{ #category : 'ops on self' }
StMSparseVector >> at: i putFullVector: aFullVector times: number [ 
	| iOffset |
	iOffset := i - 1.
	1 to: aFullVector size do: [:ii | self at: iOffset + ii put: (aFullVector at: ii)
				* number]
]

{ #category : 'ops on self *' }
StMSparseVector >> at: key times: aNumber [ 
	"Efficient method for row at: key put: ((row at: key) * aNumber)"

	| length index |
	aNumber = 1 ifTrue: [^aNumber].
	length := self basicSize.
	index := key \\ length + 1.
	[true]
		whileTrue: 
			[| probe |
			probe := self basicAt: index.
			probe == nil ifFalse: [probe == key
					ifTrue: 
						[valueArray at: index put: (valueArray at: index)
								* aNumber.
						^aNumber]
					ifFalse: [(index := index + 1) > length ifTrue: [index := 1]]]]
]

{ #category : 'accessing' }
StMSparseVector >> atIndex: index [ 
	^valueArray at: index
]

{ #category : 'ops on self' }
StMSparseVector >> conditionSelf [
	"self become new sparse vector with significant elements only."

	self become: self conditioned
]

{ #category : 'ops on self' }
StMSparseVector >> conditionSelfWithTol: tol [ 
	"self become new sparse vector with significant elements only."

	| newSelf |
	newSelf := self conditionedWithTol: tol.
	self become: newSelf
]

{ #category : 'basic ops' }
StMSparseVector >> conditioned [
	"Answer a fresh sparse vector of significant elements."

	| tol |
	tol := self maxElement * MachineAccuracy OfDouble.
	^self conditionedWithTol: tol
]

{ #category : 'basic ops' }
StMSparseVector >> conditionedWithTol: tol [ 
	"Answer a fresh sparse vector of significant elements."

	| answer |
	answer := self class new.
	self keysAndValuesDo: [:key :value | value abs >= tol ifTrue: [answer at: key put: value]].
	^answer
]

{ #category : 'basic ops' }
StMSparseVector >> dot: aVector [ 
	"Inner dot product."

	| answer valueArray |
	answer := 0.0.
	1 to: self basicSize
		do: 
			[:index | 
			| key |
			key := self basicAt: index.
			key == nil ifFalse: [answer := (valueArray at: index) * (aVector at: key) + answer]].
	^answer
]

{ #category : 'ops on self -' }
StMSparseVector >> equalSelfMinusSparseVector: aSparseVector [ 
	aSparseVector keysAndValuesDo: [:i :value | self at: i minusNumber: value]
]

{ #category : 'ops on self -' }
StMSparseVector >> equalSelfMinusSparseVector: aSparseVector times: aNumber [ 
	aSparseVector keysAndValuesDo: [:i :value | self at: i minusNumber: value * aNumber]
]

{ #category : 'ops on self +' }
StMSparseVector >> equalSelfPlusSparseVector: aSparseVector [ 
	aSparseVector keysAndValuesDo: [:i :value | self at: i plusNumber: value]
]

{ #category : 'ops on self +' }
StMSparseVector >> equalSelfPlusSparseVector: aSparseVector times: aNumber [ 
	aSparseVector keysAndValuesDo: [:i :value | self at: i plusNumber: value * aNumber]
]

{ #category : 'private' }
StMSparseVector >> findKeyOrNil: key [ 
	"Look for the key in the receiver. If it is found, answer 
	the index of the association containting the key, otherwise 
	answer the index of the first unused slot."
	"key is anInteger."

	| index length |
	length := self basicSize.
	index := key \\ length + 1.
	[true]
		whileTrue: 
			[| probe |
			probe := self basicAt: index.
			probe == nil
				ifTrue: [^index]
				ifFalse: [probe == key
						ifTrue: [^index]
						ifFalse: [(index := index + 1) > length ifTrue: [index := 1]]]]
]

{ #category : 'accessing' }
StMSparseVector >> fullsize: aInteger [ 
	fullsize := aInteger
]

{ #category : 'adding' }
StMSparseVector >> grow [
	| oldfullsize |
	oldfullsize := fullsize.
	super grow.
	fullsize := oldfullsize
]

{ #category : 'testing' }
StMSparseVector >> isSequenceable [
	"Answers true."

	^true
]

{ #category : 'testing' }
StMSparseVector >> isZero [
	| value |
	1 to: self basicSize
		do: 
			[:index | 
			value := valueArray at: index.
			(value == nil or: [value isZero])
				ifFalse: [^false]].
	^true
]

{ #category : 'norms' }
StMSparseVector >> length [
	"Euclidean norm."
	"Square root of the sum of squares."

	^self sumOfSquares sqrt
]

{ #category : 'ops on self' }
StMSparseVector >> magnifySelf: double [ 
	double = 1 ifTrue: [^self].
	1 to: self basicSize do: [:index | (self basicAt: index)
			== nil ifFalse: [valueArray at: index put: (valueArray at: index)
					* double]]
]

{ #category : 'norms' }
StMSparseVector >> maxElement [
	"abs is not efficient."

	| answer |
	answer := 0.0.
	1 to: self basicSize
		do: 
			[:index | 
			| num |
			num := valueArray at: index.
			num == nil
				ifFalse: 
					[num < 0.0 ifTrue: [num := 0.0 - num].
					answer < num ifTrue: [answer := num]]].
	^answer
]

{ #category : 'accessing' }
StMSparseVector >> maxPrint [

	^ 50000
]

{ #category : 'norms' }
StMSparseVector >> minAndMaxValues [
	| min max num valueArray |
	min := 1.0e300.
	max := min negated.
	1 to: self basicSize
		do: 
			[:index | 
			num := valueArray at: index.
			num == nil
				ifFalse: 
					[min < num ifFalse: [min := num].
					max > num ifFalse: [max := num]]].
	^Array with: min with: max
]

{ #category : 'basic ops -' }
StMSparseVector >> minusSparseVector: aSparseVector [ 
	| answer |
	self tally < aSparseVector tally
		ifTrue: 
			[answer := aSparseVector copy.
			self keysAndValuesDo: [:i :value | answer at: i minusNumber: value]]
		ifFalse: 
			[answer := self copy.
			aSparseVector keysAndValuesDo: [:i :value | answer at: i minusNumber: value]].
	^answer
]

{ #category : 'basic ops -' }
StMSparseVector >> minusSparseVector: aSparseVector times: beta [ 
	| answer |
	self tally < aSparseVector tally
		ifTrue: 
			[answer := aSparseVector times: beta.
			self keysAndValuesDo: [:i :value | answer at: i minusNumber: value]]
		ifFalse: 
			[answer := self copy.
			aSparseVector keysAndValuesDo: [:i :value | answer at: i minusNumber: value * beta]].
	^answer
]

{ #category : 'accessing' }
StMSparseVector >> ncol [
	self subclassResponsibility
]

{ #category : 'basic ops' }
StMSparseVector >> negated [
	^self times: -1.0
]

{ #category : 'norms' }
StMSparseVector >> normL: number [ 
	^(self sumOfElementsRaisedTo: number)
		raisedTo: number reciprocal
]

{ #category : 'accessing' }
StMSparseVector >> nrow [
	self subclassResponsibility
]

{ #category : 'accessing' }
StMSparseVector >> numberOfElements [
	"Answer the number of elements in the full vector or matrix."

	^fullsize
]

{ #category : 'printing' }
StMSparseVector >> outputOnFile: aString [ 
	| writeStream aij aijString |
	writeStream := aString asFilename writeStream.
	1 to: self nrow
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

{ #category : 'basic ops +' }
StMSparseVector >> plusSparseVector: aSparseVector [ 
	| answer |
	self tally < aSparseVector tally
		ifTrue: 
			[answer := aSparseVector copy.
			self keysAndValuesDo: [:i :value | answer at: i plusNumber: value]]
		ifFalse: 
			[answer := self copy.
			aSparseVector keysAndValuesDo: [:i :value | answer at: i plusNumber: value]].
	^answer
]

{ #category : 'basic ops +' }
StMSparseVector >> plusSparseVector: aSparseVector times: beta [ 
	| answer |
	self tally < aSparseVector tally
		ifTrue: 
			[answer := aSparseVector times: beta.
			self keysAndValuesDo: [:i :value | answer at: i plusNumber: value]]
		ifFalse: 
			[answer := self copy.
			aSparseVector keysAndValuesDo: [:i :value | answer at: i plusNumber: value * beta]].
	^answer
]

{ #category : 'printing' }
StMSparseVector >> printElementsOn: aStream [
	"Append to the argument aStream a sequence of characters that identifies the receiver."

	| tooMany |
	tooMany := aStream position + self maxPrint.
	aStream print: tally / self basicSize.
	aStream nextPutAll: ' ('.
	self associationsDo: [ :element |
		aStream position > tooMany ifTrue: [
			aStream nextPutAll: '...etc...)'.
			^ self ].
		element value isZero ifFalse: [
			element printOn: aStream.
			aStream nextPutAll: ', ' ] ].
	aStream nextPut: $)
]

{ #category : 'printing' }
StMSparseVector >> printOn: aStream [ 
	"Append to the argument aStream a sequence of characters that identifies the receiver."

	| tooMany |
	tooMany := aStream position + self maxPrint.
	aStream print: self class.
	aStream space.
	aStream print: tally / self basicSize.
	aStream nextPutAll: ' ('.
	self
		associationsDo: 
			[:element | 
			aStream position > tooMany
				ifTrue: 
					[aStream nextPutAll: '...etc...)'.
					^self].
			element printOn: aStream.
			aStream space].
	aStream nextPut: $)
]

{ #category : 'removing' }
StMSparseVector >> removeKey: key [ 
	"Remove key from the receiver. If key is not in the receiver, 
	do nothing and return nil. Otherwise, answer the value 
	associated with key."

	| index value |
	index := self findKeyOrNil: key.
	^(self basicAt: index)
		== nil
		ifTrue: [nil]
		ifFalse: 
			[value := valueArray at: index.
			self removeAndCleanUpAtIndex: index.
			value]
]

{ #category : 'norms' }
StMSparseVector >> rootMeanSquare [
	"(sumOfSquares / numberOfElements) sqrt"

	^(self sumOfSquares / self numberOfElements) sqrt
]

{ #category : 'norms' }
StMSparseVector >> sumOfAbsElements [
	| sum |
	sum := 0.
	1 to: self basicSize do: 
		[:index | 
		| num |
		(num := valueArray at: index) == nil ifFalse: [sum := num > 0.0
						ifTrue: [sum + num]
						ifFalse: [sum - num]]].
	^sum
]

{ #category : 'norms' }
StMSparseVector >> sumOfElements [
	| sum |
	sum := 0.
	1 to: self basicSize do: 
		[:index | 
		| num |
		(num := valueArray at: index) == nil ifFalse: [sum := num + sum]].
	^sum
]

{ #category : 'norms' }
StMSparseVector >> sumOfElementsRaisedTo: number [ 
	"For each element abs it, raised it to the power of number."
	"Then sum them all."

	| sum |
	sum := 0.
	1 to: self basicSize do: 
		[:index | 
		| num |
		(num := valueArray at: index) == nil
			ifFalse: 
				[num < 0.0 ifTrue: [num := 0.0 - num].
				sum := sum + (num raisedTo: number)]].
	^sum
]

{ #category : 'norms' }
StMSparseVector >> sumOfSquares [
	"When sum is integer 0, num * num + sum is more efficient than sum + num * num."

	| sum |
	sum := 0.
	1 to: self basicSize do: 
		[:index | 
		| num |
		(num := valueArray at: index) == nil ifFalse: [sum := num * num + sum]].
	^sum
]

{ #category : 'accessing' }
StMSparseVector >> tally [
	^tally
]

{ #category : 'basic ops *' }
StMSparseVector >> times: aNumber [ 
	| answer |
	answer := self copy.
	^answer magnifySelf: aNumber
]

{ #category : 'basic ops' }
StMSparseVector >> times: double conditionedWithTol: tol [ 
	"Answer a fresh sparse vector of significant elements."

	| answer newValue |
	answer := self class new.
	self
		keysAndValuesDo: 
			[:key :value | 
			newValue := value * double.
			newValue abs >= tol ifTrue: [answer at: key put: newValue]].
	^answer
]

{ #category : 'basic ops -' }
StMSparseVector >> times: alpha minusSparseVector: aSparseVector [ 
	| answer |
	self tally < aSparseVector tally
		ifTrue: 
			[answer := aSparseVector copy.
			self keysAndValuesDo: [:i :value | answer at: i minusNumber: value * alpha]]
		ifFalse: 
			[answer := self times: alpha.
			aSparseVector keysAndValuesDo: [:i :value | answer at: i minusNumber: value]].
	^answer
]

{ #category : 'basic ops -' }
StMSparseVector >> times: alpha minusSparseVector: aSparseVector times: beta [ 
	| answer |
	self tally < aSparseVector tally
		ifTrue: 
			[answer := aSparseVector times: beta.
			self keysAndValuesDo: [:i :value | answer at: i minusNumber: value * alpha]]
		ifFalse: 
			[answer := self times: alpha.
			aSparseVector keysAndValuesDo: [:i :value | answer at: i minusNumber: value * beta]].
	^answer
]

{ #category : 'basic ops +' }
StMSparseVector >> times: alpha plusSparseVector: aSparseVector [ 
	| answer |
	self tally < aSparseVector tally
		ifTrue: 
			[answer := aSparseVector copy.
			self keysAndValuesDo: [:i :value | answer at: i plusNumber: value * alpha]]
		ifFalse: 
			[answer := self times: alpha.
			aSparseVector keysAndValuesDo: [:i :value | answer at: i plusNumber: value]].
	^answer
]

{ #category : 'basic ops +' }
StMSparseVector >> times: alpha plusSparseVector: aSparseVector times: beta [ 
	| answer |
	self tally < aSparseVector tally
		ifTrue: 
			[answer := aSparseVector times: beta.
			self keysAndValuesDo: [:i :value | answer at: i plusNumber: value * alpha]]
		ifFalse: 
			[answer := self times: alpha.
			aSparseVector keysAndValuesDo: [:i :value | answer at: i plusNumber: value * beta]].
	^answer
]

{ #category : 'accessing' }
StMSparseVector >> validIndicesWithoutKey: discardKey [ 
	| indices |
	indices := OrderedCollection new: self size.
	1 to: self basicSize
		do: 
			[:index | 
			| key |
			key := self basicAt: index.
			key == nil ifFalse: [key == discardKey ifFalse: [indices add: index]]].
	^indices
]

{ #category : 'accessing' }
StMSparseVector >> valueArray [
	^valueArray
]

{ #category : 'ops on self' }
StMSparseVector >> zeroSelf [
	"Make non zero elements zero. Do not remove them."

	1 to: self basicSize do: [:index | (self basicAt: index) == nil ifFalse: [valueArray at: index put: 0.0]]
]
