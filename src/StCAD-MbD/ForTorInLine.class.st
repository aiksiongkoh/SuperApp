Class {
	#name : 'ForTorInLine',
	#superclass : 'ForceTorqueItem',
	#instVars : [
		'forceInLine',
		'torqueInLine'
	],
	#category : 'StCAD-MbD-MbDForce',
	#package : 'StCAD-MbD',
	#tag : 'MbDForce'
}

{ #category : 'instance creation' }
ForTorInLine class >> onFrmI: efrmI andFrmJ: efrmJ [ 
	^self new onFrmI: efrmI andFrmJ: efrmJ
]

{ #category : 'VisualWorks metadata' }
ForTorInLine class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'accessing' }
ForTorInLine >> aFX [
	^forceInLine aFTIeO
]

{ #category : 'accessing' }
ForTorInLine >> aTX [
	^torqueInLine aFTIeO
]

{ #category : 'accIC' }
ForTorInLine >> fillAccICIterError: col [
	forceInLine fillAccICIterError: col.
	torqueInLine fillAccICIterError: col
]

{ #category : 'accIC' }
ForTorInLine >> fillAccICIterJacob: mat [
	forceInLine fillAccICIterJacob: mat.
	torqueInLine fillAccICIterJacob: mat
]

{ #category : 'dynamic' }
ForTorInLine >> fillDynError: col [
	forceInLine fillDynError: col.
	torqueInLine fillDynError: col
]

{ #category : 'posIC' }
ForTorInLine >> fillPosICError: col [
	forceInLine fillPosICError: col.
	torqueInLine fillPosICError: col
]

{ #category : 'posIC' }
ForTorInLine >> fillPosICJacob: mat [
	forceInLine fillPosICJacob: mat.
	torqueInLine fillPosICJacob: mat
]

{ #category : 'static' }
ForTorInLine >> fillStaticError: col [
	forceInLine fillStaticError: col.
	torqueInLine fillStaticError: col
]

{ #category : 'static' }
ForTorInLine >> fillStaticJacob: mat [
	forceInLine fillStaticJacob: mat.
	torqueInLine fillStaticJacob: mat
]

{ #category : 'dynamic' }
ForTorInLine >> fillpFpy: mat [
	forceInLine fillpFpy: mat.
	torqueInLine fillpFpy: mat
]

{ #category : 'dynamic' }
ForTorInLine >> fillpFpydot: mat [
	forceInLine fillpFpydot: mat.
	torqueInLine fillpFpydot: mat
]

{ #category : 'initialize-release' }
ForTorInLine >> initializeGlobally [
	forceInLine initializeGlobally.
	torqueInLine initializeGlobally
]

{ #category : 'initialize-release' }
ForTorInLine >> initializeLocally [
	forceInLine initializeLocally.
	torqueInLine initializeLocally
]

{ #category : 'initialize-release' }
ForTorInLine >> onFrmI: efrmI andFrmJ: efrmJ [ 
	forceInLine := ForTorActReactInLine forceOnFrmI: efrmI andFrmJ: efrmJ.
	torqueInLine := ForTorActReactInLine torqueOnFrmI: efrmI andFrmJ: efrmJ
]

{ #category : 'accIC' }
ForTorInLine >> postAccICIteration [
	forceInLine postAccICIteration.
	torqueInLine postAccICIteration
]

{ #category : 'collision' }
ForTorInLine >> postCollisionCorrectorIteration [
	forceInLine postCollisionCorrectorIteration.
	torqueInLine postCollisionCorrectorIteration
]

{ #category : 'collision' }
ForTorInLine >> postCollisionPredictor [
	forceInLine postCollisionPredictor.
	torqueInLine postCollisionPredictor
]

{ #category : 'dynamic' }
ForTorInLine >> postDynCorrectorIteration [
	forceInLine postDynCorrectorIteration.
	torqueInLine postDynCorrectorIteration
]

{ #category : 'dynamic' }
ForTorInLine >> postDynOutput [
	forceInLine postDynOutput.
	torqueInLine postDynOutput
]

{ #category : 'dynamic' }
ForTorInLine >> postDynPredictor [
	forceInLine postDynPredictor.
	torqueInLine postDynPredictor
]

{ #category : 'input-output' }
ForTorInLine >> postInput [
	forceInLine postInput.
	torqueInLine postInput
]

{ #category : 'static' }
ForTorInLine >> postStaticIteration [
	forceInLine postStaticIteration.
	torqueInLine postStaticIteration
]

{ #category : 'accIC' }
ForTorInLine >> preAccIC [
	forceInLine preAccIC.
	torqueInLine preAccIC
]

{ #category : 'dynamic' }
ForTorInLine >> preDynOutput [
	forceInLine preDynOutput.
	torqueInLine preDynOutput
]

{ #category : 'static' }
ForTorInLine >> preStatic [
	forceInLine preStatic.
	torqueInLine preStatic
]

{ #category : 'dynamic' }
ForTorInLine >> simUpdateAll [
	forceInLine simUpdateAll.
	torqueInLine simUpdateAll
]

{ #category : 'initialize-release' }
ForTorInLine >> submitToSystem [
	self registerName.
	TheMbDSystem forTors add: self
]

{ #category : 'accessing' }
ForTorInLine >> tension: func [ 
	(func notNil and: [func isZero not])
		ifTrue: [forceInLine forTorFunction formula: func]
		ifFalse: [forceInLine := ForTorZero new]
]

{ #category : 'accessing' }
ForTorInLine >> twist: func [ 
	(func notNil and: [func isZero not])
		ifTrue: [torqueInLine forTorFunction formula: func]
		ifFalse: [torqueInLine := ForTorZero new]
]

{ #category : 'initialize-release' }
ForTorInLine >> useEquationNumbers [
	forceInLine useEquationNumbers.
	torqueInLine useEquationNumbers
]
