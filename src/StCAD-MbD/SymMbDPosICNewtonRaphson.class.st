Class {
	#name : 'SymMbDPosICNewtonRaphson',
	#superclass : 'SymMbDAnyPosICNewtonRaphson',
	#instVars : [
		'pivotRowLimits'
	],
	#category : 'StCAD-MbD-MbDSolver',
	#package : 'StCAD-MbD',
	#tag : 'MbDSolver'
}

{ #category : 'VisualWorks metadata' }
SymMbDPosICNewtonRaphson class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'initialize-release' }
SymMbDPosICNewtonRaphson >> assignEquationNumbers [
	"Equation order is q,s,u,lambar,lam."

	| partFrames contactEndFrames uHolders essentialConstraints displacementConstraints perpendicularConstraints eqnNo lastEssenConEqnNo lastDispConEqnNo |
	partFrames := system partFrames.
	contactEndFrames := system contactEndFrames.
	uHolders := system uHolders.
	essentialConstraints := system essentialConstraints2.
	displacementConstraints := system displacementConstraints.
	perpendicularConstraints := system perpendicularConstraints2.
	eqnNo := 1.
	partFrames do: [ :part |
		part iqX: eqnNo.
		eqnNo := eqnNo + 3.
		part iqE: eqnNo.
		eqnNo := eqnNo + 4 ].
	contactEndFrames do: [ :endFrm |
		endFrm is: eqnNo.
		eqnNo := eqnNo + endFrm sSize ].
	uHolders do: [ :uHolder |
		uHolder iu: eqnNo.
		eqnNo := eqnNo + 1 ].
	nqsu := eqnNo - 1.
	essentialConstraints do: [ :con |
		con iG: eqnNo.
		eqnNo := eqnNo + 1 ].
	lastEssenConEqnNo := eqnNo - 1.
	displacementConstraints do: [ :con |
		con iG: eqnNo.
		eqnNo := eqnNo + 1 ].
	lastDispConEqnNo := eqnNo - 1.
	perpendicularConstraints do: [ :con |
		con iG: eqnNo.
		eqnNo := eqnNo + 1 ].
	n := eqnNo - 1.
	pivotRowLimits := Array with: lastEssenConEqnNo with: lastDispConEqnNo with: n
]

{ #category : 'solving' }
SymMbDPosICNewtonRaphson >> handleSingularMatrix [
	nSingularMatrixError := nSingularMatrixError + 1.
	nSingularMatrixError = 1 
		ifTrue: 
			[self lookForRedundantConstraints.
			matrixSolver := self matrixSolverClass new]
		ifFalse: 
			[(matrixSolver isMemberOf: GESpMatParPvMarkoFast) 
				ifTrue: 
					[matrixSolver := GESpMatParPvPrecise new.
					self solveEquations]
				ifFalse: 
					[(matrixSolver isMemberOf: GESpMatParPvPrecise) 
						ifTrue: 
							[self lookForRedundantConstraints.
							matrixSolver := self matrixSolverClass new]
						ifFalse: [self halt: 'Check this.']]]
]

{ #category : 'solving' }
SymMbDPosICNewtonRaphson >> isConverged [
	^self isConvergedToNumericalLimit
]

{ #category : 'solving' }
SymMbDPosICNewtonRaphson >> lookForRedundantConstraints [

	| posICsolver |
	system logString: #'MbD: \Checking for redundant constraints.'.
	"	self toDebugTxtShowContextFrom: 1 to: 100."
	posICsolver := MbDGESpMatFullPvPosIC3 new.
	posICsolver system: self.
	Smalltalk garbageCollect.
	dx := posICsolver solve: pypx with: y negated saveOriginal: false.
	Smalltalk garbageCollect
]

{ #category : 'solving' }
SymMbDPosICNewtonRaphson >> lookForRedundantConstraints1 [

	| posICsolver |
	system logString: #'MbD: \Checking for redundant constraints.'.
	posICsolver := MbDGESpMatFullPvPosIC3 new.
	posICsolver system: self.
	Smalltalk garbageCollect.
	dx := posICsolver solve: pypx with: y negated saveOriginal: false.
	Smalltalk garbageCollect
]

{ #category : 'solving' }
SymMbDPosICNewtonRaphson >> lookForRedundantConstraints2 [
	"
	Alternate trying with RowPivoting and FullPivoting. 
	Extra check may be due to insufficient matrix solver precision for large problems. 
	Hence increase matrix solving precision.
	"

	| posICsolver |
	nSingularMatrixError := nSingularMatrixError + 1.
	nSingularMatrixError odd
		ifTrue: [
			matrixSolver := GESpMatParPvPrecise new.
			[ super solveEquations ]
				on: SingularMatrixError
				do: [ :ex | self lookForRedundantConstraints ] ]
		ifFalse: [
			system logString: #'MbD: \Checking for redundant constraints.'.
			posICsolver := MbDGESpMatFullPvPosIC3 new.
			posICsolver system: self.
			Smalltalk garbageCollect.
			dx := posICsolver solve: pypx with: y negated saveOriginal: false.
			Smalltalk garbageCollect.
			matrixSolver := self matrixSolverClass new ]
]

{ #category : 'accessing' }
SymMbDPosICNewtonRaphson >> pivotRowLimits [
	^pivotRowLimits
]

{ #category : 'solving' }
SymMbDPosICNewtonRaphson >> preRun [

	system
		logString: #'MbD: \Assembling system. ';
		prePosIC
]

{ #category : 'solving' }
SymMbDPosICNewtonRaphson >> run [

	[ super run ]
		on: SingularMatrixError
		do: [ :ex |
			| redundantEqns |
			redundantEqns := ex parameter.
			self allDo: [ :item | item removeRedundantConstraints: redundantEqns ].
			self allDo: [ :item | item constraintsReport ].
			self allDo: [ :item | item setqsu: qsuOld ].
			Smalltalk garbageCollect.
			ex retry ]
]

{ #category : 'solving' }
SymMbDPosICNewtonRaphson >> solveEquations1 [

	[
	iterNo > 2
		ifTrue: [
			(dxNorms at: iterNo - 1) > (30.0 * (dxNorms at: iterNo - 2))
				ifTrue: [ "Diverging solution." SingularMatrixError signal ]
				ifFalse: [ super solveEquations ] ]
		ifFalse: [ "Make it more likely to run redundant constraint checking in the first two iterations."
			matrixSolver singularPivotTolerance: 1.0e-12.
			super solveEquations.
			matrixSolver singularPivotTolerance: MachineAccuracy OfDoubleTimesFour ] ]
		on: SingularMatrixError
		do: [ :ex | self handleSingularMatrix ]
]
