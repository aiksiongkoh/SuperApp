Class {
	#name : 'VerySparseVector',
	#superclass : 'SpecialLinearAlgebra',
	#instVars : [
		'fullsize'
	],
	#category : 'StMath-StMathArraySpecial',
	#package : 'StMath',
	#tag : 'StMathArraySpecial'
}

{ #category : 'VisualWorks metadata' }
VerySparseVector class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'accessing' }
VerySparseVector >> numberOfElements [
	"Answer the number of elements in the full vector or matrix."

	^fullsize
]
