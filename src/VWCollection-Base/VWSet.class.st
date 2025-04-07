Class {
	#name : 'VWSet',
	#superclass : 'Collection',
	#instVars : [
		'tally'
	],
	#classVars : [
		'PrimeMap'
	],
	#category : 'VWCollection-Base',
	#package : 'VWCollection-Base'
}

{ #category : 'private' }
VWSet class >> goodSizeFrom: requestedSize [
	"Given a size request, round it up to a size which will give best 
	hash clustering (such as next prime)."

	"Just ensure oddness if out-of-range."

	| list low high mid item |
	requestedSize <= 7 ifTrue: [ ^ (requestedSize bitOr: 1) max: 3 ].
	requestedSize <= ((PrimeMap size bitShift: 1) + 1) ifTrue: [
		^ (PrimeMap at: (requestedSize bitShift: -1)) + (requestedSize bitOr: 1) ].
	list := self largePrimes.
	low := 1.
	high := list size.
	[
	mid := low + high + 1 bitShift: -1.
	item := list at: mid.
	item <= requestedSize
		ifTrue: [ low := mid ]
		ifFalse: [ high := mid - 1 ].
	low = high ] whileFalse.
	item := list at: low.
	item < requestedSize ifTrue: [ low := low + 1 ].
	^ low <= list size
		  ifTrue: [ list at: low ]
		  ifFalse: [ requestedSize bitOr: 1 ]
]

{ #category : 'class initialization' }
VWSet class >> initialize [
	"self initialize"

	| maxMapped primes pos sz map |
	maxMapped := 2049.
	primes := OrderedCollection with: 3.
	3 to: maxMapped + 100 by: 2 do: [ :cand |
	primes detect: [ :p | cand \\ p = 0 ] ifNone: [ primes add: cand ] ]. "Slop to ensure we get next prime over maxMapped"
	primes := primes asArray.
	sz := maxMapped // 2.
	map := ByteArray new: sz.
	pos := 1.
	1 to: sz do: [ :i |
		| n p |
		n := i * 2 + 1.
		[ (p := primes at: pos) >= n ] whileFalse: [ pos := pos + 1 ].
		map at: i put: p - n ].
	PrimeMap := map
]

{ #category : 'instance creation' }
VWSet class >> new [
	"Create an instance of a Set."

	^ self new: 2
]

{ #category : 'instance creation' }
VWSet class >> new: anInteger [
	"Create an instance of a Set."

	anInteger >= 0 ifFalse: [ self improperCreationSizeSignal raiseWith: anInteger ].
	^ (super new: (self goodSizeFrom: anInteger)) setTally
]

{ #category : 'copying' }
VWSet >> copyEmpty: aSize [
	"Answer a copy of the receiver that contains no elements.

	This method should be redefined in subclasses that add
	instance variables, so that the state of those variables
	is preserved"

	^ self class new: aSize
]

{ #category : 'private' }
VWSet >> grow [
	"The receiver becomes roomier."

	self changeCapacityTo: self capacity + self growSize
]

{ #category : 'growing' }
VWSet >> growSize [
	"Answer an amount by which the receiver should grow 
	to make room for more elements."

	^ self capacity max: 2
]

{ #category : 'initialization' }
VWSet >> setTally [
	"Initialize the number of elements to be 0."

	tally := 0
]

{ #category : 'accessing' }
VWSet >> swap: oneElement with: otherElement [

	| save |
	save := self basicAt: oneElement.
	self basicAt: oneElement put: (self basicAt: otherElement).
	self basicAt: otherElement put: save
]
