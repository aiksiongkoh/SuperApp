Extension { #name : #StSpotter }

{ #category : #'*StCAD-Basic' }
StSpotter >> initialExtent [

	self flag: #TODO. "Maybe calculate coordinates?"
	^ self isShowingPreview 
		ifTrue: [ 1600@800 ]
		ifFalse: [ 500@450 ]
]
