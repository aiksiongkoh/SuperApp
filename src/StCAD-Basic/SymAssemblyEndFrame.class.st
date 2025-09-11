Class {
	#name : 'SymAssemblyEndFrame',
	#superclass : 'SymIndependentFrame',
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'accessing' }
SymAssemblyEndFrame >> aAjOe: j [

	^ aAOf column: j
]

{ #category : 'initialization' }
SymAssemblyEndFrame >> initializeGlobally [
	"Do nothing."

	
]

{ #category : 'accessing' }
SymAssemblyEndFrame >> ivE [

	^ nil
]

{ #category : 'accessing' }
SymAssemblyEndFrame >> ivX [

	^ nil
]

{ #category : 'accessing' }
SymAssemblyEndFrame >> markerFrame [

	^ sup
]

{ #category : 'accessing' }
SymAssemblyEndFrame >> theme: col [

	1 to: 3 do: [ :i | (theFf at: i) rhs: (col at: i) ].
	theFf := theFf simplified
]
