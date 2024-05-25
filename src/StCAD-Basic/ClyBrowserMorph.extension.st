Extension { #name : 'ClyBrowserMorph' }

{ #category : '*StCAD-Basic' }
ClyBrowserMorph >> initialExtent [
	^ 1200@800 * self currentWorld displayScaleFactor
]

{ #category : '*StCAD-Basic' }
ClyBrowserMorph >> open [

	| window |
	self ensureInitialState.
	window := self openInWindow.
	window model: self.
	self updateWindowTitle.
	window minimumExtent: (650 @ 500.0) scaledByDisplayScaleFactor.
	self window maximize
]
