Class {
	#name : 'SymAssemblyPointMarkerFrame',
	#superclass : 'SymAssemblyMarkerFrame',
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'adding' }
SymAssemblyPointMarkerFrame >> addEndFrm: endFrm [

	subs add: endFrm.
	endFrm sup: self
]

{ #category : 'instance creation' }
SymAssemblyPointMarkerFrame >> newEndFramec [

	^ SymAssemblyEndFramec new
]
