Class {
	#name : 'MbDDirectionCosineIeqcJec',
	#superclass : 'MbDDirectionCosineIecJec',
	#instVars : [
		'pAijIeJepEI',
		'ppAijIeJepEIpEI',
		'pAjOIepEIT',
		'ppAjOIepEIpEI'
	],
	#category : 'StCAD-MbD-MbDKinematicIJ',
	#package : 'StCAD-MbD',
	#tag : 'MbDKinematicIJ'
}

{ #category : 'VisualWorks metadata' }
MbDDirectionCosineIeqcJec class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'instance creation' }
MbDDirectionCosineIeqcJec class >> withFrmI: afrmI frmJ: afrmJ axisI: aaxisI axisJ: aaxisJ [ 
	^(afrmI isMemberOf: MbDEndFrameqc)
		& (afrmJ isMemberOf: MbDEndFramec)
		ifTrue: [self new
				withFrmI: afrmI
				frmJ: afrmJ
				axisI: aaxisI
				axisJ: aaxisJ]
		ifFalse: [nil]
]

{ #category : 'calc' }
MbDDirectionCosineIeqcJec >> calcPostDynCorrectorIteration [
	| ppAijIeJepEIipEI ppAjOIepEIipEI |
	super calcPostDynCorrectorIteration.
	pAjOIepEIT := frmI pAjOepET: axisI.
	1 to: 4 do: [:i | pAijIeJepEI at: i put: ((pAjOIepEIT at: i) dot: aAjOJe)].
	1 to: 4 do:  [:i | 
			ppAijIeJepEIipEI := ppAijIeJepEIpEI at: i.
			ppAjOIepEIipEI := ppAjOIepEIpEI at: i.
			i to: 4 do: [:j | ppAijIeJepEIipEI at: j put: ((ppAjOIepEIipEI at: j) dot: aAjOJe)]].
	ppAijIeJepEIpEI symLowerWithUpper
]

{ #category : 'initialize-release' }
MbDDirectionCosineIeqcJec >> initialize [
	super initialize.
	pAijIeJepEI := StMFullRow new: 4.
	ppAijIeJepEIpEI := StMFullMatrix new: 4 by: 4
]

{ #category : 'initialize-release' }
MbDDirectionCosineIeqcJec >> initializeGlobally [
	ppAjOIepEIpEI := frmI ppAjOepEpE: axisI
]

{ #category : 'accessing' }
MbDDirectionCosineIeqcJec >> pAijIeJepEI [
	^pAijIeJepEI
]

{ #category : 'accessing' }
MbDDirectionCosineIeqcJec >> ppAijIeJepEIpEI [
	^ppAijIeJepEIpEI
]

{ #category : 'accessing' }
MbDDirectionCosineIeqcJec >> ppvaluepEIpEI [
	^ppAijIeJepEIpEI
]

{ #category : 'accessing' }
MbDDirectionCosineIeqcJec >> pvaluepEI [
	^pAijIeJepEI
]
