Class {
	#name : 'ASMTTime',
	#superclass : 'ASMTFunction',
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'DYN' }
ASMTTime >> createMbDin: mbdAssemblyFrm [
	"asmtNum*asmtUnit = siNum*siUnit = mbdNum*mbdUnit"

	| mbdTime asmtTime |
	mbdTime := mbdAssemblyFrm time.
	asmtTime := mbdTime / self units time.
	self x: mbdTime expression: asmtTime simplified
]

{ #category : 'DYN' }
ASMTTime >> deleteMbD [

	x := nil.
	expression := nil
]
