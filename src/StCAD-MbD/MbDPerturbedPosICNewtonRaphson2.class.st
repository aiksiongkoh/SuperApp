Class {
	#name : 'MbDPerturbedPosICNewtonRaphson2',
	#superclass : 'MbDPosICNewtonRaphson2',
	#category : 'StCAD-MbD-MbDSolver',
	#package : 'StCAD-MbD',
	#tag : 'MbDSolver'
}

{ #category : 'VisualWorks metadata' }
MbDPerturbedPosICNewtonRaphson2 class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'initialize-release' }
MbDPerturbedPosICNewtonRaphson2 >> initializeGlobally [
	| delta |
	super initializeGlobally.
	delta := 0.01.
	system allDo: [:item | item bePerturbed: delta fillqsulam: x].
	system allDo: [:item | item postPosICIteration]
]
