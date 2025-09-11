Class {
	#name : 'SymEulerParametersTest',
	#superclass : 'TestCase',
	#category : 'StCAD-Basic-Tests',
	#package : 'StCAD-Basic',
	#tag : 'Tests'
}

{ #category : 'tests' }
SymEulerParametersTest >> testAandBCT [

	| qE1 qE2 qE3 qE4 qE aA |
	qE1 := UnknownDependentVariable name: #qE1.
	qE2 := UnknownDependentVariable name: #qE2.
	qE3 := UnknownDependentVariable name: #qE3.
	qE4 := UnknownDependentVariable name: #qE4.
	qE := SymEulerParameters
		      with: qE1
		      with: qE2
		      with: qE3
		      with: qE4.
	aA := SymFullMatrix new: 3 by: 3.
	aA at: 1 and: 1 put: (qE4 * qE4) + (qE1 * qE1) - (qE2 * qE2) - (qE3 * qE3).
	aA at: 1 and: 2 put: (qE1 * qE2 - (qE3 * qE4)) * 2.
	aA at: 1 and: 3 put: (qE1 * qE3 + (qE2 * qE4)) * 2.
	aA at: 2 and: 1 put: (qE1 * qE2 + (qE3 * qE4)) * 2.
	aA at: 2 and: 2 put: (qE4 * qE4) - (qE1 * qE1) + (qE2 * qE2) - (qE3 * qE3).
	aA at: 2 and: 3 put: (qE2 * qE3 - (qE1 * qE4)) * 2.
	aA at: 3 and: 1 put: (qE1 * qE3 - (qE2 * qE4)) * 2.
	aA at: 3 and: 2 put: (qE2 * qE3 + (qE1 * qE4)) * 2.
	aA at: 3 and: 3 put: (qE4 * qE4) - (qE1 * qE1) - (qE2 * qE2) + (qE3 * qE3).
	1 to: 3 do: [ :i |
		1 to: 3 do: [ :j |
			self assert: (aA at: i and: j) equals: (qE aA at: i and: j) ] ]
]
