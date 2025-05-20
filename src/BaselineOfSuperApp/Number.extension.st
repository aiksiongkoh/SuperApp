Extension { #name : 'Number' }

{ #category : '*BaselineOfSuperApp' }
Number >> asDouble [

	^ self asFloat
]

{ #category : '*BaselineOfSuperApp' }
Number class >> chooseFloatRepresentationFor: exponentChar [

	('de' includes: exponentChar) ifTrue: [ ^ Float ]
]

{ #category : '*BaselineOfSuperApp' }
Number class >> coerce: value precision: precision exponent: exponent exponentChar: expChar [
	"Coerce the value to an instance of the receiver, if
	appropriate.  If the receiver supports the idea of
	controllable precision, such as FixedPoint numbers,
	then 'precision' and 'exponent' define how many
	digits should follow the decimal point."

	"This is a support routine for Number class>>readFrom:,
	and may change or disappear from release to release."

	^ exponent == nil
		  ifTrue: [ self zero coerce: value ]
		  ifFalse: [ (self zero coerce: value) * (10 raisedTo: exponent) ]
]

{ #category : '*BaselineOfSuperApp' }
Number class >> coerce: value to: class precision: precision exponent: exponent exponentChar: expChar [
	"Coerce the value to be an instance of 'class', or
	if the receiver is a concrete subclass of Number, it
	should coerce the number to itself.  'precision' is
	the number of digits after the decimal point that
	were explicitly represented. 'exponent' is the number
	that follows the exponent character--this usually
	represents multiplying the number by a power of 10,
	but may mean something else for FixedPoint. The
	'expChar' is the character that identifies what type
	of number this is, and separates the basic number
	from its exponent."

	"This is a support routine for Number class>>readFrom:,
	and may change or disappear from release to release."

	^ class
		  coerce: value
		  precision: precision
		  exponent: exponent
		  exponentChar: expChar
]

{ #category : '*BaselineOfSuperApp' }
Number class >> importDouble: integerPart from: aStream [
	"Answer an instance of me as described on the stream, aStream."

	| value coercionClass possibleCoercionClass precision digit num den exp neg endOfNumber eChar |
	precision := 0.
	num := 0.
	den := 1.
	coercionClass := Integer.
	(aStream peekFor: $.) ifTrue: [ "<integer>.<fraction>"
		(aStream atEnd not and: [ aStream peek isDigit ])
			ifTrue: [
				| atEnd |
				coercionClass := Float.
				[ (atEnd := aStream atEnd) or: [ (digit := aStream next) isDigit not ] ] whileFalse: [
					num := num * 10 + digit digitValue.
					precision := precision + 1 ].
				den := 10 ** precision.
				atEnd ifFalse: [ aStream skip: -1 ] ]
			ifFalse: [
				('de' includes: aStream peek asLowercase) ifFalse: [ "oops - just <integer>." "un-gobble the period"
					aStream skip: -1 ] ] ].
	eChar := aStream peek.
	eChar == nil
		ifTrue: [ possibleCoercionClass := nil ]
		ifFalse: [
			eChar := eChar asLowercase.
			possibleCoercionClass := self chooseFloatRepresentationFor: eChar.
			possibleCoercionClass == nil ifFalse: [ aStream next ] ].
	exp := nil.
	possibleCoercionClass == nil ifFalse: [
		coercionClass := possibleCoercionClass.
		endOfNumber := aStream position.
		neg := (aStream peekFor: $+)
			       ifTrue: [ false ]
			       ifFalse: [ aStream peekFor: $- ].
		((digit := aStream peek) notNil and: [ digit isDigit ])
			ifTrue: [
				exp := self readIntegerFrom: aStream radix: 10.
				neg ifTrue: [ exp := exp negated ] ]
			ifFalse: [ aStream position: endOfNumber ] ].
	value := integerPart + (num / den).
	coercionClass := coercionClass == Integer
		                 ifTrue: [ Integer ]
		                 ifFalse: [ Float ]. "The exponent will be added in the next step."
	^ self
		  coerce: value
		  to: coercionClass
		  precision: precision
		  exponent: exp
		  exponentChar: eChar
]

{ #category : '*BaselineOfSuperApp' }
Number class >> importFrom: aStream [
	"Answer an instance of me as described on the stream, aStream."

	| value neg |
	(aStream atEnd or: [ aStream peek isLetter ]) ifTrue: [ ^ 0 ].
	neg := (aStream peekFor: $+)
		       ifTrue: [ false ]
		       ifFalse: [ aStream peekFor: $- ].
	value := self readIntegerFrom: aStream radix: 10.
	value := self importDouble: value from: aStream.
	^ neg
		  ifTrue: [ value negated ]
		  ifFalse: [ value ]
]

{ #category : '*BaselineOfSuperApp' }
Number class >> readIntegerFrom: aStream radix: radix [
	"Answer an instance of one of the concrete subclasses if Integer. 
	Initial minus sign accepted, and bases > 10 use letters A-Z.
	Imbedded radix specifiers not allowed;  use Integer 
	class readFrom: for that. Answer zero if there are no digits."

	| digit value |
	value := 0.
	[ aStream atEnd ] whileFalse: [
		digit := aStream next digitValue.
		(digit < 0 or: [ digit >= radix ])
			ifTrue: [
				aStream skip: -1.
				^ value ]
			ifFalse: [ value := value * radix + digit ] ].
	^ value
]
