Class {
	#name : 'MbDDAEIntegrator',
	#superclass : 'DAEIntegrator',
	#category : 'StCAD-MbD-MbDSolver',
	#package : 'StCAD-MbD',
	#tag : 'MbDSolver'
}

{ #category : 'VisualWorks metadata' }
MbDDAEIntegrator class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'accessing' }
MbDDAEIntegrator >> correctorAbsoluteTolerance [
	^(StMFullColumn new: neqn)
		atAllPut: system correctorAbsoluteTolerance
]

{ #category : 'accessing' }
MbDDAEIntegrator >> correctorRelativeTolerance [
	^(StMFullColumn new: neqn)
		atAllPut: system correctorRelativeTolerance
]

{ #category : 'initialize-release' }
MbDDAEIntegrator >> initializeGlobally [
	super initializeGlobally.
	self assignEquationNumbers.
	system allDo: [:item | item useEquationNumbers]
]

{ #category : 'accessing' }
MbDDAEIntegrator >> integrationAbsoluteTolerance [
	"Answer column of tolerances used by the integration error estimator."
	"Algebraic variables are not included in the error estimator."

	| absTol col |
	absTol := system integrationAbsoluteTolerance.
	col := StMFullColumn new: neqn.
	1 to: neqn - ncon do: [:i | col at: i put: absTol].
	^col
]

{ #category : 'accessing' }
MbDDAEIntegrator >> integrationRelativeTolerance [
	"Answer column of tolerances used by the integration error estimator."
	"Algebraic variables are not included in the error estimator."

	| absTol col |
	absTol := system integrationRelativeTolerance.
	col := StMFullColumn new: neqn.
	1 to: neqn - ncon do: [:i | col at: i put: absTol].
	^col
]
