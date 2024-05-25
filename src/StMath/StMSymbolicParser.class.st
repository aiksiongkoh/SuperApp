Class {
	#name : 'StMSymbolicParser',
	#superclass : 'ExternalLanguageParser',
	#instVars : [
		'variables'
	],
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'VisualWorks metadata' }
StMSymbolicParser class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'Kernel'
	)

]

{ #category : 'error handling' }
StMSymbolicParser >> expected: aString [ 
	"Notify a problem at token 'here'"

	^self notify: aString , ' expected ->' at: mark
]

{ #category : 'accessing' }
StMSymbolicParser >> functions [
	^self intrinsicFunctions
]

{ #category : 'initialize-release' }
StMSymbolicParser >> initVariables [
	variables := IdentityDictionary new.
	self variablesSet do: [:item | variables at: item name asSymbol put: item]
]

{ #category : 'accessing' }
StMSymbolicParser >> intrinsicFunctions [
	"The methods 'intrinsic' and 'intrinsicFunctions' must have the same functions."

	| functions |
	functions := OrderedCollection new.
	functions add: StMArcTan.
	functions add: StMArcTan2.
	functions add: StMCos.
	functions add: StMExp.
	functions add: StMInverseOfSpectralDensity.
	functions add: StMLg.
	functions add: StMLn.
	functions add: StMSin.
	functions add: StMGeneralSplineX.
	functions add: StMSqrt.
	functions add: StMTan.
	^functions
]

{ #category : 'error handling' }
StMSymbolicParser >> notify: aString [ 
	"Notify problem at token before 'here'"

	^self notify: aString at: mark
]

{ #category : 'scanning' }
StMSymbolicParser >> signedNumber [
	"Recognize a possibly signed number."

	tokenType == #number
		ifTrue: 
			[stack addLast: token.
			self scanToken.
			^true].
	(token = $+ and: [hereChar notNil and: [hereChar isDigit or: [hereChar = $.]]])
		ifTrue: 
			["no intervening delimiters"
			self scanToken.
			stack addLast: token.
			self scanToken.
			^true].
	(token = $- and: [hereChar notNil and: [hereChar isDigit or: [hereChar = $.]]])
		ifTrue: 
			["no intervening delimiters"
			self scanToken.
			stack addLast: token negated.
			self scanToken.
			^true].
	^false
]

{ #category : 'accessing' }
StMSymbolicParser >> variables [
	^variables
]

{ #category : 'initialize-release' }
StMSymbolicParser >> variablesSet [
	| set |
	set := Set new.
	^set
]

{ #category : 'scanning' }
StMSymbolicParser >> xDigit [
	"form a number"

	tokenType := #number.
	hereChar == nil ifFalse: [source skip: -1].
	token := Number importFrom: source.
	hereChar := source next
]
