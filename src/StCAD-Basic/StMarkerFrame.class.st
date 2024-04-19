Class {
	#name : #StMarkerFrame,
	#superclass : #StCartesianFrame,
	#instVars : [
		'thepm'
	],
	#category : #'StCAD-Basic'
}

{ #category : #accessing }
StMarkerFrame >> aAOm [

	^ aAOf
]

{ #category : #accessing }
StMarkerFrame >> aApm [

	^ aAFf
]

{ #category : #adding }
StMarkerFrame >> addEndFC: aStEndFrameCurve [

	subs add: aStEndFrameCurve.
	aStEndFrameCurve sup: self
]

{ #category : #adding }
StMarkerFrame >> addEndFS: aStEndFrameSurface [

	subs add: aStEndFrameSurface.
	aStEndFrameSurface sup: self
]

{ #category : #adding }
StMarkerFrame >> addEndFc: aStEndFramec [

	subs add: aStEndFramec.
	aStEndFramec sup: self
]

{ #category : #adding }
StMarkerFrame >> addEndFt: aStEndFramet [

	subs add: aStEndFramet.
	aStEndFramet sup: self
]

{ #category : #calc }
StMarkerFrame >> calcAll [

	rOfO := self calcrOmO.
	aAOf := self calcaAOm.
	subs do: [ :sub | sub calcAll ]
]

{ #category : #calc }
StMarkerFrame >> calcaAOm [

	^ sup aAOp timesFullMatrix: self aApm
]

{ #category : #calc }
StMarkerFrame >> calcrOmO [

	^ sup rOpO + (sup aAOp timesFullColumn: self rpmp)
]

{ #category : #initialization }
StMarkerFrame >> initialize [

	| rpmp1 rpmp2 rpmp3 rpmp thepm1x thepm2y thepm3z aApm |
	super initialize.
	rpmp1 := StMConstantParameter name: #rpmp1.
	rpmp2 := StMConstantParameter name: #rpmp2.
	rpmp3 := StMConstantParameter name: #rpmp3.
	rpmp := StMFullColumn with: rpmp1 with: rpmp2 with: rpmp3.
	rFfF := rpmp simplified.
	thepm1x := StMConstantParameter name: #thepm1x.
	thepm2y := StMConstantParameter name: #thepm2y.
	thepm3z := StMConstantParameter name: #thepm3z.
	thepm := StEulerAngles with: thepm1x with: thepm2y with: thepm3z.
	aApm := thepm
		        calc;
		        aA.
	aAFf := aApm simplified
]

{ #category : #accessing }
StMarkerFrame >> rOmO [

	^ rOfO
]

{ #category : #accessing }
StMarkerFrame >> rpmp [

	^ rFfF
]

{ #category : #accessing }
StMarkerFrame >> sup: aStPartFrame [

	sup := aStPartFrame
]
