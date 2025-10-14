Extension { #name : 'StSpotter' }

{ #category : '*StCAD-Misc' }
StSpotter class >> defaultPreferredExtent [
	
	^ self isShowingPreview 
		ifTrue: [ (1800@900) ]
		ifFalse: [ (500@680) ]
]
