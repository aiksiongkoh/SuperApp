Extension { #name : #Scanner }

{ #category : #'*StCAD-Misc-StCAD-DEV' }
Scanner class >> example1 [
	"Scanner example1"

	| aScanner |
	aScanner := Scanner new.
	aScanner 
		breakIntoTokens: 'http://freshmeat.net/search/?q=3d+cad&section=projects&Go.x=0&Go.y=0'
]
