Class {
	#name : 'StMNegative',
	#superclass : 'StMIntrinsicFunctionX',
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'accessing' }
StMNegative class >> functionSymbol [

	^ '-'
]

{ #category : 'VisualWorks metadata' }
StMNegative class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'StCAD.Math'
	)

]

{ #category : 'instance creation' }
StMNegative class >> with: arg [

	^ super new
		  x: arg;
		  yourself
]

{ #category : 'converting' }
StMNegative >> asValue [

	^ x asValue negated
]

{ #category : 'StCAD-UI' }
StMNegative >> cadStringOn: aStream [ 
	aStream nextPut: $(.
	aStream nextPut: $-.
	x cadStringOn: aStream.
	aStream nextPut: $)
]

{ #category : 'evaluating' }
StMNegative >> differentiateWRTx [
	^StMConstant with: -1
]

{ #category : 'printing' }
StMNegative >> funcName [

	^ '-'
]

{ #category : 'testing' }
StMNegative >> isConstant [

	^ x isConstant
]

{ #category : 'testing' }
StMNegative >> isNegative [

	^ true
]

{ #category : 'testing' }
StMNegative >> isTrig [

	self halt: 'Check this.'.
	^ x isTrig
]

{ #category : 'ops' }
StMNegative >> negated [

	^ x
]

{ #category : 'testing' }
StMNegative >> negative [

	^ true
]

{ #category : 'printing' }
StMNegative >> printFuntionNameOn: aStream [
	aStream nextPutAll: '-'
]

{ #category : 'simplify' }
StMNegative >> simplifyNegative [

	| newx answer |
	newx := x simplifyNegative.
	answer := self class with: newx.
	^ newx isConstant
		  ifTrue: [ StMConstant with: answer value ]
		  ifFalse: [
			  newx isNegative
				  ifTrue: [ newx x ]
				  ifFalse: [ answer ] ]
]

{ #category : 'evaluating' }
StMNegative >> simplifyUntil: set [

	| xx |
	^ (set includes: self)
		  ifTrue: [ self ]
		  ifFalse: [
			  xx := x simplifyUntil: set.
			  xx isConstant
				  ifTrue: [
					  xx value: xx value negated.
					  xx ]
				  ifFalse: [
					  xx isProduct
						  ifTrue: [
							  xx coeff: xx coeff negated.
							  xx ]
						  ifFalse: [ self class with: xx ] ] ]
]

{ #category : 'evaluating' }
StMNegative >> value [
	^x value negated
]
