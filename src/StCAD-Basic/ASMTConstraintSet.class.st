Class {
	#name : 'ASMTConstraintSet',
	#superclass : 'ASMTItemIJ',
	#instVars : [
		'iFXonIs',
		'iFYonIs',
		'iFZonIs',
		'iTXonIs',
		'iTYonIs',
		'iTZonIs'
	],
	#category : 'StCAD-Basic',
	#package : 'StCAD-Basic'
}

{ #category : 'parsing' }
ASMTConstraintSet >> parseFXonIs: lines [

	| tokens |
	tokens := lines removeFirst substrings asOrderedCollection.
	[ tokens removeFirst trim = 'FXonI' ] assert.
	iFXonIs := OrderedCollection ofSize: tokens size.
	1 to: tokens size do: [ :i |
	iFXonIs at: i put: (Float readFrom: tokens removeFirst trim) ]
]

{ #category : 'parsing' }
ASMTConstraintSet >> parseFYonIs: lines [

	| tokens |
	tokens := lines removeFirst substrings asOrderedCollection.
	[ tokens removeFirst trim = 'FYonI' ] assert.
	iFYonIs := OrderedCollection ofSize: tokens size.
	1 to: tokens size do: [ :i |
	iFYonIs at: i put: (Float readFrom: tokens removeFirst trim) ]
]

{ #category : 'parsing' }
ASMTConstraintSet >> parseFZonIs: lines [

	| tokens |
	tokens := lines removeFirst substrings asOrderedCollection.
	[ tokens removeFirst trim = 'FZonI' ] assert.
	iFZonIs := OrderedCollection ofSize: tokens size.
	1 to: tokens size do: [ :i |
	iFZonIs at: i put: (Float readFrom: tokens removeFirst trim) ]
]

{ #category : 'parsing' }
ASMTConstraintSet >> parseTXonIs: lines [

	| tokens |
	tokens := lines removeFirst substrings asOrderedCollection.
	[ tokens removeFirst trim = 'TXonI' ] assert.
	iTXonIs := OrderedCollection ofSize: tokens size.
	1 to: tokens size do: [ :i |
	iTXonIs at: i put: (Float readFrom: tokens removeFirst trim) ]
]

{ #category : 'parsing' }
ASMTConstraintSet >> parseTYonIs: lines [

	| tokens |
	tokens := lines removeFirst substrings asOrderedCollection.
	[ tokens removeFirst trim = 'TYonI' ] assert.
	iTYonIs := OrderedCollection ofSize: tokens size.
	1 to: tokens size do: [ :i |
	iTYonIs at: i put: (Float readFrom: tokens removeFirst trim) ]
]

{ #category : 'parsing' }
ASMTConstraintSet >> parseTZonIs: lines [

	| tokens |
	tokens := lines removeFirst substrings asOrderedCollection.
	[ tokens removeFirst trim = 'TZonI' ] assert.
	iTZonIs := OrderedCollection ofSize: tokens size.
	1 to: tokens size do: [ :i |
	iTZonIs at: i put: (Float readFrom: tokens removeFirst trim) ]
]
