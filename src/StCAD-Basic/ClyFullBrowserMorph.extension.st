Extension { #name : #ClyFullBrowserMorph }

{ #category : #'*StCAD-Basic' }
ClyFullBrowserMorph >> open [

	super open.
	self switchToFullClassHierarchy.
	self window maximize
]
