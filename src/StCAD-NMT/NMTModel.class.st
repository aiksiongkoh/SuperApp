"
NMTNMTModel creates and stores all nonUse NMTItem.

Subclasses must implement the following messages:
	calc
		cItemWithBoundingBox

Instance Variables:
	aBoundingBox	<Object>	description of aBoundingBox
	cEdge	<Collection>	Stores all Edge.
	cFace	<Collection>	Stores all Face
	cFeature	<Collection>	Stores all Feature
	cLoop	<Collection>	Stores all Loop
	cRegion	<Collection>	Stores all Regions including embedded regions (voids)
	cShell	<Collection>	Stores all Shell
	cVertex	<Collection>	Stores all Vertex


"
Class {
	#name : #NMTModel,
	#superclass : #ConcreteNMT,
	#instVars : [
		'cFeature',
		'cRegion',
		'cShell',
		'cFace',
		'cLoop',
		'cEdge',
		'cVertex',
		'aRefFrame',
		'aBoundingBox'
	],
	#category : #'StCAD-NMT-Basic'
}

{ #category : #'VisualWorks metadata' }
NMTModel class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.NMT'
		'superclassNamespace' 'StCAD.NMT'
	)

]

{ #category : #accessing }
NMTModel >> _aRefFrame: aaRefFrame [ 
	aRefFrame := aaRefFrame.
	aRefFrame body: self
]

{ #category : #accessing }
NMTModel >> aBoundingBox [
	^aBoundingBox ifNil: 
			[self calcBoundingBox.
			aBoundingBox]
]

{ #category : #accessing }
NMTModel >> aBoundingBox: anObject [
	aBoundingBox := anObject
]

{ #category : #accessing }
NMTModel >> aBoundingBoxF [
	"NMTModel frame is the same as part frame. No transformation needed."

	^self aBoundingBox
]

{ #category : #accessing }
NMTModel >> aDisplayList [
	^self triggerEvent: #aDisplayList
]

{ #category : #accessing }
NMTModel >> aDisplayList: aDisplayList [ 
	self removeActionsForEvent: #aDisplayList.
	aDisplayList notNil 
		ifTrue: 
			[self 
				when: #aDisplayList
				ask: aDisplayList
				perform: #yourself]
]

{ #category : #accessing }
NMTModel >> aModel [
	^self
]

{ #category : #accessing }
NMTModel >> aOutsideRegion [
	^cRegion at: 1
]

{ #category : #accessing }
NMTModel >> aRefFrame [
	^aRefFrame
]

{ #category : #accessing }
NMTModel >> aRefFrame: aaRefFrame [ 
	aRefFrame := aaRefFrame.
	aRefFrame body: self
]

{ #category : #accessing }
NMTModel >> aSketch [
	^self
]

{ #category : #accessing }
NMTModel >> addEdge: aEdge [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	aEdge removeSup.
	cEdge add: aEdge.
	aEdge aSup: self.
	^aEdge
]

{ #category : #accessing }
NMTModel >> addFace: aFace [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	aFace removeSup.
	cFace add: aFace.
	aFace aSup: self.
	^aFace
]

{ #category : #accessing }
NMTModel >> addFeature: aFeature [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	self aRefFrame addSub: aFeature aRefFrame.
	aFeature removeSup.
	cFeature add: aFeature.
	aFeature aSup: self.
	^aFeature
]

{ #category : #accessing }
NMTModel >> addLoop: aLoop [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	aLoop removeSup.
	cLoop add: aLoop.
	aLoop aSup: self.
	^aLoop
]

{ #category : #accessing }
NMTModel >> addRegion: aRegion [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	aRegion removeSup.
	cRegion add: aRegion.
	aRegion aSup: self.
	^aRegion
]

{ #category : #accessing }
NMTModel >> addShell: aShell [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	aShell removeSup.
	cShell add: aShell.
	aShell aSup: self.
	^aShell
]

{ #category : #accessing }
NMTModel >> addSurface: aSurface [ 
	aSurface removeSup.
	aRefFrame addSub: aSurface aRefFrame.
	aSurface aSup: self.
	^aSurface
]

{ #category : #accessing }
NMTModel >> addVertex: aVertex [ 
	"aSub maybe already in a tree. Make sure aSub is released by its aSup."

	aVertex removeSup.
	cVertex add: aVertex.
	aVertex aSup: self.
	^aVertex
]

{ #category : #ops }
NMTModel >> buildCutFeature: aCutFeature [ 
	self doDIFFwith: aCutFeature aModel
]

{ #category : #ops }
NMTModel >> buildExtrudedFeature: aExtrudedFeature [ 
	self doORwith: aExtrudedFeature aModel
]

{ #category : #accessing }
NMTModel >> cFace [
	^cFace
]

{ #category : #accessing }
NMTModel >> cFace: anObject [
	cFace := anObject
]

{ #category : #accessing }
NMTModel >> cFeature [
	^cFeature
]

{ #category : #calc }
NMTModel >> cItemWithBoundingBox [
	self subclassResponsibility
]

{ #category : #accessing }
NMTModel >> cSub [
	^cRegion
]

{ #category : #accessing }
NMTModel >> cadObject: cadObject [ 
	self removeActionsForEvent: #getCADObject.
	cadObject notNil 
		ifTrue: 
			[self 
				when: #getCADObject
				ask: cadObject
				perform: #yourself]
]

{ #category : #calc }
NMTModel >> calcBoundingBox [
	self privateCalcBoundingBox.
	aSup ifNotNil: [aSup clearBoundingBox]
]

{ #category : #calc }
NMTModel >> calcMomentsOfVolume [
	"To be implemented."

	^self notYetImplemented
]

{ #category : #ops }
NMTModel >> clear [
	cRegion asArray do: [:aRegion | self removeRegion: aRegion].
	cShell asArray do: [:aShell | self removeShell: aShell].
	cFace asArray do: [:aFace | self removeFace: aFace].
	cLoop asArray do: [:aLoop | self removeLoop: aLoop].
	cEdge asArray do: [:aEdge | self removeEdge: aEdge].
	cVertex asArray do: [:aVertex | self removeVertex: aVertex].
	self addRegion: OutsideRegion new
]

{ #category : #accessing }
NMTModel >> container [
	^aSup
]

{ #category : #executing }
NMTModel >> doORwith: aModel [ 
	"Do boolean OR. Do nothing for now."

	| cNewRegion |
	self emptySelf.
	cNewRegion := aModel selectRegion: [:aRegion | true].
	cNewRegion do: [:aRegion | self addRegion: aRegion]
]

{ #category : #accessing }
NMTModel >> emptySelf [
	cRegion asArray do: [:aRegion | self removeSub: aRegion]
]

{ #category : #'initialize-release' }
NMTModel >> initialize [

	cFeature := StCAD_Misc_OrderedSet new. "VW_TRANSLATION:StCAD.Misc.OrderedSet:StCAD_Misc_OrderedSet"
	cRegion := StCAD_Misc_OrderedSet new.
	cShell := StCAD_Misc_OrderedSet new.
	cFace := StCAD_Misc_OrderedSet new.
	cLoop := StCAD_Misc_OrderedSet new.
	cEdge := StCAD_Misc_OrderedSet new.
	cVertex := StCAD_Misc_OrderedSet new.
	self aRefFrame: OriginFrame new.
	aBoundingBox := StCAD_Misc_BoundingBox new. "VW_TRANSLATION:StCAD.Misc.BoundingBox:StCAD_Misc_BoundingBox"
	self addRegion: OutsideRegion new
]

{ #category : #accessing }
NMTModel >> interface [
	^aSup interface
]

{ #category : #ops }
NMTModel >> magnifySelf: aDouble [ 
	(self selectSurface: [:a | a isSpatial]) do: [:a | a magnifySelf: aDouble].
	(self selectCurve: [:a | a isSpatial]) do: [:a | a magnifySelf: aDouble].
	(self selectVertex: [:a | a isSpatial]) do: [:a | a magnifySelf: aDouble].
	(self selectFaceUse: [:a | a aSurface isSpatial]) 
		do: [:a | a glSurface: nil].
	aRefFrame rFfF magnifySelf: aDouble.
	aBoundingBox magnifySelf: aDouble
]

{ #category : #accessing }
NMTModel >> newEdgeWith: aVertex1 and: aVertex2 aCurve: aCurve [

	| acEdge acVertex aEdge |
	acEdge := self selectEdge: [ :aaEdge | 
		          acVertex := aaEdge cVertex.
		          (acVertex includes: aVertex1) and: [ 
			          (acVertex includes: aVertex2) and: [ 
				          aaEdge aCurve = aCurve ] ] ].
	^ acEdge size = 0
		  ifTrue: [ 
			  aEdge := StCAD_NMT_Edge new. "VW_TRANSLATION:StCAD.NMT.Edge:StCAD_NMT_Edge"
			  aEdge aCurve: aCurve.
			  self addEdge: aEdge.
			  aEdge ]
		  ifFalse: [ 
			  acEdge size = 1
				  ifTrue: [ acEdge first ]
				  ifFalse: [ self assert: [ acEdge size < 2 ] ] ]
]

{ #category : #accessing }
NMTModel >> newFace [

	| aFace |
	aFace := StCAD_NMT_Face new. "VW_TRANSLATION:StCAD.NMT.Face:StCAD_NMT_Face"
	self addFace: aFace.
	^ aFace
]

{ #category : #accessing }
NMTModel >> newLoop [

	| aLoop |
	aLoop := StCAD_NMT_Loop new. "VW_TRANSLATION:StCAD.NMT.Loop:StCAD_NMT_Loop"
	self addLoop: aLoop.
	^ aLoop
]

{ #category : #accessing }
NMTModel >> newRegion [

	| aRegion |
	aRegion := StCAD_NMT_Region new. "VW_TRANSLATION:StCAD.NMT.Region:StCAD_NMT_Region"
	self addRegion: aRegion.
	^ aRegion
]

{ #category : #accessing }
NMTModel >> newShell [

	| aShell |
	aShell := StCAD_NMT_Shell new. "VW_TRANSLATION:StCAD.NMT.Shell:StCAD_NMT_Shell"
	self addShell: aShell.
	^ aShell
]

{ #category : #accessing }
NMTModel >> newVertex: aPoint [

	"A Vertex must be unique in space."

	| aVertex |
	aVertex := cVertex
		           detect: [ :aaVertex | aaVertex aPoint = aPoint ]
		           ifNone: nil.
	^ aVertex ifNil: [ 
		  self addVertex: (StCAD_NMT_Vertex new: aPoint) "VW_TRANSLATION:StCAD.NMT.Vertex:StCAD_NMT_Vertex" ]
]

{ #category : #'initialize-release' }
NMTModel >> preSave [
"	self aOutsideRegion preSave."
	self removeDisplayList
]

{ #category : #printing }
NMTModel >> printOn: aStream [ 
	aStream nextPutAll: 'aM'.
	aStream print: (self selectModel: [:item | true]) size.
	aStream nextPutAll: ':R'.
	aStream print: (self selectRegion: [:item | true]) size.
	aStream nextPutAll: ':S'.
	aStream print: (self selectShell: [:item | true]) size.
	aStream nextPutAll: ':F'.
	aStream print: (self selectFace: [:item | true]) size.
	aStream nextPutAll: ':L'.
	aStream print: (self selectLoop: [:item | true]) size.
	aStream nextPutAll: ':E'.
	aStream print: (self selectEdge: [:item | true]) size.
	aStream nextPutAll: ':V'.
	aStream print: (self selectVertex: [:item | true]) size.
	aStream nextPutAll: ':FU'.
	aStream print: (self selectFaceUse: [:item | true]) size.
	aStream nextPutAll: ':LU'.
	aStream print: (self selectLoopUse: [:item | true]) size.
	aStream nextPutAll: ':EU'.
	aStream print: (self selectEdgeUse: [:item | true]) size.
	aStream nextPutAll: ':VU'.
	aStream print: (self selectVertexUse: [:item | true]) size
]

{ #category : #ops }
NMTModel >> privateBuildSolidModel [
	self clear.
	cFeature do: [:aFeature | aFeature buildIn: self].
	self calcBoundingBox.
	self calcMomentsOfVolume
]

{ #category : #calc }
NMTModel >> privateCalcBoundingBox [

	| cFaceUse |
	cFaceUse := self aOutsideRegion selectFaceUse: [ :aFaceUse | true ].
	aBoundingBox := StCAD_Misc_BoundingBox new. "VW_TRANSLATION:StCAD.Misc.BoundingBox:StCAD_Misc_BoundingBox"
	cFaceUse do: [ :aFaceUse | 
		aBoundingBox expandToBound: aFaceUse aSurface aBoundingBoxF ]
]

{ #category : #calc }
NMTModel >> privateCalcBoundingBox1 [

	| tcVertex |
	tcVertex := self aOutsideRegion selectVertex: [ :aVertex | true ].
	aBoundingBox := StCAD_Misc_BoundingBox new. "VW_TRANSLATION:StCAD.Misc.BoundingBox:StCAD_Misc_BoundingBox"
	tcVertex
		inject: aBoundingBox
		into: [ :bbox :aVertex | bbox expandToBound: aVertex aPoint ]
]

{ #category : #calc }
NMTModel >> privateCalcBoundingBox2 [

	| cFaceUse |
	cFaceUse := self aOutsideRegion selectFaceUse: [ :aFaceUse | true ].
	aBoundingBox := StCAD_Misc_BoundingBox new. "VW_TRANSLATION:StCAD.Misc.BoundingBox:StCAD_Misc_BoundingBox"
	cFaceUse do: [ :aFaceUse | 
		aBoundingBox expandToBound: aFaceUse aSurface aBoundingBoxF ]
]

{ #category : #accessing }
NMTModel >> rDfD [
	^aSup rDfD
]

{ #category : #accessing }
NMTModel >> removeDisplayList [
	self aDisplayList ifNotNil: 
			[:listID | 
			self interface display aOpenGLContext removeDisplayList: listID.
			self aDisplayList: nil]
]

{ #category : #accessing }
NMTModel >> removeEdge: aEdge [ 
	cEdge remove: aEdge ifAbsent: [nil].
	aEdge aSup: nil.
	^aEdge
]

{ #category : #accessing }
NMTModel >> removeFace: aFace [ 
	cFace remove: aFace ifAbsent: [nil].
	aFace aSup: nil.
	^aFace
]

{ #category : #accessing }
NMTModel >> removeGeometry: aGeometry [ 
	aRefFrame removeSub: aGeometry aRefFrame.
	aGeometry aSup: nil.
	^aGeometry
]

{ #category : #accessing }
NMTModel >> removeLoop: aLoop [ 
	cLoop remove: aLoop ifAbsent: [nil].
	aLoop aSup: nil.
	^aLoop
]

{ #category : #accessing }
NMTModel >> removeRegion: aRegion [ 
	cRegion remove: aRegion ifAbsent: [nil].
	aRegion aSup: nil.
	^aRegion
]

{ #category : #accessing }
NMTModel >> removeShell: aShell [ 
	cShell remove: aShell ifAbsent: [nil].
	aShell aSup: nil.
	^aShell
]

{ #category : #accessing }
NMTModel >> removeSup [
	self removeDisplayList.
	self aSup ifNotNil: [:aaSup | aaSup removeNMT: self]
]

{ #category : #accessing }
NMTModel >> removeVertex: aVertex [ 
	cVertex remove: aVertex ifAbsent: [nil].
	aVertex aSup: nil.
	^aVertex
]

{ #category : #displaying }
NMTModel >> renderOn1: aOpenGLContext [ 
	self removeDisplayList.
	self aOutsideRegion renderOn: aOpenGLContext
]

{ #category : #displaying }
NMTModel >> renderOn2: aOpenGLContext [ 
	| block |
	block := 
			[| listID |
			listID := aOpenGLContext 
						createDisplayList: [self aOutsideRegion renderOn: aOpenGLContext]
						displayImmediately: false.
			self aDisplayList: listID.
			aOpenGLContext callDisplayList: listID].
	self aDisplayList ifNil: block
		ifNotNil: 
			[:listID | 
			(aOpenGLContext isDisplayList: listID) 
				ifTrue: [aOpenGLContext callDisplayList: listID]
				ifFalse: block]
]

{ #category : #displaying }
NMTModel >> renderOn: aOpenGLContext [ 
	| block |
	block := 
			[| listID |
			listID := aOpenGLContext 
						createDisplayList: [self aOutsideRegion renderOn: aOpenGLContext]
						displayImmediately: false.
			self aDisplayList: listID.
			aOpenGLContext callDisplayList: listID].
	self aDisplayList ifNil: block
		ifNotNil: 
			[:listID | 
			(aOpenGLContext isDisplayList: listID) 
				ifTrue: [aOpenGLContext callDisplayList: listID]
				ifFalse: block]
]

{ #category : #enumerating }
NMTModel >> selectCurve: aBlock into: aSet [ 
	cEdge do: [:each | each selectCurve: aBlock into: aSet]
]

{ #category : #enumerating }
NMTModel >> selectEdge: aBlock into: aSet [ 
	cEdge do: [:each | each selectEdge: aBlock into: aSet]
]

{ #category : #enumerating }
NMTModel >> selectEdgeUse: aBlock into: aSet [ 
	cRegion do: [:each | each selectEdgeUse: aBlock into: aSet]
]

{ #category : #enumerating }
NMTModel >> selectFace: aBlock into: aSet [ 
	cFace do: [:each | each selectFace: aBlock into: aSet]
]

{ #category : #enumerating }
NMTModel >> selectFaceUse: aBlock into: aSet [ 
	cRegion do: [:each | each selectFaceUse: aBlock into: aSet]
]

{ #category : #enumerating }
NMTModel >> selectLoop: aBlock into: aSet [ 
	cLoop do: [:each | each selectLoop: aBlock into: aSet]
]

{ #category : #enumerating }
NMTModel >> selectLoopUse: aBlock into: aSet [ 
	cRegion do: [:each | each selectLoopUse: aBlock into: aSet]
]

{ #category : #enumerating }
NMTModel >> selectModel: aBlock into: aSet [ 
	(aBlock value: self) ifTrue: [aSet add: self]
]

{ #category : #enumerating }
NMTModel >> selectRegion: aBlock into: aSet [ 
	cRegion do: [:each | each selectRegion: aBlock into: aSet]
]

{ #category : #enumerating }
NMTModel >> selectShell: aBlock into: aSet [ 
	cShell do: [:each | each selectShell: aBlock into: aSet]
]

{ #category : #enumerating }
NMTModel >> selectShellUse: aBlock into: aSet [ 
	cRegion do: [:each | each selectShellUse: aBlock into: aSet]
]

{ #category : #enumerating }
NMTModel >> selectSurface: aBlock into: aSet [ 
	cFace do: [:each | each selectSurface: aBlock into: aSet]
]

{ #category : #enumerating }
NMTModel >> selectVertex: aBlock into: aSet [ 
	cVertex do: [:each | each selectVertex: aBlock into: aSet]
]

{ #category : #enumerating }
NMTModel >> selectVertexUse: aBlock into: aSet [ 
	cRegion do: [:each | each selectVertexUse: aBlock into: aSet]
]

{ #category : #ops }
NMTModel >> unmarkFaceUse [
	cFace do: [:aFace | aFace cUse do: [:aFaceUse | aFaceUse unmark]]
]
