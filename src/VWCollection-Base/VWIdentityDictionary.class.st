Class {
	#name : 'VWIdentityDictionary',
	#superclass : 'VWDictionary',
	#instVars : [
		'valueArray'
	],
	#category : 'VWCollection-Base',
	#package : 'VWCollection-Base'
}

{ #category : 'adding' }
VWIdentityDictionary >> add: anAssociation [
	"Include anAssociation as one of the receiver's elements.  Answer anAssociation."

	self at: anAssociation key put: anAssociation value.
	^ anAssociation
]

{ #category : 'accessing' }
VWIdentityDictionary >> associationAt: key ifAbsent: aBlock [
	"Answer an Association consisting of key and the value of
	the receiver at that key.  If key is not found, evaluate aBlock."

	| index storedKey |
	index := self findKeyOrNil: key.
	^ (storedKey := self basicAt: index) == nil
		  ifTrue: [ aBlock value ]
		  ifFalse: [ Association key: storedKey value: (valueArray at: index) ]
]

{ #category : 'enumerating' }
VWIdentityDictionary >> associationsDo: aBlock [
	"Evaluate aBlock for associations consisting of the receiver's keys and 
	their values."

	1 to: self basicSize do: [ :index |
		(self basicAt: index) == nil ifFalse: [
			aBlock value: (Association key: (self basicAt: index) value: (valueArray at: index)) ] ]
]

{ #category : 'accessing' }
VWIdentityDictionary >> at: key [
	"Answer the value at key. If key is not found, return nil."

	| index |
	index := self findKeyOrNil: key.
	^ (self basicAt: index) == nil
		  ifTrue: [ nil ]
		  ifFalse: [ valueArray at: index ]
]

{ #category : 'accessing' }
VWIdentityDictionary >> at: key ifAbsent: aBlock [
	"Answer the value at key.  If key is not found, evaluate aBlock."

	| index |
	index := self findKeyOrNil: key.
	^ (self basicAt: index) == nil
		  ifTrue: [ aBlock value ]
		  ifFalse: [ valueArray at: index ]
]

{ #category : 'accessing' }
VWIdentityDictionary >> at: key put: value [
	"Set the value at key to be value."

	| index |
	key == nil ifTrue: [ ^ self subscriptBoundsErrorFor: #at:put: index: nil value: value ].
	index := self findKeyOrNil: key.
	(self basicAt: index) == nil
		ifTrue: [
			tally := tally + 1.
			self basicAt: index put: key.
			valueArray at: index put: value.
			self fullCheck ]
		ifFalse: [ valueArray at: index put: value ].
	^ value
]

{ #category : 'as yet unclassified' }
VWIdentityDictionary >> changeCapacityTo: newCapacity [
	"Change the size of the receiver to newCapacity.  The receiver will
	be regrown if necessary to fit its contents."

	"Note that #rehash uses this -- don't optimize the case where
	the receiver doesn't change in size."

	| newSelf |
	newSelf := self copyEmpty: newCapacity.
	self keysAndValuesDo: [ :key :value | newSelf noCheckAt: key put: value ].
	self become: newSelf
]

{ #category : 'accessing' }
VWIdentityDictionary >> copyWithCopiedValues [
	"This is a high-performance copy operation that answers a new
	 IdentityDictionary with the same keys, but copies of each value."

	^ self shallowCopy postCopyWithCopiedValues
]

{ #category : 'enumerating' }
VWIdentityDictionary >> do: aBlock [
	"Evaluate aBlock with each of the receiver's elements as the argument."

	1 to: self basicSize do: [ :index |
	(self basicAt: index) == nil ifFalse: [ aBlock value: (valueArray at: index) ] ]
]

{ #category : 'private' }
VWIdentityDictionary >> findKeyOrNil: key [
	"Look for the key in the receiver.  If it is found, answer
	the index of the association containting the key, otherwise
	answer the index of the first unused slot."

	| index length probe pass |
	length := self basicSize.
	pass := 1.
	index := self initialIndexFor: key identityHash boundedBy: length.
	[ (probe := self basicAt: index) == nil or: [ probe == key ] ] whileFalse: [
		(index := index + 1) > length ifTrue: [
			index := 1.
			pass := pass + 1.
			pass > 2 ifTrue: [ ^ self grow findKeyOrNil: key ] ] ].
	^ index
]

{ #category : 'enumerating' }
VWIdentityDictionary >> keyAtValue: value ifAbsent: exceptionBlock [
	"Answer the key whose value equals the argument, value.  If there is none, 
	answer the result of evaluating exceptionBlock."

	| theKey |
	1 to: self basicSize do: [ :index |
		value == (valueArray at: index) ifTrue: [
			(theKey := self basicAt: index) == nil ifFalse: [ ^ theKey ] ] ].
	^ exceptionBlock value
]

{ #category : 'accessing' }
VWIdentityDictionary >> keys [
	"Answer a set containing the receiver's keys."

	| aSet |
	aSet := IdentitySet new: self size * 3 // 2.
	self keysDo: [ :key | aSet add: key ].
	^ aSet
]

{ #category : 'accessing' }
VWIdentityDictionary >> keysAndValuesDo: aBlock [
	"Evaluate aBlock with each of the receiver's key/value pairs as the 
	arguments."

	1 to: self basicSize do: [ :index |
		| key |
		(key := self basicAt: index) == nil ifFalse: [ aBlock value: key value: (valueArray at: index) ] ]
]

{ #category : 'accessing' }
VWIdentityDictionary >> noCheckAt: key put: value [
	"Assume that the key is already in the receiver and store the value
	without checking to make sure."

	| index |
	index := self findKeyOrNil: key.
	self basicAt: index put: key.
	tally := tally + 1.
	^ valueArray at: index put: value
]

{ #category : 'copying' }
VWIdentityDictionary >> postCopy [

	valueArray := valueArray copy
]

{ #category : 'copying' }
VWIdentityDictionary >> postCopyWithCopiedValues [

	self postCopy.
	1 to: valueArray size do: [ :i |
		| value |
		nil == (value := valueArray at: i) ifFalse: [ valueArray at: i put: value copy ] ]
]

{ #category : 'copying' }
VWIdentityDictionary >> readGeneralStructureOn: aBinaryStorageReader [
	"Read the receiver's structure, avoiding hashing.  Rehash only after
	 all objects have   read in, to ensure their hashes can be computed."

	(tally := aBinaryStorageReader readLength) > 0 ifTrue: [
		aBinaryStorageReader postProcess: self with: #rehash.
		1 to: tally do: [ :i |
			self basicAt: i put: aBinaryStorageReader readObject.
			valueArray at: i put: aBinaryStorageReader readObject ] ]
]

{ #category : 'copying' }
VWIdentityDictionary >> removeAndCleanUpAtIndex: index [
	"Remove the key at the given index,
	relocating any following entries as needed."

	| location oldKey length |
	self basicAt: index put: nil.
	valueArray at: index put: nil.
	tally := tally - 1.
	length := self basicSize.
	location := index.
	[
	location := location = length
		            ifTrue: [ 1 ]
		            ifFalse: [ location + 1 ].
	(self basicAt: location) == nil ] whileFalse: [
		oldKey := self findKeyOrNil: (self basicAt: location).
		location = oldKey ifFalse: [ self swap: location with: oldKey ] ]
]

{ #category : 'removing' }
VWIdentityDictionary >> removeDangerouslyKey: key ifAbsent: errorBlock [
	"Assume that the key is in the receiver and go fetch its value.
	If the value is nil, answer the result of evaluating the errorBlock.
	Otherwise, remove the key from the receiver."

	| location |
	location := self findKeyOrNil: key.
	(self basicAt: location) == nil ifTrue: [ ^ errorBlock value ].
	self removeAndCleanUpAtIndex: location
]

{ #category : 'removing' }
VWIdentityDictionary >> removeKey: key [
	"Remove key from the receiver. If key is not in the receiver, 
	do nothing and return nil. Otherwise, answer the value 
	associated with key."

	| index value |
	index := self findKeyOrNil: key.
	^ (self basicAt: index) == nil
		  ifTrue: [ nil ]
		  ifFalse: [
			  value := valueArray at: index.
			  self removeAndCleanUpAtIndex: index.
			  value ]
]

{ #category : 'removing' }
VWIdentityDictionary >> removeKey: key ifAbsent: aBlock [
	"Remove key from the receiver.  If key is not in the receiver, 
	answer the result of evaluating aBlock.  Otherwise, answer the value 
	associated with key."

	| index value |
	index := self findKeyOrNil: key.
	(self basicAt: index) == nil ifTrue: [ ^ aBlock value ].
	value := valueArray at: index.
	self removeAndCleanUpAtIndex: index.
	^ value
]

{ #category : 'initialization' }
VWIdentityDictionary >> setTally [
	"Initialize tally and other instance variables."

	super setTally.
	valueArray := Array new: self basicSize
]

{ #category : 'accessing' }
VWIdentityDictionary >> swap: oneElement with: otherElement [
	"Store otherElement in the position for oneElement, and
	vice versa."

	super swap: oneElement with: otherElement.
	valueArray swap: oneElement with: otherElement
]

{ #category : 'as yet unclassified' }
VWIdentityDictionary >> traceWalkFrom: aTracer [

	self keysAndValuesDo: [ :k :v |
		aTracer trace: k.
		aTracer trace: v ]
]
