Class {
	#name : 'SymZRotation',
	#superclass : 'SymMotionIJ',
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'initialize-release' }
SymZRotation >> connectsI: mkrII toJ: mkrJJ [

	super connectsI: mkrII toJ: mkrJJ.
	self addConstraint: (SymDirectionCosineConstraintIJ
			 withFrmI: endFrmI
			 frmJ: endFrmJ
			 axisI: 2
			 axisJ: 1)
]

{ #category : 'initialization' }
SymZRotation >> initializeGlobally [

	constraints isEmpty
		ifTrue: [
			self initMotions.
			self owns: (SymDirectionCosineConstraintIJ
					 withFrmI: endFrmI
					 frmJ: endFrmJ
					 axisI: 2
					 axisJ: 1).
			self hasChanged: true ]
		ifFalse: [ super initializeGlobally ]
]

{ #category : 'accessing' }
SymZRotation >> phiBlk [

	^ phiBlk
]

{ #category : 'accessing' }
SymZRotation >> phiBlk: anObject [

	phiBlk := anObject
]

{ #category : 'accessing' }
SymZRotation >> psiBlk [

	^ psiBlk
]

{ #category : 'accessing' }
SymZRotation >> psiBlk: anObject [

	psiBlk := anObject
]

{ #category : 'accessing' }
SymZRotation >> theBlk [

	^ theBlk
]

{ #category : 'accessing' }
SymZRotation >> theBlk: anObject [

	theBlk := anObject
]

{ #category : 'accessing' }
SymZRotation >> xBlk [

	^ xBlk
]

{ #category : 'accessing' }
SymZRotation >> xBlk: anObject [

	xBlk := anObject
]

{ #category : 'accessing' }
SymZRotation >> yBlk [

	^ yBlk
]

{ #category : 'accessing' }
SymZRotation >> yBlk: anObject [

	yBlk := anObject
]

{ #category : 'accessing' }
SymZRotation >> zBlk [

	^ zBlk
]

{ #category : 'accessing' }
SymZRotation >> zBlk: anObject [

	zBlk := anObject
]
