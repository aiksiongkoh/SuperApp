Class {
	#name : 'StMStep',
	#superclass : 'StMPiecewiseFunctionX',
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'VisualWorks metadata' }
StMStep class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'instance creation' }
StMStep class >> with: variable x1: xx1 y1: yy1 y2: yy2 [ 
	^super new
		x: variable
		x1: xx1
		y1: yy1
		y2: yy2
]

{ #category : 'initialize-release' }
StMStep >> x: arg x1: argx1 y1: argy1 y2: argy2 [ 
	| x1 y1 y2 |
	x := self conditionArgument: arg.
	x1 := self conditionArgument: argx1.
	y1 := self conditionArgument: argy1.
	y2 := self conditionArgument: argy2.
	functions := OrderedCollection new.
	functions add: y1.
	functions add: y2.
	transitions := OrderedCollection new.
	transitions add: x1
]
