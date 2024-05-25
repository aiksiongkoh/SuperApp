Class {
	#name : 'SpecialMatrix',
	#superclass : 'SpecialLinearAlgebra',
	#category : 'StMath-StMathArraySpecial',
	#package : 'StMath',
	#tag : 'StMathArraySpecial'
}

{ #category : 'VisualWorks metadata' }
SpecialMatrix class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'accessing' }
SpecialMatrix >> numberOfElements [
	"Answer the number of elements in the full vector or matrix."

	^self nrow * self ncol
]
