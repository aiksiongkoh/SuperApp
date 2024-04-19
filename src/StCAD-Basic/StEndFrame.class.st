Class {
	#name : #StEndFrame,
	#superclass : #StCartesianFrame,
	#category : #'StCAD-Basic'
}

{ #category : #accessing }
StEndFrame >> aAOe [

	^ aAOf
]

{ #category : #accessing }
StEndFrame >> aAme [

	^ aAFf
]

{ #category : #calc }
StEndFrame >> calcAll [

	rOfO := self calcrOeO.
	aAOf := self calcaAOe.
	subs do: [ :sub | sub calcAll ]
]

{ #category : #calc }
StEndFrame >> calcaAOe [

	^ sup aAOm timesFullMatrix: self aAme
]

{ #category : #calc }
StEndFrame >> calcrOeO [

	^ sup rOmO + (sup aAOm timesFullColumn: self rmem)
]

{ #category : #accessing }
StEndFrame >> rOeO [

	^ rOfO
]

{ #category : #accessing }
StEndFrame >> rmem [

	^ rFfF
]
