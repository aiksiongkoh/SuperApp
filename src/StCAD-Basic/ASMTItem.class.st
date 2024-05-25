Class {
	#name : 'ASMTItem',
	#superclass : 'Object',
	#instVars : [
		'name',
		'sup',
		'mbdObject'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'accessing' }
ASMTItem >> allJoints [

	^ self root allJoints
]

{ #category : 'accessing' }
ASMTItem >> allMarkers [

	^ self root allMarkers
]

{ #category : 'DYN' }
ASMTItem >> deleteMbD [

	self mbdObject: nil
]

{ #category : 'accessing' }
ASMTItem >> findJointNamed: markerName [

	^ self allJoints detect: [ :jt | jt fullName = markerName ]
]

{ #category : 'accessing' }
ASMTItem >> findMarkerNamed: markerName [

	^ self allMarkers detect: [ :mkr | mkr fullName = markerName ]
]

{ #category : 'accessing' }
ASMTItem >> fullName [

	| stream |
	stream := WriteStream on: (String new: 256).
	self fullPath do: [ :node |
		(node respondsTo: #name) ifTrue: [
			node name isString ifTrue: [
				stream nextPut: $/.
				stream nextPutAll: node name ] ] ].
	^ stream contents asSymbol
]

{ #category : 'accessing' }
ASMTItem >> fullPath [

	| fullPath |
	fullPath := sup isNil
		            ifTrue: [ OrderedCollection new ]
		            ifFalse: [ sup fullPath ].
	fullPath add: self.
	^ fullPath
]

{ #category : 'accessing' }
ASMTItem >> mbdClass [

	^ self class mbdClass
]

{ #category : 'accessing' }
ASMTItem >> mbdObject [

	^ mbdObject
]

{ #category : 'accessing' }
ASMTItem >> mbdObject: anObject [

	mbdObject := anObject
]

{ #category : 'accessing' }
ASMTItem >> name [

	^ name
]

{ #category : 'accessing' }
ASMTItem >> name: anObject [

	name := anObject
]

{ #category : 'parsing' }
ASMTItem >> parseName: lines [

	[ lines removeFirst trim = 'Name' ] assert.
	name := lines removeFirst trim
]

{ #category : 'parsing' }
ASMTItem >> readBooleanOffTop: lines [

	^ Boolean readFrom: lines removeFirst trim
]

{ #category : 'parsing' }
ASMTItem >> readColumnOfDoubles: line [

	^ StMFullColumn
		  fromCollection: line substrings
		  aBlock: [ :str | Float readFrom: str ]
]

{ #category : 'parsing' }
ASMTItem >> readColumnOfDoublesOffTop: lines [

	^ self readColumnOfDoubles: lines removeFirst
]

{ #category : 'parsing' }
ASMTItem >> readDoubleOffTop: lines [

	^ Float readFrom: lines removeFirst trim
]

{ #category : 'parsing' }
ASMTItem >> readIntegerOffTop: lines [

	^ Integer readFrom: lines removeFirst trim
]

{ #category : 'parsing' }
ASMTItem >> readRowOfDoubles: line [

	^ StMFullRow
		  fromCollection: line substrings
		  aBlock: [ :str | Float readFrom: str ]
]

{ #category : 'parsing' }
ASMTItem >> readRowOfDoublesOffTop: lines [

	^ self readRowOfDoubles: lines removeFirst
]

{ #category : 'accessing' }
ASMTItem >> root [

	^ sup root
]

{ #category : 'accessing' }
ASMTItem >> sup: owner [

	sup := owner
]

{ #category : 'accessing' }
ASMTItem >> units [

	^ self root units
]
