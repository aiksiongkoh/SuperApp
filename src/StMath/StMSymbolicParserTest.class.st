Class {
	#name : 'StMSymbolicParserTest',
	#superclass : 'TestCase',
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'tests' }
StMSymbolicParserTest >> test2_pi_time [

	| parser stack symFunc |
	parser := StMMotionFunctionParser new.
	parser variables at: #time put: ASMTTime new.
	stack := parser
		         parse: '2.0d*pi*time'
		         as: #expression
		         notifying: nil
		         ifFail: nil.
	symFunc := stack first
]
