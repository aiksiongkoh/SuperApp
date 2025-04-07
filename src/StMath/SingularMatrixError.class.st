Class {
	#name : 'SingularMatrixError',
	#superclass : 'Exception',
	#category : 'StMath-Exception',
	#package : 'StMath',
	#tag : 'Exception'
}

{ #category : 'class initialization' }
SingularMatrixError class >> initializeX [
	"SingularMatrixError initialize"
	SingularMatrixError
		notifierString: #'Singular Matrix Error' << #'StCAD.UI'
				>> 'Singular Matrix Error'
]

{ #category : 'testing' }
SingularMatrixError class >> mayResume [
	^true
]

{ #category : 'signalling' }
SingularMatrixError class >> signalWith: aCollection [

	^ self new
		  messageText: aCollection;
		  signal
]

{ #category : 'VisualWorks metadata' }
SingularMatrixError class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'accessing' }
SingularMatrixError >> parameter [

	^ messageText
]

{ #category : 'printing' }
SingularMatrixError >> printOn: aStream [

	aStream
		nextPutAll: self class name;
		space;
		nextPutAll: messageText printString
]
