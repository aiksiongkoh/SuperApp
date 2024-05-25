Extension { #name : 'StSpotter' }

{ #category : '*StCAD-Basic' }
StSpotter >> initialExtent [

	self flag: #TODO. "Maybe calculate coordinates?"
	^ self isShowingPreview
		  ifTrue: [ 1800 @ 952 ]
		  ifFalse: [ 1600 @ 800 ]
]
