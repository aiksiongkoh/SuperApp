"
An ASMTAssemblyTest is a test class for testing the behavior of ASMTAssembly
"
Class {
	#name : 'ASMTAssemblyTest',
	#superclass : 'TestCase',
	#category : 'StCAD-Basic-Tests',
	#package : 'StCAD-Basic',
	#tag : 'Tests'
}

{ #category : 'tests' }
ASMTAssemblyTest >> testPiston [

	ASMTAssembly runDynFile:
		'.\pharo-local\iceberg\aiksiongkoh\SuperApp\src\piston.asmt'
]
