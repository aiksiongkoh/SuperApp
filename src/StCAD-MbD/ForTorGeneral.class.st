Class {
	#name : 'ForTorGeneral',
	#superclass : 'ForceTorqueItem',
	#instVars : [
		'forceVector',
		'torqueVector'
	],
	#category : 'StCAD-MbD-MbDForce',
	#package : 'StCAD-MbD',
	#tag : 'MbDForce'
}

{ #category : 'instance creation' }
ForTorGeneral class >> onFrmI: efrmI andFrmJ: efrmJ [ 
	^self new onFrmI: efrmI andFrmJ: efrmJ
]

{ #category : 'instance creation' }
ForTorGeneral class >> onFrmI: efrmI andFrmJ: efrmJ wrtFrmK: efrmK [ 
	^self new
		onFrmI: efrmI
		andFrmJ: efrmJ
		wrtFrmK: efrmK
]

{ #category : 'VisualWorks metadata' }
ForTorGeneral class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'accessing' }
ForTorGeneral >> aFX [
	^forceVector aFTIeO
]

{ #category : 'accessing' }
ForTorGeneral >> aTX [
	^torqueVector aFTIeO
]

{ #category : 'accIC' }
ForTorGeneral >> fillAccICIterError: col [ 
	forceVector fillAccICIterError: col .
	torqueVector fillAccICIterError: col
]

{ #category : 'accIC' }
ForTorGeneral >> fillAccICIterJacob: mat [ 
	forceVector fillAccICIterJacob: mat .
	torqueVector fillAccICIterJacob: mat
]

{ #category : 'dynamic' }
ForTorGeneral >> fillDynError: col [
	forceVector fillDynError: col.
	torqueVector fillDynError: col
]

{ #category : 'posIC' }
ForTorGeneral >> fillPosICError: col [ 
	forceVector fillPosICError: col.
	torqueVector fillPosICError: col
]

{ #category : 'posIC' }
ForTorGeneral >> fillPosICJacob: mat [ 
	forceVector fillPosICJacob: mat.
	torqueVector fillPosICJacob: mat
]

{ #category : 'static' }
ForTorGeneral >> fillStaticError: col [
	forceVector fillStaticError: col.
	torqueVector fillStaticError: col
]

{ #category : 'static' }
ForTorGeneral >> fillStaticJacob: mat [
	forceVector fillStaticJacob: mat.
	torqueVector fillStaticJacob: mat
]

{ #category : 'dynamic' }
ForTorGeneral >> fillpFpy: mat [
	forceVector fillpFpy: mat.
	torqueVector fillpFpy: mat
]

{ #category : 'dynamic' }
ForTorGeneral >> fillpFpydot: mat [
	forceVector fillpFpydot: mat.
	torqueVector fillpFpydot: mat
]

{ #category : 'accessing' }
ForTorGeneral >> forceFunctions: col [ 
	forceVector functions: col
]

{ #category : 'initialize-release' }
ForTorGeneral >> initializeGlobally [
	forceVector initializeGlobally.
	torqueVector initializeGlobally
]

{ #category : 'initialize-release' }
ForTorGeneral >> initializeLocally [
	forceVector initializeLocally.
	torqueVector initializeLocally
]

{ #category : 'initialize-release' }
ForTorGeneral >> onFrmI: efrmI andFrmJ: efrmJ [ 
	forceVector := ForceVector onFrmI: efrmI andFrmJ: efrmJ.
	torqueVector := TorqueVector onFrmI: efrmI andFrmJ: efrmJ
]

{ #category : 'initialize-release' }
ForTorGeneral >> onFrmI: efrmI andFrmJ: efrmJ wrtFrmK: efrmK [ 
	forceVector := ForceVector
				onFrmI: efrmI
				andFrmJ: efrmJ
				wrtFrmK: efrmK.
	torqueVector := TorqueVector
				onFrmI: efrmI
				andFrmJ: efrmJ
				wrtFrmK: efrmK
]

{ #category : 'accIC' }
ForTorGeneral >> postAccICIteration [
	forceVector postAccICIteration.
	torqueVector postAccICIteration
]

{ #category : 'collision' }
ForTorGeneral >> postCollisionCorrectorIteration [
	forceVector postCollisionCorrectorIteration.
	torqueVector postCollisionCorrectorIteration
]

{ #category : 'collision' }
ForTorGeneral >> postCollisionPredictor [
	forceVector postCollisionPredictor.
	torqueVector postCollisionPredictor
]

{ #category : 'dynamic' }
ForTorGeneral >> postDynCorrectorIteration [
	forceVector postDynCorrectorIteration.
	torqueVector postDynCorrectorIteration
]

{ #category : 'dynamic' }
ForTorGeneral >> postDynOutput [
	forceVector postDynOutput.
	torqueVector postDynOutput
]

{ #category : 'dynamic' }
ForTorGeneral >> postDynPredictor [
	forceVector postDynPredictor.
	torqueVector postDynPredictor
]

{ #category : 'input-output' }
ForTorGeneral >> postInput [
	forceVector postInput.
	torqueVector postInput
]

{ #category : 'static' }
ForTorGeneral >> postStaticIteration [
	forceVector postStaticIteration.
	torqueVector postStaticIteration
]

{ #category : 'accIC' }
ForTorGeneral >> preAccIC [
	forceVector preAccIC.
	torqueVector preAccIC
]

{ #category : 'dynamic' }
ForTorGeneral >> preDynOutput [
	forceVector preDynOutput.
	torqueVector preDynOutput
]

{ #category : 'static' }
ForTorGeneral >> preStatic [
	forceVector preStatic.
	torqueVector preStatic
]

{ #category : 'dynamic' }
ForTorGeneral >> simUpdateAll [
	forceVector simUpdateAll.
	torqueVector simUpdateAll
]

{ #category : 'initialize-release' }
ForTorGeneral >> submitToSystem [
	self registerName.
	TheMbDSystem forTors add: self
]

{ #category : 'accessing' }
ForTorGeneral >> torqueFunctions: col [ 
	torqueVector functions: col
]

{ #category : 'initialize-release' }
ForTorGeneral >> useEquationNumbers [
	forceVector useEquationNumbers.
	torqueVector useEquationNumbers
]
