Class {
	#name : 'StMDataXYFunctionX',
	#superclass : 'StMFunctionX',
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'VisualWorks metadata' }
StMDataXYFunctionX class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'comparing' }
StMDataXYFunctionX >> = anObject [ 
	^super = anObject and: [x = anObject x]
]

{ #category : 'message handling' }
StMDataXYFunctionX >> argsPerform: selector withArguments: anArray [ 
	Processor yield.
	x perform: selector withArguments: anArray
]

{ #category : 'copying' }
StMDataXYFunctionX >> postCopy [
	x := x copy
]

{ #category : 'changing' }
StMDataXYFunctionX >> substitute: var1 with: var2 [ 
	| xx |
	^self = var1
		ifTrue: [var2]
		ifFalse: 
			[xx := x substitute: var1 with: var2.
			self class with: xx]
]

{ #category : 'accessing' }
StMDataXYFunctionX >> x [
	^x
]

{ #category : 'accessing' }
StMDataXYFunctionX >> x: arg [ 
	x := self conditionArgument: arg
]
