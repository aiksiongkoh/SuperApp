Class {
	#name : 'MbDPosNewtonRaphson2',
	#superclass : 'MbDSystemNewtonRaphson2',
	#category : 'StCAD-MbD-MbDSolver',
	#package : 'StCAD-MbD',
	#tag : 'MbDSolver'
}

{ #category : 'VisualWorks metadata' }
MbDPosNewtonRaphson2 class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'solving' }
MbDPosNewtonRaphson2 >> askSystemToUpdate [
	system allDo: [:item | item postPosICIteration]
]

{ #category : 'solving' }
MbDPosNewtonRaphson2 >> incrementIterNo [

	iterNo >= iterMax ifTrue: [
		system logString: #'MbD: \No convergence after %1 iterations.' withArgument: iterNo printString.
		system logString: #'MbD: \A geometrically incompatible system has been specified.'.
		system logString:
			#'MbD: \Or the system parts are distributed too far apart from the assembled positions.'.
		SimulationStoppingError signal ].
	iterNo := iterNo + 1
]

{ #category : 'solving' }
MbDPosNewtonRaphson2 >> postRun [
	system allDo: [:item | item postPosIC]
]

{ #category : 'solving' }
MbDPosNewtonRaphson2 >> preRun [
	system partsJointsMotionsDo: [:item | item prePosIC]
]
