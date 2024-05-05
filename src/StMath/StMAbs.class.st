Class {
	#name : #StMAbs,
	#superclass : #StMIntrinsicFunctionX,
	#category : #'StMath-Symbolic'
}

{ #category : #accessing }
StMAbs class >> functionSymbol [
	^'abs'
]

{ #category : #'VisualWorks metadata' }
StMAbs class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #evaluating }
StMAbs >> differentiateWRTx [
	^StMStep
		with: x copy
		x1: 0.0
		y1: -1.0
		y2: 1.0
]

{ #category : #printing }
StMAbs >> printFuntionNameOn: aStream [
	aStream nextPutAll: 'abs'
]

{ #category : #evaluating }
StMAbs >> value [
	^x value abs
]
