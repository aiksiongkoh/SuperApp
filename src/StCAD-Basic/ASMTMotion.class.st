Class {
	#name : 'ASMTMotion',
	#superclass : 'ASMTConstraintSet',
	#instVars : [
		'motionJoint'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'MbD' }
ASMTMotion >> createMbDin: mbdAssemblyFrm [

	| mbdMotion eFrmtI |
	self halt.
	mbdMotion := self mbdClass new.
	mbdObject := mbdMotion.
	mbdMotion name: self name.
	eFrmtI := self motionEndFrmI.
	mbdMotion connectsI: eFrmtI toJ: markerJ mbdObject.
	mbdAssemblyFrm addMotion: mbdMotion
]

{ #category : 'initialize-release' }
ASMTMotion >> initMotions [

	self subclassResponsibility
]

{ #category : 'parsing' }
ASMTMotion >> parseMotionJoint: lines [

	| jointName |
	[ lines removeFirst trim = 'MotionJoint' ] assert.
	jointName := lines removeFirst trim.
	motionJoint := self findJointNamed: jointName.
	markerI := motionJoint markerI.
	markerJ := motionJoint markerJ
]

{ #category : 'parsing' }
ASMTMotion >> parseMotionSeries: lines [

	| tokens motionName |
	tokens := lines removeFirst substrings.
	[ '*MotionSeries' match: tokens first ] assert.
	motionName := tokens second.
	[ self fullName = motionName ] assert.
	self parseFXonIs: lines.
	self parseFYonIs: lines.
	self parseFZonIs: lines.
	self parseTXonIs: lines.
	self parseTYonIs: lines.
	self parseTZonIs: lines
]
