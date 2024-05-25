Class {
	#name : 'MbDQuasiStaticIntegrator',
	#superclass : 'MbDQuasiIntegrator',
	#category : 'StCAD-MbD-MbDSolver',
	#package : 'StCAD-MbD',
	#tag : 'MbDSolver'
}

{ #category : 'VisualWorks metadata' }
MbDQuasiStaticIntegrator class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'run' }
MbDQuasiStaticIntegrator >> preRun [
	system logString: #'MbD: \Starting static or quasi static analysis.'.
	super preRun
]

{ #category : 'run' }
MbDQuasiStaticIntegrator >> runInitialConditionTypeSolution [
	system runStaticIC
]
