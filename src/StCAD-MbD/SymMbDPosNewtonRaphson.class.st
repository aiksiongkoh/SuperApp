Class {
	#name : 'SymMbDPosNewtonRaphson',
	#superclass : 'SymMbDSystemNewtonRaphson',
	#category : 'StCAD-MbD-MbDSolver',
	#package : 'StCAD-MbD',
	#tag : 'MbDSolver'
}

{ #category : 'VisualWorks metadata' }
SymMbDPosNewtonRaphson class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'solving' }
SymMbDPosNewtonRaphson >> askSystemToUpdate [
	system allDo: [:item | item postPosICIteration]
]

{ #category : 'solving' }
SymMbDPosNewtonRaphson >> incrementIterNo [

	iterNo >= iterMax ifTrue: [
		system logString: #'MbD: \No convergence after %1 iterations.' withArgument: iterNo printString.
		system logString: #'MbD: \A geometrically incompatible system has been specified.'.
		system logString:
			#'MbD: \Or the system parts are distributed too far apart from the assembled positions.'.
		SimulationStoppingError signal ].
	iterNo := iterNo + 1
]

{ #category : 'solving' }
SymMbDPosNewtonRaphson >> postRun [
	system allDo: [:item | item postPosIC]
]
