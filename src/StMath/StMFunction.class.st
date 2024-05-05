Class {
	#name : #StMFunction,
	#superclass : #StMSymbolic,
	#category : #'StMath-Symbolic'
}

{ #category : #'binary storage' }
StMFunction class >> binaryReaderBlockForVersion: oldVersion format: oldFormat [ 
	"Remove the instance variable 'value' from StMSymbolic."
	"Remove the instance variable 'dependents' from StMFunction."

	oldVersion == nil
		ifTrue: 
			[| inst |
			inst := self basicNew.
			^
			[:oldObj | 
			| new |
			new := Array new: oldObj size - 2.
			new
				replaceFrom: 1
				to: new size
				with: oldObj
				startingAt: 3.
			oldObj become: new.
			oldObj changeClassToThatOf: inst]].
	^super binaryReaderBlockForVersion: oldVersion format: oldFormat
]

{ #category : #'binary storage' }
StMFunction class >> binaryRepresentationVersion [
	^30
]

{ #category : #accessing }
StMFunction class >> functionSymbol [
	self subclassResponsibility
]

{ #category : #accessing }
StMFunction class >> functionTemplate [
	self subclassResponsibility
]

{ #category : #'VisualWorks metadata' }
StMFunction class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : #comparing }
StMFunction >> = anObject [ 
	^self class == anObject class
]

{ #category : #accessing }
StMFunction >> arguments: array [ 
	self subclassResponsibility
]

{ #category : #'initialize-release' }
StMFunction >> initialize [
	"Do nothing."
]

{ #category : #printing }
StMFunction >> outputOn: filename interval: interval [ 
	| writeStream |
	Transcript cr; show: 'Tabulated data is in ' , filename.
	writeStream := filename asFilename writeStream.
	writeStream nextPut: $x; nextPut: $,; nextPutAll: 'func'; cr.
	interval
		do: 
			[:x | 
			| fvalue |
			writeStream print: x asFloat; nextPut: $,.
			self x: x.
			fvalue := self value.
			fvalue isSequenceable
				ifTrue: [fvalue do: [:fvaluei | writeStream print: fvaluei asFloat; nextPut: $,]]
				ifFalse: [writeStream print: fvalue asFloat].
			writeStream cr].
	writeStream flush; close
]

{ #category : #printing }
StMFunction >> printFuntionNameOn: aStream [
	self subclassResponsibility
]

{ #category : #printing }
StMFunction >> printOn: aStream [ 
	self printFuntionNameOn: aStream.
	aStream nextPut: $(.
	self print_cArgumentOn: aStream.
	aStream nextPut: $)
]

{ #category : #printing }
StMFunction >> print_cArgumentOn: aStream [
	self subclassResponsibility
]

{ #category : #evaluating }
StMFunction >> value: xx [ 
	self x: xx.
	^self value
]
