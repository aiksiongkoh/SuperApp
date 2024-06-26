Class {
	#name : 'MbDDistIeqcJeqc',
	#superclass : 'MbDDistIeqcJec',
	#instVars : [
		'prIeJepXJ',
		'prIeJepEJ',
		'pprIeJepXIpXJ',
		'pprIeJepEIpXJ',
		'pprIeJepXJpXJ',
		'pprIeJepXIpEJ',
		'pprIeJepEIpEJ',
		'pprIeJepXJpEJ',
		'pprIeJepEJpEJ',
		'prIeJeOpEJT'
	],
	#category : 'StCAD-MbD-MbDKinematicIJ',
	#package : 'StCAD-MbD',
	#tag : 'MbDKinematicIJ'
}

{ #category : 'VisualWorks metadata' }
MbDDistIeqcJeqc class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.MbD'
		'superclassNamespace' 'StCAD.MbD'
	)

]

{ #category : 'instance creation' }
MbDDistIeqcJeqc class >> withFrmI: afrmI frmJ: afrmJ [ 
	^(afrmI isMemberOf: MbDEndFrameqc)
		& (afrmJ isMemberOf: MbDEndFrameqc)
		ifTrue: [self new withFrmI: afrmI frmJ: afrmJ]
		ifFalse: [nil]
]

{ #category : 'calc' }
MbDDistIeqcJeqc >> calcPrivate [
	| prIeJeOpEJ pprIeJeOpEJpEJ pprIeJepXIipXJ prIeJepXIi element pprIeJepEIipXJ prIeJepEIi mprIeJeOpEIiT pprIeJepXJipXJ prIeJepXJi pprIeJepXIipEJ prIeJeOipEJ pprIeJepEIipEJ pprIeJepXJipEJ pprIeJepEJipEJ prIeJepEJi pprIeJeOpEJipEJ prIeJeOpEJiT uIeJeOT |
	super calcPrivate.
	rIeJe = 0.0 ifTrue: [^self].
	prIeJeOpEJ := frmJ prOeOpE.
	prIeJeOpEJT := prIeJeOpEJ transpose.
	pprIeJeOpEJpEJ := frmJ pprOeOpEpE.
	uIeJeOT := uIeJeO transpose.
	prIeJepXJ := uIeJeOT.
	prIeJepEJ := uIeJeOT timesFullMatrix: prIeJeOpEJ.
	1 to: 3
		do: 
			[:i | 
			pprIeJepXIipXJ := pprIeJepXIpXJ at: i.
			prIeJepXIi := prIeJepXI at: i.
			1 to: 3
				do: 
					[:j | 
					element := i == j
								ifTrue: [-1.0]
								ifFalse: [0.0].
					element := element - (prIeJepXIi * (prIeJepXJ at: j)).
					pprIeJepXIipXJ at: j put: element / rIeJe]].
	1 to: 4
		do: 
			[:i | 
			pprIeJepEIipXJ := pprIeJepEIpXJ at: i.
			prIeJepEIi := prIeJepEI at: i.
			mprIeJeOpEIiT := mprIeJeOpEIT at: i.
			1 to: 3
				do: 
					[:j | 
					element := 0.0 - (mprIeJeOpEIiT at: j) - (prIeJepEIi * (prIeJepXJ at: j)).
					pprIeJepEIipXJ at: j put: element / rIeJe]].
	1 to: 3
		do: 
			[:i | 
			pprIeJepXJipXJ := pprIeJepXJpXJ at: i.
			prIeJepXJi := prIeJepXJ at: i.
			1 to: 3
				do: 
					[:j | 
					element := i == j
								ifTrue: [1.0]
								ifFalse: [0.0].
					element := element - (prIeJepXJi * (prIeJepXJ at: j)).
					pprIeJepXJipXJ at: j put: element / rIeJe]].
	1 to: 3
		do: 
			[:i | 
			pprIeJepXIipEJ := pprIeJepXIpEJ at: i.
			prIeJepXIi := prIeJepXI at: i.
			prIeJeOipEJ := prIeJeOpEJ at: i.
			1 to: 4
				do: 
					[:j | 
					element := 0.0 - (prIeJeOipEJ at: j) - (prIeJepXIi * (prIeJepEJ at: j)).
					pprIeJepXIipEJ at: j put: element / rIeJe]].
	1 to: 4
		do: 
			[:i | 
			pprIeJepEIipEJ := pprIeJepEIpEJ at: i.
			prIeJepEIi := prIeJepEI at: i.
			mprIeJeOpEIiT := mprIeJeOpEIT at: i.
			1 to: 4
				do: 
					[:j | 
					element := 0.0 - (mprIeJeOpEIiT dot: (prIeJeOpEJT at: j)) - (prIeJepEIi * (prIeJepEJ at: j)).
					pprIeJepEIipEJ at: j put: element / rIeJe]].
	1 to: 3
		do: 
			[:i | 
			pprIeJepXJipEJ := pprIeJepXJpEJ at: i.
			prIeJepXJi := prIeJepXJ at: i.
			prIeJeOipEJ := prIeJeOpEJ at: i.
			1 to: 4
				do: 
					[:j | 
					element := (prIeJeOipEJ at: j)
								- (prIeJepXJi * (prIeJepEJ at: j)).
					pprIeJepXJipEJ at: j put: element / rIeJe]].
	1 to: 4
		do: 
			[:i | 
			pprIeJepEJipEJ := pprIeJepEJpEJ at: i.
			prIeJepEJi := prIeJepEJ at: i.
			pprIeJeOpEJipEJ := pprIeJeOpEJpEJ at: i.
			prIeJeOpEJiT := prIeJeOpEJT at: i.
			1 to: 4
				do: 
					[:j | 
					element := (prIeJeOpEJiT dot: (prIeJeOpEJT at: j))
								+ ((pprIeJeOpEJipEJ at: j)
										dot: rIeJeO) - (prIeJepEJi * (prIeJepEJ at: j)).
					pprIeJepEJipEJ at: j put: element / rIeJe]]
]

{ #category : 'initialize-release' }
MbDDistIeqcJeqc >> initialize [
	super initialize.
	prIeJepXJ := StMFullRow new: 3.
	prIeJepEJ := StMFullRow new: 4.
	pprIeJepXIpXJ := StMFullMatrix new: 3 by: 3.
	pprIeJepEIpXJ := StMFullMatrix new: 4 by: 3.
	pprIeJepXJpXJ := StMFullMatrix new: 3 by: 3.
	pprIeJepXIpEJ := StMFullMatrix new: 3 by: 4.
	pprIeJepEIpEJ := StMFullMatrix new: 4 by: 4.
	pprIeJepXJpEJ := StMFullMatrix new: 3 by: 4.
	pprIeJepEJpEJ := StMFullMatrix new: 4 by: 4
]

{ #category : 'accessing' }
MbDDistIeqcJeqc >> ppvaluepEIpEJ [
	^pprIeJepEIpEJ
]

{ #category : 'accessing' }
MbDDistIeqcJeqc >> ppvaluepEIpXJ [
	^pprIeJepEIpXJ
]

{ #category : 'accessing' }
MbDDistIeqcJeqc >> ppvaluepEJpEJ [
	^pprIeJepEJpEJ
]

{ #category : 'accessing' }
MbDDistIeqcJeqc >> ppvaluepXIpEJ [
	^pprIeJepXIpEJ
]

{ #category : 'accessing' }
MbDDistIeqcJeqc >> ppvaluepXIpXJ [
	^pprIeJepXIpXJ
]

{ #category : 'accessing' }
MbDDistIeqcJeqc >> ppvaluepXJpEJ [
	^pprIeJepXJpEJ
]

{ #category : 'accessing' }
MbDDistIeqcJeqc >> ppvaluepXJpXJ [
	^pprIeJepXJpXJ
]

{ #category : 'accessing' }
MbDDistIeqcJeqc >> prIeJeOpEJ [
	^frmJ prOeOpE
]

{ #category : 'accessing' }
MbDDistIeqcJeqc >> prIeJepEJ [
	^prIeJepEJ
]

{ #category : 'accessing' }
MbDDistIeqcJeqc >> prIeJepXJ [
	^prIeJepXJ
]

{ #category : 'accessing' }
MbDDistIeqcJeqc >> puIeJeOpEJ [
	| answer prIeJeOpEJ oneOverrIeJe oneOverrIeJeSq answeri prIeJeOpEJi rIeJeOi aij |
	answer := StMFullMatrix new: 3 by: 4.
	prIeJeOpEJ := frmJ prOeOpE.
	oneOverrIeJe := 1.0 / rIeJe.
	oneOverrIeJeSq := oneOverrIeJe / rIeJe.
	1 to: 3 do: [:i | 
			answeri := answer at: i.
			prIeJeOpEJi := prIeJeOpEJ at: i.
			rIeJeOi := rIeJeO at: i.
			1 to: 4 do: [:j | 
					aij := (prIeJeOpEJi at: j) * oneOverrIeJe - (rIeJeOi * (prIeJepEJ at: j) * oneOverrIeJeSq).
					answeri at: j put: aij]].
	^answer
]

{ #category : 'accessing' }
MbDDistIeqcJeqc >> puIeJeOpXJ [
	| answer m1OverrIeJe m1OverrIeJeSq answeri rIeJeOi aij |
	answer := StMFullMatrix new: 3 by: 3.
	m1OverrIeJe := -1.0 / rIeJe.
	m1OverrIeJeSq := m1OverrIeJe / rIeJe.
	1 to: 3 do: [:i | 
			answeri := answer at: i.
			rIeJeOi := rIeJeO at: i.
			1 to: 3 do: [:j | 
					aij := rIeJeOi * (prIeJepXJ at: j) * m1OverrIeJeSq.
					answeri at: j put: aij].
			answeri at: i minusNumber: m1OverrIeJe].
	^answer
]

{ #category : 'accessing' }
MbDDistIeqcJeqc >> pvaluepEJ [
	^prIeJepEJ
]

{ #category : 'accessing' }
MbDDistIeqcJeqc >> pvaluepXJ [
	^prIeJepXJ
]
