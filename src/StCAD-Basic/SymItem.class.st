Class {
	#name : 'SymItem',
	#superclass : 'Object',
	#instVars : [
		'name',
		'sup'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'examples' }
SymItem >> aaaa [

	^ self
]

{ #category : 'examples' }
SymItem >> aaaaa [

	^ self
]

{ #category : 'examples' }
SymItem >> aaaaaa [

	^ self
]

{ #category : 'examples' }
SymItem >> d [

	^ self
]

{ #category : 'testing' }
SymItem >> hasChanged [

	^ sup hasChanged
]

{ #category : 'testing' }
SymItem >> hasChanged: bool [

	^ sup hasChanged: bool
]

{ #category : 'initialization' }
SymItem >> initializeGlobally [
	"Called once only."

	"Initialize all constant dependent instance variables using local and global objects."

	"Default is do nothing."

	
]

{ #category : 'initialization' }
SymItem >> initializeLocally [
	"Called once only."

	"Assume that the independent instance variables are already set."

	"Initialize all constant dependent instance variables using local objects only."

	"Default is do nothing."

	
]

{ #category : 'accessing' }
SymItem >> name [

	^ name
]

{ #category : 'accessing' }
SymItem >> name: anObject [

	name := anObject
]

{ #category : 'accessing' }
SymItem >> owner: aSym [

	sup := aSym
]

{ #category : 'accessing' }
SymItem >> sup [

	^ sup
]

{ #category : 'accessing' }
SymItem >> sup: owner [

	sup := owner
]
