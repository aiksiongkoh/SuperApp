Class {
	#name : 'MbDDirectionCosineIeqcJeqc',
	#superclass : 'MbDDirectionCosineIeqcJec',
	#instVars : [
		'pAijIeJepEJ',
		'ppAijIeJepEIpEJ',
		'ppAijIeJepEJpEJ',
		'pAjOJepEJT',
		'ppAjOJepEJpEJ'
	],
	#category : 'StCAD-MbD-MbDKinematicIJ',
	#package : 'StCAD-MbD',
	#tag : 'MbDKinematicIJ'
}

{ #category : 'VisualWorks metadata' }
MbDDirectionCosineIeqcJeqc class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'instance creation' }
MbDDirectionCosineIeqcJeqc class >> withFrmI: afrmI frmJ: afrmJ axisI: aaxisI axisJ: aaxisJ [ 
	^(afrmI isMemberOf: MbDEndFrameqc)
		& (afrmJ isMemberOf: MbDEndFrameqc)
		ifTrue: [self new
				withFrmI: afrmI
				frmJ: afrmJ
				axisI: aaxisI
				axisJ: aaxisJ]
		ifFalse: [nil]
]

{ #category : 'calc' }
MbDDirectionCosineIeqcJeqc >> calcPostDynCorrectorIteration [
	| ppAijIeJepEIipEJ ppAijIeJepEJipEJ ppAjOJepEJipEJ |
	super calcPostDynCorrectorIteration.
	pAjOJepEJT := frmJ pAjOepET: axisJ.
	1 to: 4 do: [:i | pAijIeJepEJ at: i put: (aAjOIe dot: (pAjOJepEJT at: i))].
	1 to: 4 do:  [:i | 
			ppAijIeJepEIipEJ := ppAijIeJepEIpEJ at: i.
			1 to: 4 do: [:j | ppAijIeJepEIipEJ at: j put: ((pAjOIepEIT at: i) dot: (pAjOJepEJT at: j))]].
	1 to: 4 do:  [:i | 
			ppAijIeJepEJipEJ := ppAijIeJepEJpEJ at: i.
			ppAjOJepEJipEJ := ppAjOJepEJpEJ at: i.
			i to: 4 do: [:j | ppAijIeJepEJipEJ at: j put: (aAjOIe dot: (ppAjOJepEJipEJ at: j))]].
	ppAijIeJepEJpEJ symLowerWithUpper
]

{ #category : 'initialize-release' }
MbDDirectionCosineIeqcJeqc >> initialize [
	super initialize.
	pAijIeJepEJ := StMFullRow new: 4.
	ppAijIeJepEIpEJ := StMFullMatrix new: 4 by: 4.
	ppAijIeJepEJpEJ := StMFullMatrix new: 4 by: 4
]

{ #category : 'initialize-release' }
MbDDirectionCosineIeqcJeqc >> initializeGlobally [
	super initializeGlobally.
	ppAjOJepEJpEJ := frmJ ppAjOepEpE: axisJ
]

{ #category : 'accessing' }
MbDDirectionCosineIeqcJeqc >> pAijIeJepEJ [
	^pAijIeJepEJ
]

{ #category : 'accessing' }
MbDDirectionCosineIeqcJeqc >> ppAijIeJepEIpEJ [
	^ppAijIeJepEIpEJ
]

{ #category : 'accessing' }
MbDDirectionCosineIeqcJeqc >> ppAijIeJepEJpEJ [
	^ppAijIeJepEJpEJ
]

{ #category : 'accessing' }
MbDDirectionCosineIeqcJeqc >> ppvaluepEIpEJ [
	^ppAijIeJepEIpEJ
]

{ #category : 'accessing' }
MbDDirectionCosineIeqcJeqc >> ppvaluepEJpEJ [
	^ppAijIeJepEJpEJ
]

{ #category : 'accessing' }
MbDDirectionCosineIeqcJeqc >> pvaluepEJ [
	^pAijIeJepEJ
]
