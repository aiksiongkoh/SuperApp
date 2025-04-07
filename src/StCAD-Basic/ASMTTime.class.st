Class {
	#name : 'ASMTTime',
	#superclass : 'ASMTFunction',
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'converting' }
ASMTTime >> asValue [

	^ expression asValue
]

{ #category : 'DYN' }
ASMTTime >> createMbDin: mbdAssemblyFrm [
	"asmtNum*asmtUnit = siNum*siUnit = mbdNum*mbdUnit"

	| mbdTime asmtTime |
	mbdTime := mbdAssemblyFrm time.
	asmtTime := mbdTime * mbdAssemblyFrm units time / self units time.
	self x: mbdTime expression: asmtTime simplifyAll
]

{ #category : 'DYN' }
ASMTTime >> deleteMbD [

	x := nil.
	expression := nil
]

{ #category : 'accessing' }
ASMTTime >> name [

	^ 'time'
]
