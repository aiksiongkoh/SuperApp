Class {
	#name : 'ASMTConstantGravity',
	#superclass : 'ASMTItem',
	#instVars : [
		'gravAcc'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'accessing' }
ASMTConstantGravity class >> mbdClass [

	^ SymConstantGravity
]

{ #category : 'MbD' }
ASMTConstantGravity >> createMbDin: mbdAssemblyFrm [

	| constGrav |
	constGrav := self mbdClass new.
	mbdObject := constGrav.
	constGrav gXYZ: gravAcc * self units acceleration.
	mbdAssemblyFrm addField: constGrav
]

{ #category : 'initialization' }
ASMTConstantGravity >> initialize [

	name := 'gravity'
]

{ #category : 'parsing' }
ASMTConstantGravity >> parseASMT: lines [

	[ lines removeFirst trim = 'ConstantGravity' ] assert.
	gravAcc := self readColumnOfDoublesOffTop: lines
]
