Class {
	#name : 'StMSymbolicParser',
	#superclass : 'Object',
	#instVars : [
		'source',
		'mark',
		'prevEnd',
		'hereChar',
		'token',
		'tokenType',
		'saveComments',
		'currentComment',
		'buffer',
		'typeTable',
		'stack',
		'variables',
		'requestor',
		'failBlock',
		'correctionDelta',
		'keywordMarker',
		'reservedWords',
		'backupStack'
	],
	#category : 'StMath-Symbolic',
	#package : 'StMath',
	#tag : 'Symbolic'
}

{ #category : 'testing' }
StMSymbolicParser class >> hasKeywords [

	^ false
]

{ #category : 'accessing' }
StMSymbolicParser class >> reservedWords [

	^ false
]

{ #category : 'accessing' }
StMSymbolicParser class >> typeTable [

	^ nil
]

{ #category : 'VisualWorks metadata' }
StMSymbolicParser class >> visualWorksMetadata [

	^ #(
		'namespace' 'StCAD.Math'
		'superclassNamespace' 'Kernel'
	)

]

{ #category : 'accessing' }
StMSymbolicParser >> constant [

	self signedNumber ifTrue: [
		| num |
		num := (num := stack removeLast) isInteger
			       ifTrue: [ num ]
			       ifFalse: [ num asDouble ].
		stack addLast: (StMConstant with: num).
		^ true ].
	(self peekForType: #word value: 'pi') ifTrue: [
		stack addLast: StMPI new.
		^ true ].
	^ false
]

{ #category : 'parsing' }
StMSymbolicParser >> divideByFunction [

	(self peekForTypeNoPush: '/') ifTrue: [
		self function ifTrue: [
			stack addLast: [
				| t1 t2 |
				t1 := stack removeLast.
				(t2 := stack removeLast) addTerm: t1 reciprocal.
				t2 ] value.
			^ true ].
		^ self expected: 'function' ].
	^ false
]

{ #category : 'error handling' }
StMSymbolicParser >> expected: aString [ 
	"Notify a problem at token 'here'"

	^self notify: aString , ' expected ->' at: mark
]

{ #category : 'accessing' }
StMSymbolicParser >> expression [

	stack addLast: StMSum new.
	(self plusTerm or: [ self minusTerm or: [ self plainTerm ] ]) ifTrue: [
		[ self plusTerm or: [ self minusTerm ] ] whileTrue.
		stack addLast: [
			| sum |
			(sum := stack removeLast) isSum
				ifTrue: [ sum simplified ]
				ifFalse: [ self notify: 'Compiler error!' ] ] value.
		^ true ].
	^ false
]

{ #category : 'parsing' }
StMSymbolicParser >> expressionInParentheses [

	(self peekForTypeNoPush: '(') ifTrue: [
		self expression ifTrue: [
			(self peekForTypeNoPush: ')') ifTrue: [ ^ true ].
			^ self expected: ')' ].
		^ self expected: 'expression' ].
	^ false
]

{ #category : 'accessing - keys - special' }
StMSymbolicParser >> function [

	(self expressionInParentheses or: [
		 self constant or: [
			 self namedFunction or: [
				 self variable or: [
					 stack addLast: (self notify: 'Unrecognized symbol ->').
					 stack removeLast.
					 true ] ] ] ]) ifTrue: [
		self raisedTo.
		^ true ].
	^ false
]

{ #category : 'accessing' }
StMSymbolicParser >> functions [
	^self intrinsicFunctions
]

{ #category : 'initialize' }
StMSymbolicParser >> init: streamOrString notifying: req failBlock: aBlock [
	"Initialize the scanner.  Return the initial position
	in the source stream, so that we can back up
	over an initial scan if necessary."

	| sourceStream startPos |
	(streamOrString isKindOf: Stream)
		ifTrue: [
			startPos := streamOrString position.
			sourceStream := streamOrString ]
		ifFalse: [
			startPos := 1.
			sourceStream := streamOrString asString readStream ].
	requestor := req.
	failBlock := aBlock.
	correctionDelta := 0.
	self scan: sourceStream.
	^ startPos
]

{ #category : 'initialize' }
StMSymbolicParser >> initScanner [

	buffer := WriteStream on: (String new: 40).
	saveComments := true.
	typeTable := self class typeTable.
	reservedWords := self class reservedWords.
	keywordMarker := self class hasKeywords
		                 ifTrue: [ #colon ]
		                 ifFalse: [ #xLetter ].
	stack := OrderedCollection new: 20.
	backupStack := OrderedCollection new
]

{ #category : 'initialize-release' }
StMSymbolicParser >> initVariables [
	variables := IdentityDictionary new.
	self variablesSet do: [:item | variables at: item name asSymbol put: item]
]

{ #category : 'initialize' }
StMSymbolicParser >> initialize [

	self initScanner.
	variables := IdentityDictionary new
]

{ #category : 'parsing' }
StMSymbolicParser >> intrinsic [

	| t1 t2 t3 |
	(((self peekForType: #word value: 'abs') and: [
		  stack addLast: StMAbs new.
		  true ]) or: [
		 ((self peekForType: #word value: 'arctan') and: [
			  stack addLast: StMArcTan new.
			  true ]) or: [
			 ((self peekForType: #word value: 'arctan2') and: [
				  stack addLast: StMArcTan2 new.
				  true ]) or: [
				 ((self peekForType: #word value: 'cos') and: [
					  stack addLast: StMCos new.
					  true ]) or: [
					 ((self peekForType: #word value: 'exp') and: [
						  stack addLast: StMExp new.
						  true ]) or: [
						 ((self peekForType: #word value: 'lg') and: [
							  stack addLast: StMLg new.
							  true ]) or: [
							 ((self peekForType: #word value: 'ln') and: [
								  stack addLast: StMLn new.
								  true ]) or: [
								 ((self peekForType: #word value: 'sin') and: [
									  stack addLast: StMSin new.
									  true ]) or: [
									 ((self peekForType: #word value: 'spline') and: [
										  stack addLast: StMGeneralSpline new.
										  true ]) or: [
										 ((self peekForType: #word value: 'sqrt') and: [
											  stack addLast: StMSqrt new.
											  true ]) or: [
											 ((self peekForType: #word value: 'tan') and: [
												  stack addLast: StMTan new.
												  true ]) or: [
												 ((self peekForType: #word value: 'integral') and: [
													  stack addLast: StMIntegral new.
													  true ]) or: [
													 (self peekForType: #word value: 'rampstep') and: [
														 stack addLast: StMRampStep new.
														 true ] ] ] ] ] ] ] ] ] ] ] ] ]) ifTrue: [
		(self peekForTypeNoPush: #leftParenthesis) ifTrue: [
			t3 := stack size.
			t1 := true.
			[ (t2 := t1 or: [ self peekForTypeNoPush: #ascii54 ]) and: [ self expression ] ] whileTrue: [
				t1 := false ].
			(t1
				 ifTrue: [ false ]
				 ifFalse: [
					 t2 ifTrue: [ self unexpectedError ].
					 self combineStackTo: t3.
					 true ]) ifTrue: [
				(self peekForTypeNoPush: #rightParenthesis) ifTrue: [
					stack addLast: [
						| t4 t5 |
						t5 := stack removeLast.
						t4 := stack removeLast.
						[ t4 arguments: t5 ]
							on: Error
							do: [ :t6 | self notify: t6 messageText ] ] value.
					^ true ].
				^ self expected: #rightParenthesis ].
			^ self expected: 'expression' ].
		^ self expected: #leftParenthesis ].
	^ false
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

{ #category : 'parsing' }
StMSymbolicParser >> minusTerm [

	(self peekForTypeNoPush: '-') ifTrue: [
		self plainTerm ifTrue: [ ^ true ].
		^ self expected: 'plainTerm' ].
	^ false
]

{ #category : 'error handling' }
StMSymbolicParser >> notify: aString [ 
	"Notify problem at token before 'here'"

	^self notify: aString at: mark
]

{ #category : 'instance creation' }
StMSymbolicParser >> on: inputStream [
	"Bind the input stream, fill the character buffer"

	source := inputStream.
	hereChar := source next.
	prevEnd := 0
]

{ #category : 'parsing' }
StMSymbolicParser >> peekForType: aType value: trialValue [
	"Test to see if tokenType matches aType and token equals trialValue. If so, 
	advance to the next token"

	^ (tokenType == aType and: [ token = trialValue ])
		  ifTrue: [
			  self scanToken.
			  true ]
		  ifFalse: [ false ]
]

{ #category : 'parsing' }
StMSymbolicParser >> peekForTypeNoPush: aType [
	"Test to see if tokenType matches aType. If so, advance to the next token, 
	leaving the stack unchanged"

	^ tokenType == aType asSymbol
		  ifTrue: [
			  self scanToken.
			  true ]
		  ifFalse: [ false ]
]

{ #category : 'parsing' }
StMSymbolicParser >> plainFunction [

	self function ifTrue: [
		stack addLast: [
			| t1 t2 |
			t1 := stack removeLast.
			(t2 := stack removeLast) addTerm: t1.
			t2 ] value.
		^ true ].
	^ false
]

{ #category : 'parsing' }
StMSymbolicParser >> plainTerm [

	self term ifTrue: [
		stack addLast: [
			| term termsFunc |
			term := stack removeLast.
			(termsFunc := stack removeLast) addTerm: term.
			termsFunc ] value.
		^ true ].
	^ false
]

{ #category : 'parsing' }
StMSymbolicParser >> plusTerm [

	(self peekForTypeNoPush: '+') ifTrue: [
		self plainTerm ifTrue: [ ^ true ].
		^ self expected: 'plainTerm' ].
	^ false
]

{ #category : 'parsing' }
StMSymbolicParser >> raisedTo [

	(self peekForTypeNoPush: '^') ifTrue: [
		self function ifTrue: [
			stack addLast: [
				| t1 t2 |
				t1 := stack removeLast.
				t2 := stack removeLast.
				StMPower with: t2 raisedTo: t1 ] value.
			^ true ].
		^ self expected: 'function' ].
	^ false
]

{ #category : 'public api' }
StMSymbolicParser >> scan: inputStream [
	"Bind the input stream, fill the character buffers and first token buffer"

	self on: inputStream.
	self scanToken
]

{ #category : 'accessing' }
StMSymbolicParser >> scanToken [

	prevEnd := hereChar == nil
		           ifTrue: [ source position ]
		           ifFalse: [ source position - 1 ].
	[
	hereChar == nil ifTrue: [ "end of input"
		mark := prevEnd + 1.
		tokenType := #doIt.
		^ token := nil ].
	hereChar isSeparator ] whileTrue: [ hereChar := source next ].
	mark := source position.
	hereChar isLetter
		ifTrue: [ self xLetter ]
		ifFalse: [
			hereChar isDigit
				ifTrue: [ self xDigit ]
				ifFalse: [
					token := hereChar asString.
					tokenType := token asSymbol.
					hereChar := source next "else just return the character" ] ].
	^ token
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

{ #category : 'parsing' }
StMSymbolicParser >> term [

	stack addLast: StMProduct new.
	self plainFunction ifTrue: [
		[ self timesFunction or: [ self divideByFunction ] ] whileTrue.
		stack addLast: [
			| prod |
			(prod := stack last) isProduct
				ifTrue: [
					prod isOne
						ifTrue: [ stack removeLast ]
						ifFalse: [
							prod terms size = 1
								ifTrue: [
									stack removeLast.
									stack addLast: prod terms first ]
								ifFalse: [ nil ] ] ]
				ifFalse: [ self notify: 'Compiler error!' ] ] value.
		stack removeLast.
		^ true ].
	^ false
]

{ #category : 'parsing' }
StMSymbolicParser >> timesFunction [

	(self peekForTypeNoPush: '*') ifTrue: [
		self plainFunction ifTrue: [ ^ true ].
		^ self expected: 'plainFunction' ].
	^ false
]

{ #category : 'accessing' }
StMSymbolicParser >> variable [

	| var |
	^ tokenType == #word
		  ifTrue: [
			  var := variables at: token asSymbol ifAbsent: [ ^ false ].
			  stack addLast: var.
			  self scanToken.
			  true ]
		  ifFalse: [ false ]
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
	hereChar ifNotNil: [ source skip: -1 ].
	token := Number importFrom: source.
	hereChar := source next
]

{ #category : 'parsing' }
StMSymbolicParser >> xLetter [
	"form a word, keyword, or reserved word"

	| type char |
	buffer reset.
	buffer nextPut: hereChar.
	[
	char := source next.
	char notNil and: [
		type := char isLetter
			        ifTrue: [ #xLetter ]
			        ifFalse: [
				        char isDigit
					        ifTrue: [ #xDigit ]
					        ifFalse: [ nil ] ].
		type == #xLetter or: [ type == #xDigit ] ] ] whileTrue: [ buffer nextPut: char ].
	(char notNil and: [ type == keywordMarker ])
		ifTrue: [
			buffer nextPut: char.
			char := source next.
			tokenType := #keyword ]
		ifFalse: [ tokenType := #word ]. "either #colon, if keywords,
				  or #xLetter (no match) if none"
	hereChar := char.
	token := buffer contents.
	reservedWords == false ifFalse: [
		(reservedWords includes: token) ifTrue: [ tokenType := token asSymbol ] ]
]
