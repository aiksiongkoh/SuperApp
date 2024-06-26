Class {
	#name : 'MbDNormalInContactCVCVJoint',
	#superclass : 'MbDInContactCVCVJoint',
	#category : 'StCAD-MbD-MbDJoint',
	#package : 'StCAD-MbD',
	#tag : 'MbDJoint'
}

{ #category : 'VisualWorks metadata' }
MbDNormalInContactCVCVJoint class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'dynamic' }
MbDNormalInContactCVCVJoint >> becomeStartingInContactCVCVJoint [
	self changeClassToThatOf: MbDStartingInContactCVCVJoint basicNew.
	frmI becomeContactEndFrame.
	frmJ becomeContactEndFrame.
	constraints do: [:a | a activateConstraint]
]

{ #category : 'accessing' }
MbDNormalInContactCVCVJoint >> contactForceAt: tout [ 
	| answer |
	answer := leastSquaresFit value: tout.
	"Transcript cr; show: 'contactForceAt:'; show: answer printString."
	^answer
]

{ #category : 'accessing' }
MbDNormalInContactCVCVJoint >> contactForceDerivative: n at: tout [ 
	^leastSquaresFit derivative: n at: tout
]

{ #category : 'dynamic' }
MbDNormalInContactCVCVJoint >> postDynStep [
	super postDynStep.
	self calcLSScoeffs
]
