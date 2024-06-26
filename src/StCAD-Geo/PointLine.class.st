Class {
	#name : 'PointLine',
	#superclass : 'Combination',
	#instVars : [
		'a0',
		'aDir',
		'aPar',
		'b0',
		'aClosestPoint',
		'aRightDist',
		'aMinDist'
	],
	#category : 'StCAD-Geo',
	#package : 'StCAD-Geo'
}

{ #category : 'instance creation' }
PointLine class >> a0: a0 aDir: aDir b0: b0 [ 
	^(super new)
		a0: a0
			aDir: aDir
			b0: b0;
		calc;
		yourself
]

{ #category : 'instance creation' }
PointLine class >> aStartPoint: aStartPoint aEndPoint: aEndPoint bPoint: bPoint [ 
	^self 
		a0: aStartPoint
		aDir: aEndPoint - aStartPoint
		b0: bPoint
]

{ #category : 'VisualWorks metadata' }
PointLine class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Geo'
		'superclassNamespace' 'StCAD.Geo'
	)

]

{ #category : 'accessing' }
PointLine >> a0 [
	^a0
]

{ #category : 'accessing' }
PointLine >> a0: aFullColumn aDir: aaFullColumn b0: bFullColumn [ 
	a0 := aFullColumn.
	aDir := aaFullColumn.
	b0 := bFullColumn
]

{ #category : 'accessing' }
PointLine >> aClosestPoint [
	^aClosestPoint
]

{ #category : 'accessing' }
PointLine >> aDir [
	^aDir
]

{ #category : 'accessing' }
PointLine >> aMinDist [
	^aMinDist
]

{ #category : 'accessing' }
PointLine >> aPar [
	^aPar
]

{ #category : 'accessing' }
PointLine >> aRightDist [
	^aRightDist
]

{ #category : 'accessing' }
PointLine >> b0 [
	^b0
]

{ #category : 'initialize-release' }
PointLine >> calc [
	| aDirSSq aLength bDir |
	aDirSSq := aDir sumOfSquares.
	aLength := aDirSSq sqrt.
	bDir := b0 - a0.
	aPar := (bDir dot: aDir) / aDirSSq.
	aClosestPoint := a0 plusFullColumn: aDir times: aPar.
	aRightDist := ((bDir cross: aDir) at: 3) / aLength.
	aMinDist := aRightDist abs
]
