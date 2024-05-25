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

{ #category : 'VisualWorks metadata' }
SingularMatrixError class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]
