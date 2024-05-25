Extension { #name : 'SpWindowPresenter' }

{ #category : '*StCAD-Basic' }
SpWindowPresenter >> openWithLayout: aSpecLayout [

	self buildWithSpecLayout: aSpecLayout.
	self application registerWindow: self.
	self withAdapterDo: [ :anAdapter |
		anAdapter openWithDeferredAction: [
			self allPresenters do: [ :each | each announceDisplayed ].
			self updateTitle ] ].
	self class == SpWindowPresenter ifTrue: [ self maximize ]
]
