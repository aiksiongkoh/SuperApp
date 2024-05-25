Class {
	#name : 'MbDVelICKineSolver2',
	#superclass : 'MbDVelICSolver2',
	#category : 'StCAD-MbD-MbDSolver',
	#package : 'StCAD-MbD',
	#tag : 'MbDSolver'
}

{ #category : 'VisualWorks metadata' }
MbDVelICKineSolver2 class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'run' }
MbDVelICKineSolver2 >> run [
	system logString: #'MbD: \Solving for quasi kinematic velocity.'.
	self runBasic
]
