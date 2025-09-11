Class {
	#name : 'ASMTRotationalMotion',
	#superclass : 'ASMTMotion',
	#instVars : [
		'rotationZ'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'accessing' }
ASMTRotationalMotion class >> mbdClass [

	^ SymZRotation
]

{ #category : 'accessing' }
ASMTRotationalMotion >> functionParser [

	| parser |
	parser := StMMotionFunctionParser new.
	parser container: self.
	parser initVariables.
	^ parser
]

{ #category : 'initialize-release' }
ASMTRotationalMotion >> initMotions [

	| phiFunc parser stack func mbdZRotation |
	phiFunc := rotationZ ifNil: [ StMConstant with: 0 ] ifNotNil: [
		           rotationZ isUserFunction
			           ifTrue: [
				           parser := self functionParser.
				           stack := parser parseUserFunction: rotationZ notifying: nil ifFail: nil.
				           func := stack last.
				           func ]
			           ifFalse: [ rotationZ ] ].
	phiFunc := phiFunc simplified.
	mbdZRotation := self mbdObject.
	mbdZRotation phiBlk: phiFunc.
	mbdZRotation initMotions
]

{ #category : 'as yet unclassified' }
ASMTRotationalMotion >> motionEndFrmI [

	| eFrmcI eFrmtI theta3z parser stack func |
	eFrmcI := markerI mbdObject.
	eFrmtI := eFrmcI newEndFramet.
	theta3z := rotationZ ifNil: [ StMConstant with: 0 ] ifNotNil: [
			           rotationZ isUserFunction
				           ifTrue: [
						           parser := self functionParser.
						           stack := parser
							                    parseUserFunction: rotationZ
							                    notifying: nil
							                    ifFail: nil.
						           func := stack last.
						           func ]
				           ifFalse: [ rotationZ ] ].
	theta3z := theta3z simplified.
	eFrmtI theta3z: theta3z.
	^ eFrmtI
]

{ #category : 'parsing' }
ASMTRotationalMotion >> parseASMT: lines [

	[ lines removeFirst trim = 'RotationalMotion' ] assert.
	self parseName: lines.
	self parseMotionJoint: lines.
	self parseRotationZ: lines
]

{ #category : 'parsing' }
ASMTRotationalMotion >> parseRotationZ: lines [

	| function |
	[ lines removeFirst trim = 'RotationZ' ] assert.
	function := BasicUserFunction with: lines removeFirst trim myUnit: 1.0 units: SymUnits new.
	rotationZ := function
]

{ #category : 'accessing' }
ASMTRotationalMotion >> rotZFunc [

	| parser stack func |
	parser := self functionParser.
	stack := parser parseUserFunction: rotationZ notifying: nil ifFail: nil.
	func := stack last.
	func
]
