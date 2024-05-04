Extension { #name : #ClyBrowserMorph }

{ #category : #'*StCAD-Basic' }
ClyBrowserMorph >> initialExtent [
	^ 1200@800 * self currentWorld displayScaleFactor
]
