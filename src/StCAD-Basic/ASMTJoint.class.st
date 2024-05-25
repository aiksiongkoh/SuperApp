Class {
	#name : 'ASMTJoint',
	#superclass : 'ASMTConstraintSet',
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'MbD' }
ASMTJoint >> createMbDin: mbdAssemblyFrm [

	| mbdJoint |
	mbdJoint := self mbdClass new.
	mbdObject := mbdJoint.
	mbdJoint name: self name.
	mbdJoint connectsI: markerI mbdObject toJ: markerJ mbdObject.
	mbdAssemblyFrm addJoint: mbdJoint
]

{ #category : 'parsing' }
ASMTJoint >> parseASMT: lines [

	| jointName |
	jointName := lines removeFirst trim.
	[ '*' , jointName match: self className ] assert.
	self parseName: lines.
	self parseMarkerI: lines.
	self parseMarkerJ: lines
]

{ #category : 'parsing' }
ASMTJoint >> parseJointSeries: lines [

	| tokens jointName |
	tokens := lines removeFirst substrings.
	[ '*JointSeries' match: tokens first ] assert.
	jointName := tokens second.
	[ self fullName = jointName ] assert.
	self parseFXonIs: lines.
	self parseFYonIs: lines.
	self parseFZonIs: lines.
	self parseTXonIs: lines.
	self parseTYonIs: lines.
	self parseTZonIs: lines
]
