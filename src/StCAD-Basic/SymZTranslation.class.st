Class {
	#name : 'SymZTranslation',
	#superclass : 'SymMotionIJ',
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'initialization' }
SymZTranslation >> initializeGlobally [

	constraints isEmpty
		ifTrue: [
			self initMotions.
			self owns:
				(SymTranslationConstraintIJ
					 withFrmI: endFrmI
					 frmJ: endFrmJ
					 axis: 3).
			self hasChanged: true ]
		ifFalse: [ super initializeGlobally ]
]
